-- ------------------------------------------------------------------------
-- Valley Of Death
-- ------------------------------------------------------------------------
-- Valley Of Death is a capture the flag game design and developped by Matt.
-- Credits should stay on top of this file, tho you are free to add credits for your own enhancements.
-- Credits:
--		[*] Overall game on which "Valley Of Death" is running: Moliyo [http://moliyo.com]
--		[*] Original map creation: Matt from Privatia [http://privatia.serverdev.net]
--		[*] CTF Game scripting: Matt from Privatia [http://privatia.serverdev.net]
--		[*] Moral support & technical hint: Kajack & Snowcrash from Privatia [http://privatia.serverdev.net]
-- ------------------------------------------------------------------------

-- ************************************************************************
-- FILE PURPOSE: spawnCoords.LUA - Load list of valid mob spawn location.
-- Part of game configuration externalized to avoid flooding conf file.
-- ************************************************************************
AddBirthPoint("Chaos Xmas", "07xmas2", 73,239)
AddBirthPoint("Chaos Xmas", "07xmas2", 157,260)
AddBirthPoint("Chaos Xmas", "07xmas2", 189,210)
AddBirthPoint("Chaos Xmas", "07xmas2", 246,238)
AddBirthPoint("Chaos Xmas", "07xmas2", 260,132)
AddBirthPoint("Chaos Xmas", "07xmas2", 253,68)
AddBirthPoint("Chaos Xmas", "07xmas2", 193,47)
AddBirthPoint("Chaos Xmas", "07xmas2", 135,65)
AddBirthPoint("Chaos Xmas", "07xmas2", 81,38)
AddBirthPoint("Chaos Xmas", "07xmas2", 39,70)
AddBirthPoint("Chaos Xmas", "07xmas2", 26,171)



xmas2_conf.random_mob_location = {
	{ x=144, y=240 },
	{ x=155, y=265 },
	{ x=135, y=265 },
	{ x=121, y=262 },
	{ x=107, y=254 },
	{ x=97, y=265 },
	{ x=85, y=250 },
	{ x=77, y=239 },
	{ x=54, y=251 },
	{ x=42, y=262 },
	{ x=31, y=244 },
	{ x=40, y=222 },
	{ x=26, y=209 },
	{ x=56, y=204 },
	{ x=86, y=206 },
	{ x=104, y=220 },
	{ x=27, y=172 },
	{ x=32, y=148 },
	{ x=21, y=123 },
	{ x=31, y=106 },
	{ x=29, y=78 },
	{ x=40, y=70 },
	{ x=29, y=55 },
	{ x=24, y=33 },
	{ x=45, y=30 },
	{ x=70, y=31 },
	{ x=86, y=42 },
	{ x=66, y=56 },
	{ x=53, y=66 },
	{ x=71, y=99 },
	{ x=48, y=99 },
	{ x=103, y=96 },
	{ x=93, y=72 },
	{ x=123, y=64 },
	{ x=162, y=64 },
	{ x=194, y=54 },
	{ x=184, y=33 },
	{ x=207, y=30 },
	{ x=218, y=44 },
	{ x=243, y=30 },
	{ x=260, y=30 },
	{ x=266, y=58 },
	{ x=246, y=54 },
	{ x=227, y=62 },
	{ x=212, y=84 },
	{ x=194, y=91 },
	{ x=208, y=61 },
	{ x=251, y=89 },
	{ x=265, y=110 },
	{ x=252, y=122 },
	{ x=259, y=154 },
	{ x=261, y=188 },
	{ x=264, y=204 },
	{ x=240, y=208 },
	{ x=198, y=195 },
	{ x=183, y=197 },
	{ x=222, y=213 },
	{ x=244, y=222 },
	{ x=267, y=234 },
	{ x=260, y=255 },
	{ x=251, y=268 },
	{ x=236, y=267 },
	{ x=221, y=264 },
	{ x=239, y=252 },
	{ x=180, y=225 },
	{ x=207, y=242 },
	{ x=189, y=256 },
	{ x=187, y=269 },
	{ x=168, y=252 },

}

xmas2_conf.random1_mob_location = {
	{ x=144, y=240 },
	{ x=155, y=265 },
	{ x=135, y=265 },
	{ x=121, y=262 },
	{ x=107, y=254 },
	{ x=97, y=265 },
	{ x=85, y=250 },
	{ x=77, y=239 },
	{ x=54, y=251 },
	{ x=42, y=262 },
	{ x=31, y=244 },
	{ x=40, y=222 },
	{ x=26, y=209 },
	{ x=56, y=204 },
	{ x=86, y=206 },
	{ x=104, y=220 },
	{ x=27, y=172 },
	{ x=32, y=148 },
	{ x=21, y=123 },
	{ x=31, y=106 },
	{ x=29, y=78 },
	{ x=40, y=70 },
	{ x=29, y=55 },
	{ x=24, y=33 },
	{ x=45, y=30 },
	{ x=70, y=31 },
	{ x=86, y=42 },
	{ x=66, y=56 },
	{ x=53, y=66 },
	{ x=71, y=99 },
	{ x=48, y=99 },
	{ x=103, y=96 },
	{ x=93, y=72 },
	{ x=123, y=64 },
	{ x=162, y=64 },
	{ x=194, y=54 },
	{ x=184, y=33 },
	{ x=207, y=30 },
	{ x=218, y=44 },
	{ x=243, y=30 },
	{ x=260, y=30 },
	{ x=266, y=58 },
	{ x=246, y=54 },
	{ x=227, y=62 },
	{ x=212, y=84 },
	{ x=194, y=91 },
	{ x=208, y=61 },
	{ x=251, y=89 },
	{ x=265, y=110 },
	{ x=252, y=122 },
	{ x=259, y=154 },
	{ x=261, y=188 },
	{ x=264, y=204 },
	{ x=240, y=208 },
	{ x=198, y=195 },
	{ x=183, y=197 },
	{ x=222, y=213 },
	{ x=244, y=222 },
	{ x=267, y=234 },
	{ x=260, y=255 },
	{ x=251, y=268 },
	{ x=236, y=267 },
	{ x=221, y=264 },
	{ x=239, y=252 },
	{ x=180, y=225 },
	{ x=207, y=242 },
	{ x=189, y=256 },
	{ x=187, y=269 },
	{ x=168, y=252 },

}