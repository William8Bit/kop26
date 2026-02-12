-- DO NOT EDIT THIS, PERIOD.
if CTF == nil then
	CTF 											= {}
	CTF.Conf 										= {}
	CTF.Conf.Time 									= {}	
	CTF.Conf.FlagZone								= {}
	CTF.Conf.Balance								= {}
	
	CTF.Spawns 										= {}
	CTF.Rewards										= {}
	CTF.Rewards.Items								= {}
end
-- Calling those customizable variables.
dofile(GetResPath("ctf/Configuration.lua"))

function CTF.Init()
	CTF.Members										= {}
	CTF.Flag										= {}
	CTF.EnterLobby									= {} 					-- Stores the data to players if they entered the Lobby.
	CTF.LeaveTime									= {} 					-- Stores the time players have to enter map again after leave the battle.	
	CTF.Lobby_Tick									= CTF.Conf.Time.Lobby	-- Lobby wait time before battle start if minimum player not reached.
	CTF.LobbyOpened									= false					-- Declares if the lobby is opened or not.
	CTF.MapOpened									= false					-- Declares if the battle has started or not.
end
CTF.Init()
function StartPlayerCTF(Player)
	local TeamID									= 0
	local PID										= GetPlayerID(GetChaPlayer(Player))
	if (CTF.Players[PID] == nil) then
		if (CTF.GreenTeam.Counter == CTF.RedTeam.Counter) then
			TeamID									= math.random(1,2)
		else
			if (CTF.GreenTeam.Counter > CTF.RedTeam.Counter) then
				TeamID								= 1
			else
				TeamID								= 2
			end
		end
		CTF.Players[PID]							= { cha 		= Player,
														side_id 	= TeamID,
														entered 	= LUA_FALSE,
														deadtimer	= CTF.Conf.SpawnTimer,
														}
	else
		CTF.Players[PID].cha						= Player
		CTF.Players[PID].side_id					= CTF.Players[PID].side_id
		CTF.Players[PID].entered					= LUA_FALSE
		CTF.Players[PID].deadtimer					= CTF.Conf.SpawnTimer
		TeamID										= CTF.Players[PID].side_id
	end
	if (TeamID == 1) then
		CTF.RedTeam.Counter							= CTF.RedTeam.Counter + 1
		AddState(Player, Player, STATE_PKWD, 4, CTF.Conf.Time.Init)
		MoveCity(Player, CTF.Spawns[TeamID].Spawn)
	else
		CTF.GreenTeam.Counter						= CTF.GreenTeam.Counter + 1
		AddState(Player, Player, STATE_PKWD, 4, CTF.Conf.Time.Init)
		MoveCity(Player, CTF.Spawns[TeamID].Spawn)
	end
end
-- Carry the flag to enemy team
function CarryTheFlag(Player)
	local MapCopy										= GetChaMapCopy(Player)
	local PID											= GetRoleID(Player)
	if (PID == CTF.Flag_ChaID) then
		local Name										= GetChaDefaultName(Player)
		local side_id 									= GetChaSideID(Player)
		local x,y 										= GetChaPos(Player)
		x												= math.floor(x/100)
		y												= math.floor(y/100)
		local red_base									= 4 * math.abs(x - CTF.Conf.FlagZone[2][1]) + 4 * math.abs(y - CTF.Conf.FlagZone[2][2])
		local green_base								= 4 * math.abs(x - CTF.Conf.FlagZone[1][1]) + 4 * math.abs(y - CTF.Conf.FlagZone[1][2])
		if (red_base <= 12) then
			if (side_id == 1) then
				CTF.GreenTeam.Score						= CTF.GreenTeam.Score + CTF.Conf.ScoreEnemy
				MapCopyNotice(MapCopy, "<"..CTF.Conf.MapName..">: "..Name..", from the Green Team succesfully carried the flag to Red Team Base and gets +"..CTF.Conf.ScoreEnemy.." points!")
			end
		end
		
		if (green_base <= 12) then
			if (side_id == 2) then
				CTF.RedTeam.Score						= CTF.RedTeam.Score + CTF.Conf.ScoreEnemy
				MapCopyNotice(MapCopy, "<"..CTF.Conf.MapName..">: "..Name..", from the Red Team succesfully carried the flag to Green Team Base and gets +"..CTF.Conf.ScoreEnemy.." point!")
			end
		end	
		
		if (red_base <= 12 or green_base <= 12) then
			CTF.Flag_ChaID								= 0
			RemoveState(Player, CTF.Conf.Flag.State)
			RefreshCha(Player)
		end
	end
