/datum/hud/proc/default_hud(ui_color = "#ffffff", ui_alpha = 255)
	src.adding = list()
	src.other = list()
	src.hotkeybuttons = list() //These can be disabled for hotkey usersx

	var/atom/movable/screen/using

	using = new /atom/movable/screen()
	using.name = "act_intent"
	using.icon = ui_style
	using.icon_state = "intent_" + mymob.a_intent
	using.screen_loc = ui_acti
	using.plane = ABOVE_HUD_PLANE
	src.adding += using
	action_intent = using

	using = new /atom/movable/screen/inventory/craft
	src.adding += using

//intent small hud objects
	var/icon/ico

	ico = new(ui_style, "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),1,ico.Height()/2,ico.Width()/2,ico.Height())
	using = new /atom/movable/screen( src )
	using.name = INTENT_HELP
	using.icon = ico
	using.screen_loc = ui_acti
	using.plane = ABOVE_HUD_PLANE
	src.adding += using
	help_intent = using

	ico = new(ui_style, "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),ico.Width()/2,ico.Height()/2,ico.Width(),ico.Height())
	using = new /atom/movable/screen( src )
	using.name = INTENT_PUSH
	using.icon = ico
	using.screen_loc = ui_acti
	using.plane = ABOVE_HUD_PLANE
	src.adding += using
	push_intent = using

	ico = new(ui_style, "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),ico.Width()/2,1,ico.Width(),ico.Height()/2)
	using = new /atom/movable/screen( src )
	using.name = INTENT_GRAB
	using.icon = ico
	using.screen_loc = ui_acti
	using.plane = ABOVE_HUD_PLANE
	src.adding += using
	grab_intent = using

	ico = new(ui_style, "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),1,1,ico.Width()/2,ico.Height()/2)
	using = new /atom/movable/screen( src )
	using.name = INTENT_HARM
	using.icon = ico
	using.screen_loc = ui_acti
	using.plane = ABOVE_HUD_PLANE
	src.adding += using
	harm_intent = using

//end intent small hud objects

	using = new /atom/movable/screen()
	using.name = "mov_intent"
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == MOVE_INTENT_RUN ? "running" : "walking")
	using.screen_loc = ui_movi
	using.plane = ABOVE_HUD_PLANE
	using.color = ui_color
	using.alpha = ui_alpha
	src.adding += using
	move_intent = using

	mymob.zone_sel = new /atom/movable/screen/zone_sel( null )
	mymob.zone_sel.icon = ui_style
	mymob.zone_sel.color = ui_color
	mymob.zone_sel.alpha = ui_alpha
	mymob.zone_sel.overlays.Cut()
	mymob.zone_sel.overlays += image('icons/mob/zone_sel.dmi', "[mymob.get_targetzone()]")

	mymob.pullin = new /atom/movable/screen/pull()
	mymob.pullin.icon = ui_style
	mymob.pullin.update_icon(mymob)
	mymob.pullin.screen_loc = ui_pull_resist
	src.hotkeybuttons += mymob.pullin

	lingchemdisplay = new /atom/movable/screen()
	lingchemdisplay.icon = 'icons/mob/screen_gen.dmi'
	lingchemdisplay.name = "chemical storage"
	lingchemdisplay.icon_state = "power_display"
	lingchemdisplay.screen_loc = ui_lingchemdisplay
	lingchemdisplay.plane = ABOVE_HUD_PLANE
	lingchemdisplay.invisibility = INVISIBILITY_ABSTRACT


	mymob.client.screen = list()

	mymob.client.screen += list(mymob.zone_sel)
	mymob.client.screen += src.adding + src.hotkeybuttons
	inventory_shown = 0
