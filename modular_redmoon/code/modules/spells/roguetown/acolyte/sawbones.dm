/datum/reagent/medicine/purify/on_mob_life(mob/living/carbon/human/M)
	. = ..()
	if(M.mind.has_antag_datum(/datum/antagonist/werewolf))
		M.mind.remove_antag_datum(/datum/antagonist/werewolf)
		to_chat(M, "You feel the werewolf curse burning intensely.")
		M.visible_message(span_danger("Из отверстий головы [M] начинает сочиться чёрный дым!"), \
		span_nicegreen("Ты больше не альфа-оборотень!"), \
		span_hear("Что-то происходит рядом с вами!"))
	if(M.mind.has_antag_datum(/datum/antagonist/werewolf/lesser))
		M.mind.remove_antag_datum(/datum/antagonist/werewolf/lesser)
		to_chat(M, "You feel the werewolf curse burning intensely.")
		M.visible_message(span_danger("Из отверстий головы [M] начинает сочиться серый дым!"), \
		span_nicegreen("Ты больше не оборотень!"), \
		span_hear("Что-то происходит рядом с вами!"))
	if(M.mind.has_antag_datum(/datum/antagonist/prebel))
		M.mind.remove_antag_datum(/datum/antagonist/prebel)
		to_chat(M, "You feel the werewolf curse burning intensely.")
		M.visible_message(span_danger("Из отверстий головы [M] начинает сочиться красный дым!"), \
		span_nicegreen("Ты больше не революционер!"), \
		span_hear("Что-то происходит рядом с вами!"))
