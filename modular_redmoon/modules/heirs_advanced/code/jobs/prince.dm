/datum/outfit/job/roguetown/prince/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/royal/prince
		belt = /obj/item/storage/belt/rogue/leather
		pants = /obj/item/clothing/under/roguetown/tights/black
		shoes = /obj/item/clothing/shoes/roguetown/nobleboot/thighboots
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/royal/princess
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		pants = /obj/item/clothing/under/roguetown/tights/stockings/white
		shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
	beltl = /obj/item/storage/keyring/royal
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backr = /obj/item/storage/backpack/rogue/satchel
	shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot

/datum/subclass/prince/sheltered
	name = "Political"
	tutorial = "Your fate was already defined the moment you were born. One dae you shall inherit the throne and your father's realm. \
	But for now, you can just enjoy your highborn lyfe. You are versed in politics, music, making money and disgusting backstabbing, for better or worse."
	outfit = /datum/outfit/job/roguetown/prince/sheltered
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/prince/sheltered/pre_equip(mob/living/carbon/human/H)
	r_hand = /obj/item/storage/belt/rogue/pouch/coins/rich_mayor
	l_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("speed", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("fortune", 2)
		H.change_stat("constitution", -1)
		H.change_stat("strength", -1)
		H.change_stat("endurance", -1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
// Лучше видит цены. более удачлив в компенсацию другим, белоручка, потому легкие минуса, эксперт ножей потому что хихахаха знать ножи в спину.

/datum/subclass/prince/militant
	name = "Militant"
	tutorial = "All this aristocratic haughtiness has never been for you, your heart desired battle instead. \
	Given the opportunity, you'd lead the retinue into battle personally."
	outfit = /datum/outfit/job/roguetown/prince/militant
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/prince/militant/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	l_hand = /obj/item/rogueweapon/sword/sabre
	r_hand = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	neck = /obj/item/clothing/neck/roguetown/gorget/steel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 1)
		H.change_stat("fortune", 1)
		H.change_stat("constitution", 2)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
// Недокавалерист недорыцарь, куда более теперь способная боевая еденица, ничего сверхсильного, как по мне.

/datum/subclass/prince/bookworm
	name = "Gifted"
	tutorial = "From almost your birth you desired knowledge and had a gift for using magic. \
	Through the years you studied lots of arts and given the time you'd study a lot more."
	outfit = /datum/outfit/job/roguetown/prince/bookworm
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/prince/bookworm/pre_equip(mob/living/carbon/human/H)
	backpack_contents = list(/obj/item/book/granter/spellbook/adept = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.AddSpell(new SPELL_LEARNSPELL)
		H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
		H.mind.AddSpell(new SPELL_MESSAGE)
		H.mind.AddSpell(new SPELL_FETCH)
		H.mind.AddSpell(new SPELL_DARKVISION)
		H.change_stat("intelligence", 3)
		H.change_stat("perception", 2)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 1)
		H.change_stat("constitution", -1)
		H.change_stat("strength", -2)
		H.change_stat("endurance", -2)
		H.mind.adjust_spellpoints(3)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)
// По факту самостоятельный магонаследник, удобно живет, сделан так что бы быть +- самостоятельным. но не углубляться в призывничество, потому без мелка.

/datum/subclass/prince/inbred
	name = "Mischievous"
	tutorial = "You always were less noble, but more criminal minded than others of your kind. Pickpocketing, lockpicking, is all a funny game to you. \
	You are doomed to become a disgrace to your family, if you continue, yet, they let this slide...for now."
	outfit = /datum/outfit/job/roguetown/prince/inbred
	category_tags = list(CTAG_HEIR)
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/prince/inbred/pre_equip(mob/living/carbon/human/H)
	l_hand = /obj/item/lockpickring/mundane
	r_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.change_stat("fortune", 1)
		H.change_stat("perception", 3)
		H.change_stat("intelligence", 1)
		H.change_stat("speed", 3)
		H.change_stat("constitution", -1)
		H.change_stat("strength", -2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	//Микророга наследник для смешных дел, будущий десница, ну а что, пусть отрывается пока голова по плахе не покатилась.
