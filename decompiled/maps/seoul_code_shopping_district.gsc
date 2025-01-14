// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

shopping_district_main()
{
    init_flags_shopping_district();
    precacheitem( "smoke_grenade_cheap" );
    precacheitem( "iw5_microdronelaunchersmartgrenade_sp" );
    precacheturret( "apache_turret" );
    precacheshader( "ugv_vignette_overlay" );
    precachemodel( "prop_cigarette" );
    precachemodel( "electronics_pda" );
    precachemodel( "lab_tablet_flat_on" );
    precachemodel( "com_cellphone_on" );
    thread sinkhole_section();
    thread subway_section();
    thread sd_street_combat();
    thread sd_smoke_laser_ambush();
    thread sd_flee_drone_swarm();
    thread canal_setup_pt1();
    thread canal_cormack_objective_convo();
    thread canal_fight_to_explosives_sequence();
    thread canal_handle_bomb_pickup();
    thread canal_fight_to_weapon_platform();
    thread canal_handle_bomb_plant_start();
    thread canal_finale_will_prep();
    thread canal_finale_sequence();
    vehicle_scripts\_attack_drone_controllable::controllable_drone_swarm_init();
    maps\_microdronelauncher::init();
    thread panel_on();
    maps\_utility::add_hint_string( "throw_threat_hint", &"SEOUL_THROW_THREAT_HINT", ::should_break_threat_hint );
    maps\_utility::add_control_based_hint_strings( "binoc_controls", &"SEOUL_BINOC_CONTROLS_HINT", ::binoc_hint_breakout, &"SEOUL_BINOC_CONTROLS_HINT_PC", &"SEOUL_BINOC_CONTROLS_HINT_SP" );
    rumble_notetracks();
    var_0 = getentarray( "seo_canal_waterfall_model", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 setcontents( 0 );
}

rumble_notetracks()
{
    var_0 = [ 0.2, 0.1, "wp_hatch_close" ];
    maps\_anim::addnotetrack_customfunction( "weapon_platform", "seo_finale_wp_hatch_close", ::seo_finale_rumble_heavy, "finale_plantbomb", var_0 );
    var_0 = [ 2.25, 1.5, "first_attempt_to_free" ];
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_first_attempt_to_free", ::seo_finale_rumble_light, "finale_pt02", var_0 );
    var_0 = [ 2.25, 1.75, "second_attempt_to_free" ];
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_second_attempt", ::seo_finale_rumble_light, "finale_pt02", var_0 );
    var_0 = [ 0.1, 0.5, "grabs player" ];
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_grabs_player", ::seo_finale_rumble_light, "finale_pt02" );
    var_0 = [ 0.1, 0.5, "will_pushes_player" ];
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_pushes_player", ::seo_finale_rumble_heavy, "finale_pt02", var_0 );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_jump_onto_platform", ::seo_finale_rumble_light, "finale_plantbomb" );
    var_0 = [ 0.1, 0.5, "player_grab_hatch" ];
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_grab_hatch", ::seo_finale_rumble_light, "finale_pt02", var_0 );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_lands", ::seo_finale_rumble_heavy, "finale_pt02", 0.5 );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_bounces", ::seo_finale_rumble_heavy, "finale_pt03", 1 );
    var_0 = [ 0.3, 1, "player_arm_slice" ];
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_arm_slice", ::seo_finale_rumble_heavy, "finale_pt03", var_0 );
    var_0 = [ 5, 2, "_dragged_away" ];
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_dragged_away", ::seo_finale_rumble_light, "finale_pt03", var_0 );
    var_0 = [ 1, 1.5, "_dragged_away" ];
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_finale_cormack_grab_metal", ::seo_finale_rumble_heavy, "finale_pt03" );
    var_0 = [ 4, 22, "wp_lift_off" ];
    maps\_anim::addnotetrack_customfunction( "weapon_platform", "seo_finale_wp_lift_off", ::seo_finale_rumble_heavy, "finale_pt02", var_0 );
}

init_flags_shopping_district()
{
    common_scripts\utility::flag_init( "start_sinkhole_objectives" );
    common_scripts\utility::flag_init( "objective_sd_followed_cormack_through_sinkhole" );
    common_scripts\utility::flag_init( "objective_sd_smoke_ambush_defeated" );
    common_scripts\utility::flag_init( "objective_sd_followed_cormack_through_subway" );
    common_scripts\utility::flag_init( "objective_sd_gate_opened" );
    common_scripts\utility::flag_init( "objective_start_shopping_district" );
    common_scripts\utility::flag_init( "objective_sd_street_combat_complete" );
    common_scripts\utility::flag_init( "objective_canal_stairs_bottom_reached" );
    common_scripts\utility::flag_init( "objective_canal_stairs_top_reached" );
    common_scripts\utility::flag_init( "objective_sd_cormack_convo_complete" );
    common_scripts\utility::flag_init( "objective_sd_reached_bombsquad" );
    common_scripts\utility::flag_init( "objective_sd_pick_up_bombs" );
    common_scripts\utility::flag_init( "objective_sd_bomb_planted" );
    common_scripts\utility::flag_init( "end_rumble_listener" );
    common_scripts\utility::flag_init( "first_building_jump_complete" );
    common_scripts\utility::flag_init( "wakeup_drones" );
    common_scripts\utility::flag_init( "wakeup_ambush" );
    common_scripts\utility::flag_init( "swarm_flyby1_ready" );
    common_scripts\utility::flag_init( "subway_gate_triggered" );
    common_scripts\utility::flag_init( "swarm_flyby1_go" );
    common_scripts\utility::flag_init( "canal_strategy_scene_complete" );
    common_scripts\utility::flag_init( "sd_street_combat_complete" );
    common_scripts\utility::flag_init( "shut_down_panel" );
    common_scripts\utility::flag_init( "canal_jump_complete" );
    common_scripts\utility::flag_init( "bombs_reached" );
    common_scripts\utility::flag_init( "bombs_picked_up" );
    common_scripts\utility::flag_init( "drone_control_done" );
    common_scripts\utility::flag_init( "bomb_plant_start" );
    common_scripts\utility::flag_init( "threat_grenade_thrown" );
    common_scripts\utility::flag_init( "wakeup_patrol" );
    common_scripts\utility::flag_init( "sd_combat_start" );
    common_scripts\utility::flag_init( "canal_reached_window" );
    common_scripts\utility::flag_init( "wakeup_drone_guards" );
    common_scripts\utility::flag_init( "wakeup_canal_patrols" );
    common_scripts\utility::flag_init( "begin_fight_to_weapon_platform" );
    common_scripts\utility::flag_init( "start_truck_fall" );
    common_scripts\utility::flag_init( "demo_team_seen" );
    common_scripts\utility::flag_init( "drone_swarm_launched" );
    common_scripts\utility::flag_init( "canal_start_drone_travel" );
    common_scripts\utility::flag_init( "spawn_canal_razorback" );
    common_scripts\utility::flag_init( "canal_razorback_attacked" );
    common_scripts\utility::flag_init( "start_weapon_platform_firing" );
    common_scripts\utility::flag_init( "prep_will_for_finale" );
    common_scripts\utility::flag_init( "weapon_platform_firing" );
    common_scripts\utility::flag_init( "show_canal_weapon_platform" );
    common_scripts\utility::flag_init( "canal_razorback_fire_at_swarm" );
    common_scripts\utility::flag_init( "cleanup_finale_explosive" );
    common_scripts\utility::flag_init( "canal_swarm_attacking_player" );
    common_scripts\utility::flag_init( "middle_weapon_guards_dead" );
    common_scripts\utility::flag_init( "_stealth_spotted" );
    common_scripts\utility::flag_init( "drones_investigating" );
    common_scripts\utility::flag_init( "player_starting_sinkhole" );
}

