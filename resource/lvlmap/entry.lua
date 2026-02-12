--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

function config_entry(entry) 
    SetMapEntryEntiID(entry, 193,1) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）
end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0)
    local EntryName = "Leveling Maze 24/7"
    SetMapEntryEventName( entry, EntryName )

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    Notice("Announcement: Icicle City ["..posx..","..posy.."] emerges a portal that leads to [Leveling Maze].") 

end

function after_destroy_entry_lvlmap(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    Notice("Announcement: Icicle City ["..posx..","..posy.."] nearby has ceased. Remember to take note of the announcement!") 

end

function after_player_login_lvlmap(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    ChaNotice(player_name, "The portal to Leveling Maze is opened! Cords: 1308,529 - Icicle City") 

end

function check_can_enter_lvlmap( role, copy_mgr )
	local Num_2= CheckBagItem( role,15667 )
	local Num_3= CheckBagItem( role,15668 )
	local Num_4= CheckBagItem( role,15669 )
	
    if Num_2 >= 1 or Num_3 >= 1 or Num_4 >= 1 then
        SystemNotice(role, "Please, remove [Level Booster] from your inventory!")    
        return 0
    end
end

function begin_enter_lvlmap(role, copy_mgr) 
	local cha_name = GetChaDefaultName ( role ) 
	local message = "<LM>"..cha_name.." Enters Leveling Maze"
	Notice ( message )
	SystemNotice(role,"Entering [Leveling Maze]") 
	MoveCity(role, "Leveling Maze")

end 