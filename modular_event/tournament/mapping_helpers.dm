// Buckles a mob to a bed on its turf
// No unique icon. really should not be in this repo at all but it's better then anchoring or manually setting buckled var
/obj/effect/mapping_helpers/buckle_bed
	late = TRUE

/obj/effect/mapping_helpers/buckle_bed/LateInitialize()
	. = ..()
	var/turf/home = get_turf(src)
	var/mob/living/buckle_down = locate(/mob/living) in home
	var/obj/structure/bed/home_base = locate(/obj/structure/bed) in home
	if(!buckle_down || !home_base)
		qdel(src)
		return
	home_base.buckle_mob(buckle_down)
	qdel(src)