debug_seoul_sinkhole_start()
{
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    soundscripts\_snd::snd_message( "start_seoul_sinkhole_start" );
    debug_check_allies_spawned();
    var_0 = common_scripts\utility::getstruct( "struct_start_point_sinkhole_start", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_start_point_sinkhole_start_1", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player maps\_player_high_jump::enable_high_jump();
    level.player _meth_83C0( "seoul_building_jump" );
    level.player _meth_8490( "seoul", 0 );
    maps\_utility::vision_set_fog_changes( "seoul_building_jump", 0 );
    common_scripts\utility::flag_set( "set_seoul_jump_lighting" );
    level.will_irons _meth_81C6( var_1[0].origin, var_1[0].angles );
    level.cormack _meth_81C6( var_1[1].origin, var_1[1].angles );
    level.jackson _meth_81C6( var_1[2].origin, var_1[2].angles );
    var_2 = getnode( "cover_sinkhole_window", "targetname" );
    var_3 = getnode( "cover_sinkhole_jumpdown1", "targetname" );
    var_4 = getnode( "cover_sinkhole_jumpdown2", "targetname" );
    level.will_irons maps\_utility::set_goal_radius( 15 );
    level.will_irons maps\_utility::set_goal_node( var_2 );
    level.cormack maps\_utility::set_goal_radius( 15 );
    level.cormack maps\_utility::set_goal_node( var_3 );
    level.jackson maps\_utility::set_goal_radius( 15 );
    level.jackson maps\_utility::set_goal_node( var_4 );
    var_5 = getent( "trig_start_sinkhole_section", "targetname" );
    common_scripts\utility::flag_set( "first_building_jump_complete" );
    common_scripts\utility::flag_set( "objective_start" );
    common_scripts\utility::flag_set( "start_sinkhole_objectives" );
    common_scripts\utility::flag_set( "objective_sd_street_combat_complete" );
    var_5 notify( "trigger" );
}

debug_seoul_subway_start()
{
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    soundscripts\_snd::snd_message( "start_seoul_subway_start" );
    thread maps\seoul_lighting::lighting_fx_lens_subway_interior();
    var_0 = getent( "so_player_start_subway1", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player maps\_player_high_jump::enable_high_jump();
    debug_check_allies_spawned();
    var_1 = common_scripts\utility::getstruct( "struct_will_start_subway1", "targetname" );
    level.will_irons _meth_81C6( var_1.origin, var_1.angles );
    var_2 = common_scripts\utility::getstruct( "node_cormack_start_subway1", "targetname" );
    level.cormack _meth_81C6( var_2.origin, var_2.angles );
    var_3 = common_scripts\utility::getstruct( "struct_other_guy_start_subway1", "targetname" );
    level.jackson _meth_81C6( var_3.origin, var_3.angles );
    common_scripts\utility::flag_set( "objective_start" );
    common_scripts\utility::flag_set( "start_sinkhole_objectives" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_sinkhole" );
    common_scripts\utility::flag_set( "objective_sd_smoke_ambush_defeated" );
    common_scripts\utility::flag_set( "set_seoul_subway_start_lighting" );
    var_4 = getent( "trig_start_subway_section", "targetname" );
    var_4 notify( "trigger" );
}

debug_seoul_shopping_district_start()
{
    if ( level.currentgen )
        level waittill( "transients_subway_to_shopping_dist" );

    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    soundscripts\_snd::snd_message( "start_seoul_shopping_district_start" );
    level.player _meth_83C0( "seoul_subway" );
    level.player _meth_8490( "clut_seoul_shopping", 0 );
    maps\_utility::vision_set_fog_changes( "seoul_shopping", 0 );
    common_scripts\utility::flag_set( "set_seoul_shopping_district_start_lighting" );
    var_0 = getent( "so_player_start_shopping_district1", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player maps\_player_high_jump::enable_high_jump();
    debug_check_allies_spawned();
    var_1 = common_scripts\utility::getstruct( "struct_will_start_shopping_district1", "targetname" );
    level.will_irons _meth_81C6( var_1.origin, var_1.angles );
    var_2 = common_scripts\utility::getstruct( "struct_cormack_start_shopping_district1", "targetname" );
    level.cormack _meth_81C6( var_2.origin, var_2.angles );
    var_3 = common_scripts\utility::getstruct( "struct_other_guy_start_shopping_district1", "targetname" );
    level.jackson _meth_81C6( var_3.origin, var_3.angles );
    wait 1;
    common_scripts\utility::flag_set( "objective_start" );
    common_scripts\utility::flag_set( "start_sinkhole_objectives" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_sinkhole" );
    common_scripts\utility::flag_set( "objective_sd_smoke_ambush_defeated" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_subway" );
    common_scripts\utility::flag_set( "objective_sd_gate_opened" );
    common_scripts\utility::flag_set( "objective_start_shopping_district" );
}

debug_seoul_shopping_district_flee_swarm()
{
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    soundscripts\_snd::snd_message( "start_seoul_shopping_district_flee_swarm" );
    common_scripts\utility::flag_set( "set_seoul_shopping_district_start_lighting" );
    thread maps\_utility::flag_set_delayed( "sd_start_shopping_district", 5 );
    var_0 = getent( "so_player_start_flee_swarm1", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player maps\_player_high_jump::enable_high_jump();
    debug_check_allies_spawned();
    var_1 = common_scripts\utility::getstruct( "struct_will_start_flee_swarm1", "targetname" );
    level.will_irons _meth_81C6( var_1.origin, var_1.angles );
    var_2 = common_scripts\utility::getstruct( "struct_cormack_start_flee_swarm1", "targetname" );
    level.cormack _meth_81C6( var_2.origin, var_2.angles );
    var_3 = common_scripts\utility::getstruct( "struct_other_guy_start_flee_swarm1", "targetname" );
    level.jackson _meth_81C6( var_3.origin, var_3.angles );
    wait 1;
    common_scripts\utility::flag_set( "objective_start" );
    common_scripts\utility::flag_set( "start_sinkhole_objectives" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_sinkhole" );
    common_scripts\utility::flag_set( "objective_sd_smoke_ambush_defeated" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_subway" );
    common_scripts\utility::flag_set( "objective_sd_gate_opened" );
    common_scripts\utility::flag_set( "objective_start_shopping_district" );
    common_scripts\utility::flag_set( "objective_sd_mid" );
    common_scripts\utility::flag_set( "objective_sd_intersection2" );
    common_scripts\utility::flag_set( "objective_sd_stairs" );
    common_scripts\utility::flag_set( "objective_sd_street_combat_complete" );
    thread canal_weapon_platform_firing_loop();
    common_scripts\utility::flag_set( "start_weapon_platform_firing" );
}

debug_seoul_canal_start()
{
    soundscripts\_snd::snd_message( "start_seoul_canal_intro" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    level.player maps\_player_high_jump::enable_high_jump();
    level.player _meth_83C0( "seoul_canal" );
    level.player _meth_8490( "clut_seoul_canal", 0 );
    maps\_utility::vision_set_fog_changes( "seoul_canal_entrance", 0 );
    common_scripts\utility::flag_set( "set_seoul_canal_start_lighting" );
    var_0 = getent( "node_player_start_shopping_district2", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player maps\_player_high_jump::enable_high_jump();
    debug_check_allies_spawned();
    var_1 = common_scripts\utility::getstruct( "struct_will_start_shopping_district2", "targetname" );
    level.will_irons _meth_81C6( var_1.origin, var_1.angles );
    var_2 = getnode( "canal_cover_left_door1", "targetname" );
    level.will_irons maps\_utility::set_goal_node( var_2 );
    var_3 = common_scripts\utility::getstruct( "struct_cormack_start_shopping_district2", "targetname" );
    level.cormack _meth_81C6( var_3.origin, var_3.angles );
    var_4 = getnode( "canal_cover_right_door1", "targetname" );
    level.cormack maps\_utility::set_goal_node( var_4 );
    var_5 = common_scripts\utility::getstruct( "struct_other_guy_start_shopping_district2", "targetname" );
    level.jackson _meth_81C6( var_5.origin, var_5.angles );
    var_6 = getnode( "canal_cover_crouch_door1", "targetname" );
    level.jackson maps\_utility::set_goal_node( var_6 );
    common_scripts\utility::flag_set( "sd_street_combat_complete" );
    common_scripts\utility::flag_set( "sd_escaped_swarm" );
    common_scripts\utility::flag_set( "show_canal_weapon_platform" );
    common_scripts\utility::flag_set( "objective_start" );
    common_scripts\utility::flag_set( "start_sinkhole_objectives" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_sinkhole" );
    common_scripts\utility::flag_set( "objective_sd_smoke_ambush_defeated" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_subway" );
    common_scripts\utility::flag_set( "objective_sd_gate_opened" );
    common_scripts\utility::flag_set( "objective_start_shopping_district" );
    common_scripts\utility::flag_set( "objective_sd_mid" );
    common_scripts\utility::flag_set( "objective_sd_intersection2" );
    common_scripts\utility::flag_set( "objective_sd_stairs" );
    common_scripts\utility::flag_set( "objective_sd_street_combat_complete" );
    common_scripts\utility::flag_set( "objective_canal_stairs_bottom_reached" );
    common_scripts\utility::flag_set( "objective_canal_stairs_top_reached" );
    common_scripts\utility::flag_set( "objective_sd_cormack_convo_complete" );
    var_7 = getent( "canal_trig_allies_cover1", "targetname" );
    var_7 notify( "trigger" );

    if ( level.nextgen )
        level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "sd_drone_queen1", undefined );
    else
        level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "sd_drone_queen1", undefined, 8, 5, undefined );

    level.snake_cloud thread canal_drone_swarm_think();
    thread canal_weapon_platform_firing_loop();
    common_scripts\utility::flag_set( "start_weapon_platform_firing" );
}

debug_seoul_canal_begin_combat()
{
    soundscripts\_snd::snd_message( "start_seoul_canal_combat_start" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    level.player _meth_83C0( "seoul_canal" );
    level.player _meth_8490( "clut_seoul_canal", 0 );
    maps\_utility::vision_set_fog_changes( "seoul_canal_entrance", 0 );
    common_scripts\utility::flag_set( "set_seoul_canal_start_lighting" );
    var_0 = getent( "node_player_start_shopping_district2", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player maps\_player_high_jump::enable_high_jump();
    debug_check_allies_spawned();
    var_1 = common_scripts\utility::getstruct( "struct_will_start_shopping_district2", "targetname" );
    level.will_irons _meth_81C6( var_1.origin, var_1.angles );
    var_2 = common_scripts\utility::getstruct( "struct_cormack_start_shopping_district2", "targetname" );
    level.cormack _meth_81C6( var_2.origin, var_2.angles );
    var_3 = common_scripts\utility::getstruct( "struct_other_guy_start_shopping_district2", "targetname" );
    level.jackson _meth_81C6( var_3.origin, var_3.angles );
    common_scripts\utility::flag_set( "sd_street_combat_complete" );
    common_scripts\utility::flag_set( "canal_strategy_scene_complete" );
    common_scripts\utility::flag_set( "enable_drone_control_pickup" );
    common_scripts\utility::flag_set( "shut_down_panel" );
    common_scripts\utility::flag_set( "show_canal_weapon_platform" );
    common_scripts\utility::flag_set( "objective_start" );
    common_scripts\utility::flag_set( "start_sinkhole_objectives" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_sinkhole" );
    common_scripts\utility::flag_set( "objective_sd_smoke_ambush_defeated" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_subway" );
    common_scripts\utility::flag_set( "objective_sd_gate_opened" );
    common_scripts\utility::flag_set( "objective_start_shopping_district" );
    common_scripts\utility::flag_set( "objective_sd_mid" );
    common_scripts\utility::flag_set( "objective_sd_intersection2" );
    common_scripts\utility::flag_set( "objective_sd_stairs" );
    common_scripts\utility::flag_set( "objective_sd_street_combat_complete" );
    common_scripts\utility::flag_set( "objective_canal_stairs_bottom_reached" );
    common_scripts\utility::flag_set( "objective_canal_stairs_top_reached" );
    common_scripts\utility::flag_set( "objective_sd_cormack_convo_complete" );
    common_scripts\utility::flag_set( "demo_team_seen" );
    level.player maps\_shg_utility::setup_player_for_scene();
    maps\_player_exo::player_exo_deactivate();

    if ( level.nextgen )
        level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "sd_drone_queen1", undefined );
    else
        level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "sd_drone_queen1", undefined, 8, 6, undefined );

    level.snake_cloud thread canal_drone_swarm_think();
    thread canal_weapon_platform_firing_loop();
    common_scripts\utility::flag_set( "start_weapon_platform_firing" );
    level.will_irons.ignoreall = 0;
    level.cormack.ignoreall = 0;
    level.jackson.ignoreall = 0;
}

debug_seoul_canal_fight_to_weapon_platform()
{
    soundscripts\_snd::snd_message( "start_seoul_canal_combat_start" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    level.player _meth_83C0( "seoul_canal" );
    level.player _meth_8490( "clut_seoul_canal", 0 );
    maps\_utility::vision_set_fog_changes( "seoul_canal_entrance", 0 );
    common_scripts\utility::flag_set( "set_seoul_canal_start_lighting" );
    var_0 = getent( "node_player_start_canal_part2", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player maps\_player_high_jump::enable_high_jump();
    debug_check_allies_spawned();
    var_1 = common_scripts\utility::getstruct( "struct_will_start_canal_part2", "targetname" );
    level.will_irons _meth_81C6( var_1.origin, var_1.angles );
    var_2 = common_scripts\utility::getstruct( "struct_cormack_start_shopping_district2", "targetname" );
    level.cormack _meth_81C6( var_2.origin, var_2.angles );
    var_3 = common_scripts\utility::getstruct( "struct_other_guy_start_shopping_district2", "targetname" );
    level.jackson _meth_81C6( var_3.origin, var_3.angles );
    thread canal_weapon_guards_spawn_and_think();
    thread canal_weapon_platform_firing_loop();
    common_scripts\utility::flag_set( "canal_strategy_scene_complete" );
    common_scripts\utility::flag_set( "enable_drone_control_pickup" );
    common_scripts\utility::flag_set( "bombs_picked_up" );
    common_scripts\utility::flag_set( "show_canal_weapon_platform" );
    common_scripts\utility::flag_set( "objective_start" );
    common_scripts\utility::flag_set( "start_sinkhole_objectives" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_sinkhole" );
    common_scripts\utility::flag_set( "objective_sd_smoke_ambush_defeated" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_subway" );
    common_scripts\utility::flag_set( "objective_sd_gate_opened" );
    common_scripts\utility::flag_set( "objective_start_shopping_district" );
    common_scripts\utility::flag_set( "objective_sd_mid" );
    common_scripts\utility::flag_set( "objective_sd_intersection2" );
    common_scripts\utility::flag_set( "objective_sd_stairs" );
    common_scripts\utility::flag_set( "objective_sd_street_combat_complete" );
    common_scripts\utility::flag_set( "objective_canal_stairs_bottom_reached" );
    common_scripts\utility::flag_set( "objective_canal_stairs_top_reached" );
    common_scripts\utility::flag_set( "objective_sd_cormack_convo_complete" );
    common_scripts\utility::flag_set( "demo_team_seen" );
    common_scripts\utility::flag_set( "objective_sd_pick_up_bombs" );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    maps\_player_exo::player_exo_deactivate();

    if ( level.nextgen )
        level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "sd_drone_queen1", undefined );
    else
        level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "sd_drone_queen1", undefined, 8, 6, undefined );

    level.snake_cloud thread canal_drone_swarm_think();
    common_scripts\utility::flag_set( "start_weapon_platform_firing" );
}

debug_seoul_finale_scene_start()
{
    soundscripts\_snd::snd_message( "start_seoul_finale_scene_start" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    thread maps\seoul_lighting::canal_wmp_key_tweaks();
    level.player _meth_83C0( "seoul_canal" );
    level.player _meth_8490( "clut_seoul_canal", 0 );
    maps\_utility::vision_set_fog_changes( "seoul_canal_entrance", 0 );
    common_scripts\utility::flag_set( "set_seoul_canal_start_lighting" );
    var_0 = common_scripts\utility::getstruct( "struct_start_finale_player", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player maps\_player_high_jump::enable_high_jump();
    debug_check_allies_spawned();
    var_1 = common_scripts\utility::getstruct( "struct_start_finale_will", "targetname" );
    level.will_irons _meth_81C6( var_1.origin, var_1.angles );
    var_2 = common_scripts\utility::getstruct( "struct_start_canal2_cormack", "targetname" );
    level.cormack _meth_81C6( var_2.origin, var_2.angles );
    var_3 = common_scripts\utility::getstruct( "struct_start_canal2_jackson", "targetname" );
    level.jackson _meth_81C6( var_3.origin, var_3.angles );
    common_scripts\utility::flag_set( "objective_sd_bomb_planted" );
    common_scripts\utility::flag_set( "prep_will_for_finale" );
    common_scripts\utility::flag_set( "show_canal_weapon_platform" );
    var_4 = getent( "trig_canal_near_platform", "targetname" );
    var_4 notify( "trigger" );
    level.weapon_platform_rigged = getent( "canal_weapon_platform", "targetname" );
    level.weapon_platform_rigged.animname = "weapon_platform";
    level.weapon_platform_rigged maps\_anim::setanimtree();
}

debug_check_allies_spawned()
{
    if ( !isdefined( level.will_irons ) )
    {
        var_0 = getent( "hero_will_irons_spawner", "targetname" );
        level.will_irons = var_0 maps\_shg_design_tools::actual_spawn();
    }

    level.will_irons notify( "stop_going_to_node" );
    level.will_irons.target = undefined;
    level.will_irons.a.disablepain = 1;
    level.will_irons.canjumppath = 1;

    if ( !isdefined( level.will_irons.magic_bullet_shield ) || !level.will_irons.magic_bullet_shield )
        level.will_irons thread maps\_utility::deletable_magic_bullet_shield();

    level.will_irons maps\_utility::set_force_color( "o" );
    level.will_irons.animname = "will_irons";

    if ( !isdefined( level.cormack ) )
    {
        var_1 = getent( "hero_cormack_spawner", "targetname" );
        wait 0.05;
        level.cormack = var_1 maps\_shg_design_tools::actual_spawn();
    }

    level.cormack notify( "stop_going_to_node" );
    level.cormack.target = undefined;
    level.cormack.a.disablepain = 1;

    if ( !isdefined( level.cormack.magic_bullet_shield ) || !level.cormack.magic_bullet_shield )
        level.cormack thread maps\_utility::deletable_magic_bullet_shield();

    level.cormack maps\_utility::set_force_color( "r" );
    level.cormack.animname = "cormack";
    level.cormack.canjumppath = 1;

    if ( !isdefined( level.jackson ) )
    {
        var_0 = getent( "hero_guy_spawner", "targetname" );
        level.jackson = var_0 maps\_shg_design_tools::actual_spawn();
    }

    level.jackson notify( "stop_going_to_node" );
    level.jackson.target = undefined;
    level.jackson.a.disablepain = 1;

    if ( !isdefined( level.jackson.magic_bullet_shield ) || !level.jackson.magic_bullet_shield )
        level.jackson thread maps\_utility::deletable_magic_bullet_shield();

    level.jackson maps\_utility::set_force_color( "y" );
    level.jackson _meth_8177( "allies" );
    level.jackson.animname = "jackson";
    level.jackson.canjumppath = 1;
}

shopping_district_objectives()
{
    common_scripts\utility::flag_wait( "start_sinkhole_objectives" );
    objective_add( maps\_utility::obj( "objective_demo_team" ), "current", &"SEOUL_OBJECTIVE_DEMO_TEAM" );
    objective_onentity( maps\_utility::obj( "objective_demo_team" ), level.cormack );
    common_scripts\utility::flag_wait( "objective_sd_followed_cormack_through_sinkhole" );
    var_0 = getent( "objective_sd_origin_cormack", "targetname" );
    var_1 = getent( "objective_sinkhole_ambush", "targetname" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_1.origin );
    common_scripts\utility::flag_wait( "objective_sd_smoke_ambush_defeated" );
    objective_onentity( maps\_utility::obj( "objective_demo_team" ), level.cormack );
    common_scripts\utility::flag_wait( "objective_sd_followed_cormack_through_subway" );
    var_2 = getent( "subway_open_gate", "targetname" );
    objective_setpointertextoverride( maps\_utility::obj( "objective_demo_team" ), &"SEOUL_OBJECTIVE_GATE_INT" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_2.origin );
    common_scripts\utility::flag_wait( "objective_sd_gate_opened" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "objective_demo_team" ), "" );
    common_scripts\utility::flag_wait( "objective_start_shopping_district" );
    var_3 = getent( "objective_sd_origin_intersection1", "targetname" );
    var_4 = getent( "objective_sd_origin_mid", "targetname" );
    var_5 = getent( "objective_sd_origin_intersection2", "targetname" );
    var_6 = getent( "objective_sd_origin_stairs", "targetname" );
    var_0 = getent( "objective_sd_origin_cormack", "targetname" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_3.origin );
    common_scripts\utility::flag_wait( "objective_sd_mid" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_4.origin );
    common_scripts\utility::flag_wait( "objective_sd_intersection2" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_5.origin );
    common_scripts\utility::flag_wait( "objective_sd_stairs" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_6.origin );
    common_scripts\utility::flag_wait( "objective_sd_street_combat_complete" );
    var_7 = getent( "objective_sd_origin_cormack", "targetname" );
    var_8 = getent( "objective_sd_origin_stairs_bottom", "targetname" );
    var_9 = getent( "objective_sd_origin_stairs_top", "targetname" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_8.origin );
    common_scripts\utility::flag_wait( "objective_canal_stairs_bottom_reached" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_9.origin );
    common_scripts\utility::flag_wait( "objective_canal_stairs_top_reached" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), var_7.origin );
    common_scripts\utility::flag_wait( "objective_sd_cormack_convo_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "objective_demo_team" ) );
    common_scripts\utility::flag_wait( "demo_team_seen" );
    var_10 = getent( "objective_sd_origin_bombs", "targetname" );
    objective_add( maps\_utility::obj( "objective_bombs" ), "current", &"SEOUL_OBJECTIVE_EXPLOSIVES" );
    objective_position( maps\_utility::obj( "objective_bombs" ), var_10.origin );
    objective_setpointertextoverride( maps\_utility::obj( "objective_bombs" ), " " );
    common_scripts\utility::flag_wait( "bombs_reached" );
    objective_setpointertextoverride( maps\_utility::obj( "objective_bombs" ), &"SEOUL_OBJECTIVE_EXPLOSIVES_INT" );
    common_scripts\utility::flag_wait( "objective_sd_pick_up_bombs" );
    maps\_utility::objective_complete( maps\_utility::obj( "objective_bombs" ) );
    var_11 = getent( "objective_sd_origin_bomb", "targetname" );
    var_12 = getent( "objective_sd_origin_bomb_a", "targetname" );
    _func_0D3( "objectiveAlphaEnabled", 1 );
    objective_add( maps\_utility::obj( "objective_follow_will" ), "current", &"SEOUL_OBJECTIVE_HELP_WILL" );
    objective_onentity( maps\_utility::obj( "objective_follow_will" ), level.will_irons );
    common_scripts\utility::flag_wait( "canal_bomb_plant_trigger_on" );
    common_scripts\utility::flag_wait( "weapon_platform_reached" );
    maps\_utility::objective_complete( maps\_utility::obj( "objective_follow_will" ) );
    _func_0D3( "objectiveAlphaEnabled", 0 );
    objective_add( maps\_utility::obj( "objective_plant_explosives" ), "current", &"SEOUL_OBJECTIVE_USE_EXPLOSIVES" );
    objective_position( maps\_utility::obj( "objective_plant_explosives" ), var_11.origin );
    common_scripts\utility::flag_wait( "objective_sd_bomb_planted" );
    maps\_utility::objective_complete( maps\_utility::obj( "objective_plant_explosives" ) );
}

sinkhole_section()
{
    thread maps\seoul_code_gangnam::handle_wep_drone_dropoff();
    thread sinkhole_drone_intro();
    thread maps\seoul_code_gangnam::handle_sinkhole_enemy_setup();
    thread handle_sinkhole_video_log();
    thread sinkhole_subway_vo_think();
    thread sinkhole_weapons_platform_scene();
    thread sinkhole_smoke_ambush_event();
    thread sinkhole_weapon_platform();
    thread sinkhole_jets();
    thread sign_explosion_flash_damage();
    common_scripts\utility::flag_wait( "first_building_jump_complete" );
    common_scripts\utility::flag_set( "start_sinkhole_objectives" );

    if ( !isdefined( level.cormack.script_forcecolor ) )
        level.cormack maps\_utility::set_force_color( "r" );

    if ( !isdefined( level.will_irons.script_forcecolor ) )
        level.will_irons maps\_utility::set_force_color( "o" );

    if ( !isdefined( level.jackson.script_forcecolor ) )
        level.jackson maps\_utility::set_force_color( "y" );

    level.will_irons.canjumppath = 1;
    level.cormack.canjumppath = 1;
    level.jackson.canjumppath = 1;
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sinkhole_ai_move_to_jump1" );
    var_0 = common_scripts\utility::getstructarray( "struct_start_point_sinkhole_start_1", "targetname" );
    warp_allies_forward_sinkhole();
    level.will_irons.ignoreall = 1;
    level.jackson.ignoreall = 1;
    level.cormack.ignoreall = 1;
    var_1 = getnode( "cover_sinkhole_window", "targetname" );
    var_2 = getnode( "cover_sinkhole_jumpdown1", "targetname" );
    var_3 = getnode( "cover_sinkhole_jumpdown2", "targetname" );
    level.will_irons maps\_utility::set_goal_radius( 15 );
    level.will_irons maps\_utility::set_goal_node( var_1 );
    level.cormack maps\_utility::set_goal_radius( 15 );
    level.cormack maps\_utility::set_goal_node( var_2 );
    level.jackson maps\_utility::set_goal_radius( 15 );
    level.jackson maps\_utility::set_goal_node( var_3 );
    maps\_shg_design_tools::waittill_trigger_with_name( "sinkhole_trig_allies_jump1" );
    common_scripts\utility::flag_set( "vo_sinkhole_view" );
    maps\_utility::autosave_by_name();
}

sinkhole_weapons_platform_scene()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sinkhole_launcher_vo" );
    common_scripts\utility::flag_set( "vo_will_wep_nineoclock" );
    level.cormack _meth_81A3( 1 );
    level.player.show_land_assist_help = 0;
    common_scripts\utility::flag_wait( "vo_havoc_launcher_done" );
    wait 1;
    maps\_utility::activate_trigger_with_targetname( "sinkhole_trig_allies_jump1" );
    level.player.show_land_assist_help = 1;
    wait 10;
    level.cormack _meth_81A3( 0 );
}

handle_sinkhole_video_log()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sinkhole_1st_drop" );
    common_scripts\utility::flag_set( "video_log_playing" );
    common_scripts\utility::flag_wait( "vo_havoc_launcher_done" );
    wait 1;
    common_scripts\utility::flag_set( "dialogue_performing_arts_entrance_2" );
    maps\seoul_code_gangnam::prep_cinematic( "seoul_videolog" );
    maps\seoul_code_gangnam::play_seoul_videolog();
    wait 1;
    maps\seoul::ingame_movies();
    maps\_utility::activate_trigger_with_targetname( "trig_videolog_over_sinkhole" );
}

sinkhole_subway_vo_think()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sinkhole_subway_car_vo" );
    common_scripts\utility::flag_set( "vo_subway_car_start" );
}

warp_allies_forward_sinkhole()
{
    if ( !isdefined( level.cormack.building_jump_initiate ) )
    {
        level.cormack prepare_to_teleport();
        level.cormack teleport_to_struct( "jump_cormack_moveto" );
    }
    else
        level.cormack thread speed_up_building_jump_anim();

    if ( !isdefined( level.will_irons.building_jump_initiate ) )
    {
        level.will_irons prepare_to_teleport();
        level.will_irons teleport_to_struct( "jump_will_irons_moveto" );
    }
    else
        level.will_irons thread speed_up_building_jump_anim();

    common_scripts\utility::flag_set( "player_starting_sinkhole" );
}

speed_up_building_jump_anim()
{
    maps\_utility::set_moveplaybackrate( 1.75 );

    while ( !isdefined( self.building_jump_done ) )
        waitframe();

    maps\_utility::set_moveplaybackrate( 1 );
}

teleport_to_struct( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );
    self _meth_81C6( var_1.origin, var_1.angles );
}

prepare_to_teleport()
{
    self notify( "goal" );
    self notify( "new_anim_reach" );
    self notify( "warping" );
    maps\_shg_design_tools::anim_stop();
}

sinkhole_drone_intro()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_sinkhole_enemy_setup" );
    wait(randomfloat( 1.5 ));
    var_0 = getentarray( "sinkhole_drones_intro", "script_noteworthy" );
    maps\_utility::array_spawn_function( var_0, ::sd_drone_patrol_think );
    level.sinkhole_drones = maps\_utility::array_spawn( var_0 );
    soundscripts\_snd::snd_message( "sinkhole_drones_start", level.sinkhole_drones );
    common_scripts\utility::flag_set( "vo_sinkhole_first_drones" );
}

sinkhole_drones_group2()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_sinkhole_drones_01" );
    var_0 = getentarray( "sinkhole_drones_01", "script_noteworthy" );
    var_1 = maps\_utility::array_spawn_noteworthy( "sinkhole_drones_01" );
    maps\_utility::array_removedead( level.sinkhole_drones );
    level.sinkhole_drones = maps\_utility::array_merge( level.sinkhole_drones, var_1 );

    foreach ( var_3 in var_1 )
    {
        var_3.health = 50;
        var_3.target = undefined;
        var_3 _meth_82C0( 1 );
        var_3 _meth_8139( var_3.script_team );
        var_3 thread maps\seoul_fx::drone_spot_light( var_3 );
    }

    wait 1;

    foreach ( var_3 in var_1 )
    {
        var_3 maps\_utility::vehicle_detachfrompath();
        var_3 thread vehicle_scripts\_pdrone::flying_attack_drone_logic();
    }
}

sinkhole_jets()
{
    common_scripts\utility::flag_wait( "sinkhole_jet_flyby" );
    var_0 = getentarray( "shrike_flyby_spawner", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 maps\_vehicle::spawn_vehicle_and_gopath();

    wait 2.1;
    common_scripts\utility::flag_set( "start_truck_fall" );
}

sinkhole_drones_attack_civilians()
{
    createthreatbiasgroup( "civ_victims" );
    createthreatbiasgroup( "drones_attacking_civs" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_sinkhole_drones_attack_civs" );
    level.civ_victims = [];
    var_0 = maps\_utility::spawn_targetname( "civ_sinkhole_victim1" );
    var_1 = maps\_utility::spawn_targetname( "civ_sinkhole_victim2" );
    var_0.team = "allies";
    var_1.team = "allies";
    level.civ_victims[level.civ_victims.size] = var_0;
    level.civ_victims[level.civ_victims.size] = var_1;
    wait 0.5;
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname( "civ_sinkhole_attack_drone1" );
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname( "civ_sinkhole_attack_drone2" );
    var_2.health = 50;
    var_3.health = 50;
    var_2 thread maps\seoul_fx::drone_spot_light( var_2 );
    var_3 thread maps\seoul_fx::drone_spot_light( var_3 );
    var_2 thread vehicle_scripts\_pdrone::flying_attack_drone_logic();
    var_3 thread vehicle_scripts\_pdrone::flying_attack_drone_logic();
    var_2.favoriteenemy = var_0;
    var_3.favoriteenemy = var_1;

    while ( level.civ_victims.size > 0 )
    {
        level.civ_victims = maps\_utility::array_removedead_or_dying( level.civ_victims );
        wait 0.05;
    }

    if ( isalive( var_2 ) )
        var_2 thread sd_drone_patrol_think();

    if ( isalive( var_3 ) )
        var_3 thread sd_drone_patrol_think();
}

sinkhole_civ_vicitim_group()
{
    self _meth_8177( "civ_victims" );
    self.team = "allies";
}

sinkhole_spawn_attack_drones()
{

}

sinkhole_drones_group4_spawn()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sinkhole_drones_group4" );
    var_0 = getent( "sinkhole_drones_group4", "script_noteworthy" );
    maps\_utility::array_spawn_function( var_0, ::sd_drone_patrol_think );
    maps\_utility::array_removedead( level.sinkhole_drones );
    level.sinkhole_drones = maps\_utility::array_merge( level.sinkhole_drones, var_0 );
}

sinkhole_make_piece_fall( var_0, var_1, var_2, var_3 )
{
    var_0 *= randomfloatrange( 0.1, 0.135 );
    var_4 = undefined;

    if ( isdefined( var_2 ) && isdefined( self.targetname ) & !issubstr( self.targetname, var_3 ) )
    {
        var_2 = sortbydistance( var_2, self.origin );
        var_4 = var_2[0];
    }

    wait(var_0);
    var_5 = 6;
    var_6 = 100;
    var_7 = 100;
    var_8 = 1200;
    var_9 = self.origin - ( 0, 0, var_8 );
    var_10 = self.origin[2];
    var_11 = vectortoangles( ( var_1.origin[0], var_1.origin[1], var_10 ) - self.origin );
    var_12 = self.origin + anglestoforward( var_11 ) * 200;

    while ( isdefined( level.player.player_tank ) && distance( level.player.player_tank.origin, self.origin ) < 200 )
        wait 0.05;

    var_13 = gettime() * 0.001;

    if ( isdefined( var_4 ) )
        var_4 thread maps\_utility::delaythread( 0.1, maps\_shg_design_tools::delete_auto );

    while ( gettime() * 0.001 <= var_13 + var_5 )
    {
        var_14 = self.origin + maps\_shg_design_tools::gravity_point( var_13, var_9, var_7 );
        var_15 = ( 0, vectortoangles( var_1.origin - var_14 )[1], 0 );
        var_16 = 3;
        var_17 = ( var_16, var_15[1], 0 );
        var_18 = transformmove( var_14, var_17, var_14, var_15, var_14, self.angles );
        self.origin = var_18["origin"];
        self.angles = var_18["angles"];
        wait 0.05;
    }
}

sinkhole_fracture( var_0, var_1 )
{
    var_0 = sortbydistance( var_0, var_1.origin );

    foreach ( var_4, var_3 in var_0 )
        var_3 thread sinkhole_make_piece_break( var_4, var_1 );
}

sinkhole_make_piece_break_and_sink( var_0, var_1 )
{
    wait(var_0 * 0.005);
    var_2 = randomintrange( 3, 5 );
    var_3 = var_0 + 1;

    if ( common_scripts\utility::cointoss() )
    {
        for ( var_4 = 0; var_4 < var_2; var_4++ )
        {
            if ( distance( level.player.player_tank.origin, self.origin ) < 300 )
                return;

            var_5 = ( 0, vectortoangles( var_1.origin - self.origin )[1], 0 );
            var_6 = 1;
            var_7 = ( var_6, var_5[1], 0 );
            var_8 = transformmove( self.origin, var_7, self.origin, var_5, self.origin, self.angles );
            var_9 = max( 64 - var_3 / 3, randomint( 10 ) ) * -1;
            var_10 = ( var_8["origin"][0], var_8["origin"][1], var_8["origin"][2] + var_9 );
            var_11 = randomfloatrange( -2, 2 );
            var_12 = randomfloatrange( -2, 2 );
            var_13 = randomfloatrange( -2, 2 );

            if ( common_scripts\utility::cointoss() )
                var_13 = randomfloatrange( -8, 8 );

            thread maps\_shg_design_tools::lerp_to_position( var_10, 140 );
            self.angles = var_8["angles"] + ( var_11, var_12, var_13 );
            wait 0.05;
        }
    }
}

sinkhole_make_piece_break( var_0, var_1 )
{
    wait(var_0 * 0.01);
    var_2 = randomintrange( 3, 5 );
    var_3 = var_0 + 1;

    if ( common_scripts\utility::cointoss() )
    {
        for ( var_4 = 0; var_4 < var_2; var_4++ )
        {
            if ( distance( level.player.origin, self.origin ) < 20 )
                return;

            var_5 = ( 0, vectortoangles( var_1.origin - self.origin )[1], 0 );
            var_6 = 0.5;
            var_7 = ( var_6, var_5[1], 0 );
            var_8 = transformmove( self.origin, var_7, self.origin, var_5, self.origin, self.angles );
            var_9 = ( var_8["origin"][0], var_8["origin"][1], var_8["origin"][2] );
            var_10 = randomfloatrange( -0.75, 0.75 );
            var_11 = randomfloatrange( -0.75, 0.75 );
            var_12 = randomfloatrange( -0.75, 0.75 );

            if ( common_scripts\utility::cointoss() )
                var_12 = randomfloatrange( -3, 3 );

            thread maps\_shg_design_tools::lerp_to_position( var_9, 80 );
            self.angles = var_8["angles"] + ( var_10, var_11, var_12 );
            wait 0.05;
        }
    }
}

sinkhole_truck_fall_badly()
{
    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_2 = common_scripts\utility::getstruct( "struct_sinkhole_center_2", "targetname" );
    var_3 = 600;
    maps\_shg_design_tools::lerp_to_position( var_0.origin, var_3 );
    earthquake( 0.2, 1, level.player.origin, 500 );
    var_4 = 2.0;
    thread maps\_shg_design_tools::gravity_arc( self.origin, var_1.origin, var_4, 900, 900 );
    thread sinkhole_crashed_truck_rotation();
    self waittill( "item_landed" );
    wait 0.05;
    self delete();
}

sinkhole_crashed_truck_rotation()
{
    self endon( "item_landed" );
    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    self.angles = var_0.angles;
    var_2 = ( 0, 3, 0 );

    for (;;)
    {
        self _meth_82B9( -5 );
        wait 0.05;
    }
}

sinkhole_weapon_platform()
{

}

sinkhole_smoke_ambush_event()
{
    maps\_utility::trigger_wait_targetname( "trig_sinkhole_spawn_smoke_grenades" );
    level.will_irons.ignoreall = 1;
    level.cormack.ignoreall = 1;
    level.jackson.ignoreall = 1;
    maps\_utility::autosave_by_name();
    thread sinkhole_smoke_grenade_loop();
    level.smoke_ambush_enemies = [];
    maps\_utility::array_spawn_function_noteworthy( "sinkhole_smoke_ambush", ::sinkhole_smoke_ambush_enemy_think );
    maps\_utility::array_spawn_noteworthy( "sinkhole_smoke_ambush" );
    wait 2;
    common_scripts\utility::flag_set( "vo_subway_threat_moment" );
    thread sinkhole_threat_hint();
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_sinkhole" );
    common_scripts\utility::flag_wait( "wakeup_ambush" );
    level.will_irons.ignoreall = 0;
    level.cormack.ignoreall = 0;
    level.jackson.ignoreall = 0;

    while ( level.smoke_ambush_enemies.size > 0 )
    {
        level.smoke_ambush_enemies = maps\_utility::array_removedead_or_dying( level.smoke_ambush_enemies );
        waitframe();
    }

    common_scripts\utility::flag_set( "vo_subway_threat_moment_clear" );
    common_scripts\utility::flag_set( "objective_sd_smoke_ambush_defeated" );
    var_0 = getnode( "subway_node_corner1", "targetname" );
    var_1 = getnode( "subway_node_corner2", "targetname" );
    var_2 = getnode( "subway_node_corner3", "targetname" );
    level.cormack maps\_utility::set_goal_node( var_0 );
    level.will_irons maps\_utility::set_goal_node( var_1 );
    level.jackson maps\_utility::set_goal_node( var_2 );
}

sinkhole_smoke_ambush_enemy_think()
{
    self endon( "death" );
    var_0 = getent( "sinkhole_goal_smoke_ambush", "targetname" );
    self.ignoreall = 1;
    self _meth_81A9( var_0 );
    level.smoke_ambush_enemies[level.smoke_ambush_enemies.size] = self;
    self.grenadeammo = 0;
    thread sd_patrol1_player_close_check();
    self _meth_8041( "gunshot" );
    self _meth_8041( "bulletwhizby" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "death" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "damage" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "ai_event" );
    maps\_utility::add_func( common_scripts\utility::flag_set, "wakeup_ambush" );
    thread maps\_utility::do_wait_any();
    thread maps\_utility::flag_set_delayed( "wakeup_ambush", 4 );
    common_scripts\utility::flag_wait( "wakeup_ambush" );
    self.ignoreall = 0;
    self notify( "stop_going_to_node" );
}

sinkhole_smoke_grenade_loop()
{
    var_0 = getent( "sinkhole_origin_grenade_throw", "targetname" );
    var_1 = getentarray( "sinkhole_origin_grenade_targets", "script_noteworthy" );

    for ( var_2 = 0; var_2 < 2; var_2++ )
    {
        if ( !common_scripts\utility::flag( "wakeup_ambush" ) )
        {
            foreach ( var_4 in var_1 )
            {
                _func_070( "smoke_grenade_cheap", var_4.origin, var_4.origin + ( 0, 2, 0 ), 1 );
                soundscripts\_snd::snd_message( "seo_smoke_grenade_ambush", var_4.origin + ( 0, 2, 0 ), 1 );
            }

            wait 11;
        }
    }
}

sinkhole_threat_hint()
{
    var_0 = level.player _meth_831A();
    var_1 = level.player getammocount( var_0 );

    if ( var_1 == 0 )
        return;

    thread maps\_utility::display_hint_timeout( "throw_threat_hint", 6 );

    while ( !level.player _meth_824C( "BUTTON_LSHLDR" ) )
        waitframe();

    common_scripts\utility::flag_set( "threat_grenade_thrown" );
}

should_break_threat_hint()
{
    if ( common_scripts\utility::flag( "threat_grenade_thrown" ) )
        return 1;
    else
        return 0;
}

subway_section()
{
    var_0 = getentarray( "subway_ceiling_destroyed", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 hide();

    var_4 = getentarray( "subway_ceiling_stage1", "targetname" );

    foreach ( var_2 in var_4 )
        var_2 hide();

    var_7 = getent( "seo_roof_chunk", "targetname" );
    var_7 hide();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_start_subway_section" );
    var_8 = getentarray( "gate01", "script_noteworthy" );
    var_9 = getentarray( "gate02", "script_noteworthy" );
    var_10 = getentarray( "gate01_clip", "targetname" );
    var_11 = getentarray( "gate02_clip", "targetname" );

    foreach ( var_13 in var_10 )
    {
        var_14 = common_scripts\utility::getclosest( var_13.origin, var_8, 20 );
        var_13 _meth_804D( var_14 );
        var_13 _meth_8058();
    }

    foreach ( var_13 in var_11 )
    {
        var_14 = common_scripts\utility::getclosest( var_13.origin, var_9, 20 );
        var_13 _meth_804D( var_14 );
        var_13 _meth_8058();
    }

    level.door_volume_array = getentarray( "rotating_auto_doors", "targetname" );
    common_scripts\utility::array_thread( getentarray( "rotating_auto_doors", "targetname" ), ::subway_rotating_automatic_doors );

    if ( level.nextgen )
        thread subway_setup_civilians();
    else
        thread maps\seoul_transients_cg::subway_setup_dead_civilians_cg();

    maps\_shg_design_tools::waittill_trigger_with_name( "trig_subway_round_corner" );
    level notify( "killSinkHolePerf" );
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_set( "vo_subway_see_civilians" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_subway_gate_arrival" );
    common_scripts\utility::flag_set( "objective_sd_followed_cormack_through_subway" );

    if ( !common_scripts\utility::flag( "objective_sd_smoke_ambush_defeated" ) )
        common_scripts\utility::flag_set( "objective_sd_smoke_ambush_defeated" );

    thread subway_handle_open_gate();
    common_scripts\utility::flag_wait( "subway_gate_triggered" );
    thread subway_atlas_ceiling_breach();
}

subway_atlas_ceiling_breach()
{
    level.player freezecontrols( 1 );
    thread maps\seoul_lighting::dof_subway_cinematic_optimized();
    thread maps\seoul_lighting::lighting_subway_breach();
    thread maps\seoul_lighting::cine_holelight();
    thread maps\seoul_lighting::cine_sub_will_all_mulitlight();
    level thread maps\seoul_fx::roof_breach_anticipation_fx();
    var_0 = getent( "hero_burke", "targetname" );
    var_1 = getent( "atlas_squadmate1", "targetname" );
    var_2 = getent( "atlas_squadmate2", "targetname" );
    var_3 = getent( "atlas_squadmate3", "targetname" );
    var_4 = getent( "civ_vip1", "targetname" );
    var_5 = getent( "subway_origin_atlus_breach", "targetname" );
    var_6 = getent( "subway_gate_atlas_meetup", "targetname" );
    var_7 = getent( "subway_gate_atlas_meetup_clip", "targetname" );
    _func_0D3( "g_friendlynamedist", 0 );
    level.gideon = var_0 maps\_shg_design_tools::actual_spawn();
    level.atlas1 = var_1 maps\_shg_design_tools::actual_spawn();
    level.atlas2 = var_2 maps\_shg_design_tools::actual_spawn();
    level.gideon.ignoreall = 1;
    level.atlas1.ignoreall = 1;
    level.atlas2.ignoreall = 1;
    level.vip1 = undefined;

    if ( level.nextgen )
        level.vip1 = var_4 maps\_shg_design_tools::actual_spawn();
    else
        level.vip1 = maps\seoul_transients_cg::seo_meet_atlas_civ_scriptmodel_cg();

    if ( level.nextgen )
        level.vip1.ignoreall = 1;

    level.cormack.ignoreall = 1;
    level.jackson.ignoreall = 1;
    level.will_irons.ignoreall = 1;
    level.atlas1.animname = "atlas_guy1";
    level.atlas2.animname = "atlas_guy2";
    level.gideon.animname = "gideon";
    level.cormack.animname = "cormack";
    level.jackson.animname = "jackson";
    level.will_irons.animname = "will_irons";
    level.atlas1 maps\_utility::gun_remove();
    level.atlas2 maps\_utility::gun_remove();
    level.gideon maps\_utility::gun_remove();
    level.atlas1 attach( getweaponmodel( "iw5_hbra3_sp" ), "TAG_WEAPON_RIGHT" );
    level.atlas2 attach( getweaponmodel( "iw5_hbra3_sp" ), "TAG_WEAPON_RIGHT" );
    level.gideon attach( getweaponmodel( "iw5_hbra3_sp" ), "TAG_WEAPON_RIGHT" );
    var_8 = maps\_utility::spawn_anim_model( "subway_gate" );
    var_5 maps\_anim::anim_first_frame_solo( var_8, "seo_meet_atlas" );
    var_6 _meth_804D( var_8, "tag_origin_animated" );
    var_9 = getent( "seo_roof_chunk", "targetname" );
    var_9.animname = "roof_chunks";
    var_9 maps\_utility::assign_animtree();
    var_9 maps\_utility::assign_model();
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    level notify( "atlas_scene_start" );
    maps\_player_exo::player_exo_deactivate();
    var_10 = maps\_utility::spawn_anim_model( "player_rig", level.player.origin );
    maps\_utility::attach_player_current_weapon_to_rig( var_10 );
    level.vip1.animname = "vip";
    var_11 = [ level.cormack, level.will_irons, level.gideon, level.jackson, level.atlas1, level.atlas2, level.vip1, var_10, var_8, var_9 ];
    var_9 common_scripts\utility::delaycall( 0.5, ::show );
    var_10 hide();
    var_12 = 0.5;
    level.player _meth_8080( var_10, "tag_player", var_12, var_12 * 0.5 );
    var_5 maps\_anim::anim_first_frame( [ level.gideon, level.atlas1, level.atlas2, level.vip1, var_10, var_8, var_9 ], "seo_meet_atlas" );
    var_10 common_scripts\utility::delaycall( var_12, ::show );
    level.player common_scripts\utility::delaycall( var_12, ::_meth_807D, var_10, "tag_player", 1, 7, 7, 5, 5, 1 );
    common_scripts\utility::flag_set( "vo_begin_seo_meet_atlas" );
    var_5 maps\_anim::anim_single( var_11, "seo_meet_atlas" );
    var_7 _meth_8058();
    level.player _meth_804F();
    var_10 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player freezecontrols( 0 );
    maps\_player_exo::player_exo_activate();
    level.player _meth_8031( 65, 0.1 );
    _func_0D3( "g_friendlynamedist", 1024 );
    var_6 _meth_804F();
    var_13 = getent( "subway_gate_atlas_meetup_closed", "targetname" );
    var_6 soundscripts\_snd::snd_message( "subway_gate_atlas_meetup_close" );
    var_6 _meth_82AE( var_13.origin, 2, 0.5 );
    var_14 = getent( "subway_origin_jackson_post_scene", "targetname" );
    level.jackson maps\_utility::anim_stopanimscripted();
    level.jackson _meth_81C6( var_14.origin, var_14.angles );
    thread subway_atlas_post_scene();
    common_scripts\utility::flag_set( "objective_start_shopping_district" );
    _func_0D3( "g_friendlynamedist", 1024 );
    common_scripts\utility::flag_waitopen( "vo_begin_seo_meet_atlas" );
}

subway_meet_atlas_fov_shift_on( var_0 )
{
    var_1 = 50;
    level.player _meth_8031( var_1, 0.5 );
}

subway_meet_atlas_fov_shift_off( var_0 )
{
    if ( !isdefined( level.origfov ) )
        level.origfov = 65;

    level.player _meth_8031( level.origfov, 0.5 );
}

subway_roof_breach_start_slowmo( var_0 )
{
    soundscripts\_snd::snd_message( "seo_meet_atlas_slowmo_start" );
    maps\_utility::slowmo_start();
    maps\_utility::slowmo_setspeed_slow( 0.5 );
    maps\_utility::slowmo_setlerptime_in( 0.25 );
    maps\_utility::slowmo_lerp_in();
    level notify( "stop_subway_pa" );
}

subway_roof_breach_end_slomo()
{
    maps\_utility::slowmo_setlerptime_out( 0.75 );
    maps\_utility::slowmo_lerp_out();
    maps\_utility::slowmo_end();
    soundscripts\_snd::snd_message( "seo_meet_atlas_slowmo_end" );
}

subway_meet_atlas_show_hole_geo( var_0 )
{
    var_1 = getentarray( "subway_ceiling_intact", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 hide();

    var_5 = getentarray( "subway_ceiling_stage1", "targetname" );

    foreach ( var_3 in var_5 )
        var_3 show();

    if ( level.nextgen )
        wait 0.3;

    var_8 = getentarray( "subway_ceiling_destroyed", "targetname" );

    foreach ( var_3 in var_8 )
        var_3 show();

    foreach ( var_3 in var_5 )
        var_3 hide();

    wait 0.3;
    thread subway_roof_breach_start_slowmo();
    wait 1;
    thread subway_roof_breach_end_slomo();
}

subway_atlas_post_scene()
{
    var_0 = getent( "subway_origin_atlas1", "targetname" );
    var_1 = getent( "subway_origin_atlas2", "targetname" );
    var_2 = getent( "subway_origin_atlas3", "targetname" );
    var_3 = getent( "subway_origin_atlas4", "targetname" );
    var_4 = getnode( "atlas_cover_1", "targetname" );
    var_5 = getnode( "atlas_cover_2", "targetname" );
    var_6 = getnode( "atlas_cover_3", "targetname" );
    var_7 = getent( "atlas_cover_4", "targetname" );
    level.gideon maps\_utility::anim_stopanimscripted();
    level.atlas1 maps\_utility::anim_stopanimscripted();
    level.atlas2 maps\_utility::anim_stopanimscripted();
    level.vip1 maps\_utility::anim_stopanimscripted();
    level.gideon _meth_81C6( var_0.origin, var_0.angles );
    level.atlas1 _meth_81C6( var_1.origin, var_1.angles );
    level.atlas2 _meth_81C6( var_2.origin, var_2.angles );

    if ( level.nextgen )
    {
        level.vip1 _meth_81C6( var_3.origin, var_3.angles );
        level.vip1 maps\_utility::set_goal_radius( 15 );
        level.vip1 _meth_81A7( var_7 );
    }
    else
        thread maps\seoul_transients_cg::seo_get_vip_away_cg( var_3 );

    level.gideon maps\_utility::set_goal_radius( 15 );
    level.gideon maps\_utility::set_goal_node( var_4 );
    level.atlas1 maps\_utility::set_goal_radius( 15 );
    level.atlas1 maps\_utility::set_goal_node( var_5 );
    level.atlas2 maps\_utility::set_goal_radius( 15 );
    level.atlas2 maps\_utility::set_goal_node( var_6 );
    wait 15;
    subway_atlas_cleanup();
}

subway_atlas_cleanup()
{
    level.gideon delete();
    level.atlas1 delete();
    level.atlas2 delete();
    level.vip1 delete();
}

subway_setup_civilians()
{
    var_0 = getent( "trigger_enter_subway_station_01", "targetname" );
    var_1 = getent( "trigger_enter_subway_station_02", "targetname" );
    var_2 = getent( "trigger_enter_subway_station_03", "targetname" );
    var_3 = getent( "trigger_enter_subway_station_04", "targetname" );
    level.subway_civilians = [];
    thread subway_enter_spawn_civilians( var_0, var_1 );
    thread subway_enter_spawn_civilians( var_3, var_2 );
    thread subway_exit_delete_civilians( var_1, var_0 );
    thread subway_exit_delete_civilians( var_2, var_3 );
}

handle_ally_threat_during_execution_scene()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_subway_get_allies_to_execution_scene" );
    thread maps\_shg_design_tools::trigger_to_notify( "trig_subway_round_corner", "allies_aware_of_execution" );
    level.cormack.ignoreall = 1;
    level.will_irons.ignoreall = 1;
    level.jackson.ignoreall = 1;
    level common_scripts\utility::waittill_either( "execution_scene_halted", "allies_aware_of_execution" );
    level.cormack.ignoreall = 0;
    level.will_irons.ignoreall = 0;
    level.jackson.ignoreall = 0;
}

subway_execution_scene( var_0, var_1 )
{
    thread handle_ally_threat_during_execution_scene();
    var_0 waittill( "trigger" );
    var_1 waittill( "trigger" );
    var_2 = getent( "spawner_execution_scene", "targetname" );
    var_3 = common_scripts\utility::getstructarray( "struct_subway_execution_scene_soldier1", "targetname" );
    var_4 = var_3[0] common_scripts\utility::spawn_tag_origin();
    var_5 = [];

    foreach ( var_7 in var_3 )
    {
        var_8 = var_2 maps\_shg_design_tools::actual_spawn( 1 );
        var_8 maps\_patrol_extended::force_patrol_anim_set( "gundown" );
        var_8 _meth_81A6( level.player.origin );
        var_5[var_5.size] = var_8;
        var_8 thread monitor_alert();
        wait 2;
    }

    common_scripts\utility::array_thread( var_5, ::monitor_alert, var_5 );
    level waittill( "execution_scene_halted" );
    maps\_utility::activate_trigger_with_targetname( "trig_subway_round_corner" );
}

monitor_alert( var_0 )
{
    thread maps\_utility::notify_delay( "alert", 8 );
    var_1 = common_scripts\utility::waittill_any_return( "death", "damage", "alert" );

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3 ) )
            var_3 notify( "alert" );
    }

    maps\_utility::clear_generic_idle_anim();
    maps\_utility::clear_run_anim();
    self _meth_81CA( "stand", "crouch", "prone" );
    self.disablearrivals = 0;
    self.disableexits = 0;
    self _meth_8141();
    self notify( "stop_animmode" );
    self.script_nobark = undefined;
    self.goalradius = level.default_goalradius;
}

fail_on_kill_civilian()
{
    self waittill( "death", var_0, var_1, var_2 );

    if ( isdefined( var_0 ) && var_0 == level.player )
    {
        setdvar( "ui_deadquote", &"SEOUL_FAIL_CIVILIAN_KILLED" );
        maps\_utility::missionfailedwrapper();
    }
}

kill_on_damage()
{
    self waittill( "damage" );
    maps\_utility::anim_stopanimscripted();
    self _meth_8023();
    waitframe();
    self _meth_8052();
}

return_notify_on_event( var_0, var_1 )
{
    self _meth_8041( var_0 );
}

monitor_execution_scene_civs( var_0 )
{
    self waittill( "ai_alert" );
    maps\_utility::anim_stopanimscripted();
}

monitor_execution_scene_soldiers( var_0 )
{
    thread return_notify_on_event( "grenade danger", "ai_alert" );
    thread return_notify_on_event( "bulletwhizby", "ai_alert" );
    common_scripts\utility::waittill_any( "death", "damage", "ai_event", "ai_alert" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 notify( "ai_alert" );
    }

    if ( isdefined( self ) )
        maps\_utility::anim_stopanimscripted();
}

handle_sonic_when_in_subway( var_0, var_1, var_2 )
{
    for (;;)
    {
        var_0 waittill( "trigger" );
        var_1 waittill( "trigger" );

        if ( var_2 == "off" )
            thread maps\_sonicaoe::disablesonicaoe();
        else
            thread maps\_sonicaoe::enablesonicaoe();

        var_1 waittill( "trigger" );
        var_0 waittill( "trigger" );

        if ( var_2 == "off" )
        {
            thread maps\_sonicaoe::enablesonicaoe();
            continue;
        }

        thread maps\_sonicaoe::disablesonicaoe();
    }
}

subway_enter_spawn_civilians( var_0, var_1 )
{
    if ( !isdefined( level.subway_civilians ) )
        level.subway_civilians = [];

    var_2 = getentarray( "spawner_subway_civilian", "targetname" );
    var_3 = common_scripts\utility::getstructarray( "struct_subway_civilian", "targetname" );

    for (;;)
    {
        var_0 waittill( "trigger" );
        var_1 waittill( "trigger" );
        level notify( "player_entered_subway" );

        foreach ( var_5 in var_3 )
        {
            var_6 = maps\_utility::dronespawn_bodyonly( common_scripts\utility::random( var_2 ) );
            var_6 _meth_82BF();

            if ( !isdefined( var_6 ) )
                continue;

            var_6.animname = "generic";
            var_5 thread maps\_anim::anim_generic_loop( var_6, var_5.animation );
            level.subway_civilians[level.subway_civilians.size] = var_6;
        }

        wait 0.1;
    }
}

break_if_flashed_sonic()
{
    self endon( "death" );

    while ( !iscivflashed() )
        waitframe();

    if ( isdefined( self.tag ) )
        thread maps\_shg_design_tools::anim_stop( self.tag );

    thread maps\_utility::anim_stopanimscripted();
    thread maps\_shg_design_tools::anim_stop();
}

iscivflashed()
{
    if ( !isdefined( self.iscivilianflashed ) )
        return 0;

    if ( !self.iscivilianflashed )
        return 0;

    return 1;
}

subway_exit_delete_civilians( var_0, var_1 )
{
    for (;;)
    {
        var_0 waittill( "trigger" );
        var_1 waittill( "trigger" );
        level notify( "player_leaving_subway" );

        if ( level.subway_civilians.size > 0 )
        {
            foreach ( var_3 in level.subway_civilians )
            {
                if ( isdefined( var_3.tag ) )
                    var_3.tag delete();

                if ( isdefined( var_3 ) )
                    var_3 delete();
            }
        }

        wait 0.05;
    }
}

spawn_civ_loop( var_0 )
{
    var_0.count = 1;
    var_1 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
    var_1.animname = "generic";
    var_0 thread maps\_anim::anim_generic_loop( var_1, var_0.animation );
    var_1 subway_civilian_attach_props( var_0.animation );
    var_1 thread break_if_flashed_sonic();
    return var_1;
}

subway_civ_speaking_groups_setup()
{
    var_0 = getentarray( "spawner_subway_civilian", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_subway_civilian", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = maps\_utility::dronespawn( common_scripts\utility::random( var_0 ) );

        if ( !isdefined( var_4 ) )
            continue;

        var_4.animname = "generic";
        var_4.origin = var_3.origin;
        var_4.angles = var_3.angles;
        var_3 thread maps\_anim::anim_generic_loop( var_4, var_3.animation );
        level.subway_civilians[level.subway_civilians.size] = var_4;
    }
}

subway_civilian_init_props()
{
    anim.civilianprops = [];
    anim.civilianprops["civilian_smoking_b"] = "prop_cigarette";
    anim.civilianprops["parabolic_leaning_guy_smoking_idle"] = "prop_cigarette";
    anim.civilianprops["civilian_texting_sitting"] = "electronics_pda";
    anim.civilianprops["civilian_reader_1"] = "lab_tablet_flat_on";
    anim.civilianprops["civilian_reader_2"] = "lab_tablet_flat_on";
    anim.civilianprops["civilian_texting_standing"] = "electronics_pda";
    anim.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
}

subway_civilian_attach_props( var_0 )
{
    if ( isdefined( self.hasattachedprops ) )
        return;

    subway_civilian_init_props();
    var_1 = anim.civilianprops[var_0];

    if ( isdefined( var_1 ) )
    {
        self.attachedpropmodel = var_1;
        self.attachedproptag = "tag_inhand";
        var_2 = self attach( self.attachedpropmodel, self.attachedproptag, 1 );
        self.hasattachedprops = 1;

        if ( self.attachedpropmodel == "prop_cigarette" )
            playfxontag( common_scripts\utility::getfx( "cigarette_smk" ), self, "tag_inhand" );

        return var_1;
    }
}

subway_civilian_detach_props()
{
    if ( isdefined( self.hasattachedprops ) && isdefined( self.attachedpropmodel ) )
    {
        if ( self.attachedpropmodel == "prop_cigarette" )
            stopfxontag( common_scripts\utility::getfx( "cigarette_smk" ), self, "tag_inhand" );

        self detach( self.attachedpropmodel, self.attachedproptag );
        self.hasattachedprops = undefined;
        self.attachedpropmodel = undefined;
        self.attachedproptag = undefined;
    }
}

subway_handle_open_gate()
{
    var_0 = getent( "subway_open_gate", "targetname" );
    var_0 _meth_817B();
    var_0 _meth_80DB( &"SEOUL_OPEN_GATE_HINT" );
    var_1 = var_0 maps\_shg_utility::hint_button_trigger( "x", 300 );
    common_scripts\utility::flag_set( "vo_near_gate" );
    var_2 = [ "seo_crk_mitchellgetthatgate", "seo_crk_getthegatemitchell" ];
    thread maps\_shg_utility::dialogue_reminder( level.cormack, "subway_gate_triggered", var_2 );
    maps\_utility::trigger_wait_targetname( "subway_open_gate" );
    common_scripts\utility::flag_set( "subway_gate_triggered" );
    soundscripts\_snd::snd_message( "subway_gate_triggered" );
    var_1 maps\_shg_utility::hint_button_clear();
    var_0 _meth_80DB( "" );
    common_scripts\utility::flag_set( "objective_sd_gate_opened" );
    var_0 common_scripts\utility::trigger_off();
}

subway_handle_player_weapon_in_scene()
{
    for (;;)
    {
        if ( isdefined( level.player _meth_8311() ) && level.player _meth_8311() != "none" )
        {
            var_0 = level.player _meth_8311();
            var_1 = strtok( var_0, "_" );
            var_2 = "none";

            if ( var_1[1] == "himar" )
                var_3 = "npc_himar_base";
            else
                var_3 = "npc_" + var_1[1] + "_nocamo";

            if ( isdefined( var_1[3] ) )
                var_2 = var_1[3];

            waitframe();
        }

        wait 1;
    }
}

subway_rotating_automatic_doors()
{
    if ( !isdefined( self.open_time ) )
        self.open_time = 1;

    var_0 = getentarray( self.target, "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname == "script_origin" )
        {
            var_1[var_1.size] = var_3;
            continue;
        }

        var_3 subway_auto_doors_init( self.open_time );
    }

    var_0 = common_scripts\utility::array_remove_array( var_0, var_1 );

    for (;;)
    {
        if ( !isdefined( level.player_and_squad ) )
        {
            level.player_and_squad = [];
            level.player_and_squad[level.player_and_squad.size] = level.player;
            level.player_and_squad[level.player_and_squad.size] = level.cormack;
            level.player_and_squad[level.player_and_squad.size] = level.will_irons;
            level.player_and_squad[level.player_and_squad.size] = level.jackson;
        }

        var_5 = 0;

        foreach ( var_7 in level.player_and_squad )
        {
            if ( var_7 _meth_80A9( self ) && isdefined( var_7 ) )
            {
                var_5++;
                break;
            }
        }

        if ( var_5 > 0 )
            subway_open_all_doors( var_0 );
        else
        {
            var_9 = 0.3;
            thread subway_close_all_doors( var_0, var_9 );
        }

        wait 0.05;
    }
}

subway_auto_doors_init( var_0 )
{
    self.start_position = self.angles;
    self.sliding_door_state = "closed";
    var_1 = getent( self.target, "targetname" );
    self.open_position = var_1.angles;
    self.open_velocity = distance( self.open_position, self.angles ) / var_0;
}

subway_open_all_doors( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( var_2.sliding_door_state == "open" || var_2.sliding_door_state == "opening" )
            continue;

        var_2 thread subway_open_door();
    }
}

subway_open_door()
{
    self.sliding_door_state = "opening";
    var_0 = 0.3;
    self _meth_82B5( self.open_position, var_0 );
    soundscripts\_snd::snd_message( "subway_doors_opening" );
    wait(var_0);
    self.sliding_door_state = "open";
}

subway_close_all_doors( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
    {
        if ( var_3.sliding_door_state == "closed" || var_3.sliding_door_state == "opening" )
            continue;

        var_3 _meth_82B5( var_3.start_position, var_1 );
        var_3 soundscripts\_snd::snd_message( "subway_doors_closing" );
        var_3.sliding_door_state = "closed";
    }
}

sd_intersection3_smoke_laser_spawn()
{

}

sd_street_combat()
{
    common_scripts\utility::flag_wait( "sd_start_shopping_district" );
    maps\_utility::normal_friendly_fire_penalty();
    level.will_irons.ignoreall = 1;
    level.cormack.ignoreall = 1;
    level.jackson.ignoreall = 1;
    level.player_repulsor = missile_createrepulsorent( level.player, 10000, 500 );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::autosave_by_name();
    thread sd_autosave_check();
    common_scripts\utility::flag_set( "start_weapon_platform_firing" );
    thread enable_pain_will_irons_during_shopping_fight();
    thread sd_intersection_chopper();
    thread sd_patrol1_command();
    thread sd_switch_axis_colors();
    thread sd_path_check1();
    thread sd_spawn_turret_truck();
    thread sd_upstairs_enemies_spawn();
    thread sd_spawn_zipline_group1();
    thread sd_spawn_zipline_group2();
    thread sd_spawn_and_retreat_goals( "trig_restaurant_spawn", "enemy_sd_restaraunt1", undefined, undefined );
    thread sd_spawn_and_retreat_goals( "trig_restaurant_spawn", "enemy_sd_upstairs1_reinforce", 3, undefined );
    thread sd_spawn_and_retreat_goals( "trig_sd_reinforce1", "enemy_sd_reinforce1", undefined, undefined );
    thread sd_spawn_crossfire_2nd_floor_enemies();
    thread sd_spawn_and_retreat_goals( "trig_sd_reinforce1", "enemy_sd_intersection2", undefined );
    thread sd_intersection2_smoke_and_spawn();
    thread sd_intersection3_smoke_laser_spawn();
    thread handle_movement_speed_in_final_building();
    thread sd_shop_logo_control();
    thread sd_glass_projection_setup();
    thread canal_weapon_platform_firing_loop();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_patrol1_spawn" );
    common_scripts\utility::flag_set( "vo_sd_attack_patrol" );
    level.will_irons maps\_utility::enable_cqbwalk();
    level.cormack maps\_utility::enable_cqbwalk();
    level.jackson maps\_utility::enable_cqbwalk();
    maps\_shg_design_tools::waittill_trigger_with_name( "sd_trig_engage_patrol" );
    thread sd_vo_inside_restaurant();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_upstairs2_spawn" );
    maps\_utility::autosave_by_name();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sd_intersection2_reinforce" );
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_wait( "sd_cleanup_upstairs" );
    var_0 = getent( "sd_goal_upstairs2", "targetname" );
    var_1 = maps\_utility::get_force_color_guys( "axis", "p" );
    var_2 = var_0 maps\_utility::get_ai_touching_volume( "axis" );
    var_1 = common_scripts\utility::array_combine( var_1, var_2 );

    foreach ( var_4 in var_1 )
    {
        if ( isalive( var_4 ) )
            var_4 bloody_death( 0.3 );
    }

    common_scripts\utility::flag_wait( "sd_trigger_final_combat" );
    var_6 = maps\_utility::get_force_color_guys( "axis", "g" );

    foreach ( var_4 in var_6 )
    {
        if ( isalive( var_4 ) )
            var_4.health = 1;
    }

    common_scripts\utility::flag_wait( "sd_street_combat_complete" );
    common_scripts\utility::flag_set( "objective_sd_street_combat_complete" );
}

enable_pain_will_irons_during_shopping_fight()
{
    common_scripts\utility::flag_wait( "wakeup_patrol" );
    level.will_irons maps\_utility::enable_pain();
    common_scripts\utility::flag_wait( "sd_street_combat_complete" );
    level.will_irons maps\_utility::disable_pain();
}

handle_movement_speed_in_final_building()
{
    common_scripts\utility::flag_wait( "sd_street_combat_complete" );
    maps\seoul::enable_cqb_squad();
    common_scripts\utility::flag_wait( "canal_reached_window" );
    maps\seoul::disable_cqb_squad();
}

sd_autosave_check()
{
    common_scripts\utility::flag_wait( "vo_begin_seo_meet_atlas" );
    common_scripts\utility::flag_waitopen( "vo_begin_seo_meet_atlas" );

    if ( !common_scripts\utility::flag( "sd_combat_start" ) )
        maps\_utility::autosave_by_name();
}

sd_spawn_crossfire_2nd_floor_enemies()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_upstairs2_spawn" );
    var_0 = maps\_utility::get_force_color_guys( "axis", "p" );
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );

    while ( var_0.size > 0 )
    {
        var_0 = maps\_utility::array_removedead_or_dying( var_0 );
        waitframe();
    }

    if ( !common_scripts\utility::flag( "sd_cleanup_upstairs" ) )
        thread sd_spawn_and_retreat_goals( undefined, "enemy_sd_upstairs2", undefined, "sd_goal_upstairs2", undefined, undefined, undefined, "trig_sd_cleanup_upstairs2" );
}

sd_vo_inside_restaurant()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "sd_trig_move_inside_restaurant" );
    common_scripts\utility::flag_set( "vo_inside_restaurant" );
}

sd_switch_axis_colors()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "sd_trig_move_inside_restaurant" );
    var_0 = maps\_utility::get_force_color_guys( "axis", "b" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 maps\_utility::set_force_color( "p" );
    }
}

sd_spawn_zipline_group1()
{
    level endon( "player_hit_street_zipline_trigger" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sd_upstairs1_zipreinforce" );
    level notify( "player_hit_upperfloor_zipline_trigger" );
    var_0 = getent( "sd_int2_smoke_nade_source1", "targetname" );
    var_1 = getentarray( "sd_upstairs_smoke_nade_source1", "targetname" );

    foreach ( var_3 in var_1 )
    {
        _func_070( "smoke_grenade_cheap", var_3.origin, var_3.origin + ( 0, 2, 0 ), 0.5 );
        soundscripts\_snd::snd_message( "seo_smoke_grenade_ambush", var_3.origin + ( 0, 2, 0 ), 0.5 );
    }

    wait 2;
    var_5 = getglassarray( "sd_glass_bar_windows" );

    foreach ( var_7 in var_5 )
        destroyglass( var_7 );

    var_9 = getent( "sd_org_smoke_start", "targetname" );
    var_10 = getent( "sd_org_smoke_target1", "targetname" );
    var_11 = getent( "sd_org_smoke_target2", "targetname" );
    _func_070( "smoke_grenade_cheap", var_9.origin + ( 0, 200, -60 ), var_10.origin + ( 0, 20, 20 ), 1 );
    soundscripts\_snd::snd_message( "seo_smoke_grenade_ambush", var_10.origin + ( 0, 20, 20 ), 1 );
    wait 0.5;
    _func_070( "smoke_grenade_cheap", var_9.origin + ( 0, 200, -60 ), var_11.origin + ( 0, 20, 20 ), 1 );
    soundscripts\_snd::snd_message( "seo_smoke_grenade_ambush", var_11.origin + ( 0, 20, 20 ), 1 );
    var_12 = [];
    var_12[var_12.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "enemy_sd_upstairs1_zipreinforce", "sd_zipline_upstairs_across_start2" );
    wait 0.5;
    var_12[var_12.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "enemy_sd_upstairs1_zipreinforce", "sd_zipline_upstairs_across_start1" );
    wait 0.5;
    var_12[var_12.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "enemy_sd_upstairs1_zipreinforce", "sd_zipline_upstairs_across_start3" );
    wait 0.5;
    var_12[var_12.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "enemy_sd_upstairs1_zipreinforce", "sd_zipline_upstairs_across_start4" );
    sd_zipline_enemy_think( var_12 );
}

sd_spawn_zipline_group2()
{
    level endon( "player_hit_upperfloor_zipline_trigger" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sd_upstairs1_zipreinforce_02" );
    level notify( "player_hit_street_zipline_trigger" );
    var_0 = getent( "sd_int2_smoke_nade_source1", "targetname" );
    var_1 = getentarray( "sd_upstairs_smoke_nade_source1", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( common_scripts\utility::cointoss() )
            _func_070( "smoke_grenade_cheap", var_3.origin, var_3.origin + ( 0, 2, 0 ), 0.5 );
    }

    wait 2;
    var_5 = getglassarray( "sd_glass_bar_windows" );

    foreach ( var_7 in var_5 )
        destroyglass( var_7 );

    var_9 = getent( "sd_org_smoke_start", "targetname" );
    var_10 = getent( "sd_org_smoke_target1", "targetname" );
    var_11 = getent( "sd_org_smoke_target2", "targetname" );
    _func_070( "smoke_grenade_cheap", var_9.origin + ( 0, 200, -60 ), var_10.origin + ( 0, 20, 20 ), 1 );
    wait 0.5;
    _func_070( "smoke_grenade_cheap", var_9.origin + ( 0, 200, -60 ), var_11.origin + ( 0, 20, 20 ), 1 );
    var_12 = [];
    var_12[var_12.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "enemy_sd_upstairs1_zipreinforce", "sd_zipline_upstairs_across_start2" );
    wait 0.5;
    var_12[var_12.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "enemy_sd_upstairs1_zipreinforce", "sd_zipline_upstairs_across_start1" );
    sd_zipline_enemy_think( var_12 );
}

handle_player_skipped_turret()
{
    self endon( "death" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sd_cleanup_upstairs2" );
    bloody_death();
}

handle_turret_gunner_sonic_blast( var_0 )
{
    self endon( "death" );
    self waittill( "flashed" );

    if ( isdefined( var_0 ) )
    {
        var_0 _meth_815C();
        wait 6;
        var_0 _meth_8179();
    }
}

sd_spawn_turret_truck()
{
    maps\_utility::trigger_wait_targetname( "trig_sd_turret_vehicle_spawn" );
    wait 3;
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "sd_turret_vehicle1" );

    if ( level.currentgen )
        thread maps\seoul_transients_cg::cg_kill_entity_on_transition( var_0, "pre_transients_canal_overlook_to_riverwalk" );

    var_0 soundscripts\_snd::snd_message( "shopping_district_turret_truck" );
    var_0.script_godmode = 1;
    var_1 = var_0.mgturret[0];
    var_2 = getent( "gaz_lighting_origin", "targetname" );
    var_0 _meth_847B( var_2.origin );

    foreach ( var_4 in var_0.riders )
    {
        if ( level.currentgen )
            var_4.neverdelete = 1;

        if ( var_4.vehicle_position == 3 )
        {
            var_5 = var_4;
            var_5 thread handle_turret_gunner_sonic_blast( var_1 );
            var_5 thread handle_player_skipped_turret();
        }
    }

    var_0 waittill( "reached_end_node" );
    var_0 maps\_vehicle::vehicle_unload( "all_but_gunner" );
    common_scripts\utility::flag_wait( "canal_jump_complete" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

sd_upstairs_enemies_spawn()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_patrol1_spawn" );
    maps\_shg_design_tools::waittill_trigger_with_name( "sd_trig_engage_patrol" );
    common_scripts\utility::flag_wait( "wakeup_patrol" );
    common_scripts\utility::flag_set( "vo_sd_first_reinforcements" );

    if ( level.currentgen && !issubstr( level.transient_zone, "_shopping" ) )
        level waittill( "transients_subway_to_shopping_dist" );

    maps\_utility::array_spawn_function_noteworthy( "enemy_sd_upstairs1", ::sd_1st_int_window_goal );
    var_0 = maps\_utility::array_spawn_noteworthy( "enemy_sd_upstairs1", 1 );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sd_reinforce1" );
    var_0 = maps\_utility::array_removedead_or_dying( var_0 );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::set_force_color( "p" );
}

sd_1st_int_window_goal()
{
    self.grenadeammo = 0;
    thread change_color_node_quick();
    maps\_utility::set_goal_radius( 15 );
    maps\_utility::set_goal_node( getnode( self.target, "targetname" ) );
}

sd_path_check1()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_disable_restaraunt_events" );
    maps\_utility::disable_trigger_with_targetname( "trig_disable_restaraunt_events" );
    var_0 = getent( "trig_restaurant_spawn", "targetname" );

    if ( isdefined( var_0 ) )
        maps\_utility::disable_trigger_with_targetname( "trig_restaurant_spawn" );

    var_1 = getent( "trig_sd_will_command_restaraunt1", "targetname" );

    if ( isdefined( var_1 ) )
        maps\_utility::disable_trigger_with_targetname( "trig_sd_will_command_restaraunt1" );

    var_2 = getent( "trig_sd_upstairs1_reinforce", "targetname" );

    if ( isdefined( var_2 ) )
        maps\_utility::disable_trigger_with_targetname( "trig_sd_upstairs1_reinforce" );
}

sd_patrol1_command()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_patrol1_spawn" );

    while ( level.currentgen && !_func_21E( "seoul_shopping_dist_tr" ) )
        wait 0.05;

    if ( level.currentgen )
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "sd_street_combat_complete", undefined, 15, 0 );

    common_scripts\utility::flag_clear( "wakeup_patrol" );
    thread maps\_utility::array_spawn_function_noteworthy( "enemy_sd_patrol1", ::sd_force_patrol1_anim_set, "casualkiller", 1 );
    thread maps\_utility::array_spawn_noteworthy( "enemy_sd_patrol1", 1 );
    common_scripts\utility::flag_wait( "wakeup_patrol" );
    common_scripts\utility::flag_set( "sd_combat_start" );
}

sd_force_patrol1_anim_set( var_0, var_1, var_2 )
{
    self endon( "death" );
    self.ignoreall = 1;
    self.patrol_walk_twitch = undefined;
    self.patrol_walk_anim = undefined;
    self.grenadeammo = 0;
    self.script_careful = 1;
    thread maps\_patrol::patrol();
    maps\_utility::clear_force_color();
    thread sd_patrol1_player_close_check();
    self _meth_8041( "grenade danger" );
    self _meth_8041( "gunshot" );
    self _meth_8041( "bulletwhizby" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "death" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "damage" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "ai_event" );
    maps\_utility::add_func( common_scripts\utility::flag_set, "wakeup_patrol" );
    thread maps\_utility::do_wait_any();
    common_scripts\utility::flag_wait( "wakeup_patrol" );
    self.ignoreall = 0;
    maps\_utility::set_force_color( "b" );
    self.fixednode = 0;
    remove_patrol_anim_set();
    self notify( "stop_going_to_node" );
    level.will_irons.ignoreall = 0;
    level.cormack.ignoreall = 0;
    level.jackson.ignoreall = 0;
    level.will_irons maps\_utility::disable_cqbwalk();
    level.cormack maps\_utility::disable_cqbwalk();
    level.jackson maps\_utility::disable_cqbwalk();
    maps\_utility::battlechatter_on( "allies" );
    thread change_color_node_quick();
}

sd_patrol1_player_close_check()
{
    self endon( "death" );
    level endon( "wakeup_patrol" );
    level.player endon( "death" );

    while ( distancesquared( level.player.origin, self.origin ) > squared( 450 ) )
        wait 0.25;

    common_scripts\utility::flag_set( "wakeup_patrol" );
}

sd_intersection_chopper()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "sd_intersection_chopper" );
    var_0.ignoreall = 1;
    var_0 maps\_vehicle::godon();
    var_0 soundscripts\_snd::snd_message( "sd_intersection_chopper" );
    var_0.light = common_scripts\utility::spawn_tag_origin();
    var_0.light.origin = var_0 gettagorigin( "tag_flash" );
    var_0.light.angles = var_0 gettagorigin( "tag_flash" );
    var_0.light _meth_804D( var_0, "tag_flash", ( 3, 0, 0 ), ( 90, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "spotlight_chopper" ), var_0.light, "tag_origin" );
    var_0 thread maps\_shg_design_tools::stopfxonnotify( common_scripts\utility::getfx( "spotlight_chopper" ), var_0.light, "tag_origin", "death" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_patrol1_spawn" );
    common_scripts\utility::flag_set( "sd_intersection_chopper_wait" );
}

sd_intersection2_smoke_and_spawn()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_sd_intersection2_reinforce" );
    var_0 = getent( "sd_int2_smoke_nade_source1", "targetname" );
    var_1 = getentarray( "sd_int2_smoke_nade_targets", "script_noteworthy" );
    wait 1.5;
    thread sd_spawn_and_retreat_goals( undefined, "enemy_sd_intersection2_upstairs", undefined, "sd_goal_intersection2_upstairs", undefined, undefined, undefined );
    var_2 = [];
    wait 0.5;
    wait 0.5;
    maps\_utility::autosave_by_name();
    wait 1;
    var_0 = getent( "sd_int2_smoke_nade_source2", "targetname" );
    var_3 = getentarray( "sd_int2_smoke_nade_targets2", "script_noteworthy" );
    soundscripts\_snd::snd_music_message( "mus_sd_firefight_ending" );
}

sd_shop_logo_control()
{
    var_0 = getglass( "sd_glass_sign1" );
    var_1 = getent( "sd_glass_sign1_1", "targetname" );

    while ( isglassdestroyed( var_0 ) == 0 && isdefined( var_0 ) )
        waitframe();

    var_1 delete();
}

sd_glass_projection_setup()
{
    var_0 = getglassarray( "glass_with_petals" );
    var_1 = getentarray( "petals_brush", "script_noteworthy" );

    foreach ( var_3 in var_0 )
    {
        var_4 = common_scripts\utility::getclosest( getglassorigin( var_3 ), var_1, 400 );
        thread sd_glass_projection_think( var_4, var_3 );
    }
}

sd_glass_projection_think( var_0, var_1 )
{
    while ( !isglassdestroyed( var_1 ) )
        waitframe();

    if ( isdefined( var_0 ) )
        var_0 delete();
}

sd_smoke_laser_ambush()
{
    common_scripts\utility::flag_wait( "sd_spawn_drone_swarm_for_evade" );
    common_scripts\utility::flag_set( "vo_sd_demo_team_call" );
    common_scripts\utility::flag_wait( "sd_trigger_final_combat" );
    thread handle_drone_smoke();
    level waittill( "smoke_thrown_sd" );
    thread handle_enemy_ambush_smoke_laser_sd();
    level.will_irons maps\_utility::enable_careful();
    level.cormack maps\_utility::enable_careful();
    level.jackson maps\_utility::enable_careful();
    maps\_utility::autosave_by_name();
}

sd_flee_drone_swarm()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_drone_evade" );
    common_scripts\utility::flag_set( "vo_sd_demo_team_call" );
    wait 0.5;
    var_0 = common_scripts\utility::getstructarray( "sd_snake_swarm_enter", "script_noteworthy" );
    var_1 = common_scripts\utility::getstructarray( "sd_snake_swarm_window_path1", "script_noteworthy" );
    var_2 = common_scripts\utility::getstructarray( "sd_snake_swarm_attack_path2", "script_noteworthy" );
    var_3 = common_scripts\utility::getstructarray( "sd_snake_swarm_attack_path3", "script_noteworthy" );

    foreach ( var_5 in var_0 )
        var_5.speed = 18;

    foreach ( var_5 in var_2 )
        var_5.speed = 18;

    foreach ( var_5 in var_3 )
        var_5.speed = 20;

    foreach ( var_5 in var_1 )
        var_5.speed = 25;

    var_13 = getent( "sd_drone_queen1", "targetname" );
    var_14 = getent( "sd_drone_queen2", "targetname" );
    var_15 = [ var_13, var_14 ];

    if ( level.nextgen )
    {
        var_16 = 24;
        var_17 = 10;
    }
    else
    {
        var_16 = 8;
        var_17 = 6;
    }

    level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "sd_drone_queen1", undefined, var_16, var_17 );
    common_scripts\utility::flag_wait( "sd_trigger_drone_evade" );
    maps\_utility::autosave_by_name();
    level.will_irons.ignoreall = 1;
    level.cormack.ignoreall = 1;
    level.jackson.ignoreall = 1;
    maps\_utility::battlechatter_off( "allies" );

    foreach ( var_19 in level.snake_cloud.snakes )
    {
        var_20 = var_19.flock.boid_settings;
        var_20.max_accel = 6400;
        var_20.magnet_factor = 20;
    }

    var_22 = getent( "queen_drone_cloud_evade", "targetname" );
    wait 2;
    common_scripts\utility::flag_wait( "sd_snake_swarm_entered" );
    thread maps\_shg_design_tools::trigger_to_notify( "trig_updstairs_window_retreat" );
    level.snake_cloud thread vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "sd_snake_swarm_window_path1", undefined, 3 );

    foreach ( var_19 in level.snake_cloud.snakes )
    {
        var_20 = var_19.flock.boid_settings;
        var_20.max_accel = 6400;
        var_20.magnet_factor = 30;
    }

    level.snake_cloud canal_drone_swarm_think();
}

