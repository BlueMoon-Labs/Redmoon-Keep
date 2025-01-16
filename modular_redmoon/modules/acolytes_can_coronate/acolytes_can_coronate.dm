/datum/outfit/job/roguetown/monk/pre_equip(mob/living/carbon/human/H)
	..()
	H.verbs += list(/mob/living/carbon/human/proc/lesser_coronate_lord)

/mob/living/carbon/human/proc/lesser_coronate_lord()
	set name = "Coronate Heir"
	set category = "Cleric"
	if(!mind)
		return

	if(!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
		to_chat(src, span_warning("I need to do this in the chapel."))
		return FALSE

	// Если в раунде была жрица, то коронация силами аколита невозможна
	if(SSjob.type_occupations[/datum/job/roguetown/priest].current_positions)
		to_chat(src, span_warning("Our church has the priest... My connection with the Ten is not strong enough for such act."))
		return FALSE

	for(var/mob/living/carbon/human/HU in get_step(src, src.dir))
		if(!HU.mind)
			continue
		if(HU.mind.assigned_role == "Baron")
			continue
		if(!HU.head)
			continue
		if(!istype(HU.head, /obj/item/clothing/head/roguetown/crown/serpcrown))
			continue
		// коронация возможна только для наследников
		if(HU.mind.assigned_role != "Heir")
			to_chat(src, span_warning("Only noble heirs can become new baron!"))
			continue

		// Если нет плохого знамения из-за отсутствия лорда или лорд жив, коронация невозможна
		if(!hasomen(OMEN_NOLORD))
			var/lord_is_dead = TRUE
			for(var/mob/living/carbon/human/potential_alive_ruler in GLOB.human_list)
				if(potential_alive_ruler.mind)
					if(potential_alive_ruler.job == "Baron")
						if(potential_alive_ruler.stat != DEAD)
							lord_is_dead = FALSE
							break
			if(!lord_is_dead)
				to_chat(src, span_warning("I can only coronate a heir if our ruller will be dead..."))
				continue

		//Abdicate previous Duke
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.mind)
				if(HL.mind.assigned_role == "Baron" || HL.mind.assigned_role == "Baron Consort")
					HL.mind.assigned_role = "Towner" //So they don't get the innate traits of the lord
			//would be better to change their title directly, but that's not possible since the title comes from the job datum
			if(HL.job == "Baron")
				HL.job = "Baron Emeritus"
			if(HL.job == "Baron Consort")
				HL.job = "Consort Dowager"
			SSjob.type_occupations[/datum/job/roguetown/ruler].remove_spells(HL)

		//Coronate new Lord (or Lady)
		HU.mind.assigned_role = "Baron"
		HU.job = "Baron"
		SSjob.type_occupations[/datum/job/roguetown/ruler].add_spells(HU)

		switch(HU.gender)
			if("male")
				SSticker.rulertype = "Baron"
			if("female")
				SSticker.rulertype = "Baroness"
		SSticker.rulermob = HU
		var/dispjob = mind.assigned_role
		removeomen(OMEN_NOLORD)
		say("By the authority of the gods, I pronounce you [SSticker.rulertype] of Rockhill!")
		priority_announce("[real_name] the [dispjob] has named [HU.real_name] the [SSticker.rulertype] of Rockhill!", title = "Long Live [HU.real_name]!", sound = 'sound/misc/bell.ogg')
		TITLE_LORD = SSticker.rulertype