end

-- Calculating custom balance for classes and skills in map.
CTF.MapBalance										= function(Player)
	local Modifier1 								= {Max = {HP = 1, SP = 1}, Attack = {Min = 1, Max = 1, Speed = 1}, Defense = 1, PhysicalResist = 1, HitRate = 1, Dodge = 1, Critical = 1, Recovery = {HP = 1, SP = 1}, MoveSpeed = 1}
	if (GetChaMapName(Player) == "ctf") then
		local Job 									= GetChaAttr(Player, ATTR_JOB)
		if (CTF.Conf.Balance[Job] ~= nil) then
			Modifier1.Max.HP						= CTF.Conf.Balance[Job].Max.HP
			Modifier1.Max.SP						= CTF.Conf.Balance[Job].Max.SP
			Modifier1.Attack.Min					= CTF.Conf.Balance[Job].Attack.Min
			Modifier1.Attack.Max					= CTF.Conf.Balance[Job].Attack.Max
			Modifier1.Attack.Speed					= CTF.Conf.Balance[Job].Attack.Speed
			Modifier1.Defense						= CTF.Conf.Balance[Job].Defense
			Modifier1.PhysicalResist				= CTF.Conf.Balance[Job].PhysicalResist
			Modifier1.HitRate						= CTF.Conf.Balance[Job].HitRate
			Modifier1.Dodge							= CTF.Conf.Balance[Job].Dodge
			Modifier1.Critical						= CTF.Conf.Balance[Job].Critical
			Modifier1.Recovery.HP					= CTF.Conf.Balance[Job].Recovery.HP
			Modifier1.Recovery.SP					= CTF.Conf.Balance[Job].Recovery.HP
			Modifier1.MoveSpeed						= CTF.Conf.Balance[Job].MoveSpeed
		end
		local MXHP									= Modifier1.Max.HP
		local MXSP									= Modifier1.Max.SP
		local MNATK									= Modifier1.Attack.Min
		local MXATK									= Modifier1.Attack.Max
		local DEF									= Modifier1.Defense		
		local PR										= Modifier1.PhysicalResist		
		local HIT									= Modifier1.HitRate		
		local DODGE									= Modifier1.Dodge		
		local MF										= Mf_final(Player)
		local CRIT									= Crt_final(Player)	
		local HPREC									= Hrec_final(Player)
		local SPREC									= Srec_final(Player)
		local ADIS									= Adis_final(Player)
		local MSPD									= Modifier1.MoveSpeed		
		local ASPD									= math.floor(100000/Modifier1.Attack.Speed)
		-- Cripple skill: movement and dodge reduce.
		if (GetChaStateLv(Player, CTF.Conf.Cripple.State) ~= 0) then
			MSPD									= MSPD - CTF.Conf.Cripple.MSPD
			DODGE									= DODGE - CTF.Conf.Cripple.DODGE
			SetCharaAttr(MSPD, Player, ATTR_MSPD)
			SetCharaAttr(DODGE, Player, ATTR_FLEE)
		else
			SetCharaAttr(MSPD, Player, ATTR_FLEE)
			SetCharaAttr(DODGE, Player, ATTR_FLEE)
		end
		-- Abyss Mire skill: movement reduce.
		if (GetChaStateLv(Player, CTF.Conf.Abyss.State) ~= 0) then
			MSPD									= MSPD - CTF.Conf.Abyss.MSPD
			SetCharaAttr(MSPD, Player, ATTR_MSPD)
		else
			SetCharaAttr(MSPD, Player, ATTR_MSPD)
		end	
		--[[
		--Berserk: attack speed increase.
		if (GetChaStateLv(Player, CTF.Conf.Berserk.State) ~= 0) then
			ASPD									= ASPD + CTF.Conf.Berserk.ASPD
			SetCharaAttr(ASPD, Player, ATTR_ASPD)
		else
			SetCharaAttr(ASPD, Player, ATTR_ASPD)
		end	
		]]
		--Rousing: attack speed increase.
		if (GetChaStateLv(Player, CTF.Conf.Rousing.State) ~= 0) then
			ASPD									= ASPD + CTF.Conf.Rousing.ASPD
			SetCharaAttr(ASPD, Player, ATTR_ASPD)
		else
			SetCharaAttr(ASPD, Player, ATTR_ASPD)
		end			
		SetCharaAttr(MXHP, Player, ATTR_MXHP)
		SetCharaAttr(MXSP, Player, ATTR_MXSP)
		SetCharaAttr(MNATK, Player, ATTR_MNATK)
		SetCharaAttr(MXATK, Player, ATTR_MXATK)
		SetCharaAttr(DEF, Player, ATTR_DEF)		
		SetCharaAttr(PR, Player, ATTR_PDEF)		
		SetCharaAttr(HIT, Player, ATTR_HIT)		
		SetCharaAttr(DODGE, Player, ATTR_FLEE)		
		SetCharaAttr(MF, Player, ATTR_MF)		
		SetCharaAttr(CRIT, Player, ATTR_CRT)		
		SetCharaAttr(HPREC, Player, ATTR_HREC)		
		SetCharaAttr(SPREC, Player, ATTR_SREC)		
		SetCharaAttr(ADIS, Player, ATTR_ADIS)
		SetCharaAttr(MSPD, Player, ATTR_MSPD)		
		SetCharaAttr(ASPD, Player, ATTR_ASPD)
	end			
