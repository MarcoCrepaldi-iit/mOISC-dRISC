#******* dRISC 816 timing constraints ********
# No particular timing constraints are added, to leave maximum
# freedom to the synthesizer. All timing constraints are derived
# from the Cyclone 10LP PLL.
# The Cyclone 10LP Evaluation Board has a 50MHz clock
create_clock -period 20.000 -name CLK [get_ports {CLK}] 
set_clock_groups     -exclusive     -group {CLK}
derive_pll_clocks
derive_clock_uncertainty
