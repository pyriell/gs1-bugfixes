--------------------------------------------------------------------------------
-- patcher.lua                                                                --
-- 2013-11-25  - Pyriel                                                       --
--                                                                            --
--This script does most of the work of extracting, patching, and rebuilding   --
--the disc.                                                                   --
--                                                                            --
--------------------------------------------------------------------------------

PackageInfo = {
	Name 		= "Gensou Suikoden Bug Fix Patch",
	ShortName	= "GS Bug Fix Patch",
	Version		= "1.00.002",
	Date		= "2013-11-27",
	FinalSector = 250907,
	Games		= {
		{ Name = "Suikoden v1.0", Region = "North America", Language = "English", Serial = "SLUS_002.92", PatchDir="patch\\NAV10",
		  Patches = {
			{
				Name = "Bribe Glitch",
				Description = "Fixes a glitch that allowed bosses and even impossible battles to be bypassed with Bribe",
				Active = 1, Toggle = 0,
				Files = {
					{ Type = "PPF", PatchFileName = "bribe.ppf", GameFileName = "MAIN.EXE" }
				}
			},
			{
				Name = "Clay Guardian (Base Defense)",
				Description = "Restores the Clay Guardian spell's effects, using unarmored defense to compute the bonus.",
				Active = 1, Toggle = 0,
				Files = {
					{ Type = "PPF", PatchFileName = "clay_guardian_base.ppf", GameFileName = "MAIN.EXE" }
				},
				Excludes = { "Clay Guardian (Total Defense)" }
			},
			{
				Name = "Clay Guardian (Total Defense)",
				Description = "Restores the Clay Guardian spell's effects, using armored defense to compute the bonus.",
				Active = 0, Toggle = 0,
				Files = {
					{ Type = "PPF", PatchFileName = "clay_guardian_total.ppf", GameFileName = "MAIN.EXE" }
				},
				Excludes = { "Clay Guardian (Base Defense)" }
			},
			{
				Name = "Escape Talismans (Krin)",
				Description = "Adds a quantity of 1 to the Escape Talisman Krin starts with, so it cannot be used multiple times.",
				Active = 1, Toggle = 0,
				Files = {
					{ Type = "PPF", PatchFileName = "escape_talisman_krin.ppf", GameFileName = "SLUS_002.92" }
				}
			},
			{
				Name = "Escape Talismans (Stallion)",
				Description = "Adds a quantity of 1 to the Escape Talisman Stallion starts with, so it cannot be used multiple times.",
				Active = 1, Toggle = 0,
				Files = {
					{ Type = "PPF", PatchFileName = "escape_talisman_stallion.ppf", GameFileName = "SLUS_002.92" }
				}
			},
			{
				Name = "Guardian of Earth (Base Defense)",
				Description = "Restores the Guardian of Earth spell's effects, using unarmored defense to compute the bonus.",
				Active = 1, Toggle = 0,
				Files = {
					{ Type = "PPF", PatchFileName = "guardian_of_earth_base.ppf", GameFileName = "MAIN.EXE" }
				},
				Excludes = { "Guardian of Earth (Total Defense)" }
			},
			{
				Name = "Guardian of Earth (Total Defense)",
				Description = "Restores the Guardian of Earth spell's effects, using armored defense to compute the bonus.",
				Active = 0, Toggle = 0,
				Files = {
					{ Type = "PPF", PatchFileName = "guardian_of_earth_total.ppf", GameFileName = "MAIN.EXE" }
				},
				Excludes = { "Guardian of Earth (Base Defense)" }
			},
		  }, -- end patches

		  LBAPatchList= {
			-- { name="SLUS_009.58",     path="/",     startsector=0,   seekpos=0x7dbbc },
		  }, -- end LBAPatchList

		  FileList = {
			{ name="573LOGO.STR",	path="/DEMO/",	lba=0,	size=0 },
			{ name="SUIKODEN.STR",	path="/DEMO/",	lba=0,	size=0 },
			{ name="SYSTEM.CNF",	path="/",	lba=0,	size=0 },
			{ name="MAIN.EXE",	path="/",	lba=0,	size=0 },
			{ name="SLUS_002.92",	path="/",	lba=0,	size=0 },
			{ name="LOG.BAK",	path="/DATA/",	lba=0,	size=0 },
			{ name="VX005J.CCS",	path="/DATA/",	lba=0,	size=0 },
			{ name="BATTLE.BIN",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="LOADING.BIN",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="ORCH.VA",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="ORCH.VB",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="PASS.8",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="SEQ.BIN",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="SOUND.573",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="STAY.VA",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="STAY.VB",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="STAY2.VA",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="STAY2.VB",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="STAY3.VA",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="STAY3.VB",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="STAY4.VA",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="STAY4.VB",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="STAY5.VA",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="STAY5.VB",	path="/DATA/00_INIT/",	lba=0,	size=0 },
			{ name="A00.VA",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A00.VB",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A01.VA",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A01.VB",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A02.VA",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A02.VB",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A03.VA",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A03.VB",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A04.VA",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A04.VB",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A05.VA",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A05.VB",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A08.VA",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A08.VB",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A09.VA",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A09.VB",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A12.VA",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A12.VB",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A13.VA",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A13.VB",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="AREAA_1.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="AREAA_2.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="AREAA_3.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="A_DATA.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="CDSE1.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="CDSE18.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="CDSE2.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="CDSE3.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="CDSE4.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="CDSE5.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="CDSE6.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="DJ2.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="DRAGON0.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="EV1.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="EV14.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="MORI.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="MOUNT.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="SHIRO1.8",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VA1.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VA2.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VA3.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VA4.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VA4B.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VA5.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VA6.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VA7.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VA8.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VA9.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VAA.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="VAAD.BIN",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="XA1.",	path="/DATA/01_AREA.A/",	lba=0,	size=0 },
			{ name="AREAB_1.8",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="B00.VA",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="B00.VB",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="B01.VA",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="B01.VB",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="B02.VA",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="B02.VB",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="B03.VA",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="B03.VB",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="B_DATA.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="CDSE20.8",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="J_DATA.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB1.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB2.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB3.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB4.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5A1.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5A2.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5A21.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5AB.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5AG.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5B1.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5B2.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5B3.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5B31.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5B4.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5BA.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5BB.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5BG.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5C1.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5C2.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5C3.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5C4.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5CA.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5CB.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5CC.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5CG.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5G.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5I0.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5I2.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5I3.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB5I4.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB6.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB7.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB7A.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB7D.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB8.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="VB9.BIN",	path="/DATA/02_AREA.B/",	lba=0,	size=0 },
			{ name="AZUKARI.BIN",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="BATH.BIN",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="BATH.VA",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="BATH.VB",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="BOOKS.BIN",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="CHIN.VA",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="CHIN.VB",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="COIN.BIN",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="EV10.8",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="EV4.8",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="EV8.8",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="FURO1.8",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="FURO2.8",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="FURO3.8",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="FURO4.8",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="HNK1.VA",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="HNK1.VB",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="HNK2.VA",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="HNK2.VB",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="KARUTA.BIN",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="KESSEN.VA",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="KESSEN.VB",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="LIB.VA",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="LIB.VB",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="MEL_SEL.BIN",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="SD_TEST.BIN",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="STONE.BIN",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="TITLE.8",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="WALL.BIN",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="WAR3.8",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="WIN_SEL.BIN",	path="/DATA/03_SHIRO/",	lba=0,	size=0 },
			{ name="BATH_00.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_01.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_02.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_03.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_04.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_05.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_10.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_11.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_12.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_13.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_14.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_15.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_20.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_21.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_22.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_23.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_24.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_25.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_30.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_31.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_32.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_33.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_34.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BATH_35.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BOOK_0.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BOOK_1.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BOOK_2.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BOOK_3.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BOOK_4.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="BOOK_5.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="CURIO_0.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_01.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_02.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_03.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_04.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_05.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_06.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_07.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_08.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_09.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_10.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_11.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_12.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_13.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_14.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_15.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_16.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_17.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_18.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_19.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_20.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_21.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_22.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_23.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_24.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_25.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_26.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="FACE_27.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="HANA.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="MIZU_00.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="PAPER_0.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="PAPER_1.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="PAPER_2.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="PAPER_3.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="PAPER_4.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="PAPER_5.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_00.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_01.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_02.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_03.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_04.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_05.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_06.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_07.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_08.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_09.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_0A.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_0B.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_0C.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_0D.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_0E.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_0F.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_10.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="STONE_11.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="YUGE_00.BIN",	path="/DATA/03_SHIRO/DATA/",	lba=0,	size=0 },
			{ name="AIL.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="ANJ.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="ANT.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="ARE.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="BAL.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="BEL.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="BLK.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="CAM.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="COB.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="CRE.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="CRI.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="CRO.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="CRW.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="CSI.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="EIK.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="FMA.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="FRI.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="FUK.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="FUT.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="FUU.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="GEN.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="GON.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="GRE.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="GRI.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="GRN.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="HAF.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="HEL.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="HIC.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="JUP.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KAG.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KAI.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KAM.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KAS.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KES.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KIB.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KIL.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KNA.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KRA.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KRK.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="KWA.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="LEO.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="LOT.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="LUB.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="LUK.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="MAA.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="MEG.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="MES.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="MIL.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="MIS.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="MOH.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="MOS.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="MRI.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="MUU.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="MYI.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="ODE.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="PAN.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="PSU.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="QIN.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="REP.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="RES.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="ROR.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="RYK.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="SAS.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="SEI.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="SEL.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="SHU.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="SID.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="SIL.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="SNI.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="STA.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="SYY.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="TAI.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="TED.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="TEN.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="VIC.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="VRE.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="WOU.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="YAM.BIN",	path="/DATA/04_PLAY/",	lba=0,	size=0 },
			{ name="BATTLE1.8",	path="/DATA/05_BATLE/",	lba=0,	size=0 },
			{ name="BATTLE2.8",	path="/DATA/05_BATLE/",	lba=0,	size=0 },
			{ name="GAMEOVER.BIN",	path="/DATA/05_BATLE/",	lba=0,	size=0 },
			{ name="WIN1.8",	path="/DATA/05_BATLE/",	lba=0,	size=0 },
			{ name="AREAC_1.8",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="AREAC_1B.8",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="AREAC_2.8",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C00.VA",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C00.VB",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C01.VA",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C01.VB",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C02.VA",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C02.VB",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C03.VA",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C03.VB",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C05.VA",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C05.VB",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="C_DATA.BIN",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="EV3.8",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="VC1.BIN",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="VC2.BIN",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="VC3.BIN",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="VC4.BIN",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="VC5.BIN",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="VC6.BIN",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="VC61.BIN",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="VCD.BIN",	path="/DATA/06_AREA.C/",	lba=0,	size=0 },
			{ name="AREAD_1.8",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="AREAD_2.8",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="AREAD_3.8",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="CDSE15.8",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="D00.VA",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="D00.VB",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="D01.VA",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="D01.VB",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="D05.VA",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="D05.VB",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="D06.VA",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="D06.VB",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="DJ1.8",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="D_DATA.BIN",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="EV11.8",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="K_DATA.BIN",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="SHIRO2.8",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="VD1.BIN",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="VD2.BIN",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="VD3.BIN",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="VD4.BIN",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="VD5.BIN",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="VD6.BIN",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="VD7.BIN",	path="/DATA/07_AREA.D/",	lba=0,	size=0 },
			{ name="AREAE_1.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="AREAE_2.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="AREAE_3.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="E00.VA",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="E00.VB",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="E01.VA",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="E01.VB",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="E02.VA",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="E02.VB",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="EV12.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="EV13.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="EV15.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="EV2.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="EV5.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="EV5B.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="EV6.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="EV7.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="EV9.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="E_DATA.BIN",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="GATE.8",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="VE1.BIN",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="VE2.BIN",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="VE3.BIN",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="VE4.BIN",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="VE5.BIN",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="VE6.BIN",	path="/DATA/08_AREA.E/",	lba=0,	size=0 },
			{ name="AREAF_1.8",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="CDSE11.8",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="F00.VA",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="F00.VB",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="F01.VA",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="F01.VB",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="F03.VA",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="F03.VB",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="F_DATA.BIN",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="VF1.BIN",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="VF2.BIN",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="VF3.BIN",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="VF4.BIN",	path="/DATA/09_AREA.F/",	lba=0,	size=0 },
			{ name="AREAG_1.8",	path="/DATA/10_AREA.G/",	lba=0,	size=0 },
			{ name="AREAG_2.8",	path="/DATA/10_AREA.G/",	lba=0,	size=0 },
			{ name="G00.VA",	path="/DATA/10_AREA.G/",	lba=0,	size=0 },
			{ name="G00.VB",	path="/DATA/10_AREA.G/",	lba=0,	size=0 },
			{ name="G03.VA",	path="/DATA/10_AREA.G/",	lba=0,	size=0 },
			{ name="G03.VB",	path="/DATA/10_AREA.G/",	lba=0,	size=0 },
			{ name="G_DATA.BIN",	path="/DATA/10_AREA.G/",	lba=0,	size=0 },
			{ name="VG1.BIN",	path="/DATA/10_AREA.G/",	lba=0,	size=0 },
			{ name="VG2.BIN",	path="/DATA/10_AREA.G/",	lba=0,	size=0 },
			{ name="VG3.BIN",	path="/DATA/10_AREA.G/",	lba=0,	size=0 },
			{ name="H00.VA",	path="/DATA/11_AREA.H/",	lba=0,	size=0 },
			{ name="H00.VB",	path="/DATA/11_AREA.H/",	lba=0,	size=0 },
			{ name="H01.VA",	path="/DATA/11_AREA.H/",	lba=0,	size=0 },
			{ name="H01.VB",	path="/DATA/11_AREA.H/",	lba=0,	size=0 },
			{ name="H_DATA.BIN",	path="/DATA/11_AREA.H/",	lba=0,	size=0 },
			{ name="VH1.BIN",	path="/DATA/11_AREA.H/",	lba=0,	size=0 },
			{ name="VH2.BIN",	path="/DATA/11_AREA.H/",	lba=0,	size=0 },
			{ name="BATTLE3.8",	path="/DATA/12_IKKI/",	lba=0,	size=0 },
			{ name="EV3B.8",	path="/DATA/12_IKKI/",	lba=0,	size=0 },
			{ name="PAN_TEO.BIN",	path="/DATA/12_IKKI/",	lba=0,	size=0 },
			{ name="SHU_KWA.BIN",	path="/DATA/12_IKKI/",	lba=0,	size=0 },
			{ name="SHU_TEO.BIN",	path="/DATA/12_IKKI/",	lba=0,	size=0 },
			{ name="BT1_1S00.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="BT2_1S00.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="BT2_1S01.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="BT2_1S02.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="BT2_1S03.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="BT2_1S04.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="BT2_1S05.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="BT2_1S06.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="BT2_1S07.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="BT2_1S08.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="BT2_1S09.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_KWA_0.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_KWA_1.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_KWA_2.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_KWA_3.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_KWA_4.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_KWA_5.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_KWA_6.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_PAN_0.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_PAN_1.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_PAN_2.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_PAN_3.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_PAN_4.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_PAN_5.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_PAN_6.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_SHU_0.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_SHU_1.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_SHU_2.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_SHU_3.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_SHU_4.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_SHU_5.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_SHU_6.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_TEO_0.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_TEO_1.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_TEO_2.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_TEO_3.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_TEO_4.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_TEO_5.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="IC_TEO_6.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="SKY1_1.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="SKY1_2.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="SKY1_3.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="SKY2_1.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="SKY2_2.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="SKY2_3.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="SKY3_1.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="SKY3_2.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="SKY3_3.BIN",	path="/DATA/12_IKKI/DATA/",	lba=0,	size=0 },
			{ name="AREAI_1.8",	path="/DATA/13_AREA.I/",	lba=0,	size=0 },
			{ name="I_DATA.BIN",	path="/DATA/13_AREA.I/",	lba=0,	size=0 },
			{ name="VI1.BIN",	path="/DATA/13_AREA.I/",	lba=0,	size=0 },
			{ name="VI2.BIN",	path="/DATA/13_AREA.I/",	lba=0,	size=0 },
			{ name="VS1.BIN",	path="/DATA/14_AREA.S/",	lba=0,	size=0 },
			{ name="VS2.BIN",	path="/DATA/14_AREA.S/",	lba=0,	size=0 },
			{ name="A07.VA",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="A07.VB",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="AREAA_1B.8",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="CDSE9.8",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="END.8",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="EV16.8",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="STAFF.8",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="VAC.BIN",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="VAD.BIN",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="VZ1.BIN",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="VZ2.BIN",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="VZ3.BIN",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="VZ5.BIN",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="VZ7.BIN",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="VZ8.BIN",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="VZV.BIN",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="Z_DATA.BIN",	path="/DATA/15_AREA.Z/",	lba=0,	size=0 },
			{ name="WAR.VA",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR.VB",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR1.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR_GARA.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR_KITA.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR_KUWA.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR_LAST.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR_SCA1.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR_SCA2.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR_SHAS.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR_TEO1.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="WAR_TEO2.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="W_HEADER.BIN",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="XA2.",	path="/DATA/16_WAR/",	lba=0,	size=0 },
			{ name="OPEN15MX.STR",	path="/",	lba=0,	size=0 },
		  } -- end file list
		},  -- end game NA
	} -- end games
} -- end PackageInfo
--------------------------------------------------------------------------------
--  GetCurrDirName                                                            --
--                                                                            --
--Returns the name of the current directory, given a full path.               --
--Expects a path minus the file name, e.g. /CDROM/010_ARA/                    --
--Returns the lowest directory represented (/010_ARA/).                       --
--                                                                            --
--Arguments:                                                                  --
--  path - A string representing the current absolute path.                   --
--                                                                            --
--------------------------------------------------------------------------------
function GetCurrDirName (path)
	local str, i, j;
	i, j = string.find(path, "/[^/]+/$");
	if(i ~= nil) then
		str = string.sub(path, i, j);
	end
	return str or "/";
end


--------------------------------------------------------------------------------
--  IsXA/IsSTR                                                                --
--                                                                            --
--Accepts a filename (just name or full path) and returns true if the         --
--extension is XA or STR.  Konami sometimes mangled or omitted certain        --
--properties when they built the disc, so examining the file system isn't     --
--very reliable.                                                              --
--                                                                            --
--Mainly required for determining mode when copying files (XA/STR are odd)    --
--                                                                            --
--Arguments:                                                                  --
--  path - A string ending in a file name.                                    --
--                                                                            --
--------------------------------------------------------------------------------
function IsXA (path)
	local tmp = string.upper(string.sub(path, 1, 2)) == "XA"
	return string.upper(string.sub(path, string.len(path) - 1)) == "XA" or tmp
end

function IsSTR (path)
	return string.upper(string.sub(path, string.len(path) - 2)) == "STR"
end


function verify(cdutil, mainexe, workdir)
	local hFile, out;
	local direntELF = cdutil:findpath("/" .. mainexe .. ";1")
	if (direntELF == nil) then
		print ("Main exe not found")
		return false
	end
	local deFile = cdutil:findpath("/SYSTEM.CNF;1")
	if (deFile == nil) then
		print ("system.cnf not found")
		return false
	end

	print("Disc verified.")

	hFile = cdfile(deFile);
	out = Output(workdir .. "\\SYSTEM.CNF");
	out:copyfrom(hFile);
	out:close();
	hFile:close();
	return true
end

--------------------------------------------------------------------------------
--  GetDir                                                                    --
--                                                                            --
--Function to get a DirEnt object required for writing files to their proper  --
--location on the target image.                                               --
--                                                                            --
--CD-Tool is a little light on directory parsing, so the pathtree global      --
--exists to track what directories have been created, and to hold copies of   --
--their DirEnts for later use.  This function checks to see if a directory    --
--has already been created, and returns its DirEnt if it has.                 --
--                                                                            --
--If the requested directory has not yet been created, the function will do so--
--including creating any parent directories.  It then saves the created       --
--DirEnts, and returns the DirEnt of the lowest directory passed.             --
--                                                                            --
--Example:  /CDROM/010_ARA/ is passed.  If both exist, the DirEnt for 010_ARA --
--will be retrieved from pathtree and returned.  If 010_ARA does not exist, it--
--will be created, its DirEnt will be retained in pathtree, and then returned.--
--If neither exists, CDROM will be created and retained, followed by 010_ARA. --
--Again, 010_ARA's DirEnt will be returned.                                   --
--                                                                            --
--Arguments:                                                                  --
--  path - A string representing the current absolute path.                   --
--                                                                            --
--------------------------------------------------------------------------------
function GetDir(iso, path)
	local dirCurr;
	if(pathtree[path] == nil) then
		local strCurr   = GetCurrDirName(path);
		local strParent = string.sub(path, 1, string.len(path) - string.len(strCurr)) .. "/";
--  might have to create an additional parent
		if(pathtree[strParent] == nil) then
			GetDir(iso, strParent);
		end
		local dirParent = pathtree[strParent].dir;
		local tmpd		 = cdutil:findpath(path);
		local nsect		 = tmpd.Size / 2048;
		dirCurr   = iso:createdir(dirParent, string.gsub(strCurr, "/", ""), nsect);
		if(tmpd:hasxa()) then dirCurr:setbasicsxa(); end
		pathtree[path] = { dir=dirCurr, parent=dirParent };
	else
		dirCurr = pathtree[path].dir;
	end
	return dirCurr;
end


--------------------------------------------------------------------------------
--  ApplyLBAPatch                                                             --
--                                                                            --
--Builds an array of Logical Block Addresses and file sizes (bytes) and writes--
--it to several files.  GSII does not seek using the table of contents  It    --
--uses this LBA listing to seek sectors directly.                             --
--                                                                            --
--Arguments:                                                                  --
--  None                                                                      --
--                                                                            --
--------------------------------------------------------------------------------
function ApplyLBAPatch (iso, workdir)
	local dirFile;
	local tgtFile;
	for i,v in ipairs(LBAPatchList) do
		print("Applying LBA Patch to " .. v.name)
		strPatchStatus = "Applying LBA Patch to " .. v.name
		if(iup) then coroutine.yield() end
		tgtFile = Input(workdir .. "\\" .. v.name);
		local buf = Buffer(true);
		local lba = GetLBAFromFileList(v.name, v.path);
		buf:copyfrom(tgtFile);
		buf:seek(v.seekpos);
		local tmp = buf:readU32();
		if(tmp ~= 68 and tmp ~= 0x9F800) then
			print(v.path .. v.name .. "Unable to apply LBA Patch.  Incorrect file position or table already modified");
		end
		buf:wseek(v.seekpos);
		for j,w in ipairs(FileList) do
			buf:writeU32(w.size);
			buf:writeU32(w.lba);
		end
		buf:seek(0);
		iso:putfile(buf, MODE2_FORM1, lba);
	end
end


--------------------------------------------------------------------------------
--  GetLBAFromFileList                                                        --
--                                                                            --
--The FileList saves the LBA of files written to the target ISO.  This        --
--function retrieves it, given a path and a file name.                        --
--                                                                            --
--Arguments:                                                                  --
--  name - name of the file                                                   --
--  path - path of the file, not including the file name.                     --
--------------------------------------------------------------------------------
function GetLBAFromFileList (name, path)
	local lba
	for i, v in ipairs(FileList) do
		if(v.name == name and v.path == path) then
			lba = v.lba;
			break;
		end
	end
	return lba;
end

function PatchRequested(name)
	local i, v;
	for i, v in ipairs(patchreq) do
		if(v.file == name) then
			return true;
		end
	end
	return false;
end

function ApplyPatch(patch, file)
	local i, j, v, patchbyte;
	for j, v in pairs(patch) do
		for i, patchbyte in ipairs(v) do
			file[j + i - 1] = patchbyte;
		end
	end
end

function ApplyBinFilePatches(name, deFile)
	local i, v;
	local touched = false;
	local file = Buffer(true);
	for i, v in ipairs(patchreq) do
		if(v.file == name) then
			if(v.patch == nil) then
				if(touched == true) then error("Cannot replace file from HDD after another patch has been applied.  Check patch order.") end
				print("PATCHER: Loading " .. name .. " from pre-patched file on HDD for " .. v.name);
				local tmp = Input(name);
				file:copyfrom(tmp);
				touched = true;
			else
				if(touched == false) then
					print("PATCHER:  Loading " .. name .. " from source disc.");
					local tmp = cdfile(deFile);
					file:copyfrom(tmp);
					touched = true;
				end
				print("PATCHER: Updating " .. name .. " with " .. v.name);
				ApplyPatch(v.patch, file);
			end
		end
	end
	if(touched == false) then
		print("No patches found for file " .. name .. " copying from source disc.");
		file = cdfile(deFile);
	end
	return file;
end

function extract(cdutil, workdir)
	for i,v in ipairs(FileList) do
		strPatchStatus = "Extracting file " .. v.name
		coroutine.yield()
		local isopath = v.path .. v.name .. ";1"
		local deFile = cdutil:findpath(isopath)
		local hFile
		local tree
		local out
		if (IsXA(v.name) or (IsSTR(v.name) and v.name ~= "ZZZ.STR")) then
--  Copy XA/STR files by sectors.  Copying without explicitly setting the secord and size (even MODE_RAW) hoses the data.
--  Note that ZZZ.STR is not a STR file, or at least not a valid one.
			hFile = cdfile(deFile["Sector"], (deFile["Size"] / 2048) * 2336, MODE2)
		else
			hFile = cdfile(deFile)
		end
		out = Output(workdir .. "\\" .. v.name)
		out:copyfrom(hFile)
		out:close()
		hFile:close()
		intPatchProgress = intPatchProgress + 1
	end
end

function buildcd(cdutil, iso, workdir)
	local direntELF, targetRoot;
	local hCurrFile, pvd, exefile;

	intPatchProgress = intPatchProgress + 10
	strPatchStatus = "Initializing output image..."
	coroutine.yield()
	iup.LoopStep()
	--  Create the first 16 sectors of the target ISO, i.e., the license data, from the source.
	iso:foreword(cdutil);
	--  Create the Primary Volume Descriptor (PVD) from the source.
	pvd = createpvd(cdutil);
	targetRoot = iso:setbasics(pvd);

--  Start out the pathtree with the entry for the root directory.
--  Other directories will be created on the ISO and added to the pathtree when
--  they are first encountered in the file list.
	pathtree["/"] = { dir=targetRoot, parent=targetRoot };
	for i,v in ipairs(FileList) do
		local isopath = v.path .. v.name .. ";1";
		local deFile = cdutil:findpath(isopath) or error("Could not find file: " .. isopath .. " on source image/cd");
		local hFile;
		local tree;
		local out;

		strPatchStatus = "Adding " .. v.name .. " to target and applying text fixes..."
		coroutine.yield()
		GetDir(iso, v.path);
		hFile = Input(workdir .. "\\" .. v.name);

		if (IsXA(v.name) or (IsSTR(v.name) and v.name ~= "ZZZ.STR")) then
--  Copy XA/STR files by sectors.  Copying without explicitly setting the secord and size (even MODE_RAW) hoses the data.
--  Note that ZZZ.STR is not a STR file, or at least not a valid one.
			if (v.name == "BGM.XA") then
			--Konami seems to have relied on the interleave of BGM.XA starting at sector 344, about 6 seconds and a few blocks into the disc
			--It didn't work out so well when they built the disc with a PSX EXE ~2KB smaller than in Japan for the NA region.
				local dummysector = {}
				for i = iso:getdispsect(), 344, 1 do
				--  iso:createsector(dummysector, MODE2)
				i = 344
				end
			end
			v.lba = iso:getdispsect();
			v.size = (hFile:getsize() / 2048) * 2336;
			tree = iso:createfile(pathtree[v.path].dir, v.name, hFile, deFile, MODE2)
			tree.size = deFile.Size
		else
			v.lba = iso:getdispsect();
			v.size = hFile:getsize();
			tree = iso:createfile(pathtree[v.path].dir, v.name, hFile, deFile);
			tree.size = deFile.Size
		end
		hFile:close();
		intPatchProgress = intPatchProgress + 1
	end

	--  Pad out the ISO, if possible.
	strPatchStatus = "Padding ISO (if necessary)..."
	coroutine.yield()
	local dummysector = {}
    	for i = iso:getdispsect(), finalsector, 1 do
    	    iso:createsector(dummysector, MODE2)
 	end
	intPatchProgress = intPatchProgress + 10

	strPatchStatus = "Applying LBA Patch to required files..."
	coroutine.yield()
	ApplyLBAPatch(iso, workdir);
	intPatchProgress = intPatchProgress + 50
	coroutine.yield()
end

function ApplyFilePatch(files, workdir)
	local ret
	for i, file in ipairs(files) do
		if (file.Type == "PPF") then
			strPatchStatus = "Patching " .. file.GameFileName .. " from PPF file " .. file.PatchFileName
			coroutine.yield()
			ret = PpfPatchFile(workdir .. "\\" .. file.GameFileName, patchdir .. "\\" .. file.PatchFileName)
			if(ret ~= 0) then
				print("ERROR: Could not apply patch file " .. file.PatchFileName .. " returned code " .. tostring(ret))
				return ret
			end
		end
	end
	return 0
end

function ApplySearchPatch(searches)
	for i, search in ipairs(searches) do
		SearchPatches[search.VarQual].Active = 1
		SearchPatches[search.VarQual].Type = search.Replace
		print("SEARCH: Activated " .. search.VarQual .. " with value " .. search.Replace)
	end
end

function ApplyPatches (patches, workdir, patchdir)
	local ret = 0
	for i, patch in ipairs(patches) do
		if (patch.Active == 1) then
			if(patch.Files ~= nil) then
				ret = ApplyFilePatch(patch.Files, workdir, patchdir)
			end
			if(patch.Search ~= nil) then
				ApplySearchPatch(patch.Search)
			end
			intPatchProgress = intPatchProgress + 20
			if(ret ~= 0) then
				print("ERROR: Failed applying patches.")
				return ret
			end
		end
	end
	return 0
end

function GetMainExeName (GameId)
	if(PackageInfo.Games[GameId] ~= nil) then
		return PackageInfo.Games[GameId].Serial
	end
	return nil
end

function GetRegionInfo (GameId)
	if(PackageInfo.Games[GameId] ~= nil) then
		return PackageInfo.Games[GameId].Region .. " (" .. PackageInfo.Games[GameId].Language .. ")"
	end
	return nil
end

function GetPatchDir (GameId)
	if(PackageInfo.Games[GameId] ~= nil) then
		return PackageInfo.Games[GameId].PatchDir
	end
	return nil
end

function GetFileList (GameId)
	if(PackageInfo.Games[GameId] ~= nil) then
		return PackageInfo.Games[GameId].FileList
	end
	return nil
end

function GetLBAList (GameId)
	print("Get LBA List")
	if(PackageInfo.Games[GameId] ~= nil) then
		print("LBA - " .. type(PackageInfo.Games[GameId].LBAPatchList) .. " " .. #PackageInfo.Games[GameId].LBAPatchList)
		return PackageInfo.Games[GameId].LBAPatchList
	end
	return nil
end

function GetPatchIdx (GameId, PatchName)
	for i, v in ipairs(PackageInfo.Games[GameId].Patches) do
		if(v.Name == PatchName) then
			return i
		end
	end
	return nil
end

function GetPatch (GameId, PatchName)
	for i, v in ipairs(PackageInfo.Games[GameId].Patches) do
		if(v.Name == PatchName) then
			return v
		end
	end
	return nil
end

function GetPatches (GameId)
	return PackageInfo.Games[GameId].Patches
end


--Toggle=1 indicates the patch is highlighted in the list that owns it.
--IUP is sort of bizarre in that you can't seem to retrieve item statuses
--except in the callbacks, or maybe I just can't find it in the cruddy docs.
function TogglePatch(GameId, SenderId, PatchName, State)
	local intPatchIdx = GetPatchIdx(GameId, PatchName)
	if(intPatchIdx == nil) then
		iup.Message("Patch not found", "Unable to find the patch " .. PatchName .. " in the package.")
	else
		PackageInfo.Games[GameId].Patches[intPatchIdx].Toggle = SenderId
	end
end

function ClearToggle(GameId)
	for i, v in ipairs(PackageInfo.Games[GameId].Patches) do
		v.Toggle = 0
	end
end

function UpdatePatchStatuses(GameId, SenderId)
	for i, v in ipairs(PackageInfo.Games[GameId].Patches) do
		if(v.Toggle == SenderId) then
			v.Toggle = 0
			v.Active = bit.bxor(v.Active, 1)
			if(v.Active == 1 and v.Excludes ~= nil) then
				for i, v in ipairs(v.Excludes) do
					DeactivatePatch(GameId, v)
				end
			end
		end
	end
end

function SetPatchState (GameId, PatchName, State)
	local intPatchIdx = GetPatchIdx(GameId, PatchName)
	if(intPatchIdx == nil) then
		iup.Message("Patch not found", "Unable to find the patch " .. PatchName .. " in the package.")
	else
		PackageInfo.Games[GameId].Patches[intPatchIdx].Active = State
		PackageInfo.Games[GameId].Patches[intPatchIdx].Toggle = 0
	end
end

function HasActivePatches(GameId)
	for i, v in ipairs(PackageInfo.Games[GameId].Patches) do
		if (v.Active == 1) then
			return true
		end
	end
	return false
end

function ActivatePatch(GameId, PatchName)
	SetPatchState(GameId, PatchName, 1)
end

function DeactivatePatch(GameId, PatchName)
	SetPatchState(GameId, PatchName, 0)
end

-------------------------------------------------------------------------------
--ppf.lua - Custom PPF file implementation.                                  --
--                                                                           --
--The patch requires a format that can handle files of around 150 MB, but it --
--also needs to be able to extend the files, which PPF tools won't do.       --
--Rolling up a custom implementation that can add data to files, in addition --
--to replacing it.                                                           --
--                                                                           --
--Format:	File ID - 5 bytes - "PPF40", magic value                         --
--			Encoding Version - 1 byte - 0xFF								 --
--			Patch Description - 50 bytes - Text describing the patch         --
--          Image Type - 1 byte - Always 0 for binary file                   --
--          Validation Flag - 1 byte - Always 0, validation not supported    --
--          Undo Flag - 1 byte - Always 0, undo not supported                --
--          Expansion - 1 byte - Unused value                                --
--          Patch Instructions:                                              --
--                  Command - 1 byte - Value 0 for "replace", 1 for "add"    --
--                  Offset - 4 bytes - Offset into the file.  0 for adds     --
--                  Count - 1 byte - Number of bytes to write                --
--                  Patch Data - (Count) bytes - bytes to write into the file--
-------------------------------------------------------------------------------

loadmodule "lualibs"
loadmodule "luahandle"

S_FILEID		= "PPF40"
N_FILEID_LENGTH = 5
N_FILEDESC_LENGTH = 50
ERROR_BAD_FILEID = -1
ERROR_BAD_VERSION = -2
ERROR_BAD_FLAGS = -3
ERROR_NODATA = -4
ERROR_BAD_REPLACE = -5
ERROR_BAD_OFFSET = -6
ERROR_BAD_SIZE = -7
ERROR_BAD_PATCH_INST = -8

function PpfApplyPatch (TargetFile, PatchFile)
--I had forgotten about the size property, and thought it was missing from file handles
	local FileId = "", tmp, PatchFileEnd, TargetFileEnd, mode
	PatchFile:seek(0, SEEK_END)
	PatchFileEnd = PatchFile:tell()
	PatchFile:seek(0, SEEK_SET)
	TargetFile:seek(0, SEEK_END)
	TargetFileEnd = TargetFile:tell()
	TargetFile:seek(0, SEEK_SET)

	if(PatchFileEnd - PatchFile:tell() < 0x43 or TargetFileEnd - TargetFile:tell() < 1) then return ERROR_NODATA end

	for i = 1, N_FILEID_LENGTH do
		FileId = FileId .. string.char(PatchFile:readU8())
	end
	if(FileId ~= S_FILEID) then
		return ERROR_BAD_FILEID
	end

	tmp = PatchFile:readU8()
	if(tmp ~= 0xFF) then
		return ERROR_BAD_VERSION
	end

	for i = 1, N_FILEDESC_LENGTH do
		PatchFile:readU8()
	end
	tmp = PatchFile:readU32()
	if(tmp ~= 0) then
		return ERROR_BAD_FLAGS
	end

	mode = "REPLACE"
	local bytecount = 0
	while (PatchFile:tell() < PatchFileEnd) do
		if(PatchFile:tell() + 7 > PatchFileEnd) then return ERROR_BAD_PATCH_INST end
		local cmd = PatchFile:readU8()
		local offset = PatchFile:readU32()
		local size = PatchFile:readU8()
		if(cmd == 0) then
			if(mode == "ADD") then return ERROR_BAD_REPLACE end
			if(TargetFileEnd < offset) then return ERROR_BAD_OFFSET end
			if(PatchFile:tell() + size > PatchFileEnd or offset + size > TargetFileEnd) then return ERROR_BAD_SIZE end
			TargetFile:seek(offset)
			for i = 1, size do
				tmp = PatchFile:readU8()
				TargetFile:writeU8(tmp)
				bytecount = bytecount + 1
			end
		elseif(cmd == 1) then
			if(mode == "REPLACE") then
				mode = "ADD"
				TargetFile:seek(TargetFileEnd)
			end
			if(PatchFile:tell() + size > PatchFileEnd) then return ERROR_BAD_SIZE end
			for i = 1, size do
				tmp = PatchFile:readU8()
				TargetFile:writeU8(tmp)
				bytecount = bytecount + 1
			end
		end

		--keep responsive
		if(iup and bytecount > 100000) then
			bytecount = 0
			coroutine.yield()
		end
	end
	return 0
end

function PpfPatchFile (TargetFileName, PatchFileName)
	local TargetFile = Input(TargetFileName)
	local buff = Buffer(true)
	buff:copyfrom(TargetFile)
	if(iup) then coroutine.yield() end
	TargetFile:close()
	TargetFile = Output(TargetFileName)
	TargetFile:copyfrom(buff)

	local PatchFile = Input(PatchFileName)

	local ret = PpfApplyPatch(TargetFile, PatchFile)
	--if(ret ~= 0) then print("Error:" .. ret) end
	TargetFile:flush()
	TargetFile:close()
	PatchFile:close()
	return ret
end
