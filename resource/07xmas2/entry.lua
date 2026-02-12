--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

function config_entry(entry) 
    SetMapEntryEntiID(entry,2492,1) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）

end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0)
    local EntryName = "Guild War"
    SetMapEntryEventName( entry, EntryName )

   map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
   ScrollNotice("The portal to Guild War is now opened! at ["..posx..","..posy.."] - Shaitan City", 1) 
   --SendKillNotice("The portal to Black Dragon Lair is now opened! at ["..posx..","..posy.."] - Summer Island")
   
end

function after_destroy_entry_07xmas2(entry)
  

end

function after_player_login_07xmas2(entry, player_name)


end


function check_can_enter_07xmas2( role, copy_mgr )
	local Credit_Garner2 = GetCredit(role)
	 if Credit_Garner2 < 0 then 
		SystemNotice ( role , "You do not have enough Reputation Points" )
		return 0
	else
--		DelCredit(role,30)
	end
	if Lv(role) < 55 then
	SystemNotice(role, "You must be above level 55 to enter Chaos Xmas")
		return 0    
	end
	local Has_money = check_HasMoney(role)
	if Has_money == 1 then
		
		return 1
		
	else
		SystemNotice(role,"You do not have enough Gold to enter Guild War")
		return 0
	end
end

function check_HasMoney(role)
	local lv= GetChaAttr(role, ATTR_LV)
	local Money_Need = lv*50
	local Money_Have = GetChaAttr ( role , ATTR_GD )
		if Money_Have >= Money_Need then
			return 1
		end

end


function begin_enter_07xmas2(role, copy_mgr) 
	local	Money_Have = GetChaAttr ( role , ATTR_GD )
	local lv= GetChaAttr(role, ATTR_LV)
	local Money_Need = lv*50
	local	Money_Now = Money_Have - Money_Need
	SetChaAttrI( role , ATTR_GD , Money_Now )
	DelCredit(role,30)
		SystemNotice(role,"Collects Fee: "..Money_Need.."Gold , 30 Rep") 
		local characterName = GetChaDefaultName(role)
		Notice("<CX> Beware "..characterName.." joined in!")
		MoveCity(role, "Converse Christmas Village")
      Money_all = Money_all + Money_Need * 0.8
end












