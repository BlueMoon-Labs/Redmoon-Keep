/*-----------------\
|   Ravox Miracles |
\-----------------*/

/datum/status_effect/buff/call_to_arms
	id = "call_to_arms"
	alert_type = /atom/movable/screen/alert/status_effect/buff/call_to_arms
	duration = 2.5 MINUTES
	effectedstats = list("strength" = 1, "endurance" = 2, "constitution" = 1)

/atom/movable/screen/alert/status_effect/buff/call_to_arms
	name = "Call to Arms"
	desc = span_bloody("THE FIGHT WILL BE BLOODY!")
	icon_state = "call_to_arms"

/*-----------------\
|  Just   Miracles |
\-----------------*/

/atom/movable/screen/alert/status_effect/buff/healing
	name = "Healing Miracle"
	desc = "Divine intervention relieves me of my ailments."
	icon_state = "buff"

#define MIRACLE_HEALING_FILTER "miracle_heal_glow"

/datum/status_effect/buff/healing
	id = "healing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/healing
	duration = 10 SECONDS
	examine_text = "SUBJECTPRONOUN is bathed in a restorative aura!"
	var/healing_on_tick = 0.1
	var/outline_colour = "#c42424"

/datum/status_effect/buff/healing/on_creation(mob/living/new_owner, new_healing_on_tick)
	healing_on_tick = new_healing_on_tick
	return ..()

/datum/status_effect/buff/healing/on_apply()
	var/filter = owner.get_filter(MIRACLE_HEALING_FILTER)
	if (!filter)
		owner.add_filter(MIRACLE_HEALING_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
	return TRUE

/datum/status_effect/buff/healing/tick()
	var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/heal_rogue(get_turf(owner))
	H.color = "#FF0000"
	var/list/wCount = owner.get_wounds()
	if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
		owner.blood_volume = min(owner.blood_volume+10, BLOOD_VOLUME_NORMAL)
	if(wCount.len > 0)
		owner.heal_wounds(healing_on_tick)
		owner.update_damage_overlays()
	owner.adjustBruteLoss(-healing_on_tick, 0)
	owner.adjustFireLoss(-healing_on_tick, 0)
	owner.adjustOxyLoss(-healing_on_tick, 0)
	owner.adjustToxLoss(-healing_on_tick, 0)
	owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healing_on_tick)
	owner.adjustCloneLoss(-healing_on_tick, 0)

	// Fix for simplemob slow after healing
	if(istype(owner, /mob/living/simple_animal))
		var/mob/living/simple_animal/S = owner
		S.updatehealth()

/datum/status_effect/buff/healing/on_remove()
	owner.remove_filter(MIRACLE_HEALING_FILTER)

/atom/movable/screen/alert/status_effect/buff/fortify
	name = "Fortifying Miracle"
	desc = "Divine intervention bolsters me and aids my recovery."
	icon_state = "buff"

/datum/status_effect/buff/fortify //Increases all healing while it lasts.
	id = "fortify"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fortify
	duration = 1 MINUTES

#define CRANKBOX_FILTER "crankboxbuff_glow"
/atom/movable/screen/alert/status_effect/buff/churnerprotection
	name = "Magick Distorted"
	desc = "The wailing box is disrupting magicks around me!"
	icon_state = "buff"

/datum/status_effect/buff/churnerprotection
	var/outline_colour = "#fad55a"
	id = "soulchurnerprotection"
	alert_type = /atom/movable/screen/alert/status_effect/buff/churnerprotection
	duration = 20 SECONDS

/datum/status_effect/buff/churnerprotection/on_apply()
	. = ..()
	var/filter = owner.get_filter(CRANKBOX_FILTER)
	if (!filter)
		owner.add_filter(CRANKBOX_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
	to_chat(owner, span_warning("I feel the wailing box distorting magicks around me!"))
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)

/datum/status_effect/buff/churnerprotection/on_remove()
	. = ..()
	to_chat(owner, span_warning("The wailing box's protection fades..."))
	owner.remove_filter(CRANKBOX_FILTER)
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)

#undef CRANKBOX_FILTER
#undef MIRACLE_HEALING_FILTER

// BARDIC BUFFS BELOW

