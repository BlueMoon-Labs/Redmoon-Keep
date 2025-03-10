/obj/item/kitchen/rollingpin
	name = "rolling pin"
	desc = ""
	icon_state = "rolling_pin"
	force = 8
	throwforce = 5
	throw_speed = 1
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "whacked")
	possible_item_intents = list(/datum/intent/mace/strike)
	associated_skill = /datum/skill/combat/maces
	sharpness = IS_BLUNT