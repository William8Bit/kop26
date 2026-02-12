--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
    MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    SingleMapCopyPlyNum(map, 300)   --设置一个副本的玩家数
    MapCanTeam(map , 1)
    MapType ( map , 4 )
end


function get_map_entry_pos_puzzleworld()   --设置入口的位置的坐标（坐标（米））

	local POS_X=1071
	local POS_Y=910
	return POS_X , POS_Y

end
function init_entry(map)
    SetMapEntryMapName(map, "garner") --????????λ??????????
	SetMapEntryTime(map, "2022/1/30/14/0", "0/3/0", "0/0/59", "0/0/59")
end

function map_run_puzzleworld(map)
end
function map_copy_run_puzzleworld(MapCopy)
end
function after_enter_puzzleworld(Player, MapCopy)
--	if HasMission(Player, 2022) == 1 then
--		SetFlag(Player, 2022, 10)
--	end
end
function map_copy_run_special_puzzleworld(MapCopy)
end
function before_leave_puzzleworld(Player)
end


------

function map_copy_close_puzzleworld(map_copy)
end
function can_open_entry_puzzleworld( map ) 
--	local time = GetTickCount ( ) 
	local month = os.date ("%m")
	local day = os.date ("%d")
	local hour = os.date ("%H")
    local hournum = tonumber(hour)
	if hournum == 14 or hournum == 17 or hournum == 20 or hournum == 23 or hournum == 02 or hournum == 05 or hournum == 08 then
		LG('PuzzleWorld-'..day..'', ' DW has opened today('..day..'/'..month..') at ('..hour..')')
		return 1
	else
		return 0
	end
--	local Now_Time = GetNowTime()
--	if Now_Time ==12 or Now_Time == 18 then
--		return 1
--	else
--		return 1
--	end

end 
function map_copy_before_close_puzzleworld(map_copy)
	
end