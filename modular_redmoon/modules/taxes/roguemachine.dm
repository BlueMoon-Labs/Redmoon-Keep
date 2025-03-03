/obj/structure/roguemachine
	var/taxes_check = FALSE // Аппарат проверяет, были ли уплачены налоги

/obj/structure/roguemachine/atm/proc/skip_taxes(mob/user)
	if(!(SStreasury.ignores_taxes(user, TRUE)))
		tax_process(user)
		return FALSE
	else
		var/question = alert(user, "", "Question", user.client.prefs.be_russian ? "Налоги" : "Taxes", user.client.prefs.be_russian ? "Снять маммоны" : "Withdraw mammons")
		if(question in list("Налоги", "Taxes"))
			tax_process(user)
			return FALSE
	return TRUE

/obj/structure/roguemachine/atm/proc/tax_process(mob/user)
	if(!user in SStreasury.bank_accounts)
		to_chat(user, user.client.prefs.be_russian ? span_warning("Я даже не гражданин, чтобы платить налоги.") : span_warning("I am not the citizen of Rockhill to pay taxes."))
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
			text = "уже оплатил налоги"
		else
			text = "не оплатил налоги. Нужно оплатить ещё [abs(SStreasury.bank_accounts[user])]"
			good_message = FALSE
	if(good_message)
		say(span_nicegreen("[user] [text]."))
	else
		say(span_red("[user] [text]."))
	playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
