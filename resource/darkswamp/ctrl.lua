
function config(map)
    MapCanSavePos(map, 1)
    MapCanPK(map, 1)
    MapCopyNum(map, 1)
    SingleMapCopyPlyNum(map, 300)
	MapCanTeam(map , 1)
    MapType ( map , 3 )
end
function get_map_entry_pos_darkswamp()

	local POS_X=2299
	local POS_Y=2754
	return POS_X , POS_Y

end
function init_entry(map)
    SetMapEntryMapName(map, "garner")
    SetMapEntryTime(map, "2005/8/30/6/0", "0/4/0", "0/0/50", "0/0/55")
end
function map_run_darkswamp(Map)
end
function map_copy_run_darkswamp( map_copy )
end
function after_enter_darkswamp(Player, map_copy)
end

function before_leave_darkswamp( role )
end

function map_copy_first_run_darkswamp( map_copy )

end
function map_run_darkswamp( map )
end

function map_copy_close_darkswamp ( map_copy )
end
function can_open_entry_darkswamp( map )
	local month = os.date ("%m")
	local day = os.date ("%d")
	local hour = os.date ("%H")
    local hournum = tonumber(hour)
	if hournum == 06 or hournum == 10 or hournum == 14 or hournum == 18 or hournum == 22 or hournum == 02 then
		LG('DarkSwamp-'..day..'', ' DS has opened today('..day..'/'..month..') at ('..hour..')')
		return 1
	else
		return 0
	end
end 
function map_copy_run_special_darkswamp(map_copy)
end
function map_copy_before_close_darkswamp(map_copy)
end