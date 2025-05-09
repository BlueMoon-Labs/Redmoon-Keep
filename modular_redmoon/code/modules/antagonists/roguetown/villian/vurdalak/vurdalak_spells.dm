/obj/effect/proc_holder/spell/self/claws_vurdalak
	name = "Extend Claws"
	desc = "!"
	overlay_state = "claws"
	antimagic_allowed = TRUE
	charge_max = 20 // 2 seconds
	var/extended = FALSE

/obj/effect/proc_holder/spell/self/claws_vurdalak/cast(mob/user = usr)
	..()
	var/obj/item/rogueweapon/vurdalak_claw/left/l
	var/obj/item/rogueweapon/vurdalak_claw/right/r
	l = user.get_active_held_item()
	r = user.get_inactive_held_item()

	if (extended)
		if (istype(user.get_active_held_item(), /obj/item/rogueweapon/vurdalak_claw))
			user.dropItemToGround(l, TRUE)
			user.dropItemToGround(r, TRUE)
			qdel(l)
			qdel(r)
			// user.visible_message("Your claws retract.", "You feel your claws retracting.", "You hear a sound of claws retracting.")
			extended = FALSE
	else
		var/obj
		for(var/i = 0, i<2, i++)
			switch(i)
				if(0)
					obj = user.get_active_held_item()
				if(1)
					obj = user.get_inactive_held_item()
			user.dropItemToGround(obj, TRUE)
		var/datum/antagonist/vurdalak/vurdalak_antag_datum = user.mind.has_antag_datum(/datum/antagonist/vurdalak)

		l = new(user, 1)
		r = new(user, 2)
		user.put_in_hands(l, TRUE, FALSE, TRUE)
		user.put_in_hands(r, TRUE, FALSE, TRUE)
		l.armor_penetration = vurdalak_antag_datum.claws_armor_penetration
		r.armor_penetration = vurdalak_antag_datum.claws_armor_penetration
		// user.visible_message("Your claws extend.", "You feel your claws extending.", "You hear a sound of claws extending.")
		extended = TRUE

/obj/effect/proc_holder/spell/self/vurdalak_targets_search
	name = "Seek for Prey"
	desc = "!"
	overlay_state = "transfix"
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS

/obj/effect/proc_holder/spell/self/vurdalak_targets_search/cast(mob/user = usr)
	..()
	if(GLOB.tod != "night")
		to_chat(user, user.client.prefs.be_russian ? span_warning("Ночь ещё не пришла... Мне нужно ждать, чтобы почувствовать добычу.") : span_warning("The night has not come... I need wait to look for the prey."))
		revert_cast()
		return
	var/area/user_area = get_area(user)
	if(!user_area.outdoors)
		to_chat(user, user.client.prefs.be_russian ? span_warning("Для этого, мне сначала нужно видеть луну.") : span_warning("I need to be under the sky to see the moon for it."))
		revert_cast()
		return
	var/mob/target = null
	var/last_best_distance = 1000
	for(var/mob/living/carbon/human/potential_victim in GLOB.human_list - user)
		if(!is_valid_hunting_area(get_area(potential_victim)))
			continue
		if(potential_victim.stat)
			continue
		if(potential_victim.m_intent == MOVE_INTENT_SNEAK)
			continue
		if(!potential_victim.mind)
			continue
		if("undead" in potential_victim.faction)
			continue
		if(HAS_TRAIT(potential_victim, HUGBOX_TRAIT))
			continue
		var/distance_to_potential_victim = get_dist_euclidian(user, potential_victim)
		if(distance_to_potential_victim < last_best_distance)
			last_best_distance = distance_to_potential_victim
			target = potential_victim

	if(!target)
		to_chat(user, user.client.prefs.be_russian ? span_warning("Нет живых на болоте... Кто-то может прятаться в подземелье, зданиях или красться.") : span_warning("There are no living beings in the wilderness... Some may hide in the underground, in huts or sneak around."))
		revert_cast()
		return

	var/arrowpart
	switch(get_dir(user, target))
		if(NORTH)
			arrowpart = " ⇑"
		if(SOUTH)
			arrowpart = " ⇓"
		if(EAST)
			arrowpart = " ⇒"
		if(WEST)
			arrowpart = " ⇐"
		if(NORTHWEST)
			arrowpart = " ⇖"
		if(NORTHEAST)
			arrowpart = " ⇗"
		if(SOUTHWEST)
			arrowpart = " ⇙"
		if(SOUTHEAST)
			arrowpart = " ⇘"

	to_chat(user, user.client.prefs.be_russian ? span_cult("Чувствую... Бьется сердце в [FLOOR(last_best_distance*1.5, 1)] шагах от меня. ([arrowpart])") : span_cult("I feel it... A heart is beating [FLOOR(last_best_distance*1.5, 1)] steps away. ([arrowpart])"))
	playsound(user.loc, 'sound/vo/mobs/wwolf/sniff.ogg', 60, 1)

// Spells
/obj/effect/proc_holder/spell/targeted/vurdalak_rejuv
	name = "Undead Regeneration"
	desc = "Regenerates my targeted limb and replenishes half my stamina. Recharges every 60 seconds. I must stand still."
	overlay_state = "unrot"
	action_icon = 'icons/mob/actions/roguespells.dmi'
	releasedrain = 0
	chargedrain = 0
	chargetime = 0
	range = -1
	warnie = "sydwarning"
	movement_interrupt = TRUE
	chargedloop = null
	invocation_type = "whisper"
	associated_skill = /datum/skill/magic/druidic
	antimagic_allowed = FALSE
	charge_max = 3.5 MINUTES
	cooldown_min = 3.5 MINUTES
	include_user = TRUE
	max_targets = 1

