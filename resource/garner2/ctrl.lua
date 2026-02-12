
function config(map)
  MapCanSavePos(map, garner2.conf['saveSpawn']);
  MapCanPK(map, garner2.conf['canPk']);
  MapCanTeam(map, garner2.conf['canTeam']);
  MapType(map, garner2.conf['mapType']);
  MapCopyNum(map, garner2.conf['mapCopy']);
  SingleMapCopyPlyNum(map, garner2.conf['chaAllow']);
  MapCanStall(map, garner2.conf['canStall']);
end

function init_entry(map)
  SetMapEntryMapName(map, garner2.pos['map'])
  SetMapEntryTime(map,
    '2013/07/12/0/0',
    '0/'..garner2.entry['hoursOpen']..'/0',
    '0/0/'..garner2.entry['closeTime'],
    '0/0/'..garner2.entry['shutdown']
  )
end

function Garner2SearchPartyCheater(role)
    local Team_In = IsInTeam(role)
    if Team_In == 1 then
        MoveCity(role,"Argent City")
    end
end