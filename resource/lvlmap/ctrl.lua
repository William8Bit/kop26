--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 0) --设置地图是否可以PK，此设置影响该地图的所有副本
    MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    SingleMapCopyPlyNum(map, 300)   --设置一个副本的玩家数
	MapCanTeam(map , 1)
    MapType ( map , 1 )
end

function get_map_entry_pos_lvlmap()   --设置入口的位置的坐标（坐标（米））

	local POS_X=1308
	local POS_Y=529
	return POS_X , POS_Y

end


function init_entry(map)
    SetMapEntryMapName(map, "darkblue") --设置入口的位置（地图名，坐标（米））
    SetMapEntryTime(map, "2005/8/30/0/0", "0/12/0", "0/11/58", "0/11/59") --设置入口的时间，地图对象，首次开启时间（年/月/日/时/分），以后再次开启的间隔（日/时/分，全０表示只有首次开启），每次开启到入口消失的间隔（日/时/分，全０表示永不消失），每次开启到地图关闭的间隔（日/时/分，全０表示永不关闭）。。

end

function map_copy_before_close_lvlmap( map_copy )
end

function map_copy_close_lvlmap ( map_copy )
end