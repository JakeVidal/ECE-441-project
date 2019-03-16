-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Fri Mar 15 17:56:46 2019
-- Host        : DESKTOP-I2HU3TI running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               e:/VLSI_Projects/ECE-441-project/ECE-441-VHDL-project/ECE-441-VHDL-project.srcs/sources_1/ip/ResultStorage_dist_mem_gen_0/ResultStorage_dist_mem_gen_0_sim_netlist.vhdl
-- Design      : ResultStorage_dist_mem_gen_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ResultStorage_dist_mem_gen_0_spram is
  port (
    spo : out STD_LOGIC_VECTOR ( 15 downto 0 );
    we : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 5 downto 0 );
    clk : in STD_LOGIC;
    d : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ResultStorage_dist_mem_gen_0_spram : entity is "spram";
end ResultStorage_dist_mem_gen_0_spram;

architecture STRUCTURE of ResultStorage_dist_mem_gen_0_spram is
  signal qspo_int : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of qspo_int : signal is "true";
  signal \ram_reg_0_15_0_0__0_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__10_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__11_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__12_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__13_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__14_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__1_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__2_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__3_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__4_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__5_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__6_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__7_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__8_n_0\ : STD_LOGIC;
  signal \ram_reg_0_15_0_0__9_n_0\ : STD_LOGIC;
  signal ram_reg_0_15_0_0_i_1_n_0 : STD_LOGIC;
  signal ram_reg_0_15_0_0_n_0 : STD_LOGIC;
  signal \ram_reg_0_31_0_0__0_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__10_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__11_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__12_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__13_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__14_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__1_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__2_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__3_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__4_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__5_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__6_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__7_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__8_n_0\ : STD_LOGIC;
  signal \ram_reg_0_31_0_0__9_n_0\ : STD_LOGIC;
  signal ram_reg_0_31_0_0_i_1_n_0 : STD_LOGIC;
  signal ram_reg_0_31_0_0_n_0 : STD_LOGIC;
  signal \^spo\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute KEEP : string;
  attribute KEEP of \qspo_int_reg[0]\ : label is "yes";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of \qspo_int_reg[0]\ : label is "no";
  attribute KEEP of \qspo_int_reg[10]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[10]\ : label is "no";
  attribute KEEP of \qspo_int_reg[11]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[11]\ : label is "no";
  attribute KEEP of \qspo_int_reg[12]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[12]\ : label is "no";
  attribute KEEP of \qspo_int_reg[13]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[13]\ : label is "no";
  attribute KEEP of \qspo_int_reg[14]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[14]\ : label is "no";
  attribute KEEP of \qspo_int_reg[15]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[15]\ : label is "no";
  attribute KEEP of \qspo_int_reg[1]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[1]\ : label is "no";
  attribute KEEP of \qspo_int_reg[2]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[2]\ : label is "no";
  attribute KEEP of \qspo_int_reg[3]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[3]\ : label is "no";
  attribute KEEP of \qspo_int_reg[4]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[4]\ : label is "no";
  attribute KEEP of \qspo_int_reg[5]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[5]\ : label is "no";
  attribute KEEP of \qspo_int_reg[6]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[6]\ : label is "no";
  attribute KEEP of \qspo_int_reg[7]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[7]\ : label is "no";
  attribute KEEP of \qspo_int_reg[8]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[8]\ : label is "no";
  attribute KEEP of \qspo_int_reg[9]\ : label is "yes";
  attribute equivalent_register_removal of \qspo_int_reg[9]\ : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of ram_reg_0_15_0_0 : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__0\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__1\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__10\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__11\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__12\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__13\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__14\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__2\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__3\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__4\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__5\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__6\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__7\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__8\ : label is "RAM16X1S";
  attribute XILINX_LEGACY_PRIM of \ram_reg_0_15_0_0__9\ : label is "RAM16X1S";
begin
  spo(15 downto 0) <= \^spo\(15 downto 0);
\qspo_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(0),
      Q => qspo_int(0),
      R => '0'
    );
\qspo_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(10),
      Q => qspo_int(10),
      R => '0'
    );
\qspo_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(11),
      Q => qspo_int(11),
      R => '0'
    );
\qspo_int_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(12),
      Q => qspo_int(12),
      R => '0'
    );
\qspo_int_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(13),
      Q => qspo_int(13),
      R => '0'
    );
\qspo_int_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(14),
      Q => qspo_int(14),
      R => '0'
    );
\qspo_int_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(15),
      Q => qspo_int(15),
      R => '0'
    );
\qspo_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(1),
      Q => qspo_int(1),
      R => '0'
    );
\qspo_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(2),
      Q => qspo_int(2),
      R => '0'
    );
\qspo_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(3),
      Q => qspo_int(3),
      R => '0'
    );
\qspo_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(4),
      Q => qspo_int(4),
      R => '0'
    );
