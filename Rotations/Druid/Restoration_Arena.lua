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



ProbablyEngine.rotation.register_custom(105, "|cff00FFFFDr. Green Thumb|r - |cffFF7D0AArena 2vs2 v0.1|r", {

-- Modifiers
{ "33786", { "modifier.rshift", "focus.range <= 20" }, "focus"}, -- Cyclone focus
{ "768", "modifier.lshift", "player" },
{ "88423", "party1.state.root", "party1" },

-- Misc self
{ "102342",  "player.health <= 75", "player" }, 
{ "22812", { "player.health <= 50" }, "Player" }, -- Barkskin
{ "108238", { "player.health <= 40", "talent(2,2)" }, "Player" }, -- Renewal
{ "102351",{ "player.health <= 40","talent(2,3)" }, "player" }, -- Cenarion Ward
{ "#5512", "player.health <= 30" }, -- Healthstone

-- Misc Mate
{ "102351", { "party1.health <= 60", "talent(2,3)", "party1.range <= 60" }, "party1"}, -- Cenarion Ward
{ "102342", { "party1.health <= 75", "party1.range <= 40"}, "party1"}, -- Ironbark

-- Stun
{ "5211", { "target.health <= 10", "target.range <= 5" }, "target" },

{{ -- No Shapeshift
	{{ -- Incarnation: Tree of Life
			--{"Wild Growth",{"!player.moving","lowest.range <= 40", "@coreHealing.needsHealing(90, 2)"}, "lowest"},
			--{"Wild Growth",{"!player.moving","tank.range <= 40", "@coreHealing.needsHealing(90, 2)"}, "tank"},
			--{"Wild Growth",{"!player.moving","focus.range <= 40", "@coreHealing.needsHealing(90, 2)"}, "focus"},
		{ "8936", "player.health <= 70", "player" },
		{ "8936", { "party1.range <= 40", "party1.health <= 90" }, "party1" },
	}, "player.buff(117679)"},
	{{ -- Anti Hex and Polymorph
		{ "5487", "arena1.casting(Hex)", "player" }, -- Bear Form if Hex
		{ "5487", "arena2.casting(Hex)", "player" }, -- Bear Form if Hex
		{ "5487", "arena1.casting(Polymorph)", "player" }, -- Bear Form if Hex
		{ "5487", "arena2.casting(Polymorph)", "player" }, -- Bear Form if Hex
	}, {"!player.buff(117679)", "toggle.AntiPolymorph"}},
	
	{ "132158", "player.health <= 25" },
	{ "8936", "player.buff(132158)", "player"},
	
	{ "132158", "party1.health <= 25" },
	{ "8936", "party1.buff(132158)", "party1"},
	{{
	{"Lifebloom",{"player.spell(Lifebloom).casted < 1","!lastcast(Lifebloom)","player.buff(33763).duration <= 1"},"player"},--lifebloom "tank" 
	}, "toggle.LifebloomSelf"},
	{{
	{"Lifebloom",{"player.spell(Lifebloom).casted < 1","!lastcast(Lifebloom)","party1.buff(33763).duration <= 1"},"party1"},--lifebloom "tank" 
	}, "!toggle.LifebloomSelf"},
	
	{ "18562", { "player.buff(774)", "player.health <= 85" }, "player"},
	{ "18562", { "party1.range <= 40", "party1.buff(774)", "party1.health <= 85" }, "party1"},
	{ "145518", { "player.buff(774)", "party1.buff(774)","@coreHealing.needsHealing(90,2)"},},
	
	{ "8936", { "player.health <= 75", "!player.moving" }, "player"},
	{ "8936", { "party.health <= 75", "party1.range <= 40", "!player.moving" }, "party1"},
	
	-- Magic Mushrooms
	{ "145205", {"@coreHealing.needsHealing(80,2)", "party1.range <= 10", "!player.totem(145205)"}, "lowest"},
	
	-- Rejuvenation & Germination
	{ "774", "!player.buff(774)", "player"},
	{ "774", {"!party1.buff(774)", "party1.range <= 40"}, "party1"},
	{ "774", {"player.buff(774)", "!player.buff(155777)", "talent(7,2)"}, "player"},
	{ "774", {"party1.buff(774)", "!party1.buff(155777)", "party1.range <= 40", "talent(7,2)" }, "party1"},
	{{ -- anti root
		{ "Travel Form", "player.state.root" },
		{ "/cancelform", "player.buff(Travel Form)"},
	}, "player.state.root"},
	{ "8921", "!mouseover.debuff(164812)", "mouseover"}, -- Moonfire
	{ "102355", "!arena1.debuff(102355)", "arena1"},
	{ "102355", "!arena2.debuff(102355)", "arena2"},
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
		{ "49376", {"talent(1,3)","target.range > 8"}, "target" }, -- Wild Charge
		{ "102280", {"talent(1,2)"}}, -- Displacer Beast
		{ "1850", {"!lastcast(49376)","!player.buff(137452)"} }, -- Dash
		{ "77764", {"!lastcast(49376)","!player.buff(1850)"}}, -- Stampeding Roar
	},"modifier.lalt"},
	{ "22568", {"player.combopoints = 5","player.energy >= 25", "target.range <= 5"}, "target"}, -- Ferocious Bite
	{ "106830", {"!target.debuff(106830)", "player.energy >= 50","target.range <= 5", "modifier.multitarget" },"target"}, -- Trash
	{ "5221", {"player.energy >= 40", "target.range <= 5"},"target"}, -- Shred
	{ "102355", "!arena1.debuff(102355)", "arena1"},
	{ "102355", "!arena2.debuff(102355)", "arena2"},
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
	{ "102355", "!arena1.debuff(102355)", "arena1"},
	{ "102355", "!arena2.debuff(102355)", "arena2"},
}, "player.buff(5487)"}, -- Shapeshift: Bear Form end

--END COMBAT
},{
-- out of combat
	{ "33786", "modifier.rshift", "focus"}, -- Cyclone focus	
{{-- prowl Check
	{ "1126", "!player.buff(1126)", "player"},
	{ "1126", "!party1.buff(1126)", "party1"},
	{ "774", "!player.buff(774)", "player"},

	-- Modifiers
}, "!player.buff(5215)"}, -- prowl check end
},function()

ProbablyEngine.toggle.create('LifebloomSelf', 'Interface\\Icons\\inv_misc_herb_felblossom', 'Lifebloom on yourself','On: Lifebloom on Self Off: Lifebloom on Mate')
ProbablyEngine.toggle.create('AntiPolymorph', 'Interface\\Icons\\spell_nature_polymorph', 'Toggle Anti Polymorph','Sometimes bugged')

end)