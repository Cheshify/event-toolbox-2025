GLOBAL_LIST_EMPTY(arena_eye_list)

/obj/effect/landmark/arena_eye
	var/arena_id = ""

/obj/effect/landmark/arena_eye/Initialize(mapload)
	. = ..()
	GLOB.arena_eye_list += src

/obj/item/binoculars


/obj/item/binoculars/Initialize(mapload)
	. = ..()
	qdel(GetComponent(/datum/component/scope)) // Remove default scope component

/obj/item/binoculars/examine(mob/user)
	. = ..()
	. += span_notice("Always see the best view of the nearest arena on your level.")

/obj/item/binoculars/on_wield(obj/item/source, mob/user)
	if(!user.client)
		return

	var/eye_dist = INFINITY
	var/obj/effect/landmark/arena_eye/selected_arena
	for(var/obj/effect/landmark/arena_eye/an_arena as anything in GLOB.arena_eye_list)
		if(an_arena.z == user.z && get_dist(user, an_arena) < eye_dist)
			selected_arena = an_arena
			eye_dist = get_dist(user, an_arena)
	if(!selected_arena)
		to_chat(user, span_notice("You look through the binoculars but you don't see any badass toolbox duels nearby."))
		return

	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_walk))
	user.visible_message(span_notice("[user] holds [src] up to [user.p_their()] eyes."), span_notice("You hold [src] up to your eyes."))
	user.reset_perspective(selected_arena)
	update_appearance()
	update_slot_icon()

/obj/item/binoculars/on_unwield(obj/item/source, mob/user)
	if(!user.client || user.client.eye == user)
		return
	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
	user.visible_message(span_notice("[user] lowers [src]."), span_notice("You lower [src]."))
	user.reset_perspective()
	update_appearance()
	update_slot_icon()

/obj/item/binoculars/update_icon_state()
	. = ..()
	inhand_icon_state = "binoculars[HAS_TRAIT(src, TRAIT_WIELDED) ? "_wielded" : ""]"

/obj/item/binoculars/proc/on_walk(mob/living/source)
	SIGNAL_HANDLER

	attack_self(source) // makes them lower the binocs