handle_enemy_ambush_smoke_laser_sd()
{
    var_0 = getnodearray( "node_smoke_laser_ambush_sd", "targetname" );
    var_1 = getentarray( "enemy_laser_smoke_ambush_sd", "targetname" );
    var_2 = [];

    foreach ( var_6, var_4 in var_1 )
    {
        var_5 = var_4 maps\_shg_design_tools::actual_spawn( 1 );
        var_5 set_laser_ambush_stats( var_0[var_6] );
        var_2[var_2.size] = var_5;
    }

    while ( var_2.size > 2 )
    {
        var_2 = maps\_utility::array_removedead_or_dying( var_2 );
        waitframe();
    }

    maps\_utility::activate_trigger_with_targetname( "trigger_allies_to_swarm_evade_stairs" );
    wait 3;

    foreach ( var_5 in var_2 )
    {
        if ( isdefined( var_5 ) )
            var_5 _meth_8052();

        wait(randomfloat( 3.0 ));
    }
}

set_laser_ambush_stats( var_0 )
{
    maps\_utility::enable_cqbwalk();
    self.goalradius = 196;
    self.grenadeammo = 0;
    thread maps\_utility::disable_long_death();

    if ( common_scripts\utility::cointoss() )
        thread maps\seoul_code_gangnam::forcelaser();

    if ( isdefined( var_0 ) )
        self _meth_81A5( var_0 );
}

