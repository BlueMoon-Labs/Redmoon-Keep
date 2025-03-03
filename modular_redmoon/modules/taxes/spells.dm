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
	switch(SStreasury.is_tax_paid(user))
		if(TRAIT_TAX_FREE)
			text = span_nicegreen("не облагается налогами по приказу короны")
		if(TRAIT_NOBLE)
			text = span_nicegreen("благородных кровей и не облагается налогами")
		if(TRAIT_TAX_FREE_TEACHER)
			text = span_nicegreen("учит сложным вещам и не облагается налогами")
		if(TRAIT_TAX_FREE_SERVICE)
			text = span_nicegreen("служит мечом и не облагается налогами")
		if(TRAIT_TAX_FREE_CHURCH)
			text = span_nicegreen("просвещает люд и не облагается налогами")
		if(TRUE)
			text = span_yellowteamradio("уже оплатил налоги")
		else
			text = span_red("не оплатил налог. Нужно оплатить ещё [abs(SStreasury.bank_accounts[target])].")
	to_chat(user, "[user] [text].")
