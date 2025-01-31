/obj/item/rogueore
	name = "руда"
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ore"
	w_class = WEIGHT_CLASS_NORMAL

	grid_width = 32
	grid_height = 32

/obj/item/rogueore/gold
	name = "сырое золото"
	desc = "Куча грязных блестящих самородков!"
	icon_state = "oregold1"
	smeltresult = /obj/item/ingot/gold
	grind_results = list(/datum/reagent/gold = 15)
	sellprice = 10

/obj/item/rogueore/gold/Initialize()
	icon_state = "oregold[rand(1,3)]"
	. = ..()


/obj/item/rogueore/silver
	name = "сырое серебро"
	desc = "Сверкающая руда лунного оттенка."
	icon_state = "oresilv1"
	smeltresult = /obj/item/ingot/silver
	grind_results = list(/datum/reagent/silver = 15)
	sellprice = 8

/obj/item/rogueore/silver/Initialize()
	icon_state = "oresilv[rand(1,3)]"
	. = ..()


/obj/item/rogueore/iron
	name = "сырое железо"
	desc = "Темная руда грубой силы."
	icon_state = "oreiron1"
	smeltresult = /obj/item/ingot/iron
	grind_results = list(/datum/reagent/iron = 15)
	sellprice = 5

/obj/item/rogueore/iron/Initialize()
	icon_state = "oreiron[rand(1,3)]"
	. = ..()


/obj/item/rogueore/copper
	name = "сырая медь"
	desc = "Грубая руда с красноватыми отблесками."
	icon_state = "orecop1"
	smeltresult = /obj/item/ingot/copper
	grind_results = list(/datum/reagent/copper = 15)
	sellprice = 3

/obj/item/rogueore/copper/Initialize()
	icon_state = "orecop[rand(1,3)]"
	return ..()

/obj/item/rogueore/tin
	name = "сырое олово"
	desc = "Масса мягкой, почти пластичной белой руды."
	icon_state = "oretin1"
	smeltresult = /obj/item/ingot/tin
	sellprice = 4

/obj/item/rogueore/tin/Initialize()
	icon_state = "oretin[rand(1,3)]"
	..()

/obj/item/rogueore/coal
	name = "уголь"
	desc = "Темные комки, которые впоследствии превращаются в тлеющие угли."
	icon_state = "orecoal1"
	firefuel = 30 MINUTES
	smeltresult = /obj/item/rogueore/coal
	grind_results = list(/datum/reagent/fuel/oil = 15)
	sellprice = 1

/obj/item/rogueore/coal/Initialize()
	icon_state = "orecoal[rand(1,3)]"
	return ..()

/obj/item/rogueore/cinnabar
	name = "киноварь"
	desc = "Красные драгоценные камни, содержащие частичку зловещего."
	icon_state = "orecinnabar"
	grind_results = list(/datum/reagent/mercury = 15)
	sellprice = 5

/obj/item/ingot
	name = "слиток"
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ingot"
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null
	var/datum/anvil_recipe/currecipe

	grid_width = 64
	grid_height = 32

/obj/item/ingot/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/rogueweapon/tongs))
		var/obj/item/rogueweapon/tongs/T = I
		if(!T.hingot)
			forceMove(T)
			T.hingot = src
			T.hott = null
			T.update_icon()
			return
	..()

/obj/item/ingot/Destroy()
	if(currecipe)
		QDEL_NULL(currecipe)
	if(istype(loc, /obj/machinery/anvil))
		var/obj/machinery/anvil/A = loc
		A.hingot = null
		A.update_icon()
	return ..()

/obj/item/ingot/gold
	name = "слиток золота"
	desc = "Настоящее богатство в ваших руках."
	icon_state = "ingotgold"
	smeltresult = /obj/item/ingot/gold
	grind_results = list(/datum/reagent/gold = 15)
	sellprice = 100

/obj/item/ingot/iron
	name = "слиток железа"
	desc = "Сила ковки. Необходимая для мастеров своего дела."
	icon_state = "ingotiron"
	smeltresult = /obj/item/ingot/iron
	grind_results = list(/datum/reagent/iron = 15)
	sellprice = 25

/obj/item/ingot/copper
	name = "слиток меди"
	desc = "Этот брусок вызывает легкое покалывание при прикосновении."
	icon_state = "ingotcop"
	smeltresult = /obj/item/ingot/copper
	grind_results = list(/datum/reagent/copper = 15)
	sellprice = 25

/obj/item/ingot/tin
	name = "слиток олова"
	desc = "Слиток странного, мягкого и податливого материала"
	icon_state = "ingottin"
	smeltresult = /obj/item/ingot/tin
	sellprice = 25

/obj/item/ingot/bronze
	name = "слиток бронзы"
	desc = "Твердый и прочный сплав, который предпочитают как инженеры, так и последователи Малума."
	icon_state = "ingotbronze"
	smeltresult = /obj/item/ingot/bronze
	sellprice = 30

/obj/item/ingot/silver
	name = "слиток серебра"
	desc = "Этот слиток излучает чистоту. Сокровища царств."
	icon_state = "ingotsilv"
	smeltresult = /obj/item/ingot/silver
	grind_results = list(/datum/reagent/silver = 15)
	sellprice = 60
	
/obj/item/ingot/steel
	name = "слиток стали"
	desc = "Сталь - настоящий защитник королевств."
	icon_state = "ingotsteel"
	smeltresult = /obj/item/ingot/steel
	sellprice = 40

/obj/item/ingot/blacksteel
	name = "слиток черной стали"
	desc = "Жертвуя священными элементами серебра ради грубой силы, происхождение этого странного и мощного слитка таит в себе темные легенды..."
	icon_state = "ingotblacksteel"
	smeltresult = /obj/item/ingot/blacksteel
	sellprice = 90
