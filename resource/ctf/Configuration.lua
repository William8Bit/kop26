
	-- You can safely edit this. m(^_^)m
	CTF.Conf.MapName 			= "Capture The Flag"		-- This is the overall map name, also displayed in notices/messages.
	CTF.Conf.NumMapCopy 		= 1							-- Number of map copies available, you must either edit ctrl.lua (v1.X) or MapCopyNum.txt (v2.X) to the same number.
	CTF.Conf.NumPlayer 			= 50						-- Number of players needed in lobby to start battle (by default: 50).
	CTF.Conf.MinLv 				= 0							-- Set a minimum level to be able to register.
	CTF.Conf.MaxLv 				= 0							-- Set a maximum level to be able to register.
	CTF.Conf.ServerLv			= 85						-- Set the max level available in server, this is needed for EXP rewards.
	CTF.Conf.ServerVersion 		= 1							-- This is your server's version (v1.X = 1, v2.X = 2). If your server is v1.x and you put 1, it will automatically create the copies. If your server version is v2.x, put 2 and you have to manually adjust MapCopyNum.txt.
	CTF.Conf.MapType 			= 17						-- This is your map type, it should be different from any other maps you may have, be sure to check your maps or "is_friend" function to avoid duplicates.

	CTF.Conf.Flag				= {ID = 1342, Pos_X = 150, Pos_Y = 150, State = 199}
	
	CTF.Conf.FlagZone[1] 		= {245, 53}					-- Coordinates of green team flag zone. 							
	CTF.Conf.FlagZone[2] 		= {48, 246}					-- Coordinates of red team flag zone.								
	
	CTF.Conf.ScorePlayer		= 1							-- Amount of points team will get after killing a enemy (by default: 1).
	CTF.Conf.ChanceScore		= .25						-- Percentage to player get points after killing a enemy (by default: 25%).
	
	CTF.Conf.ScoreEnemy			= 1							-- Amount of points team will get after carries the flag to enemy base.
	
	CTF.Conf.ScoreLimit			= 30						-- Minimum points the team needs to win battle (by default: 30).
	
	CTF.Conf.Time.Lobby 		= 300						-- Overall time to battle start if minimum player number in lobby did not reached (by default : 5 min).
	CTF.Conf.Time.Attempt 		= 120						-- Time in seconds that player have to return match if DC (by default: 2 min).	
	CTF.Conf.Time.Map 			= (30*60)					-- Overall time duration of the battle (by default: 30 min).
	CTF.Conf.Time.Refresh 		= 180						-- Time (in seconds) to announce round and team score in system (by default: 3 min).
	CTF.Conf.Time.Close 		= 20						-- Time (in seconds) to close map when battle ends (by default: 20 sec).
	CTF.Conf.Time.StartShow		= {1,2,3,4,5,6,7,8,9,10,20,30,45,60,120,180,240,280}
	
	CTF.Conf.OpenDay			= {0,1,2,3,4,5,6}			-- Set the days available to register for CTF (by default: all day).	
	CTF.Conf.OpenHour			= {6,18} --t the hours available to register for CTF (by default: 17:00).
	CTF.Conf.CloseMin			= 5							-- That minute which where registration will be available, after that it will be closed.	
	
	-- Balance for classes in map (Gems and equipment will make no difference).
	CTF.Conf.Balance[8]     = {Max = {HP = 15000, SP = 3000}, Attack = {Min = 1700, Max = 2000, Speed = 210}, 	Defense = 380, PhysicalResist = 40, HitRate = 300, Dodge = 300, Critical = 15, Recovery = {HP = 56, SP = 2},  MoveSpeed = 850}
    CTF.Conf.Balance[9]     = {Max = {HP = 10000, SP = 3000}, Attack = {Min = 1900, Max = 2200, Speed = 210}, 	Defense = 380, PhysicalResist = 40, HitRate = 300, Dodge = 300, Critical = 15, Recovery = {HP = 31, SP = 3},  MoveSpeed = 850}
    CTF.Conf.Balance[12]    = {Max = {HP = 12000, SP = 3000}, Attack = {Min = 1700, Max = 1900, Speed = 210}, 	Defense = 380, PhysicalResist = 40, HitRate = 320, Dodge = 280, Critical = 15, Recovery = {HP = 34, SP = 1},  MoveSpeed = 900}
    CTF.Conf.Balance[13]    = {Max = {HP = 6000, SP = 8000}, Attack = {Min = 1500, Max = 1700, Speed = 200}, 	Defense = 380, PhysicalResist = 40, HitRate = 300, Dodge = 300, Critical = 15, Recovery = {HP = 42, SP = 19}, MoveSpeed = 850}
	CTF.Conf.Balance[14]    = {Max = {HP = 14000, SP = 5000}, Attack = {Min = 1500, Max = 1700, Speed = 200}, 	Defense = 380, PhysicalResist = 40, HitRate = 300, Dodge = 300, Critical = 15, Recovery = {HP = 42, SP = 19}, MoveSpeed = 850}
	CTF.Conf.Balance[16]    = {Max = {HP = 12000, SP = 5000}, Attack = {Min = 1500, Max = 1700, Speed = 200}, 	Defense = 380, PhysicalResist = 40, HitRate = 300, Dodge = 300, Critical = 15, Recovery = {HP = 42, SP = 19}, MoveSpeed = 850}
	
	-- Balance for skills in map.
	CTF.Conf.Cripple			= {State = 39, MSPD = 300, DODGE = 100}
	CTF.Conf.Abyss				= {State = 7, MSPD = 300}
	CTF.Conf.Berserk			= {State = 24, ASPD = 100}
	CTF.Conf.Rousing			= {State = 90, ASPD = 100}
	
	-- This are the rewards given at the end of the match to the green team
	-- If values are set to "0", if will not prompt to give out that reward, including items.
	-- For "EXP", it's in percentage of player's current level.	
	CTF.Rewards.Reputation		= 0
	CTF.Rewards.Gold			= 100000
	CTF.Rewards.Honor			= 0
	CTF.Rewards.EXP				= 0
	CTF.Rewards.Items[1]		= {ID = 0885, Quantity = 1, Quality = 4}	-- Refining Gem 1*
	CTF.Rewards.Items[2]		= {ID = 3844, Quantity = 5, Quality = 4}	-- Heven's Berry 5*
	CTF.Rewards.Items[3]		= {ID = 3845, Quantity = 5, Quality = 4}	-- Charmed Berry 5*
	CTF.Rewards.Items[4]		= {ID = 7120, Quantity = 1, Quality = 4}	-- Yellow Jade 1*
	CTF.Rewards.Items[5]		= {ID = 7121, Quantity = 1, Quality = 4}	-- Red Jade*
	CTF.Rewards.Items[6]		= {ID = 7122, Quantity = 1, Quality = 4}	-- Green Jade*

	-- You can edit this if you are using a different map than the one that came with the files and modify the coordinates if you want different spawns.
	-- This also affects in the code if you aren't using the random spawn function.
	CTF.Spawns[1] = {Name = CTF.Conf.MapName, Map = "ctf", Spawn = "CTF Red Team", X = 43, Y = 243}	
	CTF.Spawns[2] = {Name = CTF.Conf.MapName, Map = "ctf", Spawn = "CTF Green Team", X = 241, Y = 44}	
	