handle_drone_smoke()
{
    var_0 = get_smoke_pair( 1 );
    var_1 = get_smoke_pair( 2 );
    var_2 = get_smoke_pair( 3 );
    var_3 = get_smoke_pair( 4 );
    var_4 = get_smoke_pair( 5 );
    _func_070( "smoke_grenade_cheap", var_2[1].origin, var_2[1].origin + ( 0, 0, 300 ), 1, 0 );
    soundscripts\_snd::snd_message( "seo_smoke_grenade_ambush", var_2[1].origin + ( 0, 0, 300 ), 1 );
    wait 0.5;
    level notify( "smoke_thrown_sd" );
    _func_070( "smoke_grenade_cheap", var_1[1].origin, var_1[1].origin + ( 0, 0, 300 ), 1, 0 );
    soundscripts\_snd::snd_message( "seo_smoke_grenade_ambush", var_1[1].origin + ( 0, 0, 300 ), 1 );
    wait 1;
}

get_smoke_pair( var_0 )
{
    var_1 = "struct_drone_smoke_0" + var_0 + "a";
    var_2 = "struct_drone_smoke_0" + var_0 + "b";
    var_3 = [];
    var_3[0] = common_scripts\utility::getstruct( var_1, "targetname" );
    var_3[1] = common_scripts\utility::getstruct( var_2, "targetname" );
    return var_3;
}

sd_handle_glass_smash()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_shopping" ) )
        level waittill( "transients_subway_to_shopping_dist" );

    var_0 = getentarray( "brush_glass_smash_drone", "targetname" );
    var_1 = getentarray( "brush_panel", "targetname" );
    common_scripts\utility::array_call( var_0, ::hide );

    foreach ( var_3 in var_1 )
    {
        var_3.panel_state = "still";
        var_3.panel_smashed = getent( var_3.target, "targetname" );
        var_3.panel_smashed _meth_804D( var_3 );
        var_3.panel_smashed hide();
        var_3.panel_smashed.state = "notsmashed";
    }

    for (;;)
    {
        level waittill( "drone_kamikaze_crash", var_5 );
        var_6 = randomint( 3 );
        var_0 = common_scripts\utility::array_removeundefined( var_0 );
        var_0 = maps\_shg_design_tools::sortbydistanceauto( var_0, var_5 );
        var_1 = maps\_shg_design_tools::sortbydistanceauto( var_1, var_5 );
        var_7 = maps\_shg_design_tools::sortbydistanceauto( var_1, var_5 );

        for ( var_8 = 0; var_8 < var_6; var_8++ )
        {
            if ( isdefined( var_0[var_8] ) && distance( var_0[var_8].origin, var_5 ) < 100 )
            {
                if ( !isdefined( var_0[var_8].smashed ) || var_0[var_8].smashed != 1 )
                {
                    var_0[var_8] show();
                    soundscripts\_snd::snd_message( "shopping_district_glass_smashed", var_0[var_8].origin );
                    var_0[var_8].smashed = 1;
                }
                else
                    soundscripts\_snd::snd_message( "shopping_district_glass_hit_after_smashed", var_0[var_8].origin );
            }

            if ( distance( var_1[var_8].origin, var_5 ) < 100 )
                var_1[var_8] thread sd_panel_impact();
        }
    }
}

sd_panel_impact()
{
    if ( self.panel_state == "still" )
    {
        self.panel_state = "moving";
        var_0 = 0.2;

        if ( self.panel_smashed.state == "notsmashed" )
        {
            soundscripts\_snd::snd_message( "shopping_district_panel_smashed", self.origin );
            self.panel_smashed.state = "smashed";
        }

        self.panel_smashed show();
        soundscripts\_snd::snd_message( "shopping_district_panel_swing", self.origin );
        self.original_angles = self.angles;
        self _meth_83DF( ( 0, randomfloatrange( 5, 10 ), 0 ), var_0, 0, 0.1 );
        wait(var_0);
        self _meth_83DF( ( 0, -1 * randomfloatrange( 5, 10 ), 0 ), var_0, 0, 0.1 );
        wait(var_0);
        self _meth_82B5( self.original_angles, var_0, 0, 0.1 );
        wait(var_0);
        self.panel_state = "still";
    }
}

sd_drone_kamikaze( var_0, var_1 )
{
    level endon( "end_kamikaze_newstyle" );

    for (;;)
    {
        var_2 = maps\_shg_design_tools::sortbydistanceauto( level.flock_drones, level.player.origin );
        var_3 = randomint( 2 );

        for ( var_4 = 0; var_4 < var_3; var_4++ )
        {
            if ( !isdefined( var_2[var_4] ) || isdefined( var_2[var_4].attacking_player ) )
                continue;

            var_2[var_4] thread vehicle_scripts\_attack_drone::drone_kamikaze_player( var_1, var_0 );
            var_2[var_4].attacking_player = 1;

            if ( level.player _meth_80A9( var_0 ) )
            {
                wait(randomfloatrange( 0.1, 0.2 ));
                continue;
            }

            wait(randomfloatrange( 0.25, 0.5 ));
        }

        wait 0.5;
    }
}

sd_snake_crash_into_player( var_0 )
{
    level endon( "end_crash_into_player" );

    for (;;)
    {
        foreach ( var_2 in level.snakes )
        {
            if ( isdefined( var_2 ) )
            {
                while ( distance( var_2.origin, level.player _meth_80A8() ) < 300 )
                {
                    vehicle_scripts\_attack_drone::force_kamikaze( common_scripts\utility::random( var_0 ) );
                    wait(randomfloatrange( 0.3, 0.75 ));
                }
            }
        }

        waitframe();
    }
}

canal_setup_pt1()
{
    thread canal_handle_car_door_shields_vis();
    thread canal_weapon_platform_vis_control();
    common_scripts\utility::flag_wait( "sd_street_combat_complete" );

    if ( level.currentgen )
    {
        var_0 = [ "enemy_canal_bridge1" ];
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "dialogue_performing_arts_exit", var_0, 15, 0 );
    }

    if ( level.currentgen && !issubstr( level.transient_zone, "_overlookbar" ) )
        level waittill( "transients_canal_overlook_to_riverwalk" );

    thread canal_bridge_patrols_spawn();
    thread canal_weapon_guards_spawn_and_think();
    level.will_irons.ignoreall = 1;
    level.cormack.ignoreall = 1;
    level.jackson.ignoreall = 1;
    maps\_utility::battlechatter_off( "allies" );
    thread canal_balcony_smoke_and_spawn();
    thread sd_spawn_and_retreat_goals( "trig_canal_bridge_reinforcements1", "canal_bridge_reinforcements1", 1 );
    thread sd_spawn_and_retreat_goals( "trig_canal_bridge_reinforcements2", "canal_bridge_reinforcements2", 1 );
    thread canal_setup_dead_demo_team();
    var_1 = getent( "enemy_sd_vehicle1", "targetname" );
    var_2 = getent( "enemy_sd_vehicle3", "targetname" );
    var_3 = getentarray( "zipline_cables", "script_noteworthy" );

    if ( isdefined( var_3 ) )
    {
        foreach ( var_5 in var_3 )
            var_5 hide();
    }

    var_7 = getentarray( "color_ents_pt2", "script_noteworthy" );
    common_scripts\utility::array_thread( var_7, common_scripts\utility::trigger_off );
}

snd_final_music_think()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_reach_waterfall" );
    soundscripts\_snd::snd_music_message( "mus_canal_combat_done" );
}

canal_handle_car_door_shields_vis()
{
    var_0 = getentarray( "canal_door_shields", "script_noteworthy" );
    common_scripts\utility::array_thread( var_0, maps\_utility::hide_entity );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_dead_demo_team1" );
    common_scripts\utility::array_thread( var_0, maps\_utility::show_entity );
    var_1 = getentarray( "trig_door_shield", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 thread canal_door_button_hint_display();
}

canal_door_button_hint_display()
{
    var_0 = maps\_shg_utility::hint_button_trigger( "x" );
    self waittill( "trigger" );

    if ( isdefined( var_0 ) )
        var_0 maps\_shg_utility::hint_button_clear();
}

canal_turret_vehicle()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_riverwalk" ) )
        level waittill( "transients_canal_overlook_to_riverwalk" );

    var_0 = getentarray( "canal_vehicle2_passengers", "script_noteworthy" );
    maps\_utility::array_spawn_function_noteworthy( "canal_vehicle2_passengers", ::canal_turret_vehicle_passenger_think );
    var_1 = getent( "enemy_sd_vehicle2", "targetname" );
    level.controllable_drone_swarm_target[1] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "enemy_sd_vehicle2" );

    foreach ( var_3 in level.controllable_drone_swarm_target[1].riders )
    {
        if ( var_3.vehicle_position == 3 )
            var_4 = var_3;
    }

    level.controllable_drone_swarm_target[1] waittill( "reached_end_node" );
    level.controllable_drone_swarm_target[1] maps\_vehicle::vehicle_unload( "all_but_gunner" );
}

canal_turret_vehicle_passenger_think()
{
    self.ignoreall = 1;
    self.grenadeammo = 0;

    if ( !isdefined( level.bridge_enemies ) )
        level.bridge_enemies = [];

    level.bridge_enemies[level.bridge_enemies.size] = self;
}

