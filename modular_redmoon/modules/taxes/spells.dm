/obj/effect/proc_holder/spell/invoked/check_taxes
	name = "Check taxes"
	desc = "Check if they have paid off their taxes"
	action_icon = 'modular_redmoon/icons/actions.dmi' 
	overlay_state = "check_taxes"
	associated_skill = /datum/skill/misc/athletics
	chargedrain = 1
	chargetime = 0 SECONDS
	releasedrain = 0 
	charge_max = 3 SECONDS

/obj/effect/proc_holder/spell/invoked/check_taxes/cast(list/targets, mob/user)
	. = ..()

	if(!ishuman(targets[1]))
		return

	var/mob/living/carbon/human/target = targets[1]

	if(target.name == "Unknown")
		to_chat(user, user.client.prefs.be_russian ? span_warning("Я не могу знать, уплачены налоги или нет, пока скрыто лицо.") : span_warning("I cannot be sure if they paid off their taxes while the face is covered."))
		return FALSE

	if(!target in SStreasury.bank_accounts)
		to_chat(user, user.client.prefs.be_russian ? span_warning("[target.gender ? "Он" : "Она"] даже не гражданин, чтобы платить налоги.") : span_warning("They are not the citizen of Rockhill to pay taxes."))
		return FALSE

	var/text = "освобождён от налогов"
	var/good_message = TRUE
	switch(SStreasury.is_tax_paid(user))
		if(TRAIT_TAX_FREE)
			text = "не облагается налогами по приказу короны"
		if(TRAIT_NOBLE)
			text = "благородных кровей и не облагается налогами"
		if(TRAIT_TAX_FREE_TEACHER)
			text = "учит сложным вещам и не облагается налогами"
		if(TRAIT_TAX_FREE_SERVICE)
			text = "служит мечом и не облагается налогами"
		if(TRAIT_TAX_FREE_CHURCH)
			text = "просвещает люд и не облагается налогами"
		if(TRUE)
			text = "уже оплатил[target.gender == FEMALE ? "а" : ""] налоги"
		else
			text = "не оплатил[target.gender == FEMALE ? "а" : ""] налоги. Нужно оплатить ещё [abs(SStreasury.debt_list[target])]."
			good_message = FALSE
	if(good_message)
		to_chat(user, span_nicegreen("[user] [text]."))
	else
		to_chat(user, span_red("[user] [text]."))