CTF_NPC = function()
	Talk(1, "CTF Waiting Rom: Welcome! You may register here for ["..CTF.Conf.MapName.."].")
	Text(1, "Register", CTF.Register)
end	

CTF_Red = function()
	InitTrigger()
    TriggerCondition(1, CTF.CheckChaSide, 2)
    TriggerAction(1, JumpPage, 1)
    TriggerFailure(1, JumpPage, 3)
    Start(GetMultiTrigger(), 1)
	
	InitTrigger()
	TriggerAction(1, ReAll)
	Talk(1, "Red Team Commander: Hello! I am the commander of your team. You have to Capture the Flag and bring your team points. What do you want from me?")
	Text(1, "Heal me!", MultiTrigger, GetMultiTrigger(), 1)
	
	Text(1, "See scores!", CTF.DisplayInfo)
	Text(1, "Nothing...", CloseTalk)
	
	Talk(3, "Red Team Commander: You will lose this battle!")
end

CTF_Green = function()
	InitTrigger()
    TriggerCondition(1, CTF.CheckChaSide, 1)
    TriggerAction(1, JumpPage, 1)
    TriggerFailure(1, JumpPage, 3)
    Start(GetMultiTrigger(), 1)
	
	InitTrigger()
	TriggerAction(1, ReAll)
	Talk(1, "Green Team Commander: Hello! I am the commander of your team. You have to Capture the Flag and bring your team points. What do you want from me?")
	Text(1, "Heal me!", MultiTrigger, GetMultiTrigger(), 1)
	
	Text(1, "See scores!", CTF.DisplayInfo)
	Text(1, "Nothing...", CloseTalk)
	
	Talk(3, "Green Team Commander: You will lose this battle!")
end