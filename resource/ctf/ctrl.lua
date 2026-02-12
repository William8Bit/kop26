function config(map)
	MapCanSavePos(map, 0)
	MapCanPK(map, 1)
	if CTF.Conf.ServerVersion ~= 2 then
		MapCopyNum(map, CTF.Conf.NumMapCopy)
	end
	SingleMapCopyPlyNum(map, CTF.Conf.NumPlayer)
	MapCanTeam(map, 0)
	MapType(map, CTF.Conf.MapType)
end
function get_map_entry_pos_ctf()
	local PosX 										= 0
	local PosY 										= 0
	return PosX, PosY
end
function init_entry(map)
end
function after_enter_ctf(Player, MapCopy)
	local Message 									= ""		
	-- Get player information
	local PID 										= GetPlayerID(GetChaPlayer(Player))
	-- Set the player's side
	if (CTF.Players[PID].side_id == 1) then
		-- Red Team
		SetChaSideID(TurnToCha(Player), 2)
		-- Show some messages
		if (CTF.Players[PID].entered	== LUA_FALSE) then
			CTF.Players[PID].entered 			= LUA_TRUE
			Message 								= AdjustTextSpace(">> Capture The Flag <<", 42, "_")
			Message 								= Message.."You were placed in the Red Team!_"
			Message 								= Message.."* Capture the Flag and carry to enemy team to obtain 10 points._"
			Message 								= Message.."* The team who reach 100 points wins the battle._"
			Message 								= Message.."* Killing players from enemy team has 25% chance to grant 1 point._"
			Message 								= Message.."* Team points can be checked at NPC located in your base._"
			HelpInfoX(TurnToCha(Player), 0, Message)
		end
	else
		-- Green Team
		SetChaSideID(TurnToCha(Player), 1)
		-- Show some messages
		if (CTF.Players[PID].entered	== LUA_FALSE) then
			CTF.Players[PID].entered 			= LUA_TRUE
			Message 								= AdjustTextSpace(">> Capture The Flag <<", 42, "_")
			Message 								= Message.."You were placed in the Green Team!_"
			Message 								= Message.."* Capture the Flag and carry to enemy team to obtain 10 points._"
			Message 								= Message.."* The team who reach 100 points wins the battle._"
			Message 								= Message.."* Killing players from enemy team has 25% chance to grant 1 point._"
			HelpInfoX(TurnToCha(Player), 0, Message)
		end	
	end
end
function before_leave_ctf(Player)
	-- Get player information	
	local Hp											= GetChaAttr(Player, ATTR_HP)
	local PID										= GetPlayerID(GetChaPlayer(Player))
	local ChaName 									= GetChaDefaultName(Player)
	local TeamID 									= GetChaSideID(Player)
	if CTF.MapOpened == true then
		-- Reduce the number of players
		if (TeamID == 2) then
			-- Reduce the number of players in Red Team
			CTF.RedTeam.Counter 					= CTF.RedTeam.Counter - 1
			MapCopyNotice(MapCopy, "["..CTF.Conf.MapName.."]: "..ChaName..", left the Red Team!")	
		else
			-- Reduce the number of players in Green Team
			CTF.GreenTeam.Counter 					= CTF.GreenTeam.Counter - 1
			MapCopyNotice(MapCopy, "["..CTF.Conf.MapName.."]: "..ChaName..", left the Green Team!")			
		end	
		-- Player has the flag and leaves the battle.
		if (CTF.Flag_ChaID == PID) then
			CTF.Flag_ChaID							= 0 
			CTF.Flag_Spawned						= LUA_FALSE
			RemoveState(Player, CTF.Conf.Flag.State)
			
			if (TeamID == 2) then
				MapCopyNotice(MapCopy, "["..CTF.Conf.MapName.."]: The Red Team lost the Flag!")	
			else
				MapCopyNotice(MapCopy, "["..CTF.Conf.MapName.."]: The Green Team lost the Flag!")	
			end
		end
		
		-- Player has been disconnected, or accidently leave map.
		if (Hp > 0 and CTF.LeaveTime[PID] == nil) then
			CTF.LeaveTime[PID]						= os.time() + CTF.Conf.Time.Attempt
		end
	end
end
function map_run_ctf(Map)
end
function map_copy_run_ctf(MapCopy)
	local ActivePlayer								= GetMapActivePlayer(MapCopy) or 0
	if CTF.MapOpened == false then
		return
	end
	
	-- Theres no players in map, we close it.
	if ActivePlayer < 1 then
		CTF.MapOpened = false
		CTF.Finish(MapCopy)
	end
	
	-- Summoning the flag.
	if (CTF.Flag_ChaID == 0 and CTF.Flag_Spawned == LUA_FALSE) then
		CTF.Flag_Spawned							= LUA_TRUE	
		local Flag 									= CreateChaEx(CTF.Conf.Flag.ID, CTF.Conf.Flag.Pos_X * 100, CTF.Conf.Flag.Pos_Y * 100, 180, 86400, MapCopy)
		AddState(Flag, Flag, CTF.Conf.Flag.State, 1, 1200)		
		SetChaLifeTime(Flag, 1200000)
		MapCopyNotice(MapCopy, "["..CTF.Conf.MapName.."]: The Flag has been spawned at ("..CTF.Conf.Flag.Pos_X..","..CTF.Conf.Flag.Pos_Y..")!")
	end
	
	-- Check if player has flag and is in enemy team base.
	if CTF.Flag_Spawned == LUA_FALSE and CTF.Flag_ChaID ~= 0 then
		DealAllActivePlayerInMap(MapCopy, "CarryTheFlag")
	end
	
	-- Checking team which reachs minimum score to win battle.
	if CTF.GreenTeam.Score >= CTF.Conf.ScoreLimit or CTF.RedTeam.Score >= CTF.Conf.ScoreLimit then
		CTF.Finish(MapCopy)
	end
	
	-- Closing the map if battle como to an end.
	if CTF.BattleTime < 1 then
		CTF.Finish(MapCopy)
	end
	
	-- Announces every 3 minutes team score.
	if (math.mod(CTF.BattleTime, CTF.Conf.Time.Refresh) == 0 and CTF.BattleTime > 0) then
		MapCopyNotice(MapCopy, "["..CTF.Conf.MapName.."]: Red Team Score {"..CTF.RedTeam.Score.."} X Green Team Score {"..CTF.GreenTeam.Score.."}!")
	end
	
	if CTF.BattleTime > 0 and CTF.BattleTime < 11 then
		MapCopyNotice(MapCopy, "["..CTF.Conf.MapName.."]: The battle will end in "..CTF.BattleTime.." seconds!")
	end
	CTF.BattleTime							= CTF.BattleTime - 1
end

function map_copy_run_special_ctf(MapCopy)
end