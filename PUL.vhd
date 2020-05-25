library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PUL is
    Port ( clk : in  STD_LOGIC;
           data : out  STD_LOGIC;
           latch : out  STD_LOGIC;
           shift : out  STD_LOGIC;
           rstO : out  STD_LOGIC;
           rst : in  STD_LOGIC);
end PUL;

architecture PUL_b of PUL is

type states is (load, move, lock);
signal state, nextState : states;

constant text : STD_LOGIC_VECTOR(0 to 55) := "00110111001101000100100001000011001101010011100100110101";

signal current_bit : integer range 0 to 55 := 0;

begin

	progress: process (nextState)	--state pusher
	begin
			state <= nextState;
	end process progress;	

	machine : process (clk, rst)	--state machine
	begin
		if (rst = '0') then
			nextState <= load;
			current_bit <= 0;
		else
			case state is
				when load =>
					data <= text(current_bit);
					shift <= '0';
					latch <= '0';
					nextState <= move;
				when move =>
					shift <= '1';
					current_bit <= (current_bit + 1) MOD 56;
					nextState <= lock;
				when lock =>
					if current_bit MOD 8 = 0 then
						latch <= '1';
					end if;
					nextState <= load;
			end case;
		end if;
	end process machine;
	
	reset_passthrough : process (rst)
	begin
		rstO <= rst;
	end process reset_passthrough;
		
end PUL_b;