\qspo_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(5),
      Q => qspo_int(5),
      R => '0'
    );
\qspo_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(6),
      Q => qspo_int(6),
      R => '0'
    );
\qspo_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(7),
      Q => qspo_int(7),
      R => '0'
    );
\qspo_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(8),
      Q => qspo_int(8),
      R => '0'
    );
\qspo_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \^spo\(9),
      Q => qspo_int(9),
      R => '0'
    );
ram_reg_0_15_0_0: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(0),
      O => ram_reg_0_15_0_0_n_0,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__0\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(1),
      O => \ram_reg_0_15_0_0__0_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__1\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(2),
      O => \ram_reg_0_15_0_0__1_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__10\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(11),
      O => \ram_reg_0_15_0_0__10_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__11\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(12),
      O => \ram_reg_0_15_0_0__11_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__12\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(13),
      O => \ram_reg_0_15_0_0__12_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__13\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(14),
      O => \ram_reg_0_15_0_0__13_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__14\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(15),
      O => \ram_reg_0_15_0_0__14_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__2\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(3),
      O => \ram_reg_0_15_0_0__2_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__3\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(4),
      O => \ram_reg_0_15_0_0__3_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__4\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(5),
      O => \ram_reg_0_15_0_0__4_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__5\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(6),
      O => \ram_reg_0_15_0_0__5_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__6\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(7),
      O => \ram_reg_0_15_0_0__6_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__7\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(8),
      O => \ram_reg_0_15_0_0__7_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__8\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(9),
      O => \ram_reg_0_15_0_0__8_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
\ram_reg_0_15_0_0__9\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => '0',
      D => d(10),
      O => \ram_reg_0_15_0_0__9_n_0\,
      WCLK => clk,
      WE => ram_reg_0_15_0_0_i_1_n_0
    );
ram_reg_0_15_0_0_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => a(4),
      I1 => a(5),
      I2 => we,
      O => ram_reg_0_15_0_0_i_1_n_0
    );
ram_reg_0_31_0_0: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(0),
      O => ram_reg_0_31_0_0_n_0,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__0\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(1),
      O => \ram_reg_0_31_0_0__0_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__1\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(2),
      O => \ram_reg_0_31_0_0__1_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__10\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(11),
      O => \ram_reg_0_31_0_0__10_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__11\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(12),
      O => \ram_reg_0_31_0_0__11_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__12\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(13),
      O => \ram_reg_0_31_0_0__12_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__13\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(14),
      O => \ram_reg_0_31_0_0__13_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__14\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(15),
      O => \ram_reg_0_31_0_0__14_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__2\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(3),
      O => \ram_reg_0_31_0_0__2_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__3\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(4),
      O => \ram_reg_0_31_0_0__3_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__4\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(5),
      O => \ram_reg_0_31_0_0__4_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__5\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(6),
      O => \ram_reg_0_31_0_0__5_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__6\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(7),
      O => \ram_reg_0_31_0_0__6_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__7\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(8),
      O => \ram_reg_0_31_0_0__7_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__8\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(9),
      O => \ram_reg_0_31_0_0__8_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
\ram_reg_0_31_0_0__9\: unisim.vcomponents.RAM32X1S
    generic map(
      INIT => X"00000000"
    )
        port map (
      A0 => a(0),
      A1 => a(1),
      A2 => a(2),
      A3 => a(3),
      A4 => a(4),
      D => d(10),
      O => \ram_reg_0_31_0_0__9_n_0\,
      WCLK => clk,
      WE => ram_reg_0_31_0_0_i_1_n_0
    );
ram_reg_0_31_0_0_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => we,
      I1 => a(5),
      O => ram_reg_0_31_0_0_i_1_n_0
    );
\spo[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => ram_reg_0_15_0_0_n_0,
      I1 => a(4),
      I2 => a(5),
      I3 => ram_reg_0_31_0_0_n_0,
      O => \^spo\(0)
    );
\spo[10]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__9_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__9_n_0\,
      O => \^spo\(10)
    );
\spo[11]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__10_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__10_n_0\,
      O => \^spo\(11)
    );
\spo[12]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__11_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__11_n_0\,
      O => \^spo\(12)
    );
\spo[13]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__12_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__12_n_0\,
      O => \^spo\(13)
    );
\spo[14]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__13_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__13_n_0\,
      O => \^spo\(14)
    );
\spo[15]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__14_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__14_n_0\,
      O => \^spo\(15)
    );
\spo[1]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__0_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__0_n_0\,
      O => \^spo\(1)
    );
\spo[2]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__1_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__1_n_0\,
      O => \^spo\(2)
    );
\spo[3]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__2_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__2_n_0\,
      O => \^spo\(3)
    );
\spo[4]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__3_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__3_n_0\,
      O => \^spo\(4)
    );
