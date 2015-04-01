ProbablyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})



ProbablyEngine.rotation.register_custom(105, "|cff00FFFFDr. Green Thumb|r - |cffFF7D0ABattleground 10vs10 v0.1|r", {

-- Stun
{ "5211", { "target.health <= 10", "target.range <= 5" }, "target" },

-- Modifiers
{ "33786", { "modifier.rshift", "focus.range <= 20" }, "focus"}, -- Cyclone focus
{ "768", "modifier.lshift", "player" },

-- Misc self
{ "102342",  "player.health <= 75", "player" }, 
{ "22812", { "player.health <= 50" }, "Player" }, -- Barkskin
{ "108238", { "player.health <= 40", "talent(2,2)" }, "Player" }, -- Renewal
{ "102351",{ "player.health <= 40","talent(2,3)" }, "player" }, -- Cenarion Ward
{ "#5512", "player.health <= 30" }, -- Healthstone

-- Misc Mate
{{ -- Cenarion Ward
	{ "102351", { "raid1.health <= 60", "raid1.range <= 40" }, "raid1"},
	{ "102351", { "raid2.health <= 60", "raid2.range <= 40" }, "raid2"},
	{ "102351", { "raid3.health <= 60", "raid3.range <= 40" }, "raid3"},
	{ "102351", { "raid4.health <= 60", "raid4.range <= 40" }, "raid4"},
	{ "102351", { "raid5.health <= 60", "raid5.range <= 40" }, "raid5"},
	{ "102351", { "raid6.health <= 60", "raid6.range <= 40" }, "raid6"},
	{ "102351", { "raid7.health <= 60", "raid7.range <= 40" }, "raid7"},
	{ "102351", { "raid8.health <= 60", "raid8.range <= 40" }, "raid8"},
	{ "102351", { "raid9.health <= 60", "raid9.range <= 40" }, "raid9"}, 
	{ "102351", { "raid10.health <= 60", "raid10.range <= 40" }, "raid10"}, 
},"talent(2,3)"},

-- Ironbark
{ "102342", { "raid1.health <= 75", "raid1.range <= 40" }, "raid1"},
{ "102342", { "raid2.health <= 75", "raid2.range <= 40" }, "raid2"},
{ "102342", { "raid3.health <= 75", "raid3.range <= 40" }, "raid3"},
{ "102342", { "raid4.health <= 75", "raid4.range <= 40" }, "raid4"},
{ "102342", { "raid5.health <= 75", "raid5.range <= 40" }, "raid5"},
{ "102342", { "raid6.health <= 75", "raid6.range <= 40" }, "raid6"},
{ "102342", { "raid7.health <= 75", "raid7.range <= 40" }, "raid7"},
{ "102342", { "raid8.health <= 75", "raid8.range <= 40" }, "raid8"},
{ "102342", { "raid9.health <= 75", "raid9.range <= 40" }, "raid9"}, 
{ "102342", { "raid10.health <= 75", "raid10.range <= 40" }, "raid10"}, 

{{ -- No Shapeshift
	{ "8921", {"!mouseover.debuff(164812)","@coreHealing.needsHealing(75,3)"}, "mouseover"}, -- Moonfire
	{ "102355", {"!mouseover.debuff(102355)","@coreHealing.needsHealing(75,3)"}, "mouseover"}, -- Moonfire
	{"!Wild Mushroom", "modifier.lalt", "mouseover.ground" },

	{{ -- Incarnation: Tree of Life
		{"Wild Growth",{"!player.moving","lowest.range <= 40", "@coreHealing.needsHealing(90, 2)"}, "lowest"},
		{ "8936", "player.health <= 70", "player" },
		{ "8936", { "raid1.range <= 40", "raid1.health <= 85" }, "raid1" },
		{ "8936", { "raid2.range <= 40", "raid2.health <= 85" }, "raid2" },
		{ "8936", { "raid3.range <= 40", "raid3.health <= 85" }, "raid3" },
		{ "8936", { "raid4.range <= 40", "raid4.health <= 85" }, "raid4" },
		{ "8936", { "raid5.range <= 40", "raid5.health <= 85" }, "raid5" },
		{ "8936", { "raid6.range <= 40", "raid6.health <= 85" }, "raid6" },
		{ "8936", { "raid7.range <= 40", "raid7.health <= 85" }, "raid7" },
		{ "8936", { "raid8.range <= 40", "raid8.health <= 85" }, "raid8" },
		{ "8936", { "raid9.range <= 40", "raid9.health <= 85" }, "raid9" },
		{ "8936", { "raid10.range <= 40", "raid10.health <= 85" }, "raid10" },
	}, "player.buff(117679)"},
	
	-- Rejuvenation
	{ "774", "!player.buff(774)", "player"},
	{ "774", {"!lowest.buff(774)", "lowest.range <= 40", "lowest.health <= 95"}, "lowest"},

	{{ -- Germination
		{ "774", { "player.buff(774)", "!player.buff(155777)", "player.health <= 90" }, "player"},
		{ "774", { "raid1.buff(774)", "!raid1.buff(155777)", "raid1.range <= 40", "raid1.health <= 90"}, "raid1"},
		{ "774", { "raid2.buff(774)", "!raid2.buff(155777)", "raid2.range <= 40", "raid2.health <= 90"}, "raid2"},
		{ "774", { "raid3.buff(774)", "!raid3.buff(155777)", "raid3.range <= 40", "raid3.health <= 90"}, "raid3"},
		{ "774", { "raid4.buff(774)", "!raid4.buff(155777)", "raid4.range <= 40", "raid4.health <= 90"}, "raid4"},
		{ "774", { "raid5.buff(774)", "!raid5.buff(155777)", "raid5.range <= 40", "raid5.health <= 90"}, "raid5"},
		{ "774", { "raid6.buff(774)", "!raid6.buff(155777)", "raid6.range <= 40", "raid6.health <= 90"}, "raid6"},
		{ "774", { "raid7.buff(774)", "!raid7.buff(155777)", "raid7.range <= 40", "raid7.health <= 90"}, "raid7"},
		{ "774", { "raid8.buff(774)", "!raid8.buff(155777)", "raid8.range <= 40", "raid8.health <= 90"}, "raid8"},
		{ "774", { "raid9.buff(774)", "!raid9.buff(155777)", "raid9.range <= 40", "raid9.health <= 90"}, "raid9"},
		{ "774", { "raid10.buff(774)", "!raid10.buff(155777)", "raid10.range <= 40", "raid10.health <= 90"}, "raid10"},
	}, "talent(7,2)"},

	
	-- Natures Swiftness with Regrowth Glyph
	{{
		{ "132158", "player.health <= 35" },
		{ "8936", "player.buff(132158)", "player"},
		{ "132158", "raid1.health <= 35", "raid1.range <= 40" },
		{ "8936", { "raid1.buff(132158)", "raid1.range <= 40"}, "raid1"},
		{ "132158", "raid2.health <= 35", "raid2.range <= 40" },
		{ "8936", { "raid2.buff(132158)", "raid2.range <= 40"}, "raid2"},
		{ "132158", "raid3.health <= 35", "raid3.range <= 40" },
		{ "8936", { "raid3.buff(132158)", "raid3.range <= 40"}, "raid3"},
		{ "132158", "raid4.health <= 35", "raid4.range <= 40" },
		{ "8936", { "raid4.buff(132158)", "raid4.range <= 40"}, "raid4"},
		{ "132158", "raid5.health <= 35", "raid5.range <= 40" },
		{ "8936", { "raid5.buff(132158)", "raid5.range <= 40"}, "raid5"},
		{ "132158", "raid6.health <= 35", "raid6.range <= 40" },
		{ "8936", { "raid6.buff(132158)", "raid6.range <= 40"}, "raid6"},
		{ "132158", "raid7.health <= 35", "raid7.range <= 40" },
		{ "8936", { "raid7.buff(132158)", "raid7.range <= 40"}, "raid7"},
		{ "132158", "raid8.health <= 35", "raid8.range <= 40" },
		{ "8936", { "raid8.buff(132158)", "raid8.range <= 40"}, "raid8"},
		{ "132158", "raid9.health <= 35", "raid9.range <= 40" },
		{ "8936", { "raid9.buff(132158)", "raid9.range <= 40"}, "raid9"},
		{ "132158", "raid10.health <= 35", "raid10.range <= 40" },
		{ "8936", { "raid10.buff(132158)", "raid10.range <= 40"}, "raid10"},
	}, {"glyph(116218)", "!player.buff(117679)"}},
	
	-- Natures Swiftness without Regrowth Glyph
	{{
		{ "132158", "player.health <= 35" },
		{ "5185", "player.buff(132158)", "player"},
		{ "132158", "raid1.health <= 35", "raid1.range <= 40" },
		{ "5185", { "player.buff(132158)", "raid1.range <= 40"}, "raid1"},
		{ "132158", "raid2.health <= 35", "raid2.range <= 40" },
		{ "5185", { "player.buff(132158)", "raid2.range <= 40"}, "raid2"},
		{ "132158", "raid3.health <= 35", "raid3.range <= 40" },
		{ "5185", { "player.buff(132158)", "raid3.range <= 40"}, "raid3"},
		{ "132158", "raid4.health <= 35", "raid4.range <= 40" },
		{ "5185", { "player.buff(132158)", "raid4.range <= 40"}, "raid4"},
		{ "132158", "raid5.health <= 35", "raid5.range <= 40" },
		{ "5185", { "player.buff(132158)", "raid5.range <= 40"}, "raid5"},
		{ "132158", "raid6.health <= 35", "raid6.range <= 40" },
		{ "5185", { "player.buff(132158)", "raid6.range <= 40"}, "raid6"},
		{ "132158", "raid7.health <= 35", "raid7.range <= 40" },
		{ "5185", { "player.buff(132158)", "raid7.range <= 40"}, "raid7"},
		{ "132158", "raid8.health <= 35", "raid8.range <= 40" },
		{ "5185", { "player.buff(132158)", "raid8.range <= 40"}, "raid8"},
		{ "132158", "raid9.health <= 35", "raid9.range <= 40" },
		{ "5185", { "player.buff(132158)", "raid9.range <= 40"}, "raid9"},
		{ "132158", "raid10.health <= 35", "raid10.range <= 40" },
		{ "5185", { "player.buff(132158)", "raid10.range <= 40"}, "raid10"},
	}, {"!glyph(116218)", "!player.buff(117679)" }},

	{{
		{"Lifebloom",{"player.spell(Lifebloom).casted < 1","!lastcast(Lifebloom)","player.buff(33763).duration <= 1"},"player"},--lifebloom "tank" 
	}, "toggle.LifebloomSelf"},
	
	{{
		{"Lifebloom",{"player.spell(Lifebloom).casted < 1","!lastcast(Lifebloom)","lowest.health <= 95","lowest.range <= 40"},"lowest"},--lifebloom "tank" 
		{"Lifebloom",{"player.spell(Lifebloom).casted < 1","!lastcast(Lifebloom)", "player.health <= 95"}, "player"},
	}, "!toggle.LifebloomSelf"},
	
	{ "8936", { "lowest.health <= 75", "lowest.range <= 40", "!player.moving" }, "lowest"},
	{ "18562", { "player.buff(774)", "player.health <= 85" }, "player"},
	{ "18562", { "lowest.range <= 40", "lowest.buff(774)", "lowest.health <= 85" }, "lowest"},
	{ "145518", { "lowest.buff(774)", "player.spell(774).casted < 3", "@coreHealing.needsHealing(90,3)", "!lastcast(145518)"},},
	
	-- Magic Mushrooms no glyph
	{ "145205", {"@coreHealing.needsHealing(75,3)", "!player.totem(145205)", "lowest.range <= 40"}, "lowest"},
	
	{{ -- anti root
		{ "Travel Form", "player.state.root" },
		{ "/cancelform", "player.buff(783)"},
	}, "player.state.root"},
}, {"!player.buff(5487)", "!player.buff(768)"}},


{{ -- Shapeshift: Cat Form
	{ "/cancelform", "modifier.lcontrol" }, -- Break Cat Form
	{ "!768", "player.state.root" }, -- Anti Root
	{ "132158", "player.health <= 75" },
	{ "8936", "player.buff(132158)", "player"},
	-- Maybe if target low auto mass entanglement?
	{ "108294", {"talent(6,1)","modifier.rcontrol"}}, -- Heart of the Wild
	{ "102355", {"talent(3,1)","!target.debuff(102355)", "target.range <= 35" },  "target"}, -- Faerie Swarm
	{ "102793", "modifier.rcontrol", "player.ground"}, -- Ursol's Vortex
	{{ -- Modifier Left Alt Wild Charge, Displacer Beast, Dash, Stampeding Roar
		-- Todo: Last cast checks
		{ "49376", {"talent(1,3)","target.range >= 8", "target.range <= 25"}, "target" }, -- Wild Charge
		{ "102280", {"talent(1,2)"}}, -- Displacer Beast
		{ "1850", {"!lastcast(49376)","!player.buff(137452)"} }, -- Dash
		{ "77764", {"!lastcast(49376)","!player.buff(1850)"}}, -- Stampeding Roar
	},"modifier.lalt"},
	{ "22568", {"player.combopoints = 5","player.energy >= 25", "target.range <= 5"}, "target"}, -- Ferocious Bite
	{ "106830", {"!target.debuff(106830)", "player.energy >= 50","target.range <= 5", "modifier.multitarget" },"target"}, -- Trash
	{ "5221", {"player.energy >= 40", "target.range <= 5"},"target"}, -- Shred
}, "player.buff(768)"}, -- Shapeshift: Cat Form end

{{ -- Shapeshift: Bear Form
	{ "/cancelform", "modifier.lcontrol" }, -- Break Bear Form
	{ "!5487", "player.state.root" }, -- Anti Root
	{ "132158", "player.health <= 80" },
	{ "8936", "player.buff(132158)", "player"},
	{ "108294", { "talent(6,1)", "modifier.rcontrol" }}, -- Heart of the Wild
	{ "102355", { "talent(3,1)", "!target.debuff(102355)", "target.range <= 35" }, "target"}, -- Faerie Swarm
	{ "33917" , "target.range <= 5", "target"}, -- Mangle
	{ "77758", "target.range <= 5", "target"}, -- Trash
	{ "22842", {"player.rage >= 20", "player.health <= 95"}, "player"},
}, "player.buff(5487)"}, -- Shapeshift: Bear Form end

--END COMBAT
},{
-- out of combat
	{ "33786", "modifier.rshift", "focus"}, -- Cyclone focus
	{ "768", "modifier.lshift", "player" },
	{ "/cancelform", "modifier.lcontrol" }, -- Break Cat Form
{{-- prowl Check
	{"!Wild Mushroom", {"modifier.ralt", "glyph(146654)"}, "mouseover.ground" },
	{ "1126", "!player.buff(1126)", "player"},
	{ "1126", "!raid1.buff(1126)", "raid1"},
	{ "774", {"!player.buff(774)", "player.health <=99"},"player"},
	{ "774", {"!lowest.buff(774)", "lowest.health <= 95"}, "lowest"},
	-- Modifiers
}, "!player.buff(5215)"}, -- prowl check end
},function()

ProbablyEngine.toggle.create('LifebloomSelf', 'Interface\\Icons\\inv_misc_herb_felblossom', 'Lifebloom on yourself','On: Lifebloom on Self Off: Lifebloom on lowest')

end)