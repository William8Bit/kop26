function config_entry(entry) 
    SetMapEntryEntiID(entry, 193,1) 
end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0) 
    local EntryName = "Dark Swamp"
    SetMapEntryEventName( entry, EntryName )
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    ScrollNotice("Announcement: Argent City ["..posx..","..posy.."] emerges a portal that leads to [Dark Swamp].", 1) 
end

function after_destroy_entry_darkswamp(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    ScrollNotice("Announcement: Argent City ["..posx..","..posy.."] nearby has ceased. Remember to take note of the announcement!", 1) 

end

function after_player_login_darkswamp(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    ChaNotice(player_name, "Announcement: Argent City ["..posx..","..posy.."] emerges a portal that leads to [Dark Swamp].") 
end

function check_can_enter_darkswamp( role, copy_mgr )
	local Num_2= CheckBagItem( role,15667 )
	local Num_3= CheckBagItem( role,15668 )
	local Num_4= CheckBagItem( role,15669 )
	
    if Num_2 >= 1 or Num_3 >= 1 or Num_4 >= 1 then
        SystemNotice(role, "Please, remove [Level Booster] from your inventory!")    
        return 0
    end
    local Cha = TurnToCha(role)
  
	if Lv(Cha) >=50 and Lv(Cha) <=55 then
		return 1
	else
		--SystemNotice(role, "Characters need to be between Lv 50 to 55 to enter Dark Swamp")
		return 1
	end
end

function begin_enter_darkswamp(role, copy_mgr) 
    SystemNotice(role,"Entering [Dark Swamp]") 
    MoveCity(role, "Dark Swamp")
end 