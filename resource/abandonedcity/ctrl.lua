--���ļ��У����ǿ��ܱ����ִ�еĺ�������������Ҫ���ϵ�ͼ��ǰ׺

function config(map)
    MapCanSavePos(map, 0) --���õ�ͼ�Ƿ񱣴��ɫλ�ã���ͼ�����꣬���򣩣�������Ӱ��õ�ͼ�����и���
    MapCanPK(map, 1) --���õ�ͼ�Ƿ����PK��������Ӱ��õ�ͼ�����и���
    MapCopyNum(map, 1) --���õ�ͼ�ĸ�����Ŀ����������ø���䣬��ʹ��Ĭ��ֵ1
    SingleMapCopyPlyNum(map, 300)
    MapCanTeam(map , 1)
    MapType ( map , 4 )

end


function get_map_entry_pos_abandonedcity()
	local POS_X=2232
	local POS_Y=2808
	return POS_X , POS_Y
end

function init_entry(map)
    SetMapEntryMapName(map, "garner")
	SetMapEntryTime(map, "2022/1/30/6/0", "0/4/0", "0/0/20", "0/0/20")
end

function map_run_abandonedcity(Map)
end

function after_enter_abandonedcity(Player, MapCopy)
--	if HasMission(Player, 2002) == 1 then
--		SetFlag(Player, 2002, 10)
--	end
end

function before_leave_abandonedcity( role )
end

function map_copy_first_run_abandonedcity( map_copy )

end

function map_copy_run_abandonedcity( map_copy )
end


function map_copy_close_abandonedcity ( map_copy )
end
function can_open_entry_abandonedcity( map )
	local month = os.date ("%m")
	local day = os.date ("%d")
	local hour = os.date ("%H")
    local hournum = tonumber(hour)
	if hournum == 06 or hournum == 14 or hournum == 18 or hournum == 02 then
		LG('ForsakenCity-'..day..'', ' FC has opened today('..day..'/'..month..') at ('..hour..')')
		return 1
	else
		return 0
	end
end 
function map_copy_run_special_abandonedcity(MapCopy)
end

-------



function map_copy_before_close_abandonedcity(map_copy)
	
end