end

-- Checking if the player team is equal the function argument.
CTF.CheckChaSide									= function(Player, SideID)
	if (GetChaSideID(TurnToCha(Player)) == SideID) then
		return LUA_TRUE
	end
	return LUA_FALSE
end

-- Checking team score in map.
CTF.DisplayInfo										= function(Player)	
	local Message									= ""
	Message 										= AdjustTextSpace(">> Capture The Flag <<", 42, "_")
	Message 										= Message..AdjustTextSpace("Red Team Score: ", 16)..AdjustTextSpace(CTF.RedTeam.Score, 20, "_")
	Message 										= Message..AdjustTextSpace("Green Team Score: ", 16)..AdjustTextSpace(CTF.GreenTeam.Score, 16, "_")
	Message 										= Message..AdjustTextSpace("Battle ends in: ", 16)..AdjustTextSpace(ToClockFormat(CTF.BattleTime), 21, "_")
	HelpInfoX(Player, 0, Message)
	return LUA_TRUE
end

-- Call that on "is_friend" at functions.lua
CTF.Friendly										= function(ATKER, DEFER)
	local ATKER_Team								= GetChaSideID(ATKER)
	local DEFER_Team								= GetChaSideID(DEFER)
	if ATKER_Team == DEFER_Team then
		return 1
	else
		return 0
	end
end
-- Call that on "birth.lua"
CTF.CreateSpawn = function()
	for a = 1, (table.getn(CTF.Spawns)), 1 do
		AddBirthPoint(CTF.Spawns[a].Name, CTF.Spawns[a].Map, CTF.Spawns[a].X, CTF.Spawns[a].Y)
		AddBirthPoint(CTF.Spawns[a].Spawn, CTF.Spawns[a].Map, CTF.Spawns[a].X, CTF.Spawns[a].Y)
	end
end
CTF.StartMap 										= function()
	CTF.Players										= {}					-- Stores the data for players in battle.
	CTF.GreenTeam									= {}					-- Stores the data for the Green Team.
	CTF.RedTeam										= {}					-- Stores the data for the Red Team.
				
	CTF.GreenTeam.Counter 							= 0						-- Stores the number of players in Green Team.
	CTF.RedTeam.Counter 							= 0						-- Stores the number of players in Red Team.
			
	CTF.GreenTeam.Score 							= 0						-- Stores the score of the Red Team.
	CTF.RedTeam.Score  								= 0						-- Stores the score of the Green Team.
	
	CTF.BattleTime									= CTF.Conf.Time.Map		-- Stores the time of whole battle duration.

	CTF.MapOpened 									= true					-- Starts the battle.
	CTF.LobbyOpened									= false					-- Closes the lobby.
	
	CTF.WinnerTeam									= nil					-- Declares the team winner of battle.

	CTF.Flag_ChaID									= 0						-- Declares the player who carries the flag.
	CTF.Flag_Spawned								= LUA_FALSE				-- Declares if the flag has been spawned.
	
	CTF.MapShutdown									= CTF.Conf.Time.Close
	GMNotice("<"..CTF.Conf.MapName..">: Map started! Red Team vs Green Team. The team that get 30 point(s) first wins! Teams can get point(s) killing enemies (25% chance) or carry the Flag to Flag Pointer. After the Team carries the Flag to the Flag Pointer, The Flag will appear in the middle. ***** If you are using Skill Tweak you can not see Flag Monster.")
