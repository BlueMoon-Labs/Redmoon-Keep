/obj/structure/fluff/millstone
	name = "millstone"
	desc = "A millstone used to grind grain into flour." //People have been mistaking the "It's Empty" on examine for it eating grain. This is not the case.
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "millstone"
	density = TRUE
	anchored = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 400
	var/list/obj/item/to_grind = list()

/obj/structure/fluff/millstone/Initialize()
//	create_reagents(900, DRAINABLE | AMOUNT_VISIBLE | REFILLABLE) - REDMOON REMOVAL - GRINDSTONE_FIX - у него больше нет механа для реагентов
	. = ..()

/obj/structure/fluff/millstone/Destroy()
//	chem_splash(loc, 2, list(reagents)) - REDMOON REMOVAL - GRINDSTONE_FIX - у него больше нет механа для реагентов
//	qdel(reagents) - REDMOON REMOVAL - GRINDSTONE_FIX - у него больше нет механа для реагентов
	qdel(to_grind)
	..()

/obj/structure/fluff/millstone/examine(mob/user, obj/structure/fluff/millstone/src_object)
	. = ..()
	// REDMOON ADD START - GRINDSTONE_FIX - дополняем описание
	if(to_grind.len)
		. += span_info("It has something inside!")
	else
		. += span_danger("It has nothing to grind.")
	// REDMOON ADD END

/obj/structure/fluff/millstone/proc/grindUp(list/obj/item/to_grind, mob/user)
	for(var/obj/item/itemtogrind in to_grind)
		if(do_after(user, 8, target = src))
			to_grind -= itemtogrind
			if (!isnull(itemtogrind.mill_result)) // prevent the millstone breaking if no mill_result is defined
				new itemtogrind.mill_result(src.loc)
				qdel(itemtogrind)
			else
				itemtogrind.loc = src.loc
			apply_farming_fatigue(user, 5) //replace with herbalism/alchemy version if/when it's added
			playsound(src, 'sound/items/wood_sharpen.ogg', 100, TRUE)
		else
			break


/obj/structure/fluff/millstone/attack_hand(mob/user)
	if(to_grind.len == 0)
		to_chat(user, span_warning("Nothing to grind!"))
		return TRUE
	if(do_after(user, 8, target = src))
		user.visible_message(span_notice("[user] begins to grind the millstone"), \
						span_notice("I begin to grind the millstone."))
		grindUp(to_grind, usr)
		user.visible_message(span_notice("[user] finishes grinding the millstone"), \
						span_notice("I finish grinding the millstone."))
		return TRUE
	..()

/obj/structure/fluff/millstone/attackby(obj/item/I, mob/user, params)
	var/obj/item/grindable = I
	if(istype(I, /obj/item/reagent_containers/glass))
		if(user.used_intent.type == INTENT_POUR) //Something like a glass. Player probably wants to transfer TO it.
			testing("attackobj2")
			if(!I.reagents.total_volume)
				to_chat(user, span_warning("[I] is empty!"))
				return
			if(reagents.holder_full())
				to_chat(user, span_warning("[src] is full."))
				return
			user.visible_message(span_notice("[user] pours [I] into [src]."), \
							span_notice("I pour [I] into [src]."))
			for(var/i in 1 to 10)
				if(do_after(user, 8, target = src))
					if(!I.reagents.total_volume)
						break
					if(reagents.holder_full())
						break
					if(!I.reagents.trans_to(src, 10, transfered_by = user))
						reagents.reaction(src, TOUCH, 10)
				else
					break
			return
		if(is_drainable() && (user.used_intent.type == /datum/intent/fill)) //A dispenser. Transfer FROM it TO us.
			testing("attackobj3")
			if(!reagents.total_volume)
				to_chat(user, span_warning("[src] is empty!"))
				return
			if(I.reagents.holder_full())
				to_chat(user, span_warning("[I] is full."))
				return
			user.visible_message(span_notice("[user] fills [I] with [src]."), \
								span_notice("I fill [I] with [src]."))
			for(var/i in 1 to 10)
				if(do_after(user, 8, target = src))
					if(I.reagents.holder_full())
						break
					if(!reagents.total_volume)
						break
					reagents.trans_to(I, 10, transfered_by = user)
				else
					break
			return
	if(istype(grindable))
		if(isnull(grindable.mill_result))
			to_chat(user, span_warning("I can't grind this into anything."))
			return TRUE
		else if(!user.transferItemToLoc(I,src))
			to_chat(user, span_warning("[I] is stuck to my hand!"))
			return TRUE
		to_chat(user, span_info("I place [I] into [src]."))
		to_grind += grindable
		return TRUE
	..()
