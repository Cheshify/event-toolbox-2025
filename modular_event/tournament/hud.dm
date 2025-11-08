/datum/atom_hud/alternate_appearance/basic/tournament
	/// Show this to everyone but people who have this trait
	var/anti_team_id

/datum/atom_hud/alternate_appearance/basic/tournament/mobShouldSee(mob/M)
	return !HAS_TRAIT(M, anti_team_id)

/datum/atom_hud/alternate_appearance/basic/tournament/team_green
	anti_team_id = EVENT_ARENA_RED_TEAM

/datum/atom_hud/alternate_appearance/basic/tournament/team_red
	anti_team_id = EVENT_ARENA_GREEN_TEAM

/obj/machinery/computer/tournament_controller/proc/add_green_team_hud(mob/contestant_mob)
	var/image/green_image = image('icons/mob/huds/antag_hud.dmi', contestant_mob, "brother")
	green_image.color = COLOR_GREEN
	contestant_mob.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/tournament/team_green, "green_team_hud", green_image)
	ADD_TRAIT(contestant_mob, EVENT_ARENA_GREEN_TEAM, "arena")
	for(var/datum/atom_hud/alternate_appearance/basic/tournament/other_hud in GLOB.active_alternate_appearances)
		other_hud.check_hud(contestant_mob)

/obj/machinery/computer/tournament_controller/proc/add_red_team_hud(mob/contestant_mob)
	var/image/red_image = image('icons/mob/huds/antag_hud.dmi', contestant_mob, "brother")
	red_image.color = COLOR_RED
	contestant_mob.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/tournament/team_red, "red_team_hud", red_image)
	ADD_TRAIT(contestant_mob, EVENT_ARENA_RED_TEAM, "arena")
	for(var/datum/atom_hud/alternate_appearance/basic/tournament/other_hud in GLOB.active_alternate_appearances)
		other_hud.check_hud(contestant_mob)
