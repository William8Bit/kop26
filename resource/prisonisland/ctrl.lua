
function config(map)
    MapCanSavePos(map, 1)
    MapCanPK(map, 1)
    SingleMapCopyPlyNum(map, 300)
    MapCanTeam(map, 1)
    MapType(map, 4)
end
function map_run_prisonisland(map)
end
function init_entry(map)
end
function get_map_entry_pos_prisonisland()
	local POS_X = 0
	local POS_Y = 0
	return POS_X, POS_Y
end
function map_copy_run_prisonisland(MapCopy)
end



function after_enter_prisonisland( role , map_copy )
end

function before_leave_prisonisland( role )
end

function map_copy_first_run_prisonisland( map_copy )

end

function map_copy_close_prisonisland ( map_copy )
end
function can_open_entry_prisonisland( map ) 
end 
function map_copy_run_special_prisonisland(MapCopy)
end