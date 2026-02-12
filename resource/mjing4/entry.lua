-- This document may be repeated whenever the implementation of the function, function names must be prefixed with the map name, such as after_destroy_entry_testpk 
-- This document the number of characters per line for the 255 largest, if objection to, please explore and procedures 

function config_entry (entry) 
    SetMapEntryEntiID (entry, 193,1) -- set up the entrance of entities map number (the number corresponds to the index characterinfo.txt) 

end 

function after_create_entry (entry) 
     local copy_mgr = GetMapEntryCopyObj (entry, 0) -- create a copy of the management of the object, this function explicit in the entrance of the map must be called, for the entrance of an implicit map (such as team challenges) No need to call the interface 

     map_name, posx, posy, tmap_name = GetMapEntryPosInfo (entry) -- check the map the location of the entrance information (the map name, the coordinates of the target map name) 
     Notice ( " Winter Island  opened Portal to Dark Area 2") -- to inform the server of the group of all players 

end 

function after_destroy_entry_mjing4 (entry) 
     map_name, posx, posy, tmap_name = GetMapEntryPosInfo (entry) 
     Notice ( "Pirate radio: access to Dark Area 2 entrance has disappeared!") 

end 

function after_player_login_mjing4(entry, player_name) 
     map_name, posx, posy, tmap_name = GetMapEntryPosInfo (entry) -- check the map the location of the entrance information (the map name, the coordinates of the target map name) 
     ChaNotice (player_name, "Winter Island  opened Portal to Dark Area 2") -- to inform the server of the group of all players 
end