end

function CTF.PKM(Mob, Player)
	local MobMap									= GetChaMapName(Mob)
	local MapName									= GetChaMapName(Player)
	local ChaName									= GetChaDefaultName(Player)
	local ChaID										= GetRoleID(Player)
	if (MapName == "ctf" and MobMap == "ctf") then
		local MobID									= GetChaID(Mob)
		if (MobID == CTF.Conf.Flag.ID) then
			local SideID							= GetChaSideID(Player)
			local MapCopy							= GetChaMapCopy(Player)
			local x,y 								= GetChaPos(Player)
			x										= math.floor(x/100)
			y										= math.floor(y/100)
			if (SideID == 2) then
				MapCopyNotice(MapCopy, "<"..CTF.Conf.MapName..">: "..ChaName..", from the Red Team captured the Flag at ("..x..","..y..")!")
			else
				MapCopyNotice(MapCopy, "<"..CTF.Conf.MapName..">: "..ChaName..", from the Green Team captured the Flag at ("..x..","..y..")!")
			end
			CTF.Flag_ChaID							= ChaID
			CTF.Flag_Spawned						= LUA_FALSE
			AddState(Player, Player, CTF.Conf.Flag.State, 1, 86400)
		end
	end
end
AdjustTextSpace = function(Text, Spaces, End)
    local Count = math.floor((Spaces - string.len(Text)) * 0.5)
    local Message = ""
    for C = 1, Count, 1 do
        Message = Message.." "
    end
    Message = Message..Text
    Count = math.floor(Spaces - string.len(Message))
    for C = 1, Count, 1 do
        Message = Message.." "
    end
    if End ~= nil then
        Message = Message..End
    end
    return Message
end

function ToClockFormat(sec)
    local num = tonumber(sec)
    if(num == 0) then
        return "00:00:00"
    else
        now_hour = string.format("%02.f",math.floor(num / 3600 ))
        now_minute = string.format("%02.f",math.floor(num / 60 - (now_hour*60)))
        now_second = string.format("%02.f",math.floor(num - now_hour*3600 - now_minute*60))
        return tonumber(now_hour)..":"..tonumber(now_minute)..":"..tonumber(now_second)..""
    end
end

function MapRespawnOnDeath(Player, mapname)
print("on death"..mapname)
    local SideID                = GetChaSideID(Player)
    if (mapname == "ctf") then
        ReAll(Player)
        if (SideID == 1) then
            return CTF.Spawns[2].Spawn
        elseif (SideID == 2) then
            return CTF.Spawns[1].Spawn
        end
    end
    return ret
end

