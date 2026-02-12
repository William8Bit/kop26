--------------------------------------------------------------------------
--									--
--									--
--				ctrl.lua				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading dyisland Ctrl.lua" )

function config(map)
    MapCanSavePos(map, 0) 
    MapCanPK(map, 1) 
    MapCanTeam( map, 1 )
    MapType( map , 3 )
    MapCopyNum(map, 1) 
    SingleMapCopyPlyNum(map, 300)  
    MapCanStall(map , 0)
end


function get_map_entry_pos_dyisland()

	local POS_X=2155
	local POS_Y=2782
	return POS_X , POS_Y

end

function init_entry(map)
    SetMapEntryMapName(map, "garner")
	SetMapEntryTime(map, "2022/1/30/3/0", "0/3/0", "0/0/05", "0/0/10")
end

function after_enter_dyisland( role , map_copy )
end

function before_leave_dyisland( role )
end

function map_copy_first_run_dyisland( map_copy )

end

function map_copy_run_dyisland( map_copy )
end

--?5??????
function map_run_dyisland( map )
end

--???????
function map_copy_close_dyisland ( map_copy )
end
		
--??????������������������������������������������

function can_open_entry_dyisland( map ) 
end 
function map_copy_run_special_dyisland(MapCopy)
end