canal_cormack_objective_convo()
{
    common_scripts\utility::flag_wait( "sd_escaped_swarm" );
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_set( "objective_canal_stairs_bottom_reached" );
    level.player.show_land_assist_help = 0;
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_reach_upstairs" );
    common_scripts\utility::flag_set( "show_canal_weapon_platform" );
    common_scripts\utility::flag_set( "objective_canal_stairs_top_reached" );
    level.will_irons maps\_utility::enable_cqbwalk();
    level.cormack maps\_utility::enable_cqbwalk();
    level.jackson maps\_utility::enable_cqbwalk();
    common_scripts\utility::flag_set( "vo_canal_call_to_window" );
    common_scripts\utility::flag_set( "canal_window_check_on" );
    var_0 = common_scripts\utility::getstruct( "canal_objective_convo", "targetname" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_2 = common_scripts\utility::getstruct( "struct_canal_upstairs_convo_will", "targetname" );
    var_3 = common_scripts\utility::getstruct( "struct_canal_upstairs_convo_jackson", "targetname" );
    var_1 thread canal_cormack_move_to_window();
    thread disable_weapons_in_canal_view_room();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_updstairs_window_approach" );
    common_scripts\utility::flag_set( "canal_start_drone_travel" );
    common_scripts\utility::flag_wait( "canal_reached_window" );
    common_scripts\utility::flag_set( "objective_sd_cormack_convo_complete" );
    common_scripts\utility::flag_set( "no_land_assist_hint" );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    maps\_player_exo::player_exo_deactivate();
    var_4 = maps\_utility::spawn_anim_model( "player_arms", level.player.origin, level.player.angle );
    var_5 = maps\_utility::spawn_anim_model( "binocs" );
    var_6 = [ var_4, var_5 ];
    var_1 maps\_anim::anim_first_frame( var_6, "seo_canal_debrief_scanning_intro_vm" );
    var_4 hide();
    soundscripts\_snd::snd_message( "seo_binocs_equip" );
    var_5 hide();
    var_7 = 0.3;
    level.player _meth_8080( var_4, "tag_player", var_7 );
    var_4 common_scripts\utility::delaycall( var_7, ::show );
    var_5 common_scripts\utility::delaycall( var_7, ::show );
    level.player common_scripts\utility::delaycall( var_7, ::_meth_807F, var_4, "tag_player" );
    var_1 thread maps\_anim::anim_single( var_6, "seo_canal_debrief_scanning_intro_vm" );
    var_8 = maps\_utility::getanim_from_animname( "seo_canal_debrief_scanning_intro_vm", var_4.animname );
    var_9 = getanimlength( var_8 );
    var_1 canal_handle_player_binoc_controls( var_4, var_9 );
    var_10 = common_scripts\utility::getstruct( "struct_start_canal2_jackson", "targetname" );
    level.will_irons _meth_81C6( var_10.origin, var_10.angles );
    level.will_irons.ignoreall = 0;
    level.will_irons.canjumppath = 1;
    var_11 = getnode( "canal_will_cover1", "targetname" );
    level.will_irons maps\_utility::set_goal_radius( 15 );
    level.will_irons maps\_utility::set_goal_node( var_11 );
    level.player _meth_804F();
    level.player _meth_8031( 65, 0 );
    var_1 notify( "stop_loop" );
    var_1 maps\_utility::anim_stopanimscripted();
    level.player _meth_8080( var_4, "tag_player", 0.3 );
    var_1 maps\_anim::anim_single( var_6, "seo_canal_debrief_scanning_outro_vm" );
    common_scripts\utility::flag_wait( "demo_team_seen" );
    common_scripts\utility::flag_set( "canal_strategy_scene_complete" );
    common_scripts\utility::flag_clear( "no_land_assist_hint" );
    level.player notify( "canal_intro_scene_done" );
    var_2 notify( "convo_complete" );
    var_3 notify( "convo_complete" );
    var_1 notify( "stop_loop" );
    level.cormack maps\_utility::anim_stopanimscripted();
    level.cormack.loopanims = [];
    level.cormack.loops = 0;
    level.cormack _meth_81A6( level.cormack.origin );
    level.cormack.goalradius = 512;
    level.player _meth_804F();
    var_4 delete();
    var_5 delete();
    level.player _meth_8031( 65, 0.5 );
    maps\_utility::autosave_now();
}

disable_weapons_in_canal_view_room()
{
    level.player endon( "canal_intro_scene_done" );

    for (;;)
    {
        maps\_shg_design_tools::waittill_trigger_with_name( "trig_updstairs_window_approach" );
        level.player _meth_8130( 0 );
        level.player _meth_831D();
        level.player _meth_831F();
        maps\_shg_design_tools::waittill_trigger_with_name( "trig_updstairs_window_retreat" );
        level.player _meth_8130( 1 );
        level.player _meth_831E();
        level.player _meth_8320();
    }
}

canal_cormack_move_to_window()
{
    thread maps\_anim::anim_reach_solo( level.cormack, "seo_canal_debrief_intro_cormack", undefined, 1 );
    var_0 = level.cormack common_scripts\utility::waittill_any_return( "anim_reach_complete", "override_anim_reach_play_binoc_scene" );
    var_1 = [ "seo_crk_overheremitchell", "seo_crk_mitchellmoveit" ];
    thread maps\_shg_utility::dialogue_reminder( level.cormack, "canal_reached_window", var_1 );

    if ( var_0 == "override_anim_reach_play_binoc_scene" )
        maps\_anim::anim_first_frame_solo( level.cormack, "seo_canal_debrief_intro_cormack" );

    maps\_anim::anim_single_solo( level.cormack, "seo_canal_debrief_intro_cormack" );
    maps\_anim::anim_loop_solo( level.cormack, "seo_canal_debrief_kneeling_idle_cormack" );
}

canal_handle_player_binoc_controls( var_0, var_1 )
{
    wait(var_1 - 0.8);
    thread canal_binoc_transition_in();
    thread maps\seoul_lighting::binocular_mwp_rim_flicker();
    thread maps\seoul_lighting::binocular_dof();
    thread maps\seoul_lighting::binocular_vision();
    wait 0.6;
    thread maps\_anim::anim_loop_solo( var_0, "seo_canal_debrief_scanning_start_loop_vm" );
    level.cormack notify( "override_anim_reach_play_binoc_scene" );
    wait 1;
    common_scripts\utility::flag_set( "vo_canal_strategy_scene" );
    wait 0.5;
    self notify( "stop_loop" );
    var_0 maps\_utility::anim_stopanimscripted();
    self _meth_8141();
    thread maps\_anim::anim_loop_solo( var_0, "seo_canal_debrief_scanning_platform_loop_vm" );
    thread canal_convo_fov_shift_to_wp();
    common_scripts\utility::flag_wait( "vo_havoc_launcher_line_done" );
    self notify( "stop_loop" );
    var_0 maps\_utility::anim_stopanimscripted();
    self _meth_8141();
    thread canal_convo_fov_shift_to_dead();
    maps\_anim::anim_single_solo( var_0, "seo_canal_debrief_scanning_platform_to_demoteam_vm" );
    thread canal_highlight_dead_team();
    wait 0.5;
    self notify( "stop_loop" );
    var_0 maps\_utility::anim_stopanimscripted();
    self _meth_8141();
    thread maps\_anim::anim_loop_solo( var_0, "seo_canal_debrief_scanning_demoteam_loop_vm" );
    common_scripts\utility::flag_wait( "vo_demo_team_lines_done" );
    level.player _meth_8031( 45, 0.5 );
    var_2 = level.player common_scripts\utility::spawn_tag_origin();
    level.player _meth_804F();
    level.player _meth_807D( var_0, "tag_player", 1, 25, 60, 30, 25 );
    thread canal_adssetfovzoomin();
    thread canal_binoc_hint();
    wait 1;
    common_scripts\utility::flag_wait( "demo_team_seen" );
    level notify( "end_fovzoom" );
    thread canal_binoc_transition_out();
    wait 0.5;
}

canal_binoc_transition_in()
{
    var_0 = 0.5;
    var_1 = newhudelem();
    var_1.x = 0;
    var_1.y = 0;
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1 _meth_80CC( "black", 640, 480 );
    var_2 = newhudelem();
    var_2.x = 0;
    var_2.y = 0;
    var_2.horzalign = "fullscreen";
    var_2.vertalign = "fullscreen";
    var_2 _meth_80CC( "white", 640, 480 );
    level.binoc_overlay[1] = newhudelem();
    level.binoc_overlay[1].x = 0;
    level.binoc_overlay[1].y = 0;
    level.binoc_overlay[1].horzalign = "fullscreen";
    level.binoc_overlay[1].vertalign = "fullscreen";
    level.binoc_overlay[1] _meth_80CC( "ugv_vignette_overlay", 640, 480 );

    if ( isdefined( var_0 ) && var_0 > 0 )
    {
        level.binoc_overlay[1].alpha = 0;
        var_2.alpha = 0;
        var_1.alpha = 0;
        var_1 fadeovertime( var_0 );
        var_1.alpha = 1;
        wait(var_0);
        thread canal_convo_fov_shift_on_start();
        var_2.alpha = 0;
        var_2 fadeovertime( 0.5 );
        var_2.alpha = 1;
        wait(var_0);
        var_1.alpha = 0;
        level.binoc_overlay[1].alpha = 1;
        var_2.alpha = 1;
        var_2 fadeovertime( var_0 + 0.5 );
        var_2.alpha = 0;
        wait(var_0 + 0.5);
    }

    var_2 destroy();
    var_1 destroy();
}

canal_binoc_transition_out()
{
    var_0 = 0.5;
    var_1 = newhudelem();
    var_1.x = 0;
    var_1.y = 0;
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1 _meth_80CC( "black", 640, 480 );

    if ( isdefined( var_0 ) && var_0 > 0 )
    {
        var_1.alpha = 0;
        var_1 fadeovertime( var_0 );
        var_1.alpha = 1;
        soundscripts\_snd::snd_message( "binocs_put_away" );
        wait(var_0);
        level.binoc_overlay[1] destroy();
        var_1.alpha = 1;
        var_1 fadeovertime( var_0 );
        var_1.alpha = 0;
        wait(var_0);
    }

    var_1 destroy();
}

handle_enemy_highlighting_in_binocs()
{
    level endon( "end_fovzoom" );
    var_0 = getentarray( "ammo_cache", "targetname" );
    var_1 = getentarray( "smart_grenade_launcher", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );

    for (;;)
    {
        var_2 = _func_0D6( "axis" );

        foreach ( var_4 in var_2 )
        {
            if ( !isdefined( var_4.running_handle_hud_outline_binocs ) )
            {
                var_4.running_handle_hud_outline_binocs = 1;
                var_4 thread handle_hud_outline_binocs();
                var_4 thread remove_hud_outline_binocs();
            }
        }

        foreach ( var_7 in var_0 )
        {
            if ( !isdefined( var_7.running_handle_hud_outline_binocs ) )
            {
                var_7.running_handle_hud_outline_binocs = 1;
                var_7 thread handle_hud_outline_binocs( 6 );
                var_7 thread remove_hud_outline_binocs();
            }
        }

        wait 0.1;
    }
}

remove_hud_outline_binocs()
{
    level waittill( "end_fovzoom" );

    if ( isdefined( self ) )
    {
        self _meth_83FB();
        self.running_handle_hud_outline_binocs = undefined;
    }
}

handle_hud_outline_binocs( var_0 )
{
    level endon( "end_fovzoom" );
    level.player.current_fov = 65;

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    for (;;)
    {
        if ( maps\_shg_utility::entity_is_in_circle( self, level.player, level.player.current_fov, 115 ) )
            self _meth_83FA( var_0, 1 );
        else
            self _meth_83FB();

        wait 0.1;
    }
}

canal_adssetfovzoomin()
{
    level endon( "end_fovzoom" );
    thread handle_enemy_highlighting_in_binocs();
    var_0 = 65;
    var_1 = 5;
    var_2 = 10;
    var_3 = 3;
    var_4 = 0.05;
    var_5 = 0;

    while ( !common_scripts\utility::flag( "canal_strategy_scene_complete" ) )
    {
        waitframe();
        var_6 = level.player _meth_82F3();

        if ( var_6[0] > 0.2 && var_2 - var_3 > var_1 )
        {
            var_2 -= var_3;
            var_4 = 0.05;

            if ( var_5 != 1 )
            {
                soundscripts\_snd::snd_message( "canal_binocs_stop_zoom_out" );
                soundscripts\_snd::snd_message( "canal_binocs_zoom_in" );
                var_5 = 1;
            }
        }
        else if ( var_6[0] < -0.2 && var_2 + var_3 < var_0 )
        {
            var_2 += var_3;
            var_4 = 0.05;

            if ( var_5 != -1 )
            {
                soundscripts\_snd::snd_message( "canal_binocs_stop_zoom_in" );
                soundscripts\_snd::snd_message( "canal_binocs_zoom_out" );
                var_5 = -1;
            }
        }
        else if ( var_6[0] == 0 && var_2 + var_3 < var_0 )
            waitframe();
        else if ( var_5 != 0 )
        {
            soundscripts\_snd::snd_message( "canal_binocs_stop_zoom_in" );
            soundscripts\_snd::snd_message( "canal_binocs_stop_zoom_out" );
            var_5 = 0;
        }

        level.player.current_fov = var_2;
        level.player thread maps\_utility::lerp_fov_overtime( var_4, var_2 );
    }
}

binoc_hint_breakout()
{
    if ( length( level.player _meth_830D() ) > 0.1 )
        level.player.binocdidpan = 1;

    if ( length( level.player _meth_82F3() ) > 0.1 )
        level.player.binocdidzoom = 1;

    if ( isdefined( level.player.binocdidzoom ) && isdefined( level.player.binocdidpan ) )
        return 1;

    return 0;
}

canal_binoc_hint()
{
    level endon( "end_fovzoom" );
    maps\_utility::hintdisplayhandler( "binoc_controls", 4 );
}

canal_highlight_dead_team()
{
    foreach ( var_1 in level.dead_demo_team )
    {
        if ( isdefined( var_1 ) )
            var_1 _meth_83FA( 4, 1 );

        wait 0.1;
    }

    common_scripts\utility::flag_wait( "demo_team_seen" );

    foreach ( var_1 in level.dead_demo_team )
    {
        if ( isdefined( var_1 ) )
            var_1 _meth_83FB();
    }
}

canal_convo_fov_shift_on_start( var_0 )
{
    var_1 = 45;
    level.player _meth_8031( 45, 0.5 );
}

canal_convo_fov_shift_to_wp( var_0 )
{
    var_1 = 35;
    level.player _meth_8031( 45, 0.5 );
    wait 0.5;
    soundscripts\_snd::snd_message( "canal_binocs_zoom_in" );
    level.player _meth_8031( 20, 0.5 );
    wait 0.5;
    soundscripts\_snd::snd_message( "canal_binocs_stop_zoom_in" );
    level.player _meth_8031( 25, 0.5 );
    soundscripts\_snd::snd_message( "canal_binocs_zoom_out" );
    wait 0.5;
    soundscripts\_snd::snd_message( "canal_binocs_stop_zoom_out" );
}

canal_convo_fov_shift_to_dead( var_0 )
{
    var_1 = 25;
    soundscripts\_snd::snd_message( "canal_binocs_zoom_out" );
    level.player _meth_8031( 45, 0.5 );
    wait 0.5;
    soundscripts\_snd::snd_message( "canal_binocs_stop_zoom_out" );
    wait 0.5;
    soundscripts\_snd::snd_message( "canal_binocs_zoom_in" );
    level.player _meth_8031( 15, 1 );
    wait 1;
    soundscripts\_snd::snd_message( "canal_binocs_stop_zoom_in" );
    soundscripts\_snd::snd_message( "canal_binocs_zoom_out" );
    level.player _meth_8031( 20, 0.5 );
    wait 0.5;
    soundscripts\_snd::snd_message( "canal_binocs_stop_zoom_out" );
    wait 0.5;
    soundscripts\_snd::snd_message( "canal_binocs_zoom_in" );
    level.player _meth_8031( 10, 1 );
    wait 1;
    soundscripts\_snd::snd_message( "canal_binocs_stop_zoom_in" );
}

canal_convo_fov_shift_off( var_0 )
{
    if ( !isdefined( level.origfov ) )
        level.origfov = 65;

    level.player _meth_8031( level.origfov, 0.5 );
}

canal_video_board_cycle()
{
    for ( var_0 = 0; !common_scripts\utility::flag( "shut_down_panel" ); var_0 = 0 )
    {
        panel_on();
        wait(randomfloatrange( 1, 3 ));

        while ( var_0 < randomintrange( 3, 6 ) )
        {
            panel_off();
            wait(randomfloatrange( 0.05, 0.1 ));
            panel_on();
            wait(randomfloatrange( 0.5, 1.5 ));
            var_0++;
        }
    }

    panel_off();
    wait(randomfloatrange( 0.1, 0.3 ));
    panel_on();
    wait 0.5;
    panel_off();
    wait(randomfloatrange( 0.1, 0.3 ));
    panel_on();
    wait 0.5;
    panel_off();
}

panel_off()
{
    if ( level.currentgen )
        level waittill( "transients_subway_to_shopping_dist" );

    var_0 = getent( "canal_vista_panel_on", "targetname" );
    var_1 = getent( "canal_vista_panel_off", "targetname" );
    var_1 show();
    var_0 hide();
}

panel_on()
{
    if ( level.currentgen )
        level waittill( "transients_subway_to_shopping_dist" );

    var_0 = getent( "canal_vista_panel_on", "targetname" );
    var_1 = getent( "canal_vista_panel_off", "targetname" );
    var_1 hide();
    var_0 show();
}

canal_bridge_patrols_spawn()
{
    while ( level.currentgen && !_func_21E( "seoul_canal_overlook_bar_tr" ) )
        wait 0.05;

    level.bridge_enemies = [];
    var_0 = 5;
    var_1 = getent( "sd_goal_bridge1", "targetname" );
    var_2 = getent( "sd_goal_bridge1_retreat", "targetname" );
    maps\_utility::array_spawn_function_noteworthy( "enemy_canal_bridge1", ::canal_bridge_patrol_think );
    var_3 = maps\_utility::array_spawn_noteworthy( "enemy_canal_bridge1", 1 );
    common_scripts\utility::flag_wait( "wakeup_canal_patrols" );
    level.bridge_enemies = maps\_utility::array_removedead_or_dying( level.bridge_enemies );

    foreach ( var_5 in level.bridge_enemies )
    {
        var_5.ignoreall = 0;
        var_5 notify( "end_patrol" );
        var_5 notify( "stop_going_to_node" );

        if ( isdefined( var_1 ) )
            var_5 _meth_81A9( var_1 );

        var_5.target = undefined;
        var_5 thread change_color_node_quick();
        var_5 maps\_utility::add_damage_function( ::canal_enemy_damage_function );
    }

    while ( level.bridge_enemies.size > var_0 )
    {
        level.bridge_enemies = maps\_utility::array_removedead_or_dying( level.bridge_enemies );
        wait 0.05;
    }

    if ( isdefined( var_2 ) )
    {
        level.bridge_enemies = maps\_utility::array_removedead_or_dying( level.bridge_enemies );

        foreach ( var_5 in level.bridge_enemies )
            var_5 _meth_81A9( var_2 );
    }
}

canal_enemy_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_1 == level.player )
        self notify( "notice_player" );

    if ( !common_scripts\utility::flag( "bombs_picked_up" ) )
    {
        if ( var_1 == level.cormack || var_1 == level.jackson )
        {
            if ( self.health > 0 )
                self.health += int( var_0 * 0.5 );
        }
    }
}

canal_bridge_patrol_think()
{
    self.ignoreall = 1;
    self.patrol_walk_twitch = undefined;
    self.patrol_walk_anim = undefined;
    self.grenadeammo = 0;
    level.bridge_enemies[level.bridge_enemies.size] = self;
    self.script_stealth = 1;
    thread maps\_patrol::patrol();
}

