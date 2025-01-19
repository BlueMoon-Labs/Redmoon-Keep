/datum/anvil_recipe/armor
	appro_skill = /datum/skill/craft/blacksmithing
	skill_level = 1
	i_type = "Доспехи"

//For the sake of keeping the code modular with the introduction of new metals, each recipe has had it's main resource added to it's datum
//This way, we can avoid having to name things in strange ways and can simply have iron/cuirass, stee/cuirass, blacksteel/cuirass->
//-> and not messy names like ibreastplate and hplate

// --------- IRON RECIPES -----------

/datum/anvil_recipe/armor/iron/chainmail
	name = "Кольчуга"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/iron

/datum/anvil_recipe/armor/iron/chaincoif
	name = "Койф"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/chaincoif/iron

/datum/anvil_recipe/armor/iron/gorget
	name = "Горжет"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/gorget

/datum/anvil_recipe/armor/iron/ogorg
	name = "Горжет с кольцом"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/gorget/oring

/datum/anvil_recipe/armor/iron/breastplate
	name = "Нагрудник (+1 Железо)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron

/datum/anvil_recipe/armor/iron/chainglove
	name = "Кольчужные перчатки"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/roguetown/chain/iron

/datum/anvil_recipe/armor/iron/chainleg
	name = "Кольчужные поножи"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/under/roguetown/chainlegs/iron

/datum/anvil_recipe/armor/iron/mask
	name = "Маска"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/facemask

/datum/anvil_recipe/armor/iron/mask/hound
	name = "Маска (Гончая)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/facemask/hound

/datum/anvil_recipe/armor/iron/skullcap
	name = "Шлем"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/skullcap

/datum/anvil_recipe/armor/iron/studded
	name = "Дублённая коженная броня (+1 Коженная броня) "
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded

/datum/anvil_recipe/armor/iron/lbrigandine
	name = "Лёгкая бригантина (+1 Ткань)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine/light

/datum/anvil_recipe/armor/iron/splintarms
	name = "Бригантинные наручи (+1 Ткань)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/wrists/roguetown/splintarms

/datum/anvil_recipe/armor/iron/splintlegs
	name = "Бригантинные поножи (+1 Ткань)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/under/roguetown/splintlegs

/datum/anvil_recipe/armor/iron/helmetgoblin
	name = "Гоблинский шлем (+1 Железо)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/roguetown/helmet/goblin
	skill_level = 2

/datum/anvil_recipe/armor/iron/plategoblin
	name = "Гоблинский шлем (+1 Железо)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/goblin
	skill_level = 2

/datum/anvil_recipe/armor/iron/chainkini
	name = "Броне-белье (+1 Выделенная кожа)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/chainkini
	skill_level = 6

// --------- STEEL -----------

/datum/anvil_recipe/armor/steel/haubergeon
	name = "Хаубергеон"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail

/datum/anvil_recipe/armor/steel/hauberk
	name = "Кольчуга (+1 Стальная)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	skill_level = 2

/datum/anvil_recipe/armor/steel/halfplate
	name = "Полулатный Нагрудник (+2 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate
	skill_level = 3

/datum/anvil_recipe/armor/steel/fullplate
	name = "Латный Нагрудник (+3 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full
	skill_level = 4

/datum/anvil_recipe/armor/steel/coatplates
	name = "Пластинчатый доспех (+1 Ткань)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	skill_level = 2

/datum/anvil_recipe/armor/steel/brigandine
	name = "Бригандина (+1 Сталь) (+2 Ткань)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/cloth, /obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine
	skill_level = 3

/datum/anvil_recipe/armor/steel/chaincoif
	name = "Кольчужный Койф"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/chaincoif

/datum/anvil_recipe/armor/steel/chainglove
	name = "Кольчужные Перчатки"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/chain

/datum/anvil_recipe/armor/steel/plateglove
	name = "Латные Руковицы"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/plate

/datum/anvil_recipe/armor/steel/chainleg
	name = "Кольчужные Поножи"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/chainlegs

/datum/anvil_recipe/armor/steel/brayette
	name = "Броне-трусы"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/brayette

/datum/anvil_recipe/armor/steel/platelegs
	name = "Латные поножи (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/under/roguetown/platelegs
	skill_level = 2

/datum/anvil_recipe/armor/steel/cuirass
	name = "Кираса (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half
	skill_level = 2

/datum/anvil_recipe/armor/steel/scalemail
	name = "Чешуйчатый доспех"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/scale

/datum/anvil_recipe/armor/steel/platebracer
	name = "Латные наруучи"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/wrists/roguetown/bracers

/datum/anvil_recipe/armor/steel/helmetnasal
	name = "Шлем"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet

/datum/anvil_recipe/armor/steel/bervor
	name = "Бевор"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/bervor

/datum/anvil_recipe/armor/steel/sgorget
	name = "Стальной Горжет"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/gorget/steel