\spo[5]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__4_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__4_n_0\,
      O => \^spo\(5)
    );
\spo[6]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__5_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__5_n_0\,
      O => \^spo\(6)
    );
\spo[7]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__6_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__6_n_0\,
      O => \^spo\(7)
    );
\spo[8]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__7_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__7_n_0\,
      O => \^spo\(8)
    );
\spo[9]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \ram_reg_0_15_0_0__8_n_0\,
      I1 => a(4),
      I2 => a(5),
      I3 => \ram_reg_0_31_0_0__8_n_0\,
      O => \^spo\(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12_synth is
  port (
    spo : out STD_LOGIC_VECTOR ( 15 downto 0 );
    we : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 5 downto 0 );
    clk : in STD_LOGIC;
    d : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12_synth : entity is "dist_mem_gen_v8_0_12_synth";
end ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12_synth;

architecture STRUCTURE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12_synth is
begin
\gen_sp_ram.spram_inst\: entity work.ResultStorage_dist_mem_gen_0_spram
     port map (
      a(5 downto 0) => a(5 downto 0),
      clk => clk,
      d(15 downto 0) => d(15 downto 0),
      spo(15 downto 0) => spo(15 downto 0),
      we => we
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 is
  port (
    a : in STD_LOGIC_VECTOR ( 5 downto 0 );
    d : in STD_LOGIC_VECTOR ( 15 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 5 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    i_ce : in STD_LOGIC;
    qspo_ce : in STD_LOGIC;
    qdpo_ce : in STD_LOGIC;
    qdpo_clk : in STD_LOGIC;
    qspo_rst : in STD_LOGIC;
    qdpo_rst : in STD_LOGIC;
    qspo_srst : in STD_LOGIC;
    qdpo_srst : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dpo : out STD_LOGIC_VECTOR ( 15 downto 0 );
    qspo : out STD_LOGIC_VECTOR ( 15 downto 0 );
    qdpo : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute C_ADDR_WIDTH : integer;
  attribute C_ADDR_WIDTH of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 6;
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is "0";
  attribute C_DEPTH : integer;
  attribute C_DEPTH of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 48;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is "./";
  attribute C_FAMILY : string;
  attribute C_FAMILY of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is "artix7";
  attribute C_HAS_CLK : integer;
  attribute C_HAS_CLK of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_HAS_D : integer;
  attribute C_HAS_D of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QSPO : integer;
  attribute C_HAS_QSPO of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QSPO_CE : integer;
  attribute C_HAS_QSPO_CE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QSPO_RST : integer;
  attribute C_HAS_QSPO_RST of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_QSPO_SRST : integer;
  attribute C_HAS_QSPO_SRST of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_HAS_SPO : integer;
  attribute C_HAS_SPO of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_MEM_INIT_FILE : string;
  attribute C_MEM_INIT_FILE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is "no_coe_file_loaded";
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_PARSER_TYPE : integer;
  attribute C_PARSER_TYPE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_READ_MIF : integer;
  attribute C_READ_MIF of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_REG_A_D_INPUTS : integer;
  attribute C_REG_A_D_INPUTS of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 0;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 1;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is 16;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 : entity is "dist_mem_gen_v8_0_12";
end ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12;

architecture STRUCTURE of ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12 is
  signal \<const0>\ : STD_LOGIC;
begin
  dpo(15) <= \<const0>\;
  dpo(14) <= \<const0>\;
  dpo(13) <= \<const0>\;
  dpo(12) <= \<const0>\;
  dpo(11) <= \<const0>\;
  dpo(10) <= \<const0>\;
  dpo(9) <= \<const0>\;
  dpo(8) <= \<const0>\;
  dpo(7) <= \<const0>\;
  dpo(6) <= \<const0>\;
  dpo(5) <= \<const0>\;
  dpo(4) <= \<const0>\;
  dpo(3) <= \<const0>\;
  dpo(2) <= \<const0>\;
  dpo(1) <= \<const0>\;
  dpo(0) <= \<const0>\;
  qdpo(15) <= \<const0>\;
  qdpo(14) <= \<const0>\;
  qdpo(13) <= \<const0>\;
  qdpo(12) <= \<const0>\;
  qdpo(11) <= \<const0>\;
  qdpo(10) <= \<const0>\;
  qdpo(9) <= \<const0>\;
  qdpo(8) <= \<const0>\;
  qdpo(7) <= \<const0>\;
  qdpo(6) <= \<const0>\;
  qdpo(5) <= \<const0>\;
  qdpo(4) <= \<const0>\;
  qdpo(3) <= \<const0>\;
  qdpo(2) <= \<const0>\;
  qdpo(1) <= \<const0>\;
  qdpo(0) <= \<const0>\;
  qspo(15) <= \<const0>\;
  qspo(14) <= \<const0>\;
  qspo(13) <= \<const0>\;
  qspo(12) <= \<const0>\;
  qspo(11) <= \<const0>\;
  qspo(10) <= \<const0>\;
  qspo(9) <= \<const0>\;
  qspo(8) <= \<const0>\;
  qspo(7) <= \<const0>\;
  qspo(6) <= \<const0>\;
  qspo(5) <= \<const0>\;
  qspo(4) <= \<const0>\;
  qspo(3) <= \<const0>\;
  qspo(2) <= \<const0>\;
  qspo(1) <= \<const0>\;
  qspo(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\synth_options.dist_mem_inst\: entity work.ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12_synth
     port map (
      a(5 downto 0) => a(5 downto 0),
      clk => clk,
      d(15 downto 0) => d(15 downto 0),
      spo(15 downto 0) => spo(15 downto 0),
      we => we
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ResultStorage_dist_mem_gen_0 is
  port (
    a : in STD_LOGIC_VECTOR ( 5 downto 0 );
    d : in STD_LOGIC_VECTOR ( 15 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ResultStorage_dist_mem_gen_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ResultStorage_dist_mem_gen_0 : entity is "ResultStorage_dist_mem_gen_0,dist_mem_gen_v8_0_12,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ResultStorage_dist_mem_gen_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of ResultStorage_dist_mem_gen_0 : entity is "dist_mem_gen_v8_0_12,Vivado 2017.4";
end ResultStorage_dist_mem_gen_0;

architecture STRUCTURE of ResultStorage_dist_mem_gen_0 is
  signal NLW_U0_dpo_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_U0_qdpo_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_U0_qspo_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "artix7";
  attribute C_HAS_CLK : integer;
  attribute C_HAS_CLK of U0 : label is 1;
  attribute C_HAS_D : integer;
  attribute C_HAS_D of U0 : label is 1;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of U0 : label is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of U0 : label is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of U0 : label is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of U0 : label is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of U0 : label is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of U0 : label is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of U0 : label is 0;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of U0 : label is 1;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 1;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of U0 : label is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of U0 : label is 0;
  attribute c_addr_width : integer;
  attribute c_addr_width of U0 : label is 6;
  attribute c_default_data : string;
  attribute c_default_data of U0 : label is "0";
  attribute c_depth : integer;
  attribute c_depth of U0 : label is 48;
  attribute c_elaboration_dir : string;
  attribute c_elaboration_dir of U0 : label is "./";
  attribute c_has_i_ce : integer;
  attribute c_has_i_ce of U0 : label is 0;
  attribute c_has_qspo : integer;
  attribute c_has_qspo of U0 : label is 0;
  attribute c_has_qspo_ce : integer;
  attribute c_has_qspo_ce of U0 : label is 0;
  attribute c_has_qspo_rst : integer;
  attribute c_has_qspo_rst of U0 : label is 0;
  attribute c_has_qspo_srst : integer;
  attribute c_has_qspo_srst of U0 : label is 0;
  attribute c_has_spo : integer;
  attribute c_has_spo of U0 : label is 1;
  attribute c_mem_init_file : string;
  attribute c_mem_init_file of U0 : label is "no_coe_file_loaded";
  attribute c_parser_type : integer;
  attribute c_parser_type of U0 : label is 1;
  attribute c_pipeline_stages : integer;
  attribute c_pipeline_stages of U0 : label is 0;
  attribute c_qualify_we : integer;
  attribute c_qualify_we of U0 : label is 0;
  attribute c_read_mif : integer;
  attribute c_read_mif of U0 : label is 0;
  attribute c_reg_a_d_inputs : integer;
  attribute c_reg_a_d_inputs of U0 : label is 0;
  attribute c_sync_enable : integer;
  attribute c_sync_enable of U0 : label is 1;
  attribute c_width : integer;
  attribute c_width of U0 : label is 16;
begin
U0: entity work.ResultStorage_dist_mem_gen_0_dist_mem_gen_v8_0_12
     port map (
      a(5 downto 0) => a(5 downto 0),
      clk => clk,
      d(15 downto 0) => d(15 downto 0),
      dpo(15 downto 0) => NLW_U0_dpo_UNCONNECTED(15 downto 0),
      dpra(5 downto 0) => B"000000",
      i_ce => '1',
      qdpo(15 downto 0) => NLW_U0_qdpo_UNCONNECTED(15 downto 0),
      qdpo_ce => '1',
      qdpo_clk => '0',
      qdpo_rst => '0',
      qdpo_srst => '0',
      qspo(15 downto 0) => NLW_U0_qspo_UNCONNECTED(15 downto 0),
      qspo_ce => '1',
      qspo_rst => '0',
      qspo_srst => '0',
      spo(15 downto 0) => spo(15 downto 0),
      we => we
    );
end STRUCTURE;
