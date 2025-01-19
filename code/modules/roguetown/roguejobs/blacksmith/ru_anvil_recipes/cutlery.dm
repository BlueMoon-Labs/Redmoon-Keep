/datum/anvil_recipe/cutlery
  appro_skill = /datum/skill/craft/blacksmithing
  skill_level = 1
  i_type = "Столовые приборы"

// Tin / Pewterware
// Possibly make those take quicksilver? Would probably make a niche recipe already too complicated - SunOYH

/datum/anvil_recipe/cutlery/tin
  name = "Оловянные миски 3x"
  req_bar = /obj/item/ingot/tin
  created_item = list(/obj/item/reagent_containers/glass/bowl/pewter, /obj/item/reagent_containers/glass/bowl/pewter, /obj/item/reagent_containers/glass/bowl/pewter)
  skill_level = 1 // Pewter is v. easy to work with

/datum/anvil_recipe/cutlery/tin/plate
  name = "Оловянные блюдца 3x"
  req_bar = /obj/item/ingot/tin
  created_item = list(/obj/item/cooking/platter/pewter, /obj/item/cooking/platter/pewter, /obj/item/cooking/platter/pewter)

/datum/anvil_recipe/cutlery/tin/fork
  name = "Оловянные вилки 3x"
  req_bar = /obj/item/ingot/tin
  created_item = list(/obj/item/kitchen/ironfork/pewter, /obj/item/kitchen/ironfork/pewter, /obj/item/kitchen/ironfork/pewter)

/datum/anvil_recipe/cutlery/tin/spoon
  name = "Оловянные ложки 3x"
  req_bar = /obj/item/ingot/tin
  created_item = list(/obj/item/kitchen/ironspoon/pewter, /obj/item/kitchen/ironspoon/pewter, /obj/item/kitchen/ironspoon/pewter)

/datum/anvil_recipe/cutlery/tin/cups
  name = "Оловянная кружки 3x"
  req_bar = /obj/item/ingot/tin
  created_item = list(/obj/item/reagent_containers/glass/cup/pewter, /obj/item/reagent_containers/glass/cup/pewter, /obj/item/reagent_containers/glass/cup/pewter)

// Silverware
// No one will bother wasting silver in those, I *know*. But it's here for completness.

/datum/anvil_recipe/cutlery/silver
  name = "Серебряные миски 3x"
  req_bar = /obj/item/ingot/silver
  created_item = list(/obj/item/reagent_containers/glass/bowl/silver, /obj/item/reagent_containers/glass/bowl/silver, /obj/item/reagent_containers/glass/bowl/silver)
  skill_level = 2

/datum/anvil_recipe/cutlery/silver/plate
  name = "Серебряные блюдца 3x"
  req_bar = /obj/item/ingot/silver
  created_item = list(/obj/item/cooking/platter/silver, /obj/item/cooking/platter/silver, /obj/item/cooking/platter/silver)

/datum/anvil_recipe/cutlery/silver/fork
  name = "Серебряные вилки 3x"
  req_bar = /obj/item/ingot/silver
  created_item = list(/obj/item/kitchen/ironfork/silver, /obj/item/kitchen/ironfork/silver, /obj/item/kitchen/ironfork/silver)

/datum/anvil_recipe/cutlery/silver/spoon
  name = "Серебряные ложки 3x"
  req_bar = /obj/item/ingot/silver
  created_item = list(/obj/item/kitchen/ironspoon/silver, /obj/item/kitchen/ironspoon/silver, /obj/item/kitchen/ironspoon/silver)

/datum/anvil_recipe/cutlery/silver/cups
  name = "Серебряные кружки 3x"
  req_bar = /obj/item/ingot/silver
  created_item = list(/obj/item/reagent_containers/glass/cup/silver, /obj/item/reagent_containers/glass/cup/silver, /obj/item/reagent_containers/glass/cup/silver)

// Iron

/datum/anvil_recipe/cutlery/iron/cups
	name = "Железные кружки 3x"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/reagent_containers/glass/cup,/obj/item/reagent_containers/glass/cup,/obj/item/reagent_containers/glass/cup)

/datum/anvil_recipe/cutlery/iron/fork
	name = "Железные вилки x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/kitchen/ironfork
	skill_level = 1

/datum/anvil_recipe/cutlery/iron/spoon
	name = "Железные ложки x3"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/kitchen/ironspoon,
						/obj/item/kitchen/ironspoon,
						/obj/item/kitchen/ironspoon
					)
	skill_level = 1

/datum/anvil_recipe/cutlery/iron/bowl
	name = "Железные миски x3"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/reagent_containers/glass/bowl/iron,
						/obj/item/reagent_containers/glass/bowl/iron,
						/obj/item/reagent_containers/glass/bowl/iron
					)
	skill_level = 1

// Steel
/datum/anvil_recipe/cutlery/steel/cups
	name = "Стальные кружки 3x"
	req_bar = /obj/item/ingot/steel
	created_item = list(/obj/item/reagent_containers/glass/cup/steel, /obj/item/reagent_containers/glass/cup/steel, /obj/item/reagent_containers/glass/cup/steel)

// Gold

/datum/anvil_recipe/general/cupsgold
	name = "Золотые кружки 3x"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/reagent_containers/glass/cup/golden, /obj/item/reagent_containers/glass/cup/golden, /obj/item/reagent_containers/glass/cup/golden)