/datum/anvil_recipe/armor/steel/sogorg
	name = "Стальной Горжет с кольцом"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/gorget/steel/oring

/datum/anvil_recipe/armor/steel/kettle
	name = "Капеллина"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/kettle

/datum/anvil_recipe/armor/steel/winged
	name = "Крылатый шлем"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/winged

/datum/anvil_recipe/armor/steel/horned
	name = "Рогатый шлем"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/horned

/datum/anvil_recipe/armor/steel/helmetsall
	name = "Саллед"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet

/datum/anvil_recipe/armor/steel/helmetsallv
	name = "Саллед с забралом (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet/visored
	skill_level = 2

/datum/anvil_recipe/armor/steel/helmetbuc
	name = "Топхельм (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	skill_level = 2

/datum/anvil_recipe/armor/steel/helmetpig
	name = "Бацинет с забралом (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/pigface
	skill_level = 2

/datum/anvil_recipe/armor/steel/helmetvolf
	name = "Шлем волка (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/volfplate
	skill_level = 3

/datum/anvil_recipe/armor/steel/bascinet
	name = "Бацинет"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet
	skill_level = 2



/datum/anvil_recipe/armor/steel/helmetknight
	name = "Рыцарский шлем (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/knight
	skill_level = 2

/datum/anvil_recipe/armor/steel/plateboot
	name = "Латные ботинки"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/shoes/roguetown/armor/steel

/datum/anvil_recipe/armor/platemask/steel
	name = "Маска"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/mask/rogue/facemask/steel

/datum/anvil_recipe/armor/platemask/steel/hound
	name = "Маска (Гончая)"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/mask/rogue/facemask/steel/hound

/datum/anvil_recipe/armor/steel/astratahelm
	name = "Астратанский шлем (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/astrata
	skill_level = 2

/datum/anvil_recipe/armor/steel/astratahelm_alt
	name = "Астратанский шлем (Альтернативный) (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/astrata/alt
	skill_level = 2

/datum/anvil_recipe/armor/steel/malumhelm
	name = "Малуммитский шлем (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/malum
	skill_level = 2

/datum/anvil_recipe/armor/steel/necrahelm
	name = "Нерканский шлем (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/necra
	skill_level = 2

/datum/anvil_recipe/armor/steel/necrahelm_alt
	name = "Нерканский шлем (Альтернативный) (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/necra/alt
	skill_level = 2

/datum/anvil_recipe/armor/steel/nochelm
	name = "Ноктианский шлем (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/noc
	skill_level = 2

/datum/anvil_recipe/armor/steel/dendorhelm
	name = "Дендоритский шлем (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/dendor
	skill_level = 2

/datum/anvil_recipe/armor/steel/ravoxian
	name = "Равксианский шлем (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/ravox
	skill_level = 2

/datum/anvil_recipe/armor/steel/eoran
	name = "Эоранский шлем"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet/eoran
	skill_level = 2

/datum/anvil_recipe/armor/steel/belt_steel
	name = "Стальной пояс"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/storage/belt/rogue/leather/steel

// --------- SILVER -----------

/datum/anvil_recipe/armor/silver/belt
	name = "Серебряный пояс"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/storage/belt/rogue/leather/plaquesilver

// --------- GOLD -----------

/datum/anvil_recipe/armor/gold/belt
	name = "Золотой пояс"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/storage/belt/rogue/leather/plaquegold

/datum/anvil_recipe/armor/gold/mask
	name = "Золотая Маска"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/mask/rogue/facemask/goldmask

// --------- BLACKSTEEL RECIPES-----------

/datum/anvil_recipe/armor/blacksteel/cuirass
	name = "Нагрудник из черной стали (+1 Чёрная Сталь)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/suit/roguetown/armor/blacksteel/cuirass
	skill_level = 4

/datum/anvil_recipe/armor/blacksteel/platechest
	name = "Латы из черной стали (+3 Чёрная Сталь)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/suit/roguetown/armor/blacksteel/platechest
	skill_level = 5

/datum/anvil_recipe/armor/blacksteel/platelegs
	name = "Латные поножи из черной стали (+1 Чёрная Сталь)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/under/roguetown/blacksteel/platelegs
	skill_level = 3

/datum/anvil_recipe/armor/blacksteel/bucket
	name = "Топхельм из черной стали (+1 Чёрная Сталь)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/head/roguetown/helmet/blacksteel/bucket
	skill_level = 3

/datum/anvil_recipe/armor/blacksteel/plategloves
	name = "Латные перчатки из черной стали"
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/clothing/gloves/roguetown/blacksteel/plategloves
	skill_level = 3

/datum/anvil_recipe/armor/blacksteel/plateboots
	name = "Ботинки из чёрной стали"
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/clothing/shoes/roguetown/boots/blacksteel/plateboots
	skill_level = 3
