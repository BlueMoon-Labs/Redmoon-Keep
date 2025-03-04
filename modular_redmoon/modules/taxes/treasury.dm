/datum/controller/subsystem/treasury
//	var/church_tith_value = 0.04
	var/list/should_pay_taxes = list()
	var/list/should_pay_tith = list()
	var/list/debt_list = list()
	var/statistic_taxes_collected = 0
	var/statistic_taxes_evaded = 0

/datum/controller/subsystem/treasury/proc/tax_assessment()
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(H in bank_accounts)
			if(!ignores_taxes(H))
				debt_list[H] -= tax_value * 100
//			if(!ignores_tith(H))
//				bank_accounts[H] -= church_tith_value * 100

/datum/controller/subsystem/treasury/proc/calculate_tax_fraud()
	for(var/X in debt_list)
		statistic_taxes_evaded += debt_list[X]

/datum/controller/subsystem/treasury/proc/is_tax_paid(mob/target)
	if(HAS_TRAIT(target, TRAIT_NOBLE))
		return TRAIT_NOBLE
	if(HAS_TRAIT(target, TRAIT_TAX_FREE))
		return TRAIT_TAX_FREE
	if(HAS_TRAIT(target, TRAIT_TAX_FREE_SERVICE))
		return TRAIT_TAX_FREE_SERVICE
	if(HAS_TRAIT(target, TRAIT_TAX_FREE_CHURCH))
		return TRAIT_TAX_FREE_CHURCH
	if(HAS_TRAIT(target, TRAIT_TAX_FREE_TEACHER))
		return TRAIT_TAX_FREE_TEACHER
	if(target in SStreasury.debt_list)
		if(SStreasury.debt_list[target] >= 0)
			return TRUE
		else
			return FALSE
	else
		return TRUE

/datum/controller/subsystem/treasury/proc/ignores_taxes(mob/target)
	if(HAS_TRAIT(target, TRAIT_NOBLE))
		return TRAIT_NOBLE
	if(HAS_TRAIT(target, TRAIT_TAX_FREE))
		return TRAIT_TAX_FREE
	if(HAS_TRAIT(target, TRAIT_TAX_FREE_SERVICE))
		return TRAIT_TAX_FREE_SERVICE
	if(HAS_TRAIT(target, TRAIT_TAX_FREE_CHURCH))
		return TRAIT_TAX_FREE_CHURCH
	if(HAS_TRAIT(target, TRAIT_TAX_FREE_TEACHER))
		return TRAIT_TAX_FREE_TEACHER
	return FALSE

/datum/controller/subsystem/treasury/proc/is_tith_paid(mob/target)
	if(HAS_TRAIT(target, TRAIT_TAX_FREE_CHURCH))
		return TRAIT_TAX_FREE_CHURCH
	if(SStreasury.debt_list[target] >= 0)
		return TRUE
	return FALSE

/datum/controller/subsystem/treasury/proc/ignores_tith(mob/target)
	if(HAS_TRAIT(target, TRAIT_TAX_FREE_CHURCH))
		return TRAIT_TAX_FREE_CHURCH
	return FALSE

/datum/controller/subsystem/treasury/proc/pay_debts(amt, mob/living/carbon/human/character)
	if(!amt)
		return FALSE
	if(!character)
		return FALSE
	if(character in debt_list)
		debt_list[character] += amt
		give_money_treasury(amt, "taxed of [character]")
	else
		to_chat(character, character.client.prefs.be_russian ? span_info("У меня нет долгов.") : span_info("I don't have any debts."))
		return FALSE
	return TRUE

/datum/controller/subsystem/treasury/proc/remove_from_debts_list(amt, mob/living/carbon/human/character, mob/living/carbon/human/collector)
	if(!amt)
		return FALSE
	if(!character)
		return FALSE
	if(!collector)
		return FALSE
	if(character in debt_list)
		debt_list[character] += amt
		log_to_steward("+[amt] taxed from [character] by [collector] (has to give)")
	return TRUE

/datum/controller/subsystem/treasury/give_money_treasury(amt, source)
	statistic_taxes_collected += amt
	. = ..()

/datum/controller/subsystem/treasury/proc/try_to_give_starting_money(mob/living/carbon/human/target, var/mammons_amount)
	if(!ignores_taxes(target))
		var/obj/item/roguecoin/mammons = new /obj/item/roguecoin/copper(target.loc)
		mammons.set_quantity(mammons_amount)
		var/obj/item/has_neck = target.get_item_by_slot(SLOT_NECK)
		if(has_neck)
			SEND_SIGNAL(target.wear_neck, COMSIG_TRY_STORAGE_INSERT, mammons, target, TRUE)
		else
			if(!target.equip_to_slot_if_possible(mammons, SLOT_IN_BACKPACK))
				if(!target.equip_to_slot_if_possible(mammons, SLOT_HANDS))
					to_chat(target, span_warning("Кажется, у меня выпали маммоны!"))
		SStreasury.bank_accounts[target] = 0
