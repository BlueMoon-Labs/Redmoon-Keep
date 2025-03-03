/datum/controller/subsystem/treasury
	var/church_tith_value = 0.04
	var/list/should_pay_taxes = list()
	var/list/should_pay_tith = list()

/datum/controller/subsystem/treasury/proc/tax_assessment()
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(H in bank_accounts)
			if(!ignores_taxes(H))
				bank_accounts[H] -= tax_value * 100
			if(!ignores_tith(H))
				bank_accounts[H] -= church_tith_value * 100

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
	if(SStreasury.bank_accounts[target] >= 0)
		return TRUE
	return FALSE

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
	if(SStreasury.bank_accounts[target] >= 0)
		return TRUE
	return FALSE

/datum/controller/subsystem/treasury/proc/ignores_tith(mob/target)
	if(HAS_TRAIT(target, TRAIT_TAX_FREE_CHURCH))
		return TRAIT_TAX_FREE_CHURCH
	return FALSE
