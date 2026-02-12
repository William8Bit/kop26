-- -----------------------------
-- Hooking crusader stealth
-- -----------------------------
-- We initiate this hook if and only if stealth is disabled either globaly
-- or for the flag holder.
if (xmas2_conf.disable_stealth == true ) then
	print( "<07xmas2> Activating crusader stealt hook" )
	xmas2_stealth_hook = Skill_Ys_End
	Skill_Ys_End = function ( ATKER , DEFER , sklv )
		-- Apply hook only in the 07xmas2 map
		if (GetChaMapName(ATKER) ~= "07xmas2") then
			-- Call "native" stealth skill
			xmas2_stealth_hook( ATKER, DEFER, sklv )
		else
			local charname = GetChaDefaultName(ATKER)
			if (xmas2_conf.disable_stealth == true) then
				-- Noone can use stealth
				SystemNotice(ATKER, "Stealth is disable in Chaos Xmas")
			else
				-- Call "native" stealth skill
				xmas2_stealth_hook( ATKER, DEFER, sklv )
			end
		end
	end
end