function CTF.PKP(ATKER, DEFER)
	local MapName_ATKER								= GetChaMapName(ATKER)
	local MapName_DEFER								= GetChaMapName(DEFER)
	if (MapName_ATKER == "ctf" and MapName_DEFER == "ctf") then
		local MapCopy								= GetChaMapCopy(ATKER)
		local Name_ATKER							= GetChaDefaultName(ATKER)
		local Name_DEFER							= GetChaDefaultName(DEFER)
		local Side_ATKER							= GetChaSideID(ATKER)
		local Side_DEFER							= GetChaSideID(DEFER)
		local ChaID_ATKER							= GetRoleID(ATKER)
		local ChaID_DEFER							= GetRoleID(DEFER)
		if (Side_ATKER == 1) then
			Name_ATKER								= Name_ATKER.." from the Green Team"
			-- Calculating the chance to grant points after kill enemy player
			if (Percentage_Random(CTF.Conf.ChanceScore) == 1) then
				CTF.GreenTeam.Score					= CTF.GreenTeam.Score + CTF.Conf.ScorePlayer
				BickerNotice(ATKER, "Red Team enemy killed, your team gets +"..CTF.Conf.ScorePlayer.." point!")
			end
		else
			Name_ATKER								= Name_ATKER.." from the Red Team"
			-- Calculating the chance to grant points after kill enemy player
			if (Percentage_Random(CTF.Conf.ChanceScore) == 1) then
				CTF.RedTeam.Score					= CTF.RedTeam.Score + CTF.Conf.ScorePlayer
				BickerNotice(ATKER, "Green Team enemy killed, your team gets +"..CTF.Conf.ScorePlayer.." point!")
			end			
		end
		if (Side_DEFER == 1) then
			Name_DEFER								= Name_DEFER.." from the Green Team"
		else
			Name_DEFER								= Name_DEFER.." from the Red Team"
		end		
		Notice("<"..CTF.Conf.MapName..">: ["..Name_DEFER.."] #02 was defeated by ["..Name_ATKER.."]#13 in "..CTF.Conf.MapName.."!")
		
		if (ChaID_DEFER == CTF.Flag_ChaID) then
			local x,y								= GetChaPos(ATKER)
			x										= math.floor(x/100)
			y										= math.floor(y/100)
			if (Side_ATKER == 2) then
				MapCopyNotice(MapCopy, "<"..CTF.Conf.MapName..">: "..Name_ATKER.." captured the Flag at ("..x..", "..y..")!")
			else
				MapCopyNotice(MapCopy, "<"..CTF.Conf.MapName..">: "..Name_ATKER.." captured the Flag at ("..x..", "..y..")!")
			end
			CTF.Flag_ChaID							= ChaID_ATKER
			RemoveState(DEFER, CTF.Conf.Flag.State)
			AddState(ATKER, ATKER, CTF.Conf.Flag.State, 1, 86400)
		end
	end	
end
			
CTF.GiveRewards 									= function(Player, Reward)
	if Reward.Gold > 0 then
		AddMoney(Player, 0, Reward.Gold)
	end
	if Reward.Reputation > 0 then
		AddCreditX(Player, 0, Reward.Reputation)
	end
	if Reward.Honor > 0 and CheckBagItem(Player, 3849) == 1 then
		local Medal 								= GetChaItem2(Player, 2, 3849)
		local Honor 								= Reward.Honor + GetItemAttr(Medal, ITEMATTR_VAL_STR)
		SetItemAttr(Medal, ITEMATTR_VAL_STR, Honor)
	end	
	if Reward.Items ~= nil then
		local rad							= math.random(1,table.getn(Reward.Items))
		local ItemID 						= Reward.Items[rad].ID
		local Quantity 						= Reward.Items[rad].Quantity
		local Quality 						= Reward.Items[rad].Quality	
		if GetChaFreeBagGridNum(Player) > 0 then
			GiveItem(Player, 0, ItemID, Quantity, Quality)
			BickerNotice(Player, "<"..CTF.Conf.MapName..">: Your team wins! Received x"..Quantity.." "..GetItemName(ItemID)..".")
		else
			GiveItemX(Player, 0, ItemID, Quantity, Quality)
			BickerNotice(Player, "<"..CTF.Conf.MapName..">: Your team wins! Received x"..Quantity.." "..GetItemName(ItemID)..".")
		end
	end
	local Level 									= Lv(Player)
	if Reward.EXP > 0 and Level < CTF.Conf.ServerLv then
		local CurrentEXP = GetChaAttr(Player, ATTR_CEXP) + ((DEXP[Level+1] - DEXP[Level]) * (Reward.EXP/100))
		SetChaAttrI(Player, ATTR_CEXP, CurrentEXP)
	end	
