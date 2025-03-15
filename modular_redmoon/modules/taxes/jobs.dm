
/*
 * Замок (знать уже не платит налог)
 */

/datum/outfit/job/roguetown/butler/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/jester/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/steward/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/check_taxes)

/datum/outfit/job/roguetown/clerk/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/check_taxes)
	if(!HAS_TRAIT(H, TRAIT_NOBLE))
		ADD_TRAIT(H, TRAIT_TAX_FREE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/wapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/servant/pre_equip(mob/living/carbon/human/H)
	..()
	if(!HAS_TRAIT(H, TRAIT_NOBLE))
		ADD_TRAIT(H, TRAIT_TAX_FREE, TRAIT_GENERIC)

/*
 * Церковь
 */

/datum/outfit/job/roguetown/shepherd/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_CHURCH, TRAIT_GENERIC)

/datum/outfit/job/roguetown/druid/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_CHURCH, TRAIT_GENERIC)

/datum/outfit/job/roguetown/monk/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_CHURCH, TRAIT_GENERIC)

/datum/outfit/job/roguetown/undertaker/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_CHURCH, TRAIT_GENERIC)

/datum/outfit/job/roguetown/priest/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_CHURCH, TRAIT_GENERIC)

/datum/outfit/job/roguetown/puritan/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_CHURCH, TRAIT_GENERIC)

/datum/outfit/job/roguetown/templar/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_CHURCH, TRAIT_GENERIC)

/*
 * Войска
 */

/datum/outfit/job/roguetown/bogmaster/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_SERVICE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/bogguardsman/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_SERVICE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/sheriff/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_SERVICE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/citywatch/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_SERVICE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/dungeoneer/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_SERVICE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/gatemaster/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_SERVICE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/manorguard/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_SERVICE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/veteran/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_SERVICE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/squire/pre_equip(mob/living/carbon/human/H)
	..()
	if(!HAS_TRAIT(H, TRAIT_NOBLE))
		ADD_TRAIT(H, TRAIT_TAX_FREE_SERVICE, TRAIT_GENERIC)

/*
 * Город
 */

/datum/outfit/job/roguetown/mayor/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/archivist/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TAX_FREE_TEACHER, TRAIT_GENERIC)
