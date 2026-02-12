dofile(GetResPath("07xmas2/conf.lua"))

print( "Loading 07xmas2 Ctrl.lua" )

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
    MapCanTeam( map, 1 )
    MapType( map , 3 )
    MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    SingleMapCopyPlyNum(map, 300)   --设置一个副本的玩家数
    --MapCanTeam(map , 1)
    MapCanStall(map , 0)
end


function get_map_entry_pos_07xmas2()   --设置入口的位置的坐标（坐标（米））

	local POS_X=896
	local POS_Y=3575
	return POS_X , POS_Y

end
---whare cord and map enter ganer or shaitan or icicle?? idk ??
function init_entry(map)

    SetMapEntryMapName(map, "magicsea") --设置入口的位置（地图名）
    SetMapEntryTime(map, "2012/09/24/14/0", "0/7/0", "0/0/35", "0/0/25") --设置入口的时间，地图对象，首次开启时间（年/月/日/时/分），以后再次开启的间隔（日/时/分，全０表示只有首次开启），每次开启到入口消失的间隔（日/时/分，全０表示永不消失），每次开启到地图关闭的间隔（日/时/分，全０表示永不关闭）。。

end

function after_enter_07xmas2( player , map_copy )
	RemoveYS( player )
end

function before_leave_07xmas2( role )
end

--function map_copy_first_run_07xmas2( map_copy )
--	lua_SetCopySpecialInter(map_copy , 10000)
--	Notice("10")
--
--end

--function map_copy_run_07xmas2( map_copy )
----Notice("3")
--local new1 = CreateChaEx(791, 120, 120, 145, 50)
--	SetChaLifeTime(new1, 900000)
	--local mobimmortal = CreateChaEx(221, 14500, 16600, 145, 60, map_copy)
	--SetChaLifeTime(mobimmortal,5 * 60 * 1000)
	--if CheckMonsterDead ( mobimmortal ) == 1 then
		--if CRY[19]==0 then
			--Notice("<GW>Someone is become Immortal! BEWARE")
			--CRY[19]=1
		--end
	--end
--end

--每5分钟秒执行1次
function map_copy_run_special_07xmas2( map_copy ) 
	Every_5_minute3 = Every_5_minute3+1
	if Every_5_minute3 == 1 then -- 初级宝箱
		local HowManyNoDead = GetMapActivePlayer(map_copy)
		Notice("<GW> There are current ["..HowManyNoDead.."] people in Guild War!")
	end
	
	if Every_5_minute3 == 2 then -- 初级宝箱
		local HowManyNoDead = GetMapActivePlayer(map_copy)
		Notice("<GW> There are current ["..HowManyNoDead.."] people in Guild War!")
	end
	
	if Every_5_minute3 == 3 then -- 中级宝箱
		local HowManyNoDead = GetMapActivePlayer(map_copy)
		Notice("<GW> There are current ["..HowManyNoDead.."] people in Guild War!")
		Notice("<GW> Flower Of Immortal has been spawn!")
		if (xmas2_conf.enable_random1_spawns == true) then
			for i = 1, xmas2_conf.random1_mob_count do
				local locationIndex = math.random(1,table.getn(xmas2_conf.random1_mob_location))
				local mobX =  xmas2_conf.random1_mob_location[locationIndex].x
				local mobY =  xmas2_conf.random1_mob_location[locationIndex].y
				-- spawn the random mob for x minutes
				local mob = CreateChaEx(221, mobX*100, mobY*100, 145, 1800, map_copy)
				SetChaLifeTime(mob,xmas2_conf.random1_mob_lifelength * 60 * 1000)
			end
		end
	end

	if Every_5_minute3 == 4 then -- 中级宝箱
		local HowManyNoDead = GetMapActivePlayer(map_copy)
		Notice("<GW> There are current ["..HowManyNoDead.."] people in Guild War!")
	end
	if Every_5_minute3 == 5 then -- 高级宝箱
		local HowManyNoDead = GetMapActivePlayer(map_copy)
		Notice("<GW> There are current ["..HowManyNoDead.."] people in Guild War!")
	end
	if Every_5_minute3 == 6 then --新手
		local HowManyNoDead = GetMapActivePlayer(map_copy)
		Notice("<GW> There are current ["..HowManyNoDead.."] people in Guild War!")
	end
	if Every_5_minute3 == 7 then -- 一转角色
		local HowManyNoDead = GetMapActivePlayer(map_copy)
		Notice("<GW> There are current ["..HowManyNoDead.."] people in Guild War!")
		Notice("<GW> Flower Of Immortal has been spawn!")
		if (xmas2_conf.enable_random1_spawns == true) then
			for i = 1, xmas2_conf.random1_mob_count do
				local locationIndex = math.random(1,table.getn(xmas2_conf.random1_mob_location))
				local mobX =  xmas2_conf.random1_mob_location[locationIndex].x
				local mobY =  xmas2_conf.random1_mob_location[locationIndex].y
				-- spawn the random mob for x minutes
				local mob = CreateChaEx(221, mobX*100, mobY*100, 145, 1800, map_copy)
				SetChaLifeTime(mob,xmas2_conf.random1_mob_lifelength * 60 * 1000)
			end
		end

	end
	if Every_5_minute3 == 8 then -- 二转角色
		local HowManyNoDead = GetMapActivePlayer(map_copy)
		Notice("<GW> There are current ["..HowManyNoDead.."] people in Guild War!")

	end
	if Every_5_minute3 == 9 then -- 黑龙角色
		local HowManyNoDead = GetMapActivePlayer(map_copy)
		Notice("<GW> There are current ["..HowManyNoDead.."] people in Guild War!")
		Notice("<GW> Chest of Xmas has beed Spawn!")
		if (xmas2_conf.enable_random_spawns == true) then
			for i = 1, xmas2_conf.random_mob_count do
				local locationIndex = math.random(1,table.getn(xmas2_conf.random_mob_location))
				local mobX =  xmas2_conf.random_mob_location[locationIndex].x
				local mobY =  xmas2_conf.random_mob_location[locationIndex].y
				-- spawn the random mob for x minutes
				local mob = CreateChaEx(1392, mobX*100, mobY*100, 145, 1800, map_copy)
				SetChaLifeTime(mob,xmas2_conf.random_mob_lifelength * 60 * 1000)
			end
		end
	end
	if Every_5_minute3 == 10 then -- 二转角色
		local HowManyNoDead = GetMapActivePlayer(map_copy)
		Notice("<GW> There are current ["..HowManyNoDead.."] people in Guild War!")
	end
	
