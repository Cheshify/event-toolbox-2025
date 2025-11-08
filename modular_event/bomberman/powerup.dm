/obj/effect/powerup/bomberman
	icon = 'modular_event/bomberman/bomberman_icons.dmi'
	pickup_sound = 'sound/machines/synth/synth_yes.ogg'

/obj/effect/powerup/bomberman/trigger(mob/living/target)
	. = ..()
	if(!.)
		return
	target.balloon_alert_to_viewers(name)

/obj/effect/powerup/bomberman/speed
	name = "speed up"
	desc = "Makes you slightly faster."
	icon_state = "speedup"

/obj/effect/powerup/bomberman/speed/trigger(mob/living/target)
	. = ..()
	if(!.)
		return
	if (target.has_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/fourth))
		return
	if (target.has_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/third))
		target.remove_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/third)
		target.add_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/fourth)
		return
	if (target.has_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/second))
		target.remove_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/second)
		target.add_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/third)
		return
	if (target.has_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/first))
		target.remove_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/first)
		target.add_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/second)
		return
	target.add_movespeed_modifier(/datum/movespeed_modifier/bomberman_speed/first)//WHO ON EARTH LET ME COOK

/datum/movespeed_modifier/bomberman_speed

/datum/movespeed_modifier/bomberman_speed/first //Turning tracking how many boosts you have into a component would be better but too bad.
	multiplicative_slowdown = -0.15

/datum/movespeed_modifier/bomberman_speed/second
	multiplicative_slowdown = -0.3

/datum/movespeed_modifier/bomberman_speed/third
	multiplicative_slowdown = -0.45

/datum/movespeed_modifier/bomberman_speed/fourth
	multiplicative_slowdown = -0.6

/obj/effect/powerup/bomberman/fire
	name = "robustness up"
	desc = "Makes your toolboxes stronger."
	icon_state = "fireup"

/obj/effect/powerup/bomberman/fire/trigger(mob/living/target)
	. = ..()
	if(!.)
		return
	for(var/obj/item/storage/toolbox/toolbox in target)
		if(toolbox.force < 16)
			toolbox.force++
			toolbox.throwforce++
			toolbox.transform = toolbox.transform.Scale(1.25, 1.25)

/obj/effect/powerup/bomberman/bomb
	name = "toolbox up"
	desc = "Gives you another toolbox."
	icon_state = "toolboxup"

/obj/effect/powerup/bomberman/bomb/trigger(mob/living/target)
	. = ..()
	if(!.)
		return
	var/toolbox = new /obj/item/storage/toolbox(target.loc)
	target.put_in_hands(toolbox)