/obj/effect/proc_holder/spell/targeted/vurdalak_rejuv/cast(list/targets, mob/user = usr)
//	if(GLOB.tod != "night")
//		to_chat(user, user.client.prefs.be_russian ? span_warning("Ночь ещё не пришла... Мне нужно ждать, чтобы регенерировать.") : span_warning("The night has not come... I need wait to regenerate myself."))
//		revert_cast()
//		return FALSE

	if(user && ishuman(user))
		var/mob/living/carbon/human/vurdalak = user
		var/datum/antagonist/vurdalak/vurdalak_antag_datum = user.mind.has_antag_datum(/datum/antagonist/vurdalak)

		var/silver_curse_status = FALSE // Fail to cast condition.
		for(var/datum/status_effect/debuff/silver_curse/silver_curse in vurdalak.status_effects)
			silver_curse_status = TRUE
			break
		if(silver_curse_status)
			to_chat(vurdalak, user.client.prefs.be_russian ? span_danger("Моё ПРОКЛЯТИЕ не даёт мне восстановиться!") : span_danger("My BANE is not letting me rejuvenate!"))
			revert_cast()
			return FALSE

		if(vurdalak_antag_datum)
			to_chat(user, user.client.prefs.be_russian ? span_cult("Я чувствую, как моё тело быстро восстанавливается... Ровно как и моя шкура. Чем больше я загублю, тем сильнее стану.")  : span_cult("I feel how my body regenerates quickly... As well as my hide. More I will feed myself, more I will restore."))
			vurdalak.reagents.add_reagent(/datum/reagent/medicine/greaterhealthpot, length(vurdalak_antag_datum.unique_victims))
			vurdalak.heal_wounds(vurdalak_antag_datum.unique_victims.len * 20)
			vurdalak.blood_volume += BLOOD_VOLUME_SURVIVE
			vurdalak.update_damage_overlays()
			vurdalak.playsound_local(get_turf(vurdalak), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)

			if(vurdalak.skin_armor)
				qdel(vurdalak.skin_armor)
			vurdalak.skin_armor = new /obj/item/clothing/suit/roguetown/armor/skin_armor/vurdalak_skin(vurdalak)
			vurdalak.skin_armor.max_integrity = vurdalak_antag_datum.hide_strength
			vurdalak.skin_armor.obj_integrity = vurdalak_antag_datum.hide_strength

// Spells
/obj/effect/proc_holder/spell/targeted/vurdalak_feast
	name = "Feast"
	desc = ""
	overlay_state = "tamebeast"
	action_icon = 'icons/mob/actions/roguespells.dmi'
	releasedrain = 0
	chargedrain = 0
	chargetime = 30
	range = 1
	warnie = "sydwarning"
	movement_interrupt = TRUE
	chargedloop = null
	invocation_type = "whisper"
	associated_skill = /datum/skill/magic/druidic
	antimagic_allowed = TRUE
	charge_max = 15 SECONDS
	cooldown_min = 15 SECONDS
	include_user = FALSE
	max_targets = 1

/obj/effect/proc_holder/spell/targeted/vurdalak_feast/cast(list/targets, mob/user = usr)
	if(iscarbon(targets[1]))
		var/mob/living/carbon/target = targets[1]
		if(ishuman(user))
			var/mob/living/carbon/human/vurdalak = user
			var/datum/antagonist/vurdalak/vurdalak_antag_datum = user.mind.has_antag_datum(/datum/antagonist/vurdalak)
			if(target.vitae_bank <= 500)
				to_chat(vurdalak, user.client.prefs.be_russian ? span_warning("Это тело уже лишилось своей жизненной силы...") : span_warning("This body has already lost its lifeforce..."))
				revert_cast()
				return
			if(!target.mind)
				to_chat(vurdalak, user.client.prefs.be_russian ? span_warning("Я не чувствую достаточно жизненной силы в этом теле... Это бесполезно.") : span_warning("I don't feel enought lifeforce in this body... It will be useless."))
				revert_cast()
				return

			while(target.vitae_bank > 500)
				var/obj/item = vurdalak.get_active_held_item()
				if(!item || !(item.type in typesof(/obj/item/rogueweapon/vurdalak_claw)))
					to_chat(vurdalak, user.client.prefs.be_russian ? span_warning("Мне нужно выпустить когти, чтобы приступить к трапезе.") : span_warning("I need to extend my claws to feast on them."))
					revert_cast()
					break
				if(!do_after(user, 1.4 SECONDS, target = target))
					break
				if(prob(10))
					user.emote("rage")
				if(!target.stat)
					target.emote("painscream")
				vurdalak.ClickOn(target, list())
				if(prob(10))
					var/obj/O = new /obj/effect/decal/cleanable/blood/gibs (get_turf(target))
					var/turf/target_turf = get_step(target, pick(alldirs))
					O.forceMove(target_turf)
				target.vitae_bank -= 500
			if(target.vitae_bank <= 500)
				vurdalak.visible_message(span_dead("[vurdalak] finishes with [target]..."), vurdalak.client.prefs.be_russian ? span_dead("Я закончил поглощать плоть... Жизненной силы достаточно.") : span_dead("I have consumed their flesh... The lifeforce is enough."))
				if(!(target.real_name in vurdalak_antag_datum.unique_victims))
					vurdalak_antag_datum.unique_victims += target.real_name
					vurdalak_antag_datum.handle_power_up()
			else
				return FALSE
			return TRUE
