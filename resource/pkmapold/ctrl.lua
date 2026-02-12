function config(map)
	MapCanSavePos(map, 0)
	MapCanPK(map, 0)
	MapCopyNum(map, 1)
	SingleMapCopyPlyNum(map, CTF.Conf.NumPlayer)
	MapCanTeam(map, 0)
	MapType(map, 1)
end
function get_map_entry_pos_pkmap()
	local PosX 										= 0
	local PosY 										= 0
	return PosX, PosY
end
function init_entry(map)
end
function after_enter_pkmap(Player, MapCopy)
end
function before_leave_pkmap(Player)
end
function map_run_pkmap(Map)
end
function map_copy_run_pkmap(MapCopy)
end