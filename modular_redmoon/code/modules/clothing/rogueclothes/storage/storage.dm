//Knifeblade belts, act as quivers mixed with belts. Lower storage size of a belt, but holds knives without taking space.
/obj/item/storage/belt/rogue/leather/knifebelt
	name = "tossblade belt"
	desc = "A five-slotted belt meant for tossblades. Little room left over."
	icon_state = "knife"
	item_state = "knife"
	strip_delay = 20
	var/max_storage = 5			//Javelin bag is 4 and they can't hold items. So, more fair having it like this since these are pretty decent weapons.
	var/list/knives = list()
	sewrepair = TRUE
	component_type = /datum/component/storage/concrete/roguetown/belt/knife_belt

/obj/item/storage/belt/rogue/leather/knifebelt/attack_turf(turf/T, mob/living/user)
	if(knives.len >= max_storage)
		to_chat(user, span_warning("Your [src.name] is full!"))
		return
	to_chat(user, span_notice("You begin to gather the ammunition..."))
	for(var/obj/item/rogueweapon/huntingknife/throwingknife/K in T.contents)
		if(do_after(user, 5))
			if(!eatknife(K))
				break

/obj/item/storage/belt/rogue/leather/knifebelt/proc/eatknife(obj/A)
	if(A.type in subtypesof(/obj/item/rogueweapon/huntingknife/throwingknife))
		if(knives.len < max_storage)
			A.forceMove(src)
			knives += A
			update_icon()
			return TRUE
		else
			return FALSE

/obj/item/storage/belt/rogue/leather/knifebelt/attackby(obj/A, loc, params)
	if(A.type in subtypesof(/obj/item/rogueweapon/huntingknife/throwingknife))
		if(knives.len < max_storage)
			if(ismob(loc))
				var/mob/M = loc
				M.doUnEquip(A, TRUE, src, TRUE, silent = TRUE)
			else
				A.forceMove(src)
			knives += A
			update_icon()
			to_chat(usr, span_notice("I discreetly slip [A] into [src]."))
		else
			to_chat(loc, span_warning("Full!"))
		return
	..()

/obj/item/storage/belt/rogue/leather/knifebelt/attack_right(mob/user)
	if(knives.len)
		var/obj/O = knives[knives.len]
		knives -= O
		O.forceMove(user.loc)
		user.put_in_hands(O)
		update_icon()
		return TRUE

/obj/item/storage/belt/rogue/leather/knifebelt/examine(mob/user)
	. = ..()
	if(knives.len)
		. += span_notice("[knives.len] inside.")

/obj/item/storage/belt/rogue/leather/knifebelt/iron/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black
	icon_state = "blackknife"
	item_state = "blackknife"

/obj/item/storage/belt/rogue/leather/knifebelt/black/iron/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black/steel/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/steel/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black/psydon/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/psydon/K = new()
		knives += K
	update_icon()
