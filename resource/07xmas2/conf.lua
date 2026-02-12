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
-- FILE PURPOSE: CONF.LUA - Load "Valley Of Death" various configuration.
-- ************************************************************************
print( "Loading 07xmas2 conf.lua" )

xmas2_conf = {} 

-- Random mob spawn
xmas2_conf.enable_random_spawns = true
xmas2_conf.random_mob_lifelength = 5 -- Life time of the mob in minutes. Make sure the mob wont survive from one session of 07xmas2 to the other. 
xmas2_conf.random_mob_count = 10 -- Amount of mob randomly spawned on the map everytime
--xmas2_conf.random_mob_period = 36000 -- Amount of seconds between 2 random monster spawn
--07xmas2_conf.random_mob_types = { 217 } -- List of mob uuid that might spawn

-- Immortal Mob --
xmas2_conf.enable_random1_spawns = true
xmas2_conf.random1_mob_lifelength = 5 -- Life time of the mob in minutes. Make sure the mob wont survive from one session of 07xmas2 to the other. 
xmas2_conf.random1_mob_count = 1 -- Amount of mob randomly spawned on the map everytime
--xmas2_conf.random1_mob_period = 120 -- Amount of seconds between 2 random monster spawn
--07xmas2_conf.random_mob_types = { 217 } -- List of mob uuid that might spawn

-- Crusader
xmas2_conf.disable_stealth = true

dofile(GetResPath("07xmas2/spawnCoords.lua")) -- stored in separated file to avoid flooding conf file.
dofile(GetResPath("07xmas2/functionhook.lua"))




