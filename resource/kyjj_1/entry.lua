function config_entry(entry) 
    SetMapEntryEntiID(entry, 193,1)

end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0)
    local EntryName = "Portal to Obscure Domain 1"
    SetMapEntryEventName( entry, EntryName )
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
   -- Notice("Pirate Radio: On Argent City appears portal to [Obscure Domain 1] at ["..posx..","..posy.."], let's check what's happening there.") 

end

function after_destroy_entry_kyjj_1(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    Notice("Entrance to [Kyjj 1] was vanished") 

end

function after_player_login_kyjj_1(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry)
  --  ChaNotice(player_name, "Hey! On Argent City appears the portal to [Obscure Domain 1] at ["..posx..","..posy.."], let's check what's happening there.")

end

function check_can_enter_kyjj_1( role, copy_mgr )


end

function begin_enter_kyjj_1(role,copy_mgr) 
	SystemNotice(role,"Entering [Obscure Domain 1 Floor]") 
	MoveCity(role,"Obscure Domain 1 Floor")
end