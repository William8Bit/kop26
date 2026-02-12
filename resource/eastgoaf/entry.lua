function config_entry(entry) 
    SetMapEntryEntiID(entry,193,1) --���õ�ͼ���ʵ��ı�ţ��ñ�Ŷ�Ӧ��characterinfo.txt��������

end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0)
    local EntryName = "Black Dragon Lair"
    SetMapEntryEventName( entry, EntryName )

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    ScrollNotice("The portal to Black Dragon Lair is now opened! at ["..posx..","..posy.."] - Summer Island", 1) 
	--SendKillNotice("The portal to Black Dragon Lair is now opened! at ["..posx..","..posy.."] - Summer Island")
end

function after_destroy_entry_eastgoaf(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    GMNotice("<BDL>The portal to Black Dragon Lair is now closed") 
    --SendKillNotice("<BDL>The portal to Black Dragon Lair is now closed") 

end

function after_player_login_eastgoaf(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    ChaNotice(player_name, "<BDL>Portal to Black Dragon Lair has opened at ["..posx..","..posy.."] - Summer Island") 
    --SendKillNotice("<BDL>Portal to Black Dragon Lair has opened at ["..posx..","..posy.."] - Summer Island") 

end






function check_can_enter_eastgoaf( role, copy_mgr )
end


function begin_enter_eastgoaf(role, copy_mgr) 
		MoveCity(role, "BlackDragonLair")
end



function before_leave_eastgoaf ( role )

end




