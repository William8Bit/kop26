
function config(map)
    MapCanSavePos(map, 0) 
    MapCanPK(map, 1) 
    MapCanTeam( map, 1 )
    MapType( map , 3 )
    MapCopyNum(map, 1) 
    SingleMapCopyPlyNum(map, 300)  
    MapCanStall(map , 0)
end
function get_map_entry_pos_eastgoaf()   --������ڵ�λ�õ����꣨���꣨�ף���

	local POS_X=3430
	local POS_Y=3296
	return POS_X , POS_Y

end
function init_entry(map)

    SetMapEntryMapName(map, "darkblue") --������ڵ�λ�ã���ͼ����
    SetMapEntryTime(map, "2006/10/18/7/0", "0/12/0", "0/0/0", "0/0/0") -- The first set of numbers is the starting point (Year/Month/Day/Hour/Minute), next is opening interval (Day/Hour/Minute), portal open duration (Day/Hour/Minute), and last is the map duration (Day/Hour/Minute)

end

function after_enter_eastgoaf( role , map_copy )
end

function before_leave_eastgoaf( role )
end

function map_copy_first_run_eastgoaf( map_copy )

end

function map_copy_run_eastgoaf( map_copy )
end

function map_run_eastgoaf( map )
end

function map_copy_close_eastgoaf ( map_copy )
end

function can_open_entry_eastgoaf( map ) 
	local month = os.date ("%m")
	local day = os.date ("%d")
	local hour = os.date ("%H")
    local hournum = tonumber(hour)
	if hournum == 07 or hournum == 19 then
		LG('BDLAIR-'..day..'', ' BD LAIR has opened today('..day..'/'..month..') at ('..hour..')')
		return 1
	else
		return 0
	end
end 