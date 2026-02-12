function config_entry(entry) 
	SetMapEntryEntiID(entry, 193,1)
end

function after_create_entry(entry) 
	local copy_mgr = GetMapEntryCopyObj(entry, 0)
	local EntryName = "Chaos Swamp"
	SetMapEntryEventName( entry, EntryName )
	map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry)
	--GMNotice("The portal to Chaos Swamp is now opened! Cords: 2219,2758 - Argent City")
end

function after_destroy_entry_PKmap(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    --GMNotice("The portal to Chaos Swamp is now closed") 

end

function after_player_login_PKmap(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --
    --ChaNotice(player_name, "<CS>Portal to Chaos Swamp has opened at ["..posx..","..posy.."] Argent City")

end

function check_can_enter_PKmap( role, copy_mgr )

	local Num_1= CheckBagItem( role,3909 )
	local Num_2= CheckBagItem( role,15667 )
	local Num_3= CheckBagItem( role,15668 )
	local Num_4= CheckBagItem( role,15669 )
	
    if Num_1 >= 1 or Num_2 >= 1 or Num_3 >= 1 or Num_4 >= 1 then
        SystemNotice(role, "Please, remove [Gyoza,Level Booster] from your inventory!")    
        return 0
    end

	local FightingBook_Num = 0
	FightingBook_Num = CheckBagItem( role,3849 )
	local Team_In = IsInTeam(role)
	if Team_In == 1 then
		SystemNotice ( role , "You cannot enter Chaos Swamp in a Party." )
		return 0
		
	end

	local Cha = TurnToCha(role)
  
	if Lv(Cha) >=25 and Lv(Cha) <=56 then
	
			return 1

	else
		SystemNotice(role, "Characters need to be between Lv 25 to 55 to enter Chaos Swamp")
		return 0    
	end

	if FightingBook_Num <= 0 then
		SystemNotice ( role , "You must have a Medal of Valor to enter Chaos Swamp" )
		return 0
	end
				
end
