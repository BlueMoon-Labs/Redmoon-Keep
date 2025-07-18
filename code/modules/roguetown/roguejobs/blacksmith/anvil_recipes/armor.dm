/datum/anvil_recipe/armor
	abstract_type = /datum/anvil_recipe/armor
	appro_skill = /datum/skill/craft/blacksmithing
	skill_level = 1
	i_type = "Armor"

//For the sake of keeping the code modular with the introduction of new metals, each recipe has had it's main resource added to it's datum
//This way, we can avoid having to name things in strange ways and can simply have iron/cuirass, stee/cuirass, blacksteel/cuirass->
//-> and not messy names like ibreastplate and hplate

// --------- IRON RECIPES -----------
/datum/anvil_recipe/armor/iron
	skill_level = 3

/datum/anvil_recipe/armor/iron/chainmail
	name = "Chainmail"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/iron

/datum/anvil_recipe/armor/iron/chaincoif
	name = "Chain Coif"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/chaincoif/iron

/datum/anvil_recipe/armor/iron/gorget
	name = "Gorget"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/gorget

/datum/anvil_recipe/armor/iron/fencerguard
	name = "Fencer Neckguard (+2 silk)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/silk, /obj/item/natural/silk)
	created_item = /obj/item/clothing/neck/roguetown/fencerguard

/datum/anvil_recipe/armor/iron/ogorg
	name = "Ringed Gorget"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/gorget/oring

/datum/anvil_recipe/armor/iron/breastplate
	name = "Breastplate (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron

/datum/anvil_recipe/armor/iron/chainglove
	name = "Chain Gauntlets"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/roguetown/chain/iron

/datum/anvil_recipe/armor/iron/chainleg
	name = "Chain Chausses"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/under/roguetown/chainlegs/iron

/datum/anvil_recipe/armor/iron/ironplateboots
	name = "Plated Boots"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/hide)
	created_item = /obj/item/clothing/shoes/roguetown/boots/armor/iron

/datum/anvil_recipe/armor/iron/mask
	name = "Mask"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/facemask

/datum/anvil_recipe/armor/iron/mask/hound
	name = "Mask (Hound)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/facemask/hound

/datum/anvil_recipe/armor/iron/skullcap
	name = "Skullcap"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/skullcap

/datum/anvil_recipe/armor/iron/studded
	name = "Studded Leather Armor (+1 Leather Armor)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded

/datum/anvil_recipe/armor/iron/lbrigandine
	name = "Light Brigandine (+1 Cloth)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine/light

/datum/anvil_recipe/armor/iron/splintarms
	name = "Brigandine Rerebraces (+1 Cloth)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/wrists/roguetown/splintarms

/datum/anvil_recipe/armor/iron/splintlegs
	name = "Brigandine Chausses (+1 Cloth)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/under/roguetown/splintlegs

/datum/anvil_recipe/armor/iron/helmetgoblin
	name = "Goblin Helmet (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/roguetown/helmet/goblin

/datum/anvil_recipe/armor/iron/plategoblin
	name = "Goblin Mail (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/goblin

/datum/anvil_recipe/armor/iron/chainkini
	name = "Chainkini (+1 Cured Leather)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/chainkini
	skill_level = 6

// --------- STEEL -----------
/datum/anvil_recipe/armor/steel
	skill_level = 4

/datum/anvil_recipe/armor/steel/haubergeon
	name = "Haubergeon"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail

/datum/anvil_recipe/armor/steel/hauberk
	name = "Hauberk (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk

/datum/anvil_recipe/armor/steel/flutedhauberk
	name = "Fluted Hauberk (+1 Steel, +2 Iron)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/iron, /obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/fluted

/datum/anvil_recipe/armor/steel/corsethalfplate
	name = "Corset Half-Plate (+2 Steel, +3 Silk)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/natural/silk, /obj/item/natural/silk, /obj/item/natural/silk)
	created_item = /obj/item/clothing/suit/roguetown/armor/otavan
	
/datum/anvil_recipe/armor/steel/halfplate
	name = "Half-Plate Armour (+2 Steel, +1 Cured Hide)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate

/datum/anvil_recipe/armor/steel/fullplate
	name = "Full-Plate Armour (+3 Steel, +2 Cured Hide)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/natural/hide/cured, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full
	skill_level = 5

/datum/anvil_recipe/armor/steel/coatplates
	name = "Coat Of Plates (+1 Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates

/datum/anvil_recipe/armor/steel/brigandine
	name = "Brigandine (+1 Steel) (+2 Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/cloth, /obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine

/datum/anvil_recipe/armor/steel/chaincoif
	name = "Chain Coif"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/chaincoif

/datum/anvil_recipe/armor/steel/chainglove
	name = "Chain Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/chain

/datum/anvil_recipe/armor/steel/plateglove
	name = "Plate Gauntlets (+1 Cured Hide)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/gloves/roguetown/plate

/datum/anvil_recipe/armor/steel/chainleg
	name = "Chain Chausses"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/chainlegs

/datum/anvil_recipe/armor/steel/brayette
	name = "Brayette"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/brayette

/datum/anvil_recipe/armor/steel/platelegs
	name = "Plated Chausses (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/under/roguetown/platelegs

/datum/anvil_recipe/armor/steel/cuirass
	name = "Cuirass (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half

/datum/anvil_recipe/armor/steel/scalemail
	name = "Scalemail"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/scale

/datum/anvil_recipe/armor/steel/platebracer
	name = "Plate Bracers"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/wrists/roguetown/bracers

/datum/anvil_recipe/armor/steel/helmetnasal
	name = "Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet

