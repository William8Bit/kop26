
function config_entry(entry) 
    SetMapEntryEntiID(entry,193,1) --���õ�ͼ���ʵ��ı�ţ��ñ�Ŷ�Ӧ��characterinfo.txt��������

end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0)
    local EntryName = "Fast Pace"
    SetMapEntryEventName( entry, EntryName )
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
	ScrollNotice("The portal to Fast Pace is now opened! Coords: ["..posx..","..posy.."] - Argent City",1) 

end

function after_destroy_entry_dyisland(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    --GMNotice("<CA>The portal to Chaos Argent is now closed") 
    ScrollNotice("<FP>The portal to Fast Pace is now closed",1) 

end

function after_player_login_dyisland(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    ChaNotice(player_name, "<FP>Portal to Fast Pace has opened at ["..posx..","..posy.."] Argent City") 

end

function begin_enter_dyisland(role, copy_mgr) 

		MoveCity(role, "Fast Pace")
end
