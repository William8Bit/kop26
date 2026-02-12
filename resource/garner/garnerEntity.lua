--------------------------------------------------------------------------
--									--
--									--
--		EventEntity.lua Created by knight 2005.5.16.		--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading Garner EventEntity.lua" )


--初始化加纳大陆的事件实体信息
function InitGarnerEntity()

	--创建加纳大陆港口实体
	CreateBerthEntity( "Docked", 455, 2, 225065, 281984, 0, 1, 2231, 2827, 0 )
	CreateBerthEntity( "Docked", 455, 2, 326048, 330919,-10, 5, 3260,3280, 0 )
	CreateBerthEntity( "Docked", 455, 2, 230572, 112347,-10, 6, 2273,1122, 0 )
	CreateBerthEntity( "Docked", 455, 2, 363213, 74776,-10, 7, 3590,755, 0 )
	CreateBerthEntity( "Docked", 455, 2, 105831, 133151,-10, 2, 1058,1323, 0 )
	CreateBerthEntity( "Docked", 455, 2, 306925, 352225,-10, 2, 3101,3511, 0 )
	
	--创建箱子实体


end

InitGarnerEntity()