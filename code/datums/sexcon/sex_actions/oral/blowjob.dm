/datum/sex_action/blowjob
	name = "Suck them off"
	check_same_tile = FALSE
	check_incapacitated = FALSE
	gags_user = TRUE

/datum/sex_action/blowjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(HAS_TRAIT(target, TRAIT_TINY))	//Someone else can figure out how a full sized humen gives a male seelie a blowjob...
		return FALSE
	return TRUE

/datum/sex_action/blowjob/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/blowjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY)))
		if(usr?.client?.prefs?.be_russian)
			user.visible_message(span_warning("[user] притрагивается к члену [target] язычком..."))	//Changed to licking due to fairy size
		else
			user.visible_message(span_warning("[user] starts licking [target]'s cock..."))	//Changed to licking due to fairy size
	else
		if(usr?.client?.prefs?.be_russian)
			user.visible_message(span_warning("[user] обхватывает член [target] язычком..."))
		else
			user.visible_message(span_warning("[user] starts sucking [target]'s cock..."))

/datum/sex_action/blowjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY)))
			if(usr?.client?.prefs?.be_russian)
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] лижет член [target]..."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] licks [target]'s cock..."))
		else
			if(usr?.client?.prefs?.be_russian)
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] сосёт член [target]..."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] sucks [target]'s cock..."))
	user.make_sucking_noise()
	do_thrust_animate(user, target)

	user.sexcon.perform_sex_action(target, 2, 0, TRUE)
	if(!target.sexcon.considered_limp())
		user.sexcon.perform_deepthroat_oxyloss(user, 1.3)
	if(target.sexcon.check_active_ejaculation())
		if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY)))
			if(usr?.client?.prefs?.be_russian)
				target.visible_message(span_lovebold("[target] кончает на лицо и волосы [user]!"))
			else
				target.visible_message(span_lovebold("[target] cums onto [user]'s hair and face!"))
			target.sexcon.cum_onto()
		else
			if(usr?.client?.prefs?.be_russian)
				target.visible_message(span_lovebold("[target] кончает в рот [user]!"))
			else
				target.visible_message(span_lovebold("[target] cums into [user]'s mouth!"))
			target.sexcon.cum_into(oral = TRUE, target_mob = user) // REDMOON EDIT - baotha_steals_triumphs - добавлены параметры, для правильного просчёта кого корраптят 

/datum/sex_action/blowjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY)))
		if(usr?.client?.prefs?.be_russian)
			user.visible_message(span_warning("[user] убирает язык от члена [target]"))
		else
			user.visible_message(span_warning("[user] stops licking [target]'s cock ..."))
	else
		if(usr?.client?.prefs?.be_russian)
			user.visible_message(span_warning("[user], чавкнув, убирает член [target] из своего рта..."))
		else
			user.visible_message(span_warning("[user] stops sucking [target]'s cock ..."))

/datum/sex_action/blowjob/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
