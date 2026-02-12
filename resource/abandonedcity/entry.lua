function config_entry(entry) 
    SetMapEntryEntiID(entry, 53,1) 
end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0) 
    local EntryName = "Forsaken City"
    SetMapEntryEventName( entry, EntryName )

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    Notice("Announcement: Argent City ["..posx..","..posy.."] emerges a portal to [Forsaken City].") 

end

function after_destroy_entry_abandonedcity(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    Notice("Announcement: Argent City ["..posx..","..posy.."] [Forsaken City] has vanished. Enjoy!") 

end

function after_player_login_abandonedcity(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry)
    ChaNotice(player_name, "Announcement: Argent City ["..posx..","..posy.."] emerges a portal to [Forsaken City].")

end

function check_can_enter_abandonedcity(role, copy_mgr)
--	local Num_1= CheckBagItem( role,3909 )
	local Num_2= CheckBagItem( role,15667 )
	local Num_3= CheckBagItem( role,15668 )
	local Num_4= CheckBagItem( role,15669 )
	
    if Num_2 >= 1 or Num_3 >= 1 or Num_4 >= 1 then
        SystemNotice(role, "Please, remove [Level Booster] from your inventory!")    
        return 0
    end
	local Cha = TurnToCha(role)
 
	if Lv(Cha) >=30 and Lv(Cha) <=45 then
		return 1
	else
		SystemNotice(role, "Characters need to be between Lv 30 to 45 to enter Forsaken City")
		return 0    
	end
end

function begin_enter_abandonedcity(role, copy_mgr) 

		SystemNotice(role,"Entering [Forsaken City]") 
		MoveCity(role, "Forsaken City")

end