end
CTF.Finish 											= function(MapCopy)
	if CTF.MapShutdown ~= nil and CTF.MapShutdown > 0 then
		for i = 1, table.getn(CTF.Conf.Time.StartShow) do
			if CTF.MapShutdown == CTF.Conf.Time.StartShow[i] then
				MapCopyNotice(MapCopy, "<"..CTF.Conf.MapName..">: Battle has come to an end! All players will leave in "..CTF.MapShutdown.." seconds!")
			end
		end
		CTF.MapShutdown								= CTF.MapShutdown - 1
		if CTF.MapShutdown == 0 then
			if CTF.GreenTeam.Score > CTF.RedTeam.Score then
				CTF.WinnerTeam								= 1
				MapCopyNotice(MapCopy, "<"..CTF.Conf.MapName..">: The Green Team wins the battle with ("..CTF.GreenTeam.Score.."/"..CTF.Conf.ScoreLimit..") points!")
				GMNotice("<"..CTF.Conf.MapName..">: The Green Team wins the battle with ("..CTF.GreenTeam.Score.."/"..CTF.Conf.ScoreLimit..") points!")
			elseif CTF.RedTeam.Score > CTF.GreenTeam.Score then
				CTF.WinnerTeam								= 2
				MapCopyNotice(MapCopy, "<"..CTF.Conf.MapName..">: The Red Team wins the battle with ("..CTF.RedTeam.Score.."/"..CTF.Conf.ScoreLimit..") points!")
				GMNotice("<"..CTF.Conf.MapName..">: The Red Team wins the battle with ("..CTF.RedTeam.Score.."/"..CTF.Conf.ScoreLimit..") points!")
			else
				MapCopyNotice(MapCopy, "<"..CTF.Conf.MapName..">: It seems there was no winners at this match!")
				GMNotice("<"..CTF.Conf.MapName..">: It seems there was no winners at this match!")
			end
			local PlayerNum									= GetMapCopyPlayerNum(MapCopy)
			BeginGetMapCopyPlayerCha(MapCopy)
			for i = 1, PlayerNum, 1 do
				local Player								= GetMapCopyNextPlayerCha(MapCopy)
				if (ValidCha(Player) == 1) then
					local SideID							= GetChaSideID(Player)
					if CTF.WinnerTeam ~= nil and SideID == CTF.WinnerTeam then
						CTF.GiveRewards(Player, CTF.Rewards)
					end
				end
			end	
			DealAllActivePlayerInMap(MapCopy, "TakeOutSideCTF")
			CTF.Init()										-- Reloads the map variables.
			ClearAllSubMapMonster(MapCopy)
			CloseMapCopy("ctf")
			return
		end
	end
end
TakeOutSideCTF										= function(Player)
	MoveCity(Player, "")
end
CTF.OpenDay						= function()
	local RegOpen				= {Day = {}, Hour = {}}
	for i,v in pairs(CTF.Conf.OpenDay) do
		RegOpen.Day[v]			= true
	end
	if (RegOpen.Day[tonumber(os.date("%w"))] == true) then
		return 1
	end
	return 0
end
CTF.OpenHour					= function()
	local RegOpen				= {Day = {}, Hour = {}}
	for i,v in pairs(CTF.Conf.OpenHour) do
		RegOpen.Hour[tonumber(v)]			= true
	end
	if (RegOpen.Hour[tonumber(os.date("%H"))] == true) then
		return 1
	end	
	return 0
end

function CTF.Timer(Player)
	local Hour,Minute,Second 						= tonumber(os.date("%H")),tonumber(os.date("%M")),tonumber(os.date("%S"))
	local Message									= ""
	for i,v in pairs(CTF.Conf.OpenHour) do	
		if Hour == v and Minute < CTF.Conf.CloseMin then
			if (GetChaMapName(TurnToCha(Player)) == "pkmap") then
				local EverySeconds = 10 
				local MinuteToSecond = (Minute*60)+Second -- 3*60 = 183
				if math.floor(MinuteToSecond/EverySeconds) == MinuteToSecond/EverySeconds then
					local CloseMinToSecond = CTF.Conf.CloseMin * 60 -- 5*60 = 300
					local Calculation = CloseMinToSecond - MinuteToSecond -- 300 - 183 = 117
					local GetRemainMin = math.floor(Calculation/60) -- 117/60 = 1
					local GetRemainSec = Calculation - (GetRemainMin*60) -- 117-60 = 57
					BickerNotice(Player,"CTF will start in "..GetRemainMin.." minute(s), "..GetRemainSec.." second(s)!")
				end
			end
			if (CTF.LobbyOpened == false) then
				CTF.LobbyOpened						= true
			end
			if (CTF.MapOpened == true) then
				CTF.MapOpened						= false
			end
		end
		if Hour == v and Minute == 00 and Second == 00 then
			if (CTF.LobbyOpened == true) then
				Message								= Message.."<"..CTF.Conf.MapName..">: Registration is now Open!"
				Message								= Message.." Go to CTF Waiting Room - (2218,2791) Argent City."
				Message								= Message.." You have 5 minute(s) to register for battle.."
				GMNotice(Message)
			end
		end
		if Hour == v and Minute == 02 and Second == 00 then
			if (CTF.LobbyOpened == true) then
				Message								= Message.."<"..CTF.Conf.MapName..">: Registration is now Open!"
				Message								= Message.." Go to CTF Waiting Room - (2218,2791) Argent City."
				Message								= Message.." You have 3 minute(s) to register for battle.."
				GMNotice(Message)
			end
		end		
		if Hour == v and Minute == 04 and Second == 00 then
			if (CTF.LobbyOpened == true) then
				Message								= Message.."<"..CTF.Conf.MapName..">: Registration is now Open!"
				Message								= Message.." Go to CTF Waiting Room - (2218,2791) Argent City."
				Message								= Message.." You have 1 minute(s) to register for battle.."
				GMNotice(Message)
			end
		end	
		if Hour == v and Minute == CTF.Conf.CloseMin and Second == 00 then
			if (CTF.LobbyOpened == true) then
				CTF.StartMap()
				for i,v in pairs(CTF.Members) do
					if (GetChaMapName(TurnToCha(v.role)) == "pkmap") then
						StartPlayerCTF(TurnToCha(v.role))
					end
				end
			end
		end			
	end
