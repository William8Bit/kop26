--print('Loading PKmap Ctrl.lua')

function config(map)
    MapCanSavePos(map, 0)
    MapCanPK(map, 1)
    MapCopyNum(map, 1)
	SingleMapCopyPlyNum(map, 300)
    MapCanTeam( map, 1 )
    MapType( map , 3 )
end

function get_map_entry_pos_PKmap() 

end

function init_entry(map)

end

function can_open_entry_PKmap(map)

end 

function after_enter_PKmap(role, map_copy)

end

function before_leave_PKmap(role)

end

function map_copy_run_PKmap(map)

end
function map_run_PKmap(map)

end

function map_copy_run_special_PKmap(map_copy)

end

function map_copy_before_close_PKmap( map_copy )

end

function map_copy_close_PKmap( map_copy )
	ClearAllSubMapCha(map_copy)
end
