LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PUL_t IS
END PUL_t;
 
ARCHITECTURE behavior OF PUL_t IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PUL
    PORT(
         clk : IN  std_logic;
         data : OUT  std_logic;
         latch : OUT  std_logic;
         shift : OUT  std_logic;
         rstO : OUT  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal data : std_logic;
   signal latch : std_logic;
   signal rstO : std_logic;
   signal shift : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PUL PORT MAP (
          clk => clk,
          data => data,
          latch => latch,
          shift => shift,
          rstO => rstO,
          rst => rst
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      rst <= '1';

      wait;
   end process;

END;