end




CTF.Register 										= function(Player)
	local Minute									= tonumber(os.date("%M"))
	local PID										= GetCharID(Player)
	local OsTime									= os.time()
	local Attempt									= CTF.LeaveTime[PID]
	if GetChaAttr(Player, ATTR_JOB) < 8 then
		BickerNotice(Player, "Only characters that have done 2nd class advancement can participate!")
		return
	end
	if CTF.OpenDay() == 0 then
		BickerNotice(Player, "Registering for "..CTF.Conf.MapName.." is unavailable today, please come back again tommorow.")
		return
	end	
	-- Not registered and battle arealdy started.
	if CTF.MapOpened == true and CTF.Members[PID] == nil then
		BickerNotice(Player, "You can't participate, the battle arealdy started!")
		return
	end
	-- Checking alt characters
	if CTF.Members[PID] ~= nil and CTF.Members[PID].chaid ~= PID then
		BickerNotice(Player, "Alts are not allowed to enter "..CTF.Conf.MapName.."!")
		return
	end	
	-- Checking alt characters
	if CTF.Members[PID] ~= nil and CTF.Members[PID].chaid ~= PID then
		BickerNotice(Player, "Alts are not allowed to enter "..CTF.Conf.MapName.."!")
		return
	end			
	-- Registered, battle started and didn't DC on map.
	if CTF.Members[PID] ~= nil and CTF.Members[PID].lobby == 1 and CTF.MapOpened == true and Attempt == nil then
		StartPlayerCTF(Player)
		return
	end
	-- Registered, battle started and disconnect attempt time didn't gone.
	if CTF.Members[PID] ~= nil and CTF.Members[PID].lobby == 1 and CTF.MapOpened == true and Attempt ~= nil and OsTime < Attempt then
		StartPlayerCTF(Player)
		return
	end	
	-- Registered, battle started and disconnect attempt time gone.
	if CTF.Members[PID] ~= nil and CTF.Members[PID].lobby == 1 and CTF.MapOpened == true and Attempt ~= nil and OsTime >= Attempt then
		BickerNotice(Player, "You can't participate anymore, your attempt time has gone!")
		return
	end		
	if IsInTeam(Player) == 1 then
		BickerNotice(Player, "You're inside a party. Cannot register!")
		return
	end
	if CTF.Conf.MinLv > GetChaAttr(Player, ATTR_LV) or (CTF.Conf.MaxLv ~= 0 and CTF.Conf.MaxLv < GetChaAttr(Player, ATTR_LV)) then
		BickerNotice(Player, "You can't participate, only players between levels "..CTF.Conf.MinLv.." through "..CTF.Conf.MaxLv.." can participate.")
		return
	end	
	if CTF.OpenHour() ~= 1 or Minute >= CTF.Conf.CloseMin then
		BickerNotice(Player, "Registering for "..CTF.Conf.MapName.." is unavailable at this hour, please come back later.")
		return
	end		
	CTF.Members[PID]										= {role = Player, chaid = PID, lobby = 1}	
	MoveCity(Player, "Arena Island")	
end

function State_None_Add(role, statelv)
end
function State_None_Rem(role, statelv)
end