/datum/anvil_recipe/armor/steel/bervor
	name = "Bevor"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/bervor

/datum/anvil_recipe/armor/steel/sgorget
	name = "Steel Gorget"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/gorget/steel

/datum/anvil_recipe/armor/steel/sogorg
	name = "Ringed Steel Gorget"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/gorget/steel/oring

/datum/anvil_recipe/armor/steel/kettle
	name = "Kettle"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/kettle

/datum/anvil_recipe/armor/steel/winged
	name = "Winged Cap"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/winged

/datum/anvil_recipe/armor/steel/horned
	name = "Horned Cap"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/horned

/datum/anvil_recipe/armor/steel/helmetsall
	name = "Sallet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet

/datum/anvil_recipe/armor/steel/helmetsallv
	name = "Sallet Visored (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet/visored

/datum/anvil_recipe/armor/steel/helmetbuc
	name = "Bucket Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/bucket

/datum/anvil_recipe/armor/steel/helmetpig
	name = "Pigface Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/pigface

/datum/anvil_recipe/armor/steel/helmetvolf
	name = "Volf Face Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/volfplate

/datum/anvil_recipe/armor/steel/bascinet
	name = "Bascinet Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet



/datum/anvil_recipe/armor/steel/helmetknight
	name = "Knight's Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/knight
	skill_level = 5

/datum/anvil_recipe/armor/steel/plateboot
	name = "Plated Boots (+1 Cured Hide)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/shoes/roguetown/armor/steel

/datum/anvil_recipe/armor/steel/fencerboots
	name = "Fencer Boots (+1 Leather Boots)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/clothing/shoes/roguetown/armor/leather)
	created_item = /obj/item/clothing/shoes/roguetown/otavan

/datum/anvil_recipe/armor/platemask/steel
	name = "Mask"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/mask/rogue/facemask/steel

/datum/anvil_recipe/armor/platemask/steel/hound
	name = "Mask (Hound)"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/mask/rogue/facemask/steel/hound

/datum/anvil_recipe/armor/steel/astratahelm
	name = "Astratan Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/astrata
	skill_level = 5

/datum/anvil_recipe/armor/steel/astratahelm_alt
	name = "Astratan Helmet Alt (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/astrata/alt
	skill_level = 5

/datum/anvil_recipe/armor/steel/malumhelm
	name = "Malummite Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/malum
	skill_level = 5

/datum/anvil_recipe/armor/steel/necrahelm
	name = "Necran Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/necra
	skill_level = 5

/datum/anvil_recipe/armor/steel/necrahelm_alt
	name = "Necran Helmet Alt (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/necra/alt
	skill_level = 5

/datum/anvil_recipe/armor/steel/nochelm
	name = "Noctian Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/noc
	skill_level = 5

/datum/anvil_recipe/armor/steel/dendorhelm
	name = "Dendorite Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/dendor
	skill_level = 5

/datum/anvil_recipe/armor/steel/ravoxian
	name = "Ravoxian Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/templar/ravox
	skill_level = 5

/datum/anvil_recipe/armor/steel/eoran
	name = "Eoran Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet/eoran
	skill_level = 5

/datum/anvil_recipe/armor/steel/belt_steel
	name = "Steel Belt"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/storage/belt/rogue/leather/steel

// --------- SILVER -----------

/datum/anvil_recipe/armor/silver/belt
	name = "Silver Belt"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/storage/belt/rogue/leather/plaquesilver

// --------- GOLD -----------

/datum/anvil_recipe/armor/gold/belt
	name = "Gold Plated Belt"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/storage/belt/rogue/leather/plaquegold

/datum/anvil_recipe/armor/gold/mask
	name = "Gold Mask"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/mask/rogue/facemask/goldmask

/datum/anvil_recipe/armor/gold/goldanklet
	name = "Exotic Gold Anklets"
	req_bar =  /obj/item/ingot/gold
	created_item = list (/obj/item/clothing/shoes/roguetown/anklets)
	skill_level = 4

/datum/anvil_recipe/armor/gold/goldcirclet
	name = "Gold Circlet"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/head/roguetown/circlet

// --------- BLACKSTEEL RECIPES-----------

/datum/anvil_recipe/armor/blacksteel/cuirass
	name = "Blacksteel Cuirass (+1 Blacksteel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/suit/roguetown/armor/blacksteel/cuirass
	skill_level = 5

/datum/anvil_recipe/armor/blacksteel/platechest
	name = "Blacksteel Plate Armor (+3 Blacksteel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/blacksteel/platechest
	skill_level = 6

/datum/anvil_recipe/armor/blacksteel/halfplatechest
	name = "Blacksteel Half Plate Armor (+2 Blacksteel, +1 Cured Hide)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/blacksteel/halfplate
	skill_level = 6

/datum/anvil_recipe/armor/blacksteel/platelegs
	name = "Blacksteel Plate Chausses (+1 Blacksteel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/under/roguetown/blacksteel/platelegs
	skill_level = 5

/datum/anvil_recipe/armor/blacksteel/bucket
	name = "Blacksteel Bucket Helmet (+1 Blacksteel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/head/roguetown/helmet/blacksteel/bucket
	skill_level = 5

/datum/anvil_recipe/armor/blacksteel/plategloves
	name = "Blacksteel Plate Gauntlets"
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/clothing/gloves/roguetown/blacksteel/plategloves
	skill_level = 5

/datum/anvil_recipe/armor/blacksteel/plateboots
	name = "Blacksteel Plate Boots"
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/clothing/shoes/roguetown/boots/blacksteel/plateboots
	skill_level = 5