/datum/status_effect/bardicbuff
	var/name
	id = "bardbuff"
	tick_interval = 1 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/bardbuff
	duration = 50 // Sanity, so that people outside the bard buff listening area lose the buff after a few seconds

/datum/status_effect/bardicbuff/on_apply()
	if(owner.mind?.has_antag_datum(/datum/antagonist)) // Check if antag datum present
		if(owner.mind?.isactuallygood()) // Then check if they're actually a "good" antag (purishep, prisoner)
			for(var/S in effectedstats)
				owner.change_stat(S, effectedstats[S])
			return TRUE
		else // Otherwise, no buff
			return FALSE
	else // All non antags get the buffs
		for(var/S in effectedstats)
			owner.change_stat(S, effectedstats[S])
		return TRUE

/datum/status_effect/bardicbuff/on_remove()
	if(owner.mind?.has_antag_datum(/datum/antagonist)) // Check if antag datum present
		if(owner.mind?.isactuallygood()) // Then check if they're actually a "good" antag (purishep, prisoner)
			for(var/S in effectedstats)
				owner.change_stat(S, -effectedstats[S])
			return TRUE
		else // Otherwise, no buff
			return FALSE
	else // All non antags get the buffs
		for(var/S in effectedstats)
			owner.change_stat(S, -effectedstats[S])
		return TRUE

// SKELETON BARD BUFF ALERT
/atom/movable/screen/alert/status_effect/bardbuff
	name = "Musical buff"
	desc = "My stats have been buffed by music!"
	icon_state = "intelligence"

// TIER 1 - WEAK
/datum/status_effect/bardicbuff/intelligence
	name = "Enlightening (+4 INT)"
	id = "bardbuff_int"
	effectedstats = list("intelligence" = 4)
	alert_type = /atom/movable/screen/alert/status_effect/bardbuff/intelligence

/atom/movable/screen/alert/status_effect/bardbuff/intelligence
	name = "Enlightening"

// TIER 2 - AVERAGE
/datum/status_effect/bardicbuff/endurance
	name = "Invigorating (+4 END)"
	id = "bardbuff_end"
	effectedstats = list("endurance" = 4)
	alert_type = /atom/movable/screen/alert/status_effect/bardbuff/endurance

/atom/movable/screen/alert/status_effect/bardbuff/endurance
	name = "Invigorating"

// TIER 3 - SKILLED
/datum/status_effect/bardicbuff/constitution
	name = "Fortitude (+3 CON)"
	id = "bardbuff_con"
	effectedstats = list("constitution" = 3)
	alert_type = /atom/movable/screen/alert/status_effect/bardbuff/constitution

/atom/movable/screen/alert/status_effect/bardbuff/constitution
	name = "Fortitude"

// TIER 4 - EXPERT
/datum/status_effect/bardicbuff/speed
	name = "Inspiring (+6 SPD)"
	id = "bardbuff_spd"
	effectedstats = list("speed" = 6)
	alert_type = /atom/movable/screen/alert/status_effect/bardbuff/speed

/atom/movable/screen/alert/status_effect/bardbuff/speed
	name = "Inspiring"

// TIER 5 - MASTER
/datum/status_effect/bardicbuff/ravox
	name = "Empowering (+2 STR, +2 PER)"
	id = "bardbuff_str"
	effectedstats = list("strength" = 2, "perception" = 2)
	alert_type = /atom/movable/screen/alert/status_effect/bardbuff/ravox

/atom/movable/screen/alert/status_effect/bardbuff/ravox
	name = "Empowering"

// TIER 6 - LEGENDARY
/datum/status_effect/bardicbuff/awaken
	name = "Awaken! (+energy, +stamina, +10 FOR)"
	id = "bardbuff_awaken"
	alert_type = /atom/movable/screen/alert/status_effect/bardbuff/awaken
	effectedstats = list("fortune" = 10)

/atom/movable/screen/alert/status_effect/bardbuff/awaken
	name = "Awaken!"

/datum/status_effect/bardicbuff/awaken/tick()
	for (var/mob/living/carbon/human/H in hearers(7, owner))
		if (!H.client)
			continue
		if(!H.can_hear())
			continue
		if(H.mind?.has_antag_datum(/datum/antagonist))
			if(!H.mind?.isactuallygood())
				continue
		H.energy_add(2)
		H.stamina_add(-1, internal_regen = FALSE)
