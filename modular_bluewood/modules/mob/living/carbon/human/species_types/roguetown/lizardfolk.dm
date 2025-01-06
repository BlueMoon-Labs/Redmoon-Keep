/datum/species/lizardfolk/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		name = "Сиссеан"
		desc = "<b>Сиссеан</b><br>\
		Сиссеане - выносливый, рептилоидный народ, объединённый уникальной связью из-за того, что они были целью \
		угнетения и порабощения другими расами, особенно Людьми и Дракианами. Они гордятся своей \
		стойкостью и способностью к адаптации, и их можно встретить по всему миру по той или иной причине."
		expanded_desc = "Сиссеане - выносливый, рептилоидный народ, объединённый уникальной связью из-за того, что они были целью угнетения \
		и порабощения другими расами, особенно Людьми и Дракианами. Они гордятся своей стойкостью и способностью к адаптации,\
		и их можно встретить по всему миру по той или иной причине. Когда-то кочевой, племенной народ, Сиссеане часто вынуждены \
		прятаться и селиться в пустынях, болотах, топях и других обычно негостеприимных землях. Их внешность меняется в зависимости от земель, \
		к которым они приспосабливаются, позволяя иметь крокодилоподобный вид, если они из болот, или ящероподобный вид, если из пустыни. \
		<br><br> \
		Их также можно встретить в больших, шумных городах, особенно в городах рабов, где их сила, выносливость и стойкость \
		делают их особенно ценными. Сиссеане часто презирают слабость и вместо этого находят утешение в страданиях. Они, как правило, \
		очень религиозны, хотя, конечно, ни одна раса не монолитна. Фактически, некоторые Сиссеане стали успешными, некоторые даже поднялись до \
		ранга знати во многих разных королевствах, несмотря на все невзгоды, но это часто делает их мишенью для завистливых сверстников."