canal_weapon_guards_spawn_and_think()
{
    createthreatbiasgroup( "cormack_group" );
    createthreatbiasgroup( "weapon_platform_guards" );
    createthreatbiasgroup( "player_and_will" );
    level.player _meth_8177( "player_and_will" );
    level.will_irons _meth_8177( "player_and_will" );
    var_0 = maps\_utility::array_spawn_noteworthy( "enemy_canal_wall1L", 1 );
    var_1 = maps\_utility::array_spawn_noteworthy( "enemy_canal_wall1R", 1 );
    var_2 = common_scripts\utility::array_combine( var_0, var_1 );
    var_3 = getent( "sd_goal_wallL", "targetname" );
    var_4 = getent( "sd_goal_wallR", "targetname" );

    foreach ( var_6 in var_2 )
    {
        var_6.ignoreall = 1;
        var_6.patrol_walk_twitch = undefined;
        var_6.patrol_walk_anim = undefined;
        var_6.grenadeammo = 0;
        var_6.script_stealth = 1;
        var_6 thread maps\_patrol::patrol();
        var_6 thread change_color_node_quick();
        var_6 maps\_utility::add_damage_function( ::canal_enemy_damage_function );
        wait 0.05;
    }

    common_scripts\utility::flag_wait( "wakeup_canal_patrols" );

    foreach ( var_6 in var_2 )
    {
        var_6.ignoreall = 0;
        var_6 notify( "end_patrol" );
        var_6 notify( "stop_going_to_node" );
        var_6.target = undefined;
        var_6.grenadeammo = 0;
        var_6 _meth_8177( "weapon_platform_guards" );
    }

    level.cormack _meth_8177( "cormack_group" );
    level.jackson _meth_8177( "cormack_group" );
    setthreatbias( "cormack_group", "weapon_platform_guards", 10000 );
    setthreatbias( "weapon_platform_guards", "cormack_group", 10000 );

    foreach ( var_6 in var_0 )
    {
        var_6 _meth_81A9( var_3 );
        var_6 thread canal_wall_enemy_think();
    }

    foreach ( var_6 in var_1 )
    {
        var_6 _meth_81A9( var_4 );
        var_6 thread canal_wall_enemy_think();
    }

    common_scripts\utility::flag_wait( "bombs_picked_up" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_reach_waterfall" );
    var_14 = maps\_utility::array_removedead_or_dying( var_2 );

    foreach ( var_6 in var_2 )
    {
        if ( isalive( var_6 ) )
        {
            var_6 bloody_death();
            wait(randomfloatrange( 0.3, 0.5 ));
        }

        var_2 = maps\_utility::array_removedead_or_dying( var_2 );
    }
}

canal_wall_enemy_think()
{
    self endon( "death" );
    thread canal_wall_enemy_close_check();
    self waittill( "notice_player" );
    self _meth_8177( "axis" );
    self _meth_8165( level.player );
    self.favoriteenemy = level.player;
}

canal_wall_enemy_close_check()
{
    self endon( "death" );
    level endon( "notice_player" );
    level.player endon( "death" );

    while ( distancesquared( level.player.origin, self.origin ) > squared( 450 ) )
        wait 0.25;

    self notify( "notice_player" );
}

canal_drone_guard_sequence()
{
    level.enemy_canal_drone_guards = [];
    var_0 = getent( "enemy_canal_drone_controller", "targetname" );
    var_1 = getent( "enemy_canal_guard1", "targetname" );
    var_0 = var_0 maps\_utility::spawn_ai( 1 );
    var_1 = var_1 maps\_utility::spawn_ai( 1 );
    level.enemy_canal_drone_guards[level.enemy_canal_drone_guards.size] = var_0;
    level.enemy_canal_drone_guards[level.enemy_canal_drone_guards.size] = var_1;
    var_2 = getnode( "cover_prone_other_guy", "targetname" );
    var_3 = getnode( "cover_prone_cormack", "targetname" );
    var_2 _meth_8059();
    var_3 _meth_8059();

    foreach ( var_5 in level.enemy_canal_drone_guards )
        var_5 thread canal_drone_guard_think();

    while ( level.enemy_canal_drone_guards.size > 1 )
    {
        level.enemy_canal_drone_guards = maps\_utility::array_removedead_or_dying( level.enemy_canal_drone_guards );
        wait 0.05;
    }

    wait 1;

    foreach ( var_5 in level.enemy_canal_drone_guards )
    {
        var_5.ignoreall = 0;
        var_5 notify( "wakeup" );
        magicbullet( level.will_irons.weapon, level.will_irons gettagorigin( "tag_flash" ), var_5 _meth_80A8() );
    }

    var_9 = common_scripts\utility::getstruct( "sd_fake_shot_glass", "targetname" );
    magicbullet( level.jackson.weapon, level.jackson gettagorigin( "tag_flash" ), var_9.origin );

    while ( level.enemy_canal_drone_guards.size > 0 )
    {
        level.enemy_canal_drone_guards = maps\_utility::array_removedead_or_dying( level.enemy_canal_drone_guards );
        wait 0.05;
    }

    var_2 _meth_805A();
    var_3 _meth_805A();
}

canal_drone_guard_think()
{
    self.ignoreall = 1;
    self.grenadeammo = 0;
    self.allowdeath = 1;

    if ( level.gameskill <= 1 )
        self.health = 1;

    thread canal_drone_guards_move_to_struct_and_loop_animation();
    thread canal_guard_player_close_check();
    self _meth_8041( "grenade danger" );
    self _meth_8041( "gunshot" );
    self _meth_8041( "bulletwhizby" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "death" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "damage" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "ai_event" );
    maps\_utility::add_func( common_scripts\utility::flag_set, "wakeup_drone_guards" );
    thread maps\_utility::do_wait_any();
    common_scripts\utility::flag_wait( "wakeup_drone_guards" );
    self.ignoreall = 0;
    self _meth_8141();
    remove_patrol_anim_set();
    self _meth_8165( level.player );
    self notify( "stop_going_to_node" );
    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_0 notify( "wakeup_drone_guards" );
}

canal_guard_player_close_check()
{
    self endon( "death" );
    level endon( "wakeup_drone_guards" );
    level.player endon( "death" );

    while ( distancesquared( level.player.origin, self.origin ) > squared( 350 ) )
        wait 0.25;

    common_scripts\utility::flag_set( "wakeup_drone_guards" );
}

canal_drone_guards_move_to_struct_and_loop_animation()
{
    self endon( "death" );
    self endon( "wakeup_drone_guards" );
    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_0 maps\_anim::anim_generic_loop( self, var_0.animation, "wakeup_drone_guards" );
}

nag_lines_if_player_skips_charges()
{
    var_0 = getent( "trig_pick_up_charges", "targetname" );
    var_0 waittill( "trigger" );

    if ( common_scripts\utility::flag( "bombs_reached" ) )
        return;

    var_1 = [ "seo_wil_getthecharges", "seo_wil_grabthosecharges" ];
    thread maps\_shg_utility::dialogue_reminder( level, "bombs_reached", var_1 );
}

canal_fight_to_explosives_sequence()
{
    common_scripts\utility::flag_wait( "canal_strategy_scene_complete" );
    common_scripts\utility::flag_clear( "flag_autofocus_binoc_on" );
    thread remove_dropped_guns_near_explosives();
    thread nag_lines_if_player_skips_charges();
    level.will_irons.ignoreall = 0;
    level.will_irons.canjumppath = 1;
    level.cormack.ignoreall = 0;
    level.jackson.ignoreall = 0;
    level.cormack.ignoresuppression = 1;
    level.jackson.ignoresuppression = 1;
    level.will_irons maps\_utility::disable_cqbwalk();
    level.cormack maps\_utility::disable_cqbwalk();
    level.jackson maps\_utility::disable_cqbwalk();
    maps\_utility::battlechatter_on( "allies" );
    var_0 = common_scripts\utility::getstruct( "struct_canal_upstairs_convo_will", "targetname" );
    var_1 = common_scripts\utility::getstruct( "struct_canal_upstairs_convo_cormack", "targetname" );
    var_2 = common_scripts\utility::getstruct( "struct_canal_upstairs_convo_jackson", "targetname" );
    var_0 notify( "convo_complete" );
    var_1 notify( "convo_complete" );
    var_2 notify( "convo_complete" );
    var_3 = getent( "canal_window_blocker", "targetname" );
    var_3 _meth_8058();
    var_3 delete();
    level.player.show_land_assist_help = 1;

    if ( !isdefined( level.player_repulsor ) )
        level.player_repulsor = missile_createrepulsorent( level.player, 10000, 500 );

    var_4 = getnode( "canal_will_cover1", "targetname" );
    level.will_irons maps\_utility::set_goal_radius( 15 );
    level.will_irons maps\_utility::set_goal_node( var_4 );
    var_5 = getnode( "cover_prone_cormack", "targetname" );
    var_6 = getnode( "cover_prone_other_guy", "targetname" );
    level.cormack maps\_utility::set_goal_radius( 15 );
    level.jackson maps\_utility::set_goal_radius( 15 );
    level.cormack maps\_utility::set_goal_node( var_5 );
    level.jackson maps\_utility::set_goal_node( var_6 );
    wait 0.5;
    level.player maps\_shg_utility::setup_player_for_gameplay();
    maps\_player_exo::player_exo_activate();
    wait 3;
    common_scripts\utility::flag_set( "wakeup_canal_patrols" );
    common_scripts\utility::flag_wait( "canal_jump_complete" );
    wait 2.5;
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_wait( "bombs_reached" );
    common_scripts\utility::flag_set( "vo_canal_grab_explosives" );
    var_7 = [ "seo_wil_getthecharges", "seo_wil_grabthosecharges" ];
    thread maps\_shg_utility::dialogue_reminder( level.will_irons, "bombs_picked_up", var_7 );
    common_scripts\utility::flag_wait( "bombs_picked_up" );
    common_scripts\utility::flag_set( "objective_sd_pick_up_bombs" );
    common_scripts\utility::flag_set( "spawn_canal_razorback" );
}

remove_dropped_guns_near_explosives()
{
    var_0 = getentarray( "vol_dropped_gun_check_volume", "targetname" );

    for (;;)
    {
        foreach ( var_2 in var_0 )
        {
            var_3 = getweaponarray();

            foreach ( var_5 in var_3 )
            {
                if ( var_5 _meth_80A9( var_2 ) )
                    var_5 delete();
            }
        }

        wait 0.25;
    }
}

canal_turn_player()
{
    var_0 = spawnstruct();
    var_0.origin = level.player.origin;
}

canal_laser()
{
    self _meth_80B2( "lag_snipper_laser" );
}

canal_balcony_smoke_and_spawn()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_bridge_reinforcements1" );
    var_0 = getent( "canal_balcony_smoke_start", "targetname" );
    var_1 = getent( "canal_balcony_smoke_target1", "targetname" );
    var_2 = getent( "canal_balcony_smoke_target2", "targetname" );
    _func_070( "smoke_grenade_cheap", var_0.origin, var_0.origin, 0.5, 0 );
    _func_070( "smoke_grenade_cheap", var_1.origin, var_1.origin, 1, 0 );
    _func_070( "smoke_grenade_cheap", var_2.origin, var_2.origin, 1, 0 );
    wait 1.5;
    var_3 = getent( "canal_zip_smoke_start2", "targetname" );
    var_4 = getent( "canal_zip_smoke_target1", "targetname" );
    var_5 = getent( "canal_zip_smoke_target2", "targetname" );
    wait 0.3;
    wait 1.5;
    var_6 = [];
    var_6[var_6.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_bridge_balcony_zipline1", "canal_zipline_bridge2_start1" );
    wait 0.5;
    var_6[var_6.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_bridge_balcony_zipline1", "canal_zipline_bridge2_start2" );
    wait 0.5;
    var_6[var_6.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_bridge_balcony_zipline1", "canal_zipline_bridge2_start3" );
    wait 0.5;
    thread sd_zipline_enemy_think( var_6 );
    var_7 = getent( "canal_bridge_balcony_rpg", "script_noteworthy" );

    for ( var_8 = 0; var_8 < 1; var_8++ )
    {
        var_9 = var_7 maps\_shg_design_tools::actual_spawn( 1 );
        var_9.grenadeammo = 0;
        var_9 maps\_utility::add_damage_function( ::canal_enemy_damage_function );
    }
}

canal_setup_dead_demo_team()
{
    var_0 = getent( "trig_canal_dead_demo_team1", "targetname" );
    var_1 = getent( "trig_canal_dead_demo_team2", "targetname" );
    var_2 = getent( "trig_canal_dead_demo_team3", "targetname" );
    var_3 = getent( "trig_canal_dead_demo_team4", "targetname" );
    level.dead_demo_team = [];
    thread canal_spawn_dead_demo_team( var_0, var_1 );
    thread canal_spawn_dead_demo_team( var_3, var_2 );
    thread canal_delete_dead_demo_team( var_1, var_0 );
    thread canal_delete_dead_demo_team( var_2, var_3 );
}

canal_handle_dead_demo_team()
{
    var_0 = getent( "canal_dead_demo_team1", "targetname" );
    var_1 = getent( "canal_dead_demo_team2", "targetname" );
    var_2 = getent( "canal_dead_demo_team3", "targetname" );
    var_3 = getent( "canal_dead_demo_team4", "targetname" );
    var_4 = getent( "canal_dead_demo_team5", "targetname" );
    var_5 = getent( "canal_origin_dead_demo_team", "targetname" );

    if ( level.nextgen )
    {
        var_6 = maps\_utility::dronespawn_bodyonly( var_0 );
        var_7 = maps\_utility::dronespawn_bodyonly( var_1 );
        var_8 = maps\_utility::dronespawn_bodyonly( var_2 );
        var_9 = maps\_utility::dronespawn_bodyonly( var_3 );
        var_10 = maps\_utility::dronespawn_bodyonly( var_4 );
    }
    else
    {
        var_6 = maps\_utility::dronespawn_bodyonly( var_0 );
        wait 0.05;
        var_7 = maps\_utility::dronespawn_bodyonly( var_1 );
        wait 0.05;
        var_8 = maps\_utility::dronespawn_bodyonly( var_2 );
        wait 0.05;
        var_9 = maps\_utility::dronespawn_bodyonly( var_3 );
        wait 0.05;
        var_10 = maps\_utility::dronespawn_bodyonly( var_4 );
    }

    var_6 setcontents( 0 );
    var_7 setcontents( 0 );
    var_8 setcontents( 0 );
    var_9 setcontents( 0 );
    var_10 setcontents( 0 );
    var_6 maps\_utility::gun_remove();
    var_7 maps\_utility::gun_remove();
    var_8 maps\_utility::gun_remove();
    var_9 maps\_utility::gun_remove();
    var_10 maps\_utility::gun_remove();
    level.dead_demo_team = [ var_6, var_7, var_8, var_9, var_10 ];

    foreach ( var_12 in level.dead_demo_team )
        var_12.animname = "generic";

    var_0 thread maps\_anim::anim_first_frame_solo( var_6, "dead_body_pose1" );
    var_1 thread maps\_anim::anim_first_frame_solo( var_7, "dead_body_pose2" );
    var_2 thread maps\_anim::anim_first_frame_solo( var_8, "dead_body_pose3" );
    var_3 thread maps\_anim::anim_first_frame_solo( var_9, "dead_body_pose4" );
    var_4 thread maps\_anim::anim_first_frame_solo( var_10, "dead_body_pose5" );
}

canal_spawn_dead_demo_team( var_0, var_1 )
{
    for (;;)
    {
        var_0 waittill( "trigger" );
        var_1 waittill( "trigger" );

        if ( level.dead_demo_team.size > 0 )
        {
            foreach ( var_3 in level.dead_demo_team )
            {
                if ( isdefined( var_3.tag ) )
                    var_3.tag delete();

                if ( isdefined( var_3 ) )
                    var_3 delete();
            }
        }

        canal_handle_dead_demo_team();
        wait 0.05;
    }
}

canal_delete_dead_demo_team( var_0, var_1 )
{
    for (;;)
    {
        var_0 waittill( "trigger" );
        var_1 waittill( "trigger" );

        if ( level.dead_demo_team.size > 0 )
        {
            foreach ( var_3 in level.dead_demo_team )
            {
                if ( isdefined( var_3.tag ) )
                    var_3.tag delete();

                if ( isdefined( var_3 ) )
                    var_3 delete();
            }
        }

        wait 0.05;
    }
}

handle_outline_on_grenade_launcher()
{
    var_0 = getent( "smart_grenade_launcher", "targetname" );

    while ( isdefined( var_0 ) )
    {
        var_0 _meth_83FB( 6, 1 );
        level notify( "end_highlight_custom" );

        while ( isdefined( var_0 ) && distance( var_0.origin, level.player.origin ) > 300 )
            waitframe();

        if ( !isdefined( var_0 ) )
            break;

        var_0 thread highlight_custom();

        while ( isdefined( var_0 ) && distance( var_0.origin, level.player.origin ) <= 300 )
            waitframe();

        waitframe();
    }

    level notify( "end_highlight_custom" );
    _func_0D3( "r_hudoutlinewidth", 2 );
}

highlight_custom()
{
    level endon( "end_highlight_custom" );
    _func_0D3( "r_hudoutlinepostmode", 2 );
    self _meth_83FA( 6, 1, 0 );

    while ( isdefined( self ) && level.gameskill <= 1 )
    {
        for ( var_0 = 1; var_0 < 4; var_0++ )
        {
            _func_0D3( "r_hudoutlinewidth", var_0 );
            _func_0D3( "r_hudoutlinepostmode", 0 );

            if ( !isdefined( self ) )
                return;

            self _meth_83FA( 6, 1, 0 );
            wait 0.1;
        }

        for ( var_0 = 4; var_0 > 0; var_0-- )
        {
            _func_0D3( "r_hudoutlinewidth", var_0 );
            _func_0D3( "r_hudoutlinepostmode", 0 );

            if ( !isdefined( self ) )
                return;

            self _meth_83FA( 6, 1, 0 );
            wait 0.1;
        }
    }
}

handle_dropped_gun_angles()
{
    var_0 = getent( "smart_grenade_launcher", "targetname" );
    var_1 = common_scripts\utility::getstruct( "struct_grenade_launcher_gun_swap", "targetname" );

    for (;;)
    {
        level.player waittill( "pickup", var_2, var_3 );

        if ( isdefined( var_3 ) && var_2 == var_0 )
        {
            level.player _meth_8332( "iw5_microdronelaunchersmartgrenade_sp" );
            wait 1;
            var_3.origin = var_1.origin;
            var_3.angles = var_1.angles;
            break;
        }
    }
}

canal_handle_bomb_pickup()
{
    thread handle_outline_on_grenade_launcher();
    thread handle_dropped_gun_angles();

    if ( level.currentgen && !issubstr( level.transient_zone, "_overlookbar" ) )
        level waittill( "transients_canal_overlook_to_riverwalk" );

    var_0 = getent( "trig_sd_pickup_bombs", "targetname" );
    var_0 _meth_80DB( &"SEOUL_PICKUP_EXPLOSIVES_HINT" );
    var_1 = getent( "objective_sd_origin_bombs", "targetname" );
    var_2 = var_0 maps\_shg_utility::hint_button_position( "x", var_1.origin, undefined, 500, undefined, var_0 );
    maps\_utility::trigger_wait_targetname( "trig_sd_pickup_bombs" );
    common_scripts\utility::flag_set( "bombs_picked_up" );
    var_2 maps\_shg_utility::hint_button_clear();
    var_0 _meth_80DB( "" );
    var_0 common_scripts\utility::trigger_off();
    var_3 = getent( "bomb_pickup", "targetname" );
    var_3 hide();
}

give_player_smart_grenade_launcher()
{
    var_0 = level.player _meth_8311();
    level.player _meth_830F( var_0 );
    level.player _meth_830E( "iw5_microdronelaunchersmartgrenade_sp" );
    level.player _meth_8315( "iw5_microdronelaunchersmartgrenade_sp" );
}

canal_irons_open_door()
{
    var_0 = common_scripts\utility::getstruct( "canal_struct_door_kick", "targetname" );
    level.will_irons.animname = "will_irons";
    common_scripts\utility::flag_wait( "bombs_picked_up" );
    maps\_utility::clear_all_color_orders( "allies" );
    var_0 maps\_anim::anim_reach_solo( level.will_irons, "foyer_door_kick_a" );
    var_1 = getnode( "canal_cover_stairs", "targetname" );
    level.will_irons maps\_utility::set_goal_radius( 30 );
    level.will_irons maps\_utility::set_goal_node( var_1 );
    var_0 maps\_anim::anim_single_solo( level.will_irons, "foyer_door_kick_a" );
    level.will_irons maps\_utility::enable_ai_color_dontmove();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_will_cover1" );
}

canal_fight_to_weapon_platform()
{
    common_scripts\utility::flag_wait( "bombs_picked_up" );
    thread canal_spawn_razorback();
    thread canal_enemy_setup_post_explosive_pickup();
    thread canal_middle_weapon_guards();
    thread canal_wall_reinforcements();
    thread canal_waterfall_last_fight();
    var_0 = getentarray( "color_ents_pt1", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        if ( var_2.classname == "trigger_multiple" )
            var_2 common_scripts\utility::trigger_off();
    }

    var_4 = getentarray( "color_ents_pt2", "script_noteworthy" );
    common_scripts\utility::array_thread( var_4, common_scripts\utility::trigger_on );
    var_5 = getent( "canal_goal_balcony", "targetname" );
    var_6 = _func_0D6( "axis" );

    foreach ( var_8 in var_6 )
    {
        if ( var_8 _meth_80A9( var_5 ) && isalive( var_8 ) )
            var_8 delete();
    }

    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_set( "vo_bomb_planting_instructions" );
    common_scripts\utility::flag_waitopen( "vo_bomb_planting_instructions" );
    common_scripts\utility::flag_set( "spawn_canal_razorback" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_reach_waterfall" );
    var_10 = _func_0D6( "axis" );
    var_10 = maps\_utility::array_removedead_or_dying( var_10 );

    foreach ( var_8 in var_10 )
        var_8.health = 10;

    common_scripts\utility::flag_wait( "middle_weapon_guards_dead" );
    common_scripts\utility::flag_set( "prep_will_for_finale" );
    soundscripts\_snd::snd_music_message( "mus_canal_combat_done" );
    common_scripts\utility::flag_wait( "bomb_plant_start" );
}

handle_will_irons_movement()
{
    while ( level.security_drones.size > 1 )
    {
        level.security_drones = common_scripts\utility::array_removeundefined( level.security_drones );
        waitframe();
    }

    level notify( "will_push_forward_01" );

    while ( level.security_drones.size > 0 )
    {
        level.security_drones = common_scripts\utility::array_removeundefined( level.security_drones );
        waitframe();
    }

    if ( !common_scripts\utility::flag( "prep_will_for_finale" ) )
        level.will_irons.goalradius = 256;

    var_0 = getent( "trig_move_will_to_canal_pos2", "targetname" );
    var_0 notify( "trigger", level.player );
    var_0 = getent( "trig_will_move_security_drones", "targetname" );
    var_0 notify( "trigger", level.player );
    level notify( "will_push_forward_02" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_move_to_final_color" );
    maps\_utility::activate_trigger_with_targetname( "trig_move_will_to_canal_pos3" );
    level notify( "will_push_forward_03" );
}

canal_waterfall_last_fight()
{
    thread spawn_security_drones();
    thread handle_will_irons_movement();
    waittill_spawn_waterfall_fight();
    var_0 = getentarray( "spawner_last_fight_01", "targetname" );
    var_1 = getnodearray( "node_last_fight_cover", "targetname" );
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        if ( !isdefined( var_4 ) )
            continue;

        var_5 = common_scripts\utility::random( var_0 ) maps\_utility::spawn_ai();

        if ( !isdefined( var_5 ) )
            continue;

        var_5 _meth_81A5( var_4 );
        var_5.goalradius = 256;
        var_2[var_2.size] = var_5;
    }

    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_dead_demo_team3" );

    foreach ( var_5 in var_2 )
    {
        if ( isdefined( var_5 ) )
        {
            if ( common_scripts\utility::cointoss() )
            {
                var_5.health = 1;
                continue;
            }

            var_5 bloody_death( randomfloat( 1 ) );
        }
    }
}

monitor_change_security_drone_gotos()
{
    var_0 = common_scripts\utility::getstructarray( "struct_security_attack_node", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_security_attack_node_pos1", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "struct_security_attack_node_pos2", "targetname" );
    var_3 = common_scripts\utility::getstructarray( "struct_security_attack_node_pos3", "targetname" );
    var_4 = common_scripts\utility::getstructarray( "struct_security_attack_node_posf1", "targetname" );
    var_5 = common_scripts\utility::getstructarray( "struct_security_attack_node_posf2", "targetname" );
    var_6 = maps\_shg_design_tools::array_combine_multiple( var_0, var_1, var_2, var_3, var_4, var_5 );
    var_7 = getent( "vol_canals_security_drone_fight_pos1", "targetname" );
    var_8 = getent( "vol_canals_security_drone_fight_pos2", "targetname" );
    var_9 = getent( "vol_canals_security_drone_fight_pos3", "targetname" );
    var_10 = getent( "vol_canals_security_drone_fight_posf1", "targetname" );
    var_11 = getent( "vol_canals_security_drone_fight_posf2", "targetname" );

    for (;;)
    {
        if ( level.player _meth_80A9( var_7 ) )
        {
            level.player.drone_attack_nodes = var_1;

            while ( level.player _meth_80A9( var_7 ) )
                waitframe();
        }
        else if ( level.player _meth_80A9( var_8 ) )
        {
            level.player.drone_attack_nodes = var_2;

            while ( level.player _meth_80A9( var_8 ) )
                waitframe();
        }
        else if ( level.player _meth_80A9( var_9 ) )
        {
            level.player.drone_attack_nodes = var_3;

            while ( level.player _meth_80A9( var_9 ) )
                waitframe();
        }
        else if ( level.player _meth_80A9( var_10 ) )
        {
            level.player.drone_attack_nodes = var_4;

            while ( level.player _meth_80A9( var_10 ) )
                waitframe();
        }
        else if ( level.player _meth_80A9( var_11 ) )
        {
            level.player.drone_attack_nodes = var_5;

            while ( level.player _meth_80A9( var_11 ) )
                waitframe();
        }
        else
            level.player.drone_attack_nodes = var_6;

        waitframe();
    }
}

handle_security_drone_hit()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );
        security_drone_hit_react( var_0, var_1, var_2, var_3, var_4 );
    }
}

security_drone_hit_react( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );

    if ( issubstr( var_4, "BULLET" ) )
    {
        playfx( common_scripts\utility::getfx( "sparks_burst_a_nolight" ), var_3 );
        self _meth_8051( var_0 * 3, var_1.origin );
        wait 1;
    }
    else
    {
        self notify( "flying_attack_drone_goal_update" );
        self notify( "drone_security_prepare_attack" );
        self notify( "drone_security_prepare_attack_relay" );
        toss_security_drone( var_2, var_3, var_4 );
        thread vehicle_scripts\_pdrone_security::flying_attack_drone_goal_update();
        thread vehicle_scripts\_pdrone_security::drone_security_prepare_attack( 0 );
    }
}

toss_security_drone( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = vectornormalize( self.origin - var_1 );
    var_4 = vectortoangles( var_3 );
    var_5 = self.origin + var_4 * randomintrange( 20, 50 );
    playfx( common_scripts\utility::getfx( "sparks_burst_a_nolight" ), self.origin );
    var_6 = randomintrange( 9, 18 );
    var_7 = self.origin;
    var_8 = 0;
    self _meth_8266();

    for ( var_9 = 0; var_9 < var_6; var_9++ )
    {
        self _meth_825C( var_9 * 60.0 );
        self _meth_825B( var_7 + maps\_shg_design_tools::getperlinovertime( 5, 3, 2, 0.5 ) * 20 );
        self _meth_8283( randomintrange( 24, 32 ), 50, 80 );
        wait 0.2;
    }

    self _meth_8283( randomintrange( 24, 32 ), 12, 20 );

    if ( !isdefined( self.sparks ) )
    {
        self.sparks = 1;
        thread security_drone_sparks();
        self _meth_8253( 30, 30, 20 );
    }
}

security_drone_sparks()
{
    self endon( "death" );

    for (;;)
    {
        wait(randomfloatrange( 0.75, 1.5 ));

        if ( common_scripts\utility::cointoss() )
            playfx( common_scripts\utility::getfx( "sparks_burst_a_nolight" ), self.origin );
        else
            playfxontag( common_scripts\utility::getfx( "sparks_burst_a_nolight" ), self, "tag_main_camera" );

        playfxontag( common_scripts\utility::getfx( "drone_smoke" ), self, "tag_origin" );
    }
}

spawn_security_drones()
{
    if ( !isdefined( level.player.closest_drone ) )
        level.player.closest_drone = level.player;

    if ( !isdefined( level.active_drones ) )
        level.active_drones = [];

    thread monitor_change_security_drone_gotos();
    level.drone_investigates = [ level.player.origin, level.will_irons.origin ];
    var_0 = [];
    var_1 = getentarray( "spawner_big_security_drone_01", "targetname" );
    var_2 = getent( "spawner_big_security_drone_00", "targetname" );
    var_1 = common_scripts\utility::array_add( var_1, var_2 );

    foreach ( var_6, var_4 in var_1 )
    {
        if ( var_6 == 2 )
            continue;

        var_5 = var_4 maps\_utility::spawn_vehicle();
        var_0[var_0.size] = var_5;
        var_5 thread make_invulnerable_while_idle();
        var_5.spawner_name = var_4.targetname;
    }

    level.security_drones = var_0;
    level waittill( "start_security_drone_fight" );
    common_scripts\utility::flag_set( "_stealth_spotted" );
    common_scripts\utility::flag_set( "drones_investigating" );

    foreach ( var_6, var_5 in var_0 )
        var_5 thread activate_security_drone( var_6, 0 );

    for (;;)
    {
        foreach ( var_5 in var_0 )
        {
            level.player.closest_drone = var_5;

            while ( isdefined( level.player.closest_drone ) )
                waitframe();
        }

        waitframe();
    }
}

make_invulnerable_while_idle()
{
    level endon( "start_security_drone_fight" );

    for (;;)
    {
        self.maxhealth = 21100;
        self.health = self.maxhealth;
        waitframe();
    }
}

activate_security_drone( var_0, var_1 )
{
    self endon( "death" );

    if ( var_1 )
    {
        level waittill( "security_drone_death" );
        level waittill( "security_drone_death" );
    }

    var_2 = self;
    var_2 maps\_vehicle::gopath();
    var_2 _meth_8283( randomintrange( 24, 32 ), 12, 20 );
    var_2.ignoreme = 1;
    var_2 thread fake_scanning_fx_thread();
    var_2 thread monitor_security_drone_death( var_0 );
    common_scripts\utility::flag_wait( "security_drones_arrived" );
    var_2 thread vehicle_scripts\_pdrone_security::drone_active_thread();
    var_2 vehicle_scripts\_pdrone_security::drone_set_mode( "attack" );
    var_2 thread handle_security_drone_hit();
    var_2 thread set_target_player_or_will( var_0 );
    level.active_drones[level.active_drones.size] = var_2;
    var_2.ignoreme = 0;
    var_2.maxhealth = 21200;
    var_2.health = var_2.maxhealth;
}

fake_scanning_fx_thread()
{
    self endon( "death" );

    if ( issubstr( self.spawner_name, "00" ) )
        thread drone_scan( "drone_scan_seoul", 1 );
    else
        thread drone_scan( "drone_scan_seoul", 0 );
}

drone_scan( var_0, var_1 )
{
    if ( !var_1 )
        playfxontag( level._effect[var_0], self, "tag_main_camera" );

    while ( !common_scripts\utility::flag( "security_drones_arrived" ) )
    {
        if ( !isdefined( self ) || issubstr( self.classname, "corpse" ) )
            break;

        self _meth_8265( common_scripts\utility::random( [ level.player, level.will_irons ] ) );

        if ( var_1 )
            playfxontag( level._effect[var_0], self, "tag_main_camera" );

        wait(randomfloatrange( 0.5, 1.0 ));
    }
}

monitor_security_drone_death( var_0 )
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "security_drones_ok_to_damage" );
        var_1 = common_scripts\utility::waittill_any_return( "death", "damage" );

        if ( var_1 == "death" )
        {
            level notify( "security_drone_death", var_0 );
            common_scripts\utility::flag_set( "security_drones_arrived" );
            break;
        }
        else
            common_scripts\utility::flag_set( "security_drones_arrived" );
    }
}

set_target_player_or_will( var_0 )
{
    self endon( "death" );

    while ( !isdefined( self.drone_threat_data ) )
        waitframe();

    var_1 = undefined;
    thread kill_player_if_move_ahead();

    for (;;)
    {
        if ( var_0 == 0 || var_0 == 2 )
            var_1 = level.player;
        else if ( var_0 == 1 )
            var_1 = level.will_irons;
        else
        {
            thread target_drone_damager();
            break;
        }

        self.drone_threat_data.threat = var_1;

        while ( isdefined( self.drone_threat_data.threat ) && self.drone_threat_data.threat == var_1 )
            waitframe();
    }
}

kill_player_if_move_ahead()
{
    self endon( "death" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_dead_demo_team3" );
    self.drone_threat_data.threat = level.player;
}

target_drone_damager()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1 );
        self.drone_threat_data.threat = var_1;
        wait 3;
    }
}

security_drone_attack()
{
    var_0 = self;
    var_0.fovcosinez = cos( 60 );
    var_0.fovcosine = cos( 60 );
    var_0 notify( "drone_investigate" );
    var_0 notify( "drone_corpse_monitor" );
    var_0 notify( "drone_alert_sight" );
    var_0 notify( "drone_wait_for_attack" );
    var_0 thread vehicle_scripts\_pdrone_security::drone_security_prepare_attack( 1 );
}

waittill_spawn_waterfall_fight()
{
    var_0 = getent( "vol_canal_enemy_ai_check_01", "targetname" );

    while ( !common_scripts\utility::flag( "canal_reached_walls" ) )
    {
        var_1 = _func_0D6( "axis" );
        var_1 = maps\_utility::array_removedead_or_dying( var_1 );
        var_2 = 0;

        foreach ( var_4 in var_1 )
        {
            if ( isdefined( var_4 ) && var_4 _meth_80A9( var_0 ) )
                var_2++;

            if ( common_scripts\utility::cointoss() )
                waitframe();
        }

        if ( var_2 > 1 )
            break;

        waitframe();
    }

    while ( !common_scripts\utility::flag( "canal_reached_walls" ) )
    {
        var_1 = _func_0D6( "axis" );
        var_2 = 0;

        foreach ( var_4 in var_1 )
        {
            if ( isdefined( var_4 ) && var_4 _meth_80A9( var_0 ) )
                var_2++;

            if ( common_scripts\utility::cointoss() )
                waitframe();
        }

        if ( var_2 == 0 )
            break;

        waitframe();
    }

    level notify( "start_security_drone_fight" );
}

canal_enemy_setup_post_explosive_pickup()
{
    var_0 = getent( "enemy_sd_canal_grp1", "script_noteworthy" );
    var_1 = 6;
    var_2 = [];

    for ( var_3 = 0; var_3 < var_1; var_3++ )
    {
        var_4 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
        var_4.grenadeammo = 0;
        var_4 thread change_color_node_quick();
        var_4 maps\_utility::add_damage_function( ::canal_enemy_damage_function );
        var_2[var_2.size] = var_4;
    }

    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_reach_waterfall" );
    var_5 = maps\_utility::array_removedead_or_dying( var_2 );

    foreach ( var_4 in var_2 )
    {
        if ( isalive( var_4 ) )
            var_4 bloody_death();

        wait(randomfloatrange( 0.3, 0.5 ));
        var_5 = maps\_utility::array_removedead_or_dying( var_5 );
    }
}

canal_middle_weapon_guards()
{
    common_scripts\utility::flag_clear( "canal_reached_walls" );
    common_scripts\utility::flag_wait( "canal_reached_walls" );
    var_0 = getent( "enemy_sd_guards2_1", "targetname" );
    var_1 = 3;
    var_2 = getent( "sd_goal_weapon_guard1", "targetname" );
    var_3 = [];

    for ( var_4 = 0; var_4 < var_1; var_4++ )
    {
        var_5 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
        var_5.grenadeammo = 0;
        var_5 thread change_color_node_quick();
        var_5 _meth_81A9( var_2 );
        var_5 maps\_utility::add_damage_function( ::canal_enemy_damage_function );
        var_3[var_3.size] = var_5;
    }

    var_6 = getent( "enemy_sd_guards2_2", "targetname" );
    var_7 = 4;
    var_2 = getent( "sd_goal_weapon_guard1", "targetname" );

    for ( var_4 = 0; var_4 < var_1; var_4++ )
    {
        var_5 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
        var_5.grenadeammo = 0;
        var_5 thread change_color_node_quick();
        var_5 _meth_81A9( var_2 );
        var_5 maps\_utility::add_damage_function( ::canal_enemy_damage_function );
        var_3[var_3.size] = var_5;
    }

    while ( var_3.size > 1 )
    {
        var_3 = maps\_utility::array_removedead_or_dying( var_3 );
        waitframe();
    }

    foreach ( var_5 in var_3 )
    {
        if ( isalive( var_5 ) )
            var_5 bloody_death();

        var_3 = maps\_utility::array_removedead_or_dying( var_3 );
    }

    common_scripts\utility::flag_set( "middle_weapon_guards_dead" );
}

canal_wall_reinforcements()
{
    var_0 = getent( "enemy_canal_wall_reinforcementsR", "script_noteworthy" );
    var_1 = 3;
    var_2 = getent( "sd_goal_wallR", "targetname" );
    var_3 = [];

    for ( var_4 = 0; var_4 < var_1; var_4++ )
    {
        var_5 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
        var_5.grenadeammo = 0;
        var_5 thread change_color_node_quick();
        var_5 _meth_81A9( var_2 );
        var_5 _meth_8177( "weapon_platform_guards" );
        var_5 maps\_utility::add_damage_function( ::canal_enemy_damage_function );
        var_3[var_3.size] = var_5;
        var_5 thread canal_wall_enemy_think();
    }

    var_6 = getent( "enemy_canal_wall_reinforcementsL", "script_noteworthy" );
    var_7 = 2;
    var_2 = getent( "sd_goal_wallL", "targetname" );

    for ( var_4 = 0; var_4 < var_1; var_4++ )
    {
        var_5 = var_6 maps\_shg_design_tools::actual_spawn( 1 );
        var_5.grenadeammo = 0;
        var_5 thread change_color_node_quick();
        var_5 _meth_81A9( var_2 );
        var_5 _meth_8177( "weapon_platform_guards" );
        var_5 maps\_utility::add_damage_function( ::canal_enemy_damage_function );
        var_3[var_3.size] = var_5;
        var_5 thread canal_wall_enemy_think();
    }

    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_reach_waterfall" );
    var_3 = maps\_utility::array_removedead_or_dying( var_3 );

    foreach ( var_5 in var_3 )
    {
        if ( isalive( var_5 ) )
            var_5 bloody_death();

        wait(randomfloatrange( 0.3, 0.5 ));
        var_3 = maps\_utility::array_removedead_or_dying( var_3 );
    }
}

canal_jet_flyover2()
{
    var_0 = getentarray( "special_jet_flyby_spawner_canal1", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 maps\_vehicle::spawn_vehicle_and_gopath();
}

canal_handle_bomb_plant_start()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_overlookbar" ) )
        level waittill( "transients_canal_overlook_to_riverwalk" );

    common_scripts\utility::flag_wait( "canal_bomb_plant_trigger_on" );
    var_0 = getent( "trig_interact_with_will_finale", "targetname" );
    var_0 _meth_80DB( &"SEOUL_GIVE_EXPLOSIVES_HINT" );
    var_0 thread canal_handle_bomb_plant_button_display();
    common_scripts\utility::flag_wait( "interacted_with_will_finale" );
    var_0 _meth_80DB( "" );
    common_scripts\utility::flag_set( "bomb_plant_start" );
    var_0 common_scripts\utility::trigger_off();
}

canal_handle_bomb_plant_button_display()
{
    var_0 = maps\_shg_utility::hint_button_trigger( "x", 250 );
    common_scripts\utility::flag_wait( "interacted_with_will_finale" );
    var_0 maps\_shg_utility::hint_button_clear();
}

canal_spawn_razorback()
{
    common_scripts\utility::flag_wait( "spawn_canal_razorback" );
    level.canal_razorback = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "vehicle_canal_razorback01" );
    level.canal_razorback soundscripts\_snd::snd_message( "seo_canal_razorback" );
    level.canal_razorback maps\_vehicle::godon();
    var_0 = getentarray( "ally_canal_razorback_grp1", "script_noteworthy" );
    var_1 = getent( "canal_razorback_clip", "targetname" );
    var_1 _meth_804D( level.canal_razorback );
    thread canal_razorback_turret_think();
    wait 2;
    common_scripts\utility::flag_set( "vo_canal_razorback_arrival" );
    common_scripts\utility::flag_wait( "canal_razorback_dropoff01" );
    common_scripts\utility::flag_set( "canal_razoback_move_again" );
    wait 8;
    common_scripts\utility::flag_set( "canal_razorback_attacked" );
    var_2 = common_scripts\utility::getstruct( "razorback_escape", "targetname" );
    level.canal_razorback.attachedpath = var_2;
    level.canal_razorback thread maps\_vehicle::vehicle_paths();
    level.canal_razorback soundscripts\_snd::snd_message( "seo_canal_heli_attacked" );

    while ( !isdefined( level.canal_razorback.crashing ) )
        waitframe();

    var_3 = level.canal_razorback.origin;
    level.canal_razorback.crash_node = common_scripts\utility::getclosest( level.canal_razorback.origin, getentarray( "helicopter_crash_location", "targetname" ), 5000 );

    while ( distance( level.canal_razorback.origin, level.canal_razorback.crash_node.origin ) > 200 )
    {
        var_3 = level.canal_razorback.origin;
        waitframe();
    }

    playfx( common_scripts\utility::getfx( "razorback_death_explosion" ), var_3 );
    var_1 _meth_804F();
    var_1 delete();
    level.canal_razorback delete();
}

canal_razorback_turret_think()
{
    level.canal_razorback vehicle_scripts\_razorback::disable_firing();
    level.canal_razorback thread vehicle_scripts\_razorback::disable_tracking();
    level.canal_razorback.fire_rate = 0.2;
    level.canal_razorback.gun_vector = level.canal_razorback gettagorigin( "TAG_TURRET" );
    wait 4;
    level.canal_razorback thread vehicle_scripts\_razorback::enable_tracking();

    while ( !common_scripts\utility::flag( "canal_razorback_dropoff01" ) )
    {
        var_0 = randomfloatrange( 10, 30 );
        var_1 = 0;
        level.canal_razorback soundscripts\_snd::snd_message( "razorback_fire_start", level.canal_razorback.gun_vector );

        while ( !common_scripts\utility::flag( "canal_razorback_dropoff01" ) && var_1 < var_0 )
        {
            var_2 = common_scripts\utility::getclosest( level.canal_razorback.origin, getentarray( "canal_wall_targetpoints", "script_noteworthy" ), 5000 );
            var_2 = var_2.origin + common_scripts\utility::randomvectorrange( 10, 100 );
            level.canal_razorback vehicle_scripts\_razorback::set_forced_target( var_2 );
            level.canal_razorback.gun_vector = level.canal_razorback gettagorigin( "TAG_TURRET" );
            canal_razorback_turret_fire();
            var_1++;
            wait(level.canal_razorback.fire_rate);
        }

        level.canal_razorback soundscripts\_snd::snd_message( "razorback_fire_stop", level.canal_razorback.gun_vector );
        wait(randomfloatrange( 0.3, 0.5 ));
    }

    level.canal_razorback thread vehicle_scripts\_razorback::disable_tracking();
    common_scripts\utility::flag_wait( "canal_razorback_dropoff01" );
    wait 1;
    wait 3;
    common_scripts\utility::flag_set( "canal_razorback_fire_at_swarm" );
    level.canal_razorback thread vehicle_scripts\_razorback::enable_tracking();

    while ( !common_scripts\utility::flag( "canal_razorback_attacked" ) )
    {
        var_0 = randomfloatrange( 4, 8 );
        var_1 = 0;
        level.canal_razorback soundscripts\_snd::snd_message( "razorback_fire_start", level.canal_razorback.gun_vector );

        while ( !common_scripts\utility::flag( "canal_razorback_attacked" ) && var_1 < var_0 )
        {
            var_2 = get_player_point_target();

            if ( !isdefined( var_2 ) )
                var_2 = common_scripts\utility::getclosest( level.canal_razorback.origin, getentarray( "canal_swarm_targetpoints", "script_noteworthy" ), 5000 );

            var_2 = var_2.origin + common_scripts\utility::randomvectorrange( 10, 50 );
            level.canal_razorback vehicle_scripts\_razorback::set_forced_target( var_2 );
            level.canal_razorback.gun_vector = level.canal_razorback gettagorigin( "TAG_TURRET" );
            canal_razorback_turret_fire();
            var_1++;
            wait(level.canal_razorback.fire_rate);
        }

        level.canal_razorback soundscripts\_snd::snd_message( "razorback_fire_stop", level.canal_razorback.gun_vector );
        wait(randomfloatrange( 0.5, 1.75 ));
    }

    level.canal_razorback thread vehicle_scripts\_razorback::disable_tracking();
}

get_player_point_target()
{
    var_0 = level.player _meth_80A8();
    var_1 = level.player _meth_8036();
    var_2 = var_0 + anglestoforward( var_1 ) * 20;
    var_3 = var_0 + anglestoforward( var_1 ) * 200;
    var_4 = bullettrace( var_2, var_3, 1, level.will_irons, 0, 0, 1 );

    if ( distance( level.player.origin, var_4["position"] ) < 300 )
        return;

    var_5 = _func_0D6( "axis" );
    var_5 = maps\_shg_design_tools::sortbydistanceauto( var_5, var_4["position"] );

    if ( isdefined( var_5[1] ) )
        var_6 = var_5[1];
    else
        var_6 = var_5[0];

    return var_6.origin;
}

canal_razorback_turret_fire( var_0, var_1 )
{
    level.canal_razorback _meth_8268();
}

canal_drone_swarm_think()
{
    common_scripts\utility::flag_wait( "canal_start_drone_travel" );
    level notify( "end_kamikaze_newstyle" );
    var_0 = common_scripts\utility::getstructarray( "canal_snake_swarm_travel1", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2.speed = 40;

    foreach ( var_5 in self.snakes )
    {
        var_6 = var_5.flock.boid_settings;
        var_6.max_accel = 4000;
        var_6.magnet_factor = 20;
    }

    thread vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "canal_snake_swarm_travel1", undefined, 3 );
    common_scripts\utility::flag_wait( "canal_snake_reached_platform" );
    var_8 = common_scripts\utility::getstructarray( "sd_snake_swarm_wp_loop", "script_noteworthy" );
    var_9 = common_scripts\utility::getstructarray( "canal_snake_swarm_initial_attack1", "script_noteworthy" );
    thread canal_kamikaze_player_check();

    foreach ( var_2 in var_8 )
        var_2.speed = 40;

    foreach ( var_2 in var_9 )
        var_2.speed = 35;

    foreach ( var_5 in self.snakes )
    {
        var_6 = var_5.flock.boid_settings;
        var_6.max_accel = 6400;
        var_6.magnet_factor = 30;
    }

    level notify( "canal_swarm_spawned" );
    thread vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "sd_snake_swarm_wp_loop", undefined, 4.5 );

    foreach ( var_5 in self.snakes )
    {
        var_6 = var_5.flock.boid_settings;
        var_6.max_accel = 6400;
        var_6.magnet_factor = 30;
    }

    common_scripts\utility::flag_wait( "canal_razorback_fire_at_swarm" );
    thread canal_drone_swarm_death_think();
    common_scripts\utility::flag_wait( "canal_razorback_attacked" );
    common_scripts\utility::flag_set( "vo_canal_razorback_attacked" );
    soundscripts\_snd::snd_music_message( "mus_canal_swarm_chasing_off_razorback" );
    wait 2;

    foreach ( var_5 in self.snakes )
    {
        var_6 = var_5.flock.boid_settings;
        var_6.max_accel = 3200;
        var_6.magnet_factor = 10;
    }

    thread vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "canal_snake_swarm_initial_attack1", undefined, 4 );
    common_scripts\utility::flag_wait( "canal_snake_attack1_path_end" );
    wait 8;
    thread vehicle_scripts\_attack_drone_common::cleanup_snake_cloud();
    soundscripts\_snd::snd_music_message( "mus_canal_helo_attacked" );
}

canal_drone_swarm_death_think()
{
    var_0 = common_scripts\utility::getstructarray( "canal_dead_drone_spawn2", "script_noteworthy" );

    while ( !common_scripts\utility::flag( "canal_razorback_attacked" ) && !common_scripts\utility::flag( "canal_razoback_move_again" ) )
    {
        if ( common_scripts\utility::flag( "canal_razoback_move_again" ) )
            var_0 = common_scripts\utility::getstructarray( "canal_dead_drone_spawn3", "script_noteworthy" );

        var_1 = var_0[randomintrange( 0, var_0.size )];
        playfx( common_scripts\utility::getfx( "drone_death_explode1" ), var_1.origin );
        wait(randomfloatrange( 0.5, 1 ));
    }

    wait 2;
    var_0 = common_scripts\utility::getstructarray( "canal_dead_drone_spawn3", "script_noteworthy" );

    while ( !common_scripts\utility::flag( "canal_razorback_attacked" ) )
    {
        var_1 = var_0[randomintrange( 0, var_0.size )];
        playfx( common_scripts\utility::getfx( "drone_death_explode1" ), var_1.origin );
        wait(randomfloatrange( 0.5, 1 ));
    }
}

canal_kamikaze_player_check()
{
    var_0 = getent( "vol_canal_kamikaze_player_check", "targetname" );
    var_1 = getent( "canal_drone_queen1", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "sd_snake_swarm_wp_loop", "script_noteworthy" );
    level endon( "end_kamikaze_newstyle" );

    while ( !common_scripts\utility::flag( "bombs_picked_up" ) )
    {
        while ( level.player _meth_80A9( var_0 ) )
        {
            if ( !common_scripts\utility::flag( "canal_swarm_attacking_player" ) )
                common_scripts\utility::flag_set( "canal_swarm_attacking_player" );

            var_3 = maps\_shg_design_tools::sortbydistanceauto( level.flock_drones, level.player.origin );
            var_4 = randomint( 2 );

            for ( var_5 = 0; var_5 < var_4; var_5++ )
            {
                if ( !isdefined( var_3[var_5] ) || isdefined( var_3[var_5].attacking_player ) )
                    continue;

                var_3[var_5] thread vehicle_scripts\_attack_drone::drone_kamikaze_player( var_1 );
                var_3[var_5].attacking_player = 1;
                wait(randomfloatrange( 0.1, 0.2 ));
            }

            foreach ( var_7 in var_2 )
                var_7.speed = 40;

            wait 0.5;
        }

        if ( common_scripts\utility::flag( "canal_swarm_attacking_player" ) )
            common_scripts\utility::flag_clear( "canal_swarm_attacking_player" );

        waitframe();
    }
}

canal_pop_smoke()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_reinforcements2" );
    var_0 = common_scripts\utility::getstruct( "struct_smoke_start_left", "targetname" );
    var_1 = common_scripts\utility::getstruct( "struct_smoke_end_left", "targetname" );
    var_2 = common_scripts\utility::getstruct( "struct_smoke_start_right", "targetname" );
    var_3 = common_scripts\utility::getstruct( "struct_smoke_end_right", "targetname" );
    _func_070( "smoke_grenade_cheap", var_0.origin, var_1.origin + ( 0, 2, 0 ), 1 );
    _func_070( "smoke_grenade_cheap", var_2.origin, var_3.origin + ( 0, 2, 0 ), 1 );
    wait 1;
    thread sd_spawn_and_retreat_goals( undefined, "enemy_sd_canal1", undefined, "sd_goal_canal1_fallback", 2, undefined, "sd_goal_weapon_guard1" );
    thread sd_spawn_and_retreat_goals( undefined, "enemy_canal_waterfall", undefined, "sd_goal_canal1_fallback", 1, undefined, "sd_goal_weapon_guard1" );
}

canal_spawn_zipline_group1()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_start_combat" );
    var_0 = [];
    var_0[var_0.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_canal_zipline1", "canal_zipline_canal1_start1" );
    wait 0.5;
    var_0[var_0.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_canal_zipline1", "canal_zipline_canal1_start2" );
    wait 0.5;
    var_0[var_0.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_canal_zipline1", "canal_zipline_canal1_start3" );
    wait 0.5;
    var_0[var_0.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_canal_zipline1", "canal_zipline_canal1_start4" );
    sd_zipline_enemy_think( var_0, "sd_goal_canal1", 2, undefined, "sd_goal_canal1_fallback" );
}

canal_spawn_zipline_group2()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_start_combat" );
    wait 0.5;
    var_0 = [];
    var_0[var_0.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_canal_zipline2", "canal_zipline_canal2_start1" );
    wait 0.5;
    var_0[var_0.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_canal_zipline2", "canal_zipline_canal2_start2" );
    wait 0.5;
    var_0[var_0.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_canal_zipline2", "canal_zipline_canal2_start3" );
    wait 0.5;
    var_0[var_0.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( "canal_enemy_canal_zipline2", "canal_zipline_canal2_start4" );
    sd_zipline_enemy_think( var_0, "sd_goal_canal1", 2, undefined, "sd_goal_canal1_fallback" );
}

canal_turret_vehicle2()
{
    var_0 = getentarray( "canal_vehicle_weap_defense_passengers", "script_noteworthy" );
    maps\_utility::array_spawn_function_noteworthy( "canal_vehicle2_passengers", ::canal_turret_vehicle_passenger_think );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "canal_vehicle_weap_defense" );
    level.controllable_drone_swarm_target[level.controllable_drone_swarm_target.size] = var_1;

    foreach ( var_3 in var_1.riders )
    {
        if ( var_3.vehicle_position == 3 )
            var_4 = var_3;
    }

    common_scripts\utility::flag_wait( "bombs_picked_up" );
    var_1 waittill( "reached_end_node" );
    var_1 maps\_vehicle::vehicle_unload( "all_but_gunner" );
}

canal_emp_wave()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_canal_emp" );
    level notify( "end_drone_swarm" );
    var_0 = getent( "canal_weapon_platform", "targetname" );
    var_1 = var_0.origin;
    var_2 = 10000;
    var_3 = common_scripts\utility::array_add( level.controllable_drones, level.controllable_cloud_queen );
    var_3 = maps\_shg_design_tools::sortbydistanceauto( var_3, var_1 );
    var_4 = var_1;
    var_5 = 25;
    var_6 = 0;

    foreach ( var_8 in var_3 )
    {
        if ( !isdefined( var_8 ) )
            continue;

        if ( var_8 maps\_vehicle::isvehicle() )
        {
            var_8 _meth_8051( var_8.health * 2, var_1 );
            continue;
        }

        var_9 = distance( var_4, var_8.origin );
        var_10 = var_9 / var_2 * 0.05;

        if ( maps\_shg_design_tools::percentchance( 25 ) )
            wait(var_10);

        if ( var_6 > var_5 )
        {
            wait 0.05;
            var_6 = 0;
        }

        if ( !isdefined( var_8 ) )
            continue;

        var_4 = var_8.origin;
        var_11 = vectornormalize( var_8.origin - var_1 );
        var_11 = vectornormalize( var_11 + ( 0, 0, 0.2 ) );
        var_12 = spawn( "script_model", var_8.origin );
        var_12 _meth_80B1( "vehicle_mil_attack_drone_static" );
        var_12.angles = var_8.angles;
        var_8 maps\_shg_design_tools::delete_auto();
        var_13 = var_12.origin + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( -10, 10 ) ) - var_1;
        var_14 = randomintrange( 10, 80 );
        var_12 _meth_8276( var_12.origin + ( randomintrange( -15, 15 ), randomintrange( -15, 15 ), randomintrange( -15, 15 ) ), var_13 * var_14 );
        var_12 common_scripts\utility::delaycall( randomfloatrange( 10, 30 ), ::delete );
        var_6++;
    }
}

canal_weapon_platform_firing_loop()
{
    if ( !isdefined( level.weapon_platform_rigged ) )
        level.weapon_platform_rigged = getent( "canal_weapon_platform", "targetname" );

    if ( level.currentgen && !issubstr( level.transient_zone, "_overlookbar" ) )
        level waittill( "transients_canal_overlook_to_riverwalk" );

    thread maps\seoul_lighting::finale_mwp_lighting_offset();
    level.weapon_platform_rigged.animname = "weapon_platform";
    level.weapon_platform_rigged maps\_anim::setanimtree();
    var_0 = getent( "canal_org_finale", "targetname" );
    var_0 maps\_anim::anim_first_frame_solo( level.weapon_platform_rigged, "firing_loop" );
    var_1 = getentarray( "vehicle_canal_wp_missiles1", "targetname" );
    var_2 = getentarray( "vehicle_canal_wp_missiles2", "targetname" );
    var_3 = getentarray( "vehicle_canal_wp_missiles3", "targetname" );
    common_scripts\utility::flag_wait( "start_weapon_platform_firing" );

    while ( common_scripts\utility::flag( "start_weapon_platform_firing" ) )
    {
        var_0 thread canal_weapon_platform_anim();
        earthquake( 0.2, 1, level.weapon_platform_rigged.origin, 1500 );
        var_4 = var_1[randomintrange( 0, var_1.size )];
        var_5 = var_4 maps\_vehicle::spawn_vehicle_and_gopath();
        playfxontag( common_scripts\utility::getfx( "weaponplf_trail_missile_runner" ), var_5, "tag_origin" );
        var_5 hide();
        var_5 notify( "stop_engineeffects" );
        stopfxontag( common_scripts\utility::getfx( "contrail" ), var_5, "tag_origin" );
        var_5 soundscripts\_snd::snd_message( "havoc_missile_launch" );
        wait(randomfloatrange( 0.2, 0.4 ));
        var_6 = var_2[randomintrange( 0, var_2.size )];
        var_7 = var_6 maps\_vehicle::spawn_vehicle_and_gopath();
        playfxontag( common_scripts\utility::getfx( "weaponplf_trail_missile_runner" ), var_7, "tag_origin" );
        var_7 hide();
        var_7 notify( "stop_engineeffects" );
        stopfxontag( common_scripts\utility::getfx( "contrail" ), var_7, "tag_origin" );
        var_7 soundscripts\_snd::snd_message( "havoc_missile_launch" );
        wait(randomfloatrange( 0.2, 0.4 ));
        var_8 = var_3[randomintrange( 0, var_3.size )];
        var_9 = var_8 maps\_vehicle::spawn_vehicle_and_gopath();
        playfxontag( common_scripts\utility::getfx( "weaponplf_trail_missile_runner" ), var_9, "tag_origin" );
        var_9 hide();
        var_9 notify( "stop_engineeffects" );
        stopfxontag( common_scripts\utility::getfx( "contrail" ), var_9, "tag_origin" );
        var_9 soundscripts\_snd::snd_message( "havoc_missile_launch" );
        wait(randomfloatrange( 5.0, 8.0 ));
    }

    common_scripts\utility::flag_waitopen( "weapon_platform_firing" );
}

canal_weapon_platform_vis_control()
{
    level.weapon_platform_rigged = getent( "canal_weapon_platform", "targetname" );
    level.weapon_platform_rigged hide();
    common_scripts\utility::flag_wait( "show_canal_weapon_platform" );
    level.weapon_platform_rigged show();
}

canal_weapon_platform_anim()
{
    common_scripts\utility::flag_set( "weapon_platform_firing" );
    maps\_anim::anim_single_solo( level.weapon_platform_rigged, "firing_loop" );
    common_scripts\utility::flag_clear( "weapon_platform_firing" );
}

canal_finale_will_prep()
{
    common_scripts\utility::flag_wait( "prep_will_for_finale" );
    common_scripts\utility::flag_waitopen( "weapon_platform_firing" );
    common_scripts\utility::flag_clear( "start_weapon_platform_firing" );
    level.will_irons.animname = "will_irons";
    level.weapon_platform_rigged maps\_utility::anim_stopanimscripted();
    var_0 = getent( "canal_org_finale", "targetname" );
    var_0 maps\_anim::anim_first_frame_solo( level.weapon_platform_rigged, "finale_pt01" );
    level.will_irons.ignoreall = 1;
    level.will_irons.ignoreme = 1;
    thread maps\seoul_lighting::finale_mwp_lighting_offset();
    thread maps\seoul_lighting::pre_bomb_plant_lighting();
    var_0 = getent( "canal_org_finale", "targetname" );
    var_1 = [ level.will_irons, level.weapon_platform_rigged ];
    var_0 maps\_anim::anim_reach_solo( level.will_irons, "finale_pt01" );
    var_0 maps\_anim::anim_single( var_1, "finale_pt01" );
    common_scripts\utility::flag_set( "canal_bomb_plant_trigger_on" );
    common_scripts\utility::flag_set( "vo_bomb_plant_reminder" );
    var_2 = [ "seo_wil_mitchellineedthe", "seo_wil_comeonmitchell" ];
    thread maps\_shg_utility::dialogue_reminder( level.will_irons, "bomb_plant_start", var_2, 3, 5 );

    if ( !common_scripts\utility::flag( "bomb_plant_start" ) )
        var_0 maps\_anim::anim_loop_solo( level.will_irons, "finale_idle_will", "bomb_plant_start" );
}

canal_finale_sequence()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_overlookbar" ) )
        level waittill( "transients_canal_overlook_to_riverwalk" );

    level notify( "aud_stop_canal_bombs" );
    var_0 = getent( "canal_org_finale", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "seo_finale_part2_lamp01" );
    var_2 = maps\_utility::spawn_anim_model( "seo_finale_part2_lamp02" );
    var_3 = maps\_utility::spawn_anim_model( "seo_finale_part2_lamp03" );
    var_4 = maps\_utility::spawn_anim_model( "seo_finale_part2_lamp04" );
    var_5 = maps\_utility::spawn_anim_model( "seo_finale_part2_lamp05" );
    var_6 = maps\_utility::spawn_anim_model( "seo_finale_part2_lamp06" );
    var_7 = maps\_utility::spawn_anim_model( "seo_finale_part2_lamp07" );
    var_8 = maps\_utility::spawn_anim_model( "seo_finale_part2_lamp08" );
    var_9 = [ var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 ];
    var_0 maps\_anim::anim_first_frame( var_9, "finale_pt02" );
    common_scripts\utility::flag_wait( "bomb_plant_start" );
    common_scripts\utility::flag_set( "end_rumble_listener" );
    level.player maps\_vehicle::godon();
    soundscripts\_snd::snd_message( "seo_finale_start" );
    thread maps\seoul_lighting::timing_offset_finale_cine_lighting();
    common_scripts\utility::flag_set( "objective_sd_bomb_planted" );
    level notify( "panel_close_wait" );
    thread cleanup_enemy_ai_seoul();
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    maps\_player_exo::player_exo_deactivate();
    var_10 = _func_0D6( "axis" );
    maps\_utility::array_delete( var_10 );
    var_11 = _func_0D9();
    maps\_utility::array_delete( var_11 );
    _func_0D3( "g_friendlynamedist", 0 );
    level.weapon_platform_rigged = getent( "canal_weapon_platform", "targetname" );
    level.weapon_platform_rigged.animname = "weapon_platform";
    level.weapon_platform_rigged maps\_anim::setanimtree();
    level.will_irons.animname = "will_irons";
    level.cormack.animname = "cormack";
    var_12 = maps\_utility::spawn_anim_model( "player_rig", level.player.origin );
    var_13 = maps\_utility::spawn_anim_model( "seo_finale_plantbomb_bomb" );
    thread maps\seoul_lighting::bomb_light( var_13 );
    var_14 = [ level.will_irons, var_12, level.weapon_platform_rigged, var_13 ];
    var_0 maps\_anim::anim_first_frame( var_14, "finale_plantbomb" );
    var_12 hide();
    var_15 = 0.5;
    level.player _meth_8080( var_12, "tag_player", var_15 );
    var_12 common_scripts\utility::delaycall( var_15 + 0.1, ::show );
    level.player common_scripts\utility::delaycall( var_15, ::_meth_807F, var_12, "tag_player" );
    common_scripts\utility::flag_set( "vo_canal_finale_scene" );
    common_scripts\utility::flag_set( "vfx_msg_finale_sequence_start" );
    var_0 maps\_anim::anim_single( var_14, "finale_plantbomb" );
    common_scripts\utility::flag_set( "cleanup_finale_explosive" );
    var_13 hide();
    var_16 = [ level.will_irons, var_12, level.weapon_platform_rigged, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 ];
    var_0 maps\_anim::anim_single( var_16, "finale_pt02" );
    level.will_irons hide();
    var_17 = maps\_utility::spawn_anim_model( "seo_finale_phase2_rock_chunk01" );
    var_18 = maps\_utility::spawn_anim_model( "seo_finale_phase2_rock_chunk02" );
    var_19 = maps\_utility::spawn_anim_model( "seo_finale_phase2_sever_debris" );
    var_20 = maps\_utility::spawn_anim_model( "seo_finale_phase2_sever_debris_02" );
    var_21 = maps\_utility::spawn_anim_model( "seo_finale_phase2_silo_burke_debris" );
    var_22 = maps\_utility::spawn_anim_model( "player_dismembered_arm" );
    thread maps\seoul_lighting::finale_cineviewmodel_lighting( var_12 );
    var_23 = getent( "canal_finale_warbird1", "targetname" ) maps\_utility::spawn_vehicle();
    var_23.animname = "warbird_finale";
    var_23.ignoreall = 1;
    var_24 = getent( "hero_cormack_spawner_outro", "targetname" );
    level.cormack_outro = var_24 maps\_shg_design_tools::actual_spawn();
    level.cormack_outro.animname = "cormack";
    level.cormack_outro.ignoreall = 1;
    var_25 = [ level.cormack_outro, var_12, var_22, var_17, var_19, var_20, var_21, var_23 ];
    soundscripts\_snd::snd_music_message( "mus_mitchels_arm" );
    thread maps\seoul_fx::outro_vm_arm_blood_init( var_25 );
    var_0 thread maps\_anim::anim_single( var_25, "finale_pt03" );
    var_26 = maps\_utility::getanim_from_animname( "finale_pt03", var_12.animname );
    maps\seoul_code_gangnam::prep_cinematic( "fusion_endlogo" );
    var_27 = getanimlength( var_26 );
    wait(var_27 - 2);
    var_28 = 2;
    thread ending_fade_out( var_28 );
    wait(var_28);
    maps\_utility::nextmission();
}

cleanup_enemy_ai_seoul()
{
    var_0 = _func_0D6( "axis" );
    common_scripts\utility::array_call( var_0, ::delete );

    if ( isdefined( level.security_drones ) )
    {
        foreach ( var_2 in level.security_drones )
        {
            if ( isdefined( var_2 ) )
                var_2 _meth_8052();
        }
    }
}

ending_fade_out( var_0 )
{
    var_1 = newhudelem();
    var_1.x = 0;
    var_1.y = 0;
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1 _meth_80CC( "black", 640, 480 );

    if ( isdefined( var_0 ) && var_0 > 0 )
    {
        var_1.alpha = 0;
        var_1 fadeovertime( var_0 );
        var_1.alpha = 1;
        wait(var_0);
    }
}

introscreen_generic_fade_out( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1.5;

    var_4 = newhudelem();
    var_4.x = 0;
    var_4.y = 0;
    var_4.horzalign = "fullscreen";
    var_4.vertalign = "fullscreen";
    var_4.foreground = 1;
    var_4 _meth_80CC( var_0, 640, 480 );

    if ( isdefined( var_3 ) && var_3 > 0 )
    {
        var_4.alpha = 0;
        var_4 fadeovertime( var_3 );
        var_4.alpha = 1;
        wait(var_3);
    }

    wait(var_1);

    if ( isdefined( var_2 ) && var_2 > 0 )
    {
        var_4.alpha = 1;
        var_4 fadeovertime( var_2 );
        var_4.alpha = 0;
    }

    var_4 destroy();
}

canal_finale_fov_shift_on( var_0 )
{
    var_1 = 55;
    level.player _meth_8031( var_1, 0.5 );
}

canal_finale_fov_shift_off( var_0 )
{
    if ( !isdefined( level.origfov ) )
        level.origfov = 65;

    level.player _meth_8031( level.origfov, 0.5 );
}

canal_finale_shock( var_0 )
{
    var_1 = 4;
    level.player shellshock( "seo_canal_finale_blowback", var_1 );
}

canal_finale_rumble( var_0 )
{
    wait 10;
    level thread maps\_utility::notify_delay( "manual_light_rumble_end", 8 );
    maps\seoul_code_gangnam::do_continuous_rumble( "manual_light_rumble_end", "damage_light" );
    wait 3;
    level.player _meth_80AD( "damage_heavy" );
}

canal_finale_rumble_sm( var_0 )
{
    level.player _meth_80AD( "damage_light" );
}

play_fullscreen_blood_splatter( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = newclienthudelem( self );
    var_5.x = 0;
    var_5.y = 0;
    var_5 _meth_80CC( var_0, 640, 480 );
    var_5.splatter = 1;
    var_5.alignx = "left";
    var_5.aligny = "top";
    var_5.sort = 1;
    var_5.foreground = 0;
    var_5.horzalign = "fullscreen";
    var_5.vertalign = "fullscreen";
    var_5.alpha = 0;
    var_5.enablehudlighting = 1;
    var_6 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_3 ) )
        var_3 = 1;

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    var_7 = 0.05;

    if ( var_2 > 0 )
    {
        var_8 = 0;
        var_9 = var_4 / ( var_2 / var_7 );

        while ( var_8 < var_4 )
        {
            var_5.alpha = var_8;
            var_8 += var_9;
            wait(var_7);
        }
    }

    var_5.alpha = var_4;
    wait(var_1 - var_2 + var_3);

    if ( var_3 > 0 )
    {
        var_8 = var_4;
        var_10 = var_4 / ( var_3 / var_7 );

        while ( var_8 > 0 )
        {
            var_5.alpha = var_8;
            var_8 -= var_10;
            wait(var_7);
        }
    }

    var_5.alpha = 0;
    var_5 destroy();
}

canal_finale_button_mashing()
{
    var_0 = use_pressed();
    var_1 = spawnstruct();
    var_1 thread occumulate_player_use_presses( self );
    level.occumulator = var_1;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;

    for (;;)
    {
        var_7 = use_pressed();
        var_8 = 0;
        var_5 = 0;

        if ( var_7 && !var_0 )
        {
            if ( !var_6 )
            {
                var_6 = 1;
                level.player _meth_80AE( self.rumble_loop );
            }

            if ( randomint( 100 ) > self.min_heavy )
                level.player _meth_80AD( "damage_heavy" );
            else if ( randomint( 100 ) > self.min_light )
                level.player _meth_80AD( "damage_light" );

            var_1.presses[var_1.presses.size] = gettime();
            var_4 = gettime();
            var_5 = ( sin( gettime() * 0.2 ) + 1 ) * 0.5;
            var_5 *= self.range;
            var_5 += self.rate;
            var_8 = 1;
        }

        if ( var_6 && gettime() > var_4 + 300 )
        {
            var_6 = 0;
            level.player _meth_80AF( self.rumble_loop );
        }

        var_0 = var_7;
        var_9 = 0;
        var_3 = undefined;

        if ( isdefined( self.set_pull_weight ) )
            level.additive_pull_weight = var_3;

        if ( isdefined( self.auto_occumulator_base ) )
        {
            var_1.occumulator_base = 1 - var_3;
            var_1.occumulator_base *= 7;
            var_1.occumulator_base = clamp( var_1.occumulator_base, 7, 1 );
        }

        var_10 = abs( var_2 - var_3 );

        if ( var_10 > 0.05 )
        {
            new_pull_earthquake( var_3 );
            var_2 = var_3;
        }

        if ( var_9 )
            break;

        wait 0.05;
    }
}

use_pressed()
{
    return level.player usebuttonpressed();
}

occumulate_player_use_presses( var_0 )
{
    self endon( "stop" );
    var_1 = 1500;
    self.presses = [];
    var_2 = 7;

    for (;;)
    {
        waittillframeend;

        for ( var_3 = 0; var_3 < self.presses.size; var_3++ )
        {
            var_4 = self.presses[var_3];

            if ( var_4 < gettime() - var_1 )
                continue;

            break;
        }

        for ( var_5 = []; var_3 < self.presses.size; var_3++ )
            var_5[var_5.size] = self.presses[var_3];

        self.presses = var_5;
        var_6 = ( self.presses.size - var_0.occumulator_base ) * 0.03;
        var_6 *= 10;
        var_6 = clamp( var_6, 0, 1.0 );
        self.occumulator_scale = var_6;
        wait 0.05;
    }
}

new_pull_earthquake( var_0 )
{
    if ( isdefined( self.override_anim_time ) )
        var_0 = self.override_anim_time;

    var_1 = var_0 + 0.37;
    var_1 *= 0.22;
    earthquake( var_1, 5, level.player.origin, 5000 );
}

goto_node( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 16;

    maps\_utility::set_goal_radius( var_2 );

    if ( isstring( var_0 ) )
        var_3 = getnode( var_0, "script_noteworthy" );
    else
        var_3 = var_0;

    if ( isdefined( var_3 ) )
        maps\_utility::set_goal_node( var_3 );
    else
    {
        var_3 = common_scripts\utility::getstruct( var_0, "script_noteworthy" );
        maps\_utility::set_goal_pos( var_3.origin );
    }

    if ( var_1 )
        self waittill( "goal" );
}

cleanup_ai_with_script_noteworthy( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 512;

    var_2 = [];

    foreach ( var_4 in getentarray( var_0, "script_noteworthy" ) )
    {
        if ( isspawner( var_4 ) )
        {
            var_4 delete();
            continue;
        }

        var_2[var_2.size] = var_4;
    }

    thread maps\_utility::ai_delete_when_out_of_sight( var_2, var_1 );
}

sd_spawn_and_retreat_goals( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( isdefined( var_0 ) )
        maps\_utility::trigger_wait_targetname( var_0 );

    var_8 = [];

    if ( isdefined( var_2 ) )
    {
        var_9 = getent( var_1, "script_noteworthy" );

        for ( var_10 = 0; var_10 < var_2; var_10++ )
            var_8[var_8.size] = var_9 maps\_shg_design_tools::actual_spawn( 1 );
    }
    else
        var_8 = maps\_utility::array_spawn_noteworthy( var_1, 1 );

    foreach ( var_12 in var_8 )
    {
        if ( isdefined( var_3 ) )
        {
            var_13 = getent( var_3, "targetname" );
            var_12 _meth_81A9( var_13 );
        }

        var_12.grenadeammo = 0;
        var_12.script_careful = 1;
        thread change_color_node_quick();
        wait 0.05;
    }

    if ( isdefined( var_4 ) || isdefined( var_5 ) )
    {
        if ( !isdefined( var_4 ) )
            common_scripts\utility::flag_wait( var_5 );
        else
        {
            var_8 = maps\_utility::array_removedead_or_dying( var_8 );

            while ( var_8.size > var_4 )
            {
                var_8 = maps\_utility::array_removedead_or_dying( var_8 );
                wait 0.05;

                if ( isdefined( var_5 ) && common_scripts\utility::flag( var_5 ) )
                    return;
            }
        }
    }

    if ( isdefined( var_6 ) )
    {
        var_15 = getent( var_6, "targetname" );
        var_8 = maps\_utility::array_removedead( var_8 );

        foreach ( var_12 in var_8 )
            var_12 _meth_81A9( var_15 );
    }

    if ( isdefined( var_7 ) )
    {
        maps\_utility::wait_for_targetname_trigger( var_7 );
        maps\_utility::ai_delete_when_out_of_sight( var_8, 40 );
    }
}

attach_flashlight_on_gun()
{
    if ( !isdefined( self.gun_flashlight ) || !self.gun_flashlight )
    {
        playfxontag( level._effect["flashlight"], self, "tag_flash" );
        self.gun_flashlight = 1;
        self notify( "flashlight_on_gun" );
    }
}

remove_patrol_anim_set()
{
    self.patrol_walk_twitch = undefined;
    self.patrol_walk_anim = undefined;
    self.script_animation = undefined;
    maps\_utility::clear_generic_run_anim();
    self.goalradius = 512;
    self _meth_81CA( "stand", "crouch", "prone" );
    self.disablearrivals = 0;
    self.disableexits = 0;
    self.allowdeath = 1;

    if ( isdefined( self.oldcombatmode ) )
        self.combatmode = self.oldcombatmode;

    maps\_utility::enable_cqbwalk();
}

sd_drone_patrol_think()
{
    self endon( "death" );
    level.cormack.ignoreall = 1;
    level.will_irons.ignoreall = 1;
    level.jackson.ignoreall = 1;
    maps\_vehicle::gopath( self );
    self.ignoreall = 1;
    self.alertlevel = "noncombat";
    self.health = 50;
    self _meth_82C0( 1 );
    self _meth_8139( self.script_team );
    thread maps\seoul_fx::drone_search_light_fx();
    self _meth_8041( "grenade danger" );
    self _meth_8041( "gunshot" );
    self _meth_8041( "bulletwhizby" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "death" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "damage" );
    maps\_utility::add_wait( maps\_utility::waittill_msg, "ai_event" );
    maps\_utility::add_func( common_scripts\utility::flag_set, "wakeup_drones" );
    thread maps\_utility::do_wait_any();
    common_scripts\utility::flag_wait( "wakeup_drones" );
    self.ignoreall = 0;
    self.target = undefined;
    maps\_utility::vehicle_detachfrompath();
    thread vehicle_scripts\_pdrone::flying_attack_drone_logic();
    wait 0.05;
    thread maps\seoul_fx::drone_spot_light( self );
    level.cormack.ignoreall = 0;
    level.will_irons.ignoreall = 0;
    level.jackson.ignoreall = 0;
}

change_color_node_quick()
{
    self notify( "started_color_node_quick" );
    self endon( "started_color_node_quick" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "color_code_move_update", var_0 );
        thread change_color_node_quick_player_close_check();
        var_1 = 0;

        if ( var_1 == 0 )
        {
            self.ignoreall = 1;
            self.goalradius = 20;
            common_scripts\utility::waittill_any( "goal", "damage", "player_close" );
            self.ignoreall = 0;
            self.goalradius = 500;
        }

        self waittill( "goal" );
        self.fixednode = 0;
        waitframe();
    }
}

change_color_node_quick_player_close_check()
{
    self notify( "started_color_node_quick_close_check" );
    self endon( "started_color_node_quick_close_check" );
    self endon( "death" );
    self endon( "damage" );
    self endon( "goal" );

    while ( distancesquared( level.player.origin, self.origin ) > squared( 100 ) )
        wait 0.25;

    self notify( "player_close" );
}

sd_anim_reach_and_play_loop( var_0, var_1, var_2 )
{
    maps\_anim::anim_reach_solo( var_0, "seo_canal_overlook_anim" );
    thread maps\_anim::anim_loop_solo( var_0, "seo_canal_overlook_anim", var_2 );
}

sd_anim_generic_reach_and_play( var_0, var_1, var_2 )
{
    var_0 endon( "death" );

    if ( isdefined( var_2 ) && var_2 )
        maps\_anim::anim_generic_reach( var_0, var_1 );
    else
    {
        var_0 _meth_81A6( self.origin );

        while ( distance( var_0.origin, self.origin ) > 32 )
            wait 0.05;
    }

    var_0 notify( "new_anim_reach" );
    self notify( "reach_notify" );
    maps\_anim::anim_generic( var_0, var_1 );
    var_0 notify( "anim_reached_and_played" );
}

sign_explosion_flash_damage()
{
    var_0 = _func_231( "destp_seo_shopping_district_sign_02", "targetname" );
    var_1 = _func_231( "destp_seo_shopping_district_sign_02", "targetname" );
    var_2 = getentarray( "scriptable_destp_advertisement_inside_03", "classname" );
    var_3 = getentarray( "scriptable_destp_advertisement_inside_04", "classname" );
    var_4 = _func_231( "destp_seo_shopping_district_sign_06", "targetname" );
    var_5 = _func_231( "destp_seo_shopping_district_sign_07", "targetname" );
    var_6 = _func_231( "destp_seo_electrical_box_02", "targetname" );
    level.flash_signs = var_0;
    level.flash_signs = common_scripts\utility::array_combine( level.flash_signs, var_1 );
    level.flash_signs = common_scripts\utility::array_combine( level.flash_signs, var_2 );
    level.flash_signs = common_scripts\utility::array_combine( level.flash_signs, var_3 );
    level.flash_signs = common_scripts\utility::array_combine( level.flash_signs, var_4 );
    level.flash_signs = common_scripts\utility::array_combine( level.flash_signs, var_5 );
    level.flash_signs = common_scripts\utility::array_combine( level.flash_signs, var_6 );
    level.flash_signs = common_scripts\utility::array_removeundefined( level.flash_signs );

    foreach ( var_8 in level.flash_signs )
        var_8 thread sign_flash_damage();
}

sign_flash_damage()
{
    self waittill( "state_changed", var_0, var_1, var_2, var_3, var_4, var_5 );
    var_6 = _func_0D6();
    var_6 = maps\_utility::array_removedead_or_dying( var_6 );

    foreach ( var_8 in var_6 )
    {
        if ( distance( var_8.origin, self.origin ) < 200 )
            var_8 maps\_utility::flashbangstart( randomfloatrange( 1, 1.5 ) );
    }

    level.flash_signs = common_scripts\utility::array_remove( level.flash_signs, self );
}

sd_zipline_enemy_think( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_0;

    foreach ( var_8 in var_6 )
    {
        if ( isdefined( var_1 ) )
        {
            var_9 = getent( var_1, "targetname" );
            var_8 _meth_81A9( var_9 );
        }

        var_8.grenadeammo = 0;
        var_8 thread change_color_node_quick();
        wait 0.05;
    }

    if ( isdefined( var_2 ) || isdefined( var_3 ) )
    {
        if ( !isdefined( var_2 ) )
            common_scripts\utility::flag_wait( var_3 );
        else
        {
            var_6 = maps\_utility::array_removedead_or_dying( var_6 );

            while ( var_6.size > var_2 )
            {
                var_6 = maps\_utility::array_removedead_or_dying( var_6 );
                wait 0.05;

                if ( isdefined( var_3 ) && common_scripts\utility::flag( var_3 ) )
                    return;
            }
        }
    }

    if ( isdefined( var_4 ) )
    {
        var_11 = getent( var_4, "targetname" );
        var_6 = maps\_utility::array_removedead( var_6 );

        foreach ( var_8 in var_6 )
            var_8 _meth_81A9( var_11 );
    }

    if ( isdefined( var_5 ) )
    {
        maps\_utility::wait_for_targetname_trigger( var_5 );
        maps\_utility::ai_delete_when_out_of_sight( var_6, 40 );
    }
}

bloody_death( var_0 )
{
    self endon( "death" );

    if ( !issentient( self ) || !isalive( self ) )
        return;

    if ( isdefined( self.bloody_death ) && self.bloody_death )
        return;

    self.bloody_death = 1;

    if ( isdefined( var_0 ) )
        wait(randomfloat( var_0 ));

    var_1 = [];
    var_1[0] = "j_hip_le";
    var_1[1] = "j_hip_ri";
    var_1[2] = "j_head";
    var_1[3] = "j_spine4";
    var_1[4] = "j_elbow_le";
    var_1[5] = "j_elbow_ri";
    var_1[6] = "j_clavicle_le";
    var_1[7] = "j_clavicle_ri";

    for ( var_2 = 0; var_2 < 3 + randomint( 5 ); var_2++ )
    {
        var_3 = randomintrange( 0, var_1.size );
        thread bloody_death_fx( var_1[var_3], undefined );
        wait(randomfloat( 0.1 ));
    }

    self _meth_8051( self.health + 50, self.origin );
}

bloody_death_fx( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level._effect["flesh_hit"];

    playfxontag( var_1, self, var_0 );
}

seo_finale_rumble_light( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        level.player _meth_80AD( "damage_light" );
    else
    {
        if ( isarray( var_1 ) )
        {
            var_2 = var_1[0];
            var_3 = var_1[1];
            var_4 = var_1[2];
            wait(var_3);
        }
        else
            var_2 = var_1;

        var_5 = randomfloat( 1000 );
        var_6 = "rumble_heavy" + var_5;
        level thread maps\_utility::notify_delay( var_6, var_2 );
        level endon( var_6 );

        for (;;)
        {
            level.player _meth_80AD( "damage_light" );
            wait 0.1;
        }
    }
}

seo_finale_rumble_heavy( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        level.player _meth_80AD( "damage_heavy" );
    else
    {
        if ( isarray( var_1 ) )
        {
            var_2 = var_1[0];
            var_3 = var_1[1];
            var_4 = var_1[2];
            wait(var_3);
        }
        else
            var_2 = var_1;

        var_5 = randomfloat( 1000 );
        var_6 = "rumble_heavy" + var_5;
        level thread maps\_utility::notify_delay( var_6, var_2 );
        level endon( var_6 );

        for (;;)
        {
            level.player _meth_80AD( "damage_light" );
            wait 0.1;
        }
    }
}
