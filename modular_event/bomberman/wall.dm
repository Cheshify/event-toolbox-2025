/turf/closed/indestructible/bombermanwall
	icon = 'modular_event/bomberman/bomberman_icons.dmi'
	icon_state = "wall-0"
	opacity = FALSE

/obj/structure/barricade/bomberman
	name = "brick wall"
	desc = "Looks vunerable to explosives, but a toolbox will do."
	icon = 'modular_event/bomberman/bomberman_icons.dmi'
	icon_state = "bricks"
	max_integrity = 1
	var/obj/powerup = null

/obj/structure/barricade/bomberman/Initialize(mapload)
	. = ..()
	//Its an event so I can get away with this
	resistance_flags = NONE

/obj/structure/barricade/bomberman/atom_destruction(damage_flag)
	if(!isnull(powerup))
		new powerup(get_turf(src))
	. = ..()

/obj/structure/barricade/bomberman/powerup

/obj/structure/barricade/bomberman/powerup/Initialize(mapload)
	. = ..()
	if (!prob(13))
		return
	powerup = pick(subtypesof(/obj/effect/powerup/bomberman))

/obj/structure/barricade/bomberman/powerup/mirror
	var/mirror_distance = 2

/obj/structure/barricade/bomberman/powerup/mirror/Initialize(mapload)
	. = ..()
	var/obj/structure/barricade/bomberman/mirrored_wall = new /obj/structure/barricade/bomberman(locate(x + mirror_distance, y, z))
	if(!isnull(powerup))
		mirrored_wall.powerup = powerup 