end
--每5秒执行一次的
function map_run_07xmas2( map )
	
end

--地图关闭时执行
-- this function runs before map closes
function map_copy_before_close_07xmas2( map_copy )
	How_Many_Active = GetMapActivePlayer(map_copy)
	if How_Many_Active > 0 then
		-- it runs this function on all players in the map 'GiveSpecItem' b
		DealAllActivePlayerInMap(map_copy,"xmas2GiveSpecItem")
	end
	How_Many_Active = 0
	Money_all = 10000000 -- amount of gold shared among people inside, survivors
	Every_5_minute3 = 0
end

--地图关闭时执行
function map_copy_close_07xmas2( map_copy )
	ClearAllSubMapCha(map_copy)
end
--
--地图开关判断——————————————————————————————————————————


function xmas2GiveSpecItem( role ) -- functon name is GiveSpecItem, fix is simple, just do this
-- if there is 0 players then does nothing
	if How_Many_Active == 0 then
		return
	end
	
	local Money_07xmas2 = Money_all/How_Many_Active
--	SystemNotice(role,How_Many_Active)

	if How_Many_Active > 10 then
		local Item_CanGet = GetChaFreeBagGridNum ( role )
		if Item_CanGet <= 0 then
			GiveItemX ( role , 0 , 854  , 10 , 4 )
		else
			GiveItem ( role , 0 , 854  , 10 , 4 )
		end
		AddMoney ( role , 0 , Money_07xmas2 )
	--	local message = "今天的乱斗共存活了"..How_Many_Active .. "位玩家,他们每人将获得"..Money_07xmas2 .."的金钱"
	--	SystemNotice(role,How_Many_Active)
		return
	end

	if How_Many_Active <  11 and How_Many_Active > 5 then
		local Item_CanGet = GetChaFreeBagGridNum ( role )
		if Item_CanGet <= 0 then
			GiveItemX ( role , 0 , 18794  , 5 , 4 ) --- 15972 show me where this here ? xzzzzzzzzz if its not here how xmaz give me it lol
			GiveItemX ( role , 0 , 18795  , 5 , 4 )--- u undetsand me ? this will not work trust me whait
		else
			GiveItem ( role , 0 , 1032  , 5 , 4 )
			GiveItem ( role , 0 , 1031  , 5 , 4 )
		end
			 
		AddMoney ( role , 0 , Money_07xmas2 )
		--SystemNotice(role,How_Many_Active)
					
		--local message = "今天的乱斗中共存活了"..How_Many_Active .."位玩家,他们每人将获得"..Money_07xmas2 .."的金钱和1个乱斗之星徽章"
		--Notice ( message )
		return
	end
	
	if How_Many_Active <  6 and How_Many_Active > 0 then
		local Item_CanGet = GetChaFreeBagGridNum ( role )
		if Item_CanGet <= 0 then
			GiveItemX ( role , 0 , 18794  , 5 , 4 )
			GiveItemX ( role , 0 , 0854  , 20 , 4 )
			GiveItemX ( role , 0 , 15085  , 1 , 4 )
		else
			GiveItem ( role , 0 , 18794  , 5 , 4 ) 
			GiveItem ( role , 0 , 0854  , 20 , 4 )
			GiveItem ( role , 0 , 15085  , 1 , 4 )
		end
		AddMoney ( role , 0 , Money_07xmas2 )
		
		
		local cha_name = GetChaDefaultName ( role )
		ScrollNotice("["..cha_name.."] is the only survivor in Guild War and obtained [65000000 Gold ]",2)
		LG('CAWinners', ''..cha_name..' is the only survivor in Guild War and obtained [65000000 Gold  ]')
		SystemNotice(role,How_Many_Active)
		return
		
	end
end 
