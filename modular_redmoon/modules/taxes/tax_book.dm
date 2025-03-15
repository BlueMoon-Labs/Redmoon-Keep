/obj/item/book/rogue/taxation
	name = "taxation book"
	desc = "Men and women have died in attempts to destroy it."
	icon_state = "book_0"
	base_icon_state = "book"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_SMALL

/obj/item/book/rogue/taxation/Topic(href, href_list)
	. = ..()
	if(!usr.canUseTopic(src, BE_CLOSE))
		return
	if(href_list["paydebt"])
		var/X = locate(href_list["paydebt"])
		if(!X)
			return
		for(var/mob/living/A in SStreasury.debt_list)
			if(A == X)
				var/pay_amount = input(usr, "How much debt to pay for [X]", src) as null|num
				if(!usr.canUseTopic(src, BE_CLOSE))
					return
				if(findtext(num2text(pay_amount), "."))
					return
				if(pay_amount <= 0)
					return
				if(abs(SStreasury.debt_list[A]) < pay_amount)
					pay_amount = abs(SStreasury.debt_list[A])
				SStreasury.remove_from_debts_list(pay_amount, A, usr)
				break
	return attack_hand(usr)

/obj/item/book/rogue/taxation/read(mob/user)
	if(.)
		return
	if(!user.job in list("Duke", "Duke Consort", "Hand", "Steward", "Clerk"))
		to_chat(user, user.client.prefs.be_russian ? span_warning("Все эти цифры, слова... Эта бухгалтерия выглядит слишком сложно для меня.") : span_warning("All this numbers, words... This bookkeeping feels too hard for me."))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/keyboard_enter.ogg', 100, FALSE, -1)
	var/canread = user.can_read(src, TRUE)
	SSassets.transport.send_assets(user?.client, list("try4_border.png", "try5.png", "slop_menustyle2.css"))
	var/contents
	contents += {"
	<!DOCTYPE html>
	<html lang='en'>
	<head>
		<meta charset='UTF-8'>
		<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
		<style>
			@import url('https://fonts.googleapis.com/css2?family=Tangerine:wght@400;700&display=swap');
			@import url('https://fonts.googleapis.com/css2?family=UnifrakturMaguntia&display=swap');
			@import url('https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap');
			body {
				background-color: rgb(31, 20, 24);
				background:
					url('[SSassets.transport.get_asset_url("try4_border.png")]'),
					url('[SSassets.transport.get_asset_url("try5.png")]');
				background-repeat: no-repeat;
				background-attachment: fixed;
				background-size: 100% 100%;
			}
		</style>
		<link rel='stylesheet' type='text/css' href='[SSassets.transport.get_asset_url("slop_menustyle2.css")]'>
	</head> "}

	contents += "<center>Debts<BR>"
	contents += "--------------</center><BR>"
	for(var/mob/living/carbon/human/A in SStreasury.debt_list)
		if(ishuman(A))
			var/mob/living/carbon/human/tmp = A
			contents += "[tmp.real_name] ([tmp.advjob ? tmp.advjob : tmp.job]) - [abs(SStreasury.debt_list[A])]m<BR>"
		else
			contents += "[A.real_name] - [abs(SStreasury.debt_list[A])]m<BR>"
		contents += "<a href='byond://?src=\ref[src];paydebt=\ref[A]'>\[Pay Debt\]</a>"
	contents += {"
		</head>
	</html>
	"}
	if(!canread)
		contents = stars(contents)
	var/datum/browser/popup = new(user, "VENDORTHING", "", 500, 800)
	popup.set_content(contents)
	popup.set_window_options("can_minimize=0;can_maximize=0")
	popup.open()

/datum/supply_pack/rogue/luxury/tax_book
	name = "Taxation Book"
	cost = 100
	contains = list(/obj/item/book/rogue/taxation)
