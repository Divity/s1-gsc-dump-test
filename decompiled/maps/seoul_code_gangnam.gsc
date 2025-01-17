// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

gangnam_main()
{
    _func_0D3( "high_jump_double_tap", "1" );
    common_scripts\utility::flag_init( "hault_column" );
    common_scripts\utility::flag_init( "opening_view_off" );
    common_scripts\utility::flag_init( "cloud_queen_retreat_path" );
    common_scripts\utility::flag_init( "shoot_guide_now" );
    common_scripts\utility::flag_init( "orders_given_lets_move_out" );
    common_scripts\utility::flag_init( "incoming_rocket_fire" );
    common_scripts\utility::flag_init( "kill_rocket_scene_guy" );
    common_scripts\utility::flag_init( "encounter_01_done" );
    common_scripts\utility::flag_init( "truck_push_initiate" );
    common_scripts\utility::flag_init( "second_land_assist_go" );
    common_scripts\utility::flag_init( "fob_animation_complete" );
    common_scripts\utility::flag_init( "destroy_fob_blocking" );
    common_scripts\utility::flag_init( "player_initiated_door_ripoff" );
    common_scripts\utility::flag_init( "guy_dragged_success" );
    common_scripts\utility::flag_init( "send_will_2secs_early" );
    common_scripts\utility::flag_init( "player_passed_fob" );
    common_scripts\utility::flag_init( "land_assist_activated" );
    common_scripts\utility::flag_init( "e3_presentation_cleanup" );
    common_scripts\utility::flag_init( "snake_swarm_first_flyby_begin" );
    common_scripts\utility::flag_init( "npc_pods_landed" );
    common_scripts\utility::flag_init( "player_just_grabbed_door" );
    common_scripts\utility::flag_init( "snake_swarm_cardoor_charge_end" );
    common_scripts\utility::flag_init( "dropoff_drones_exit" );
    common_scripts\utility::flag_init( "end_lobby_loopers" );
    common_scripts\utility::flag_init( "all_targeted_drones_dead" );
    common_scripts\utility::flag_init( "ignore_land_assist_hint" );
    common_scripts\utility::flag_init( "end_smart_grenade_hint" );
    common_scripts\utility::flag_init( "drone_swarm_complete" );
    common_scripts\utility::flag_init( "all_drones_dead" );
    common_scripts\utility::flag_init( "jump_training_ended" );
    common_scripts\utility::flag_init( "objective_start" );
    common_scripts\utility::flag_init( "objective_cardoor" );
    common_scripts\utility::flag_init( "objective_mobile_turret" );
    common_scripts\utility::flag_init( "vista_bomber_trigger_01" );
    common_scripts\utility::flag_init( "vista_bomber_trigger_02" );
    common_scripts\utility::flag_init( "vista_bomber_trigger_03" );
    common_scripts\utility::flag_init( "dialogue_performing_arts_interior" );
    common_scripts\utility::flag_init( "dialogue_performing_arts_exit" );
    common_scripts\utility::flag_init( "spawn_regular_heroes" );
    common_scripts\utility::flag_init( "spawn_guys_for_intro" );
    common_scripts\utility::flag_init( "video_log_playing" );
    common_scripts\utility::flag_init( "will_cardoor_watcher_flag" );
    common_scripts\utility::flag_init( "flag_drone_ok_to_follow" );
    common_scripts\utility::flag_init( "enable_door_clip" );
    common_scripts\utility::flag_init( "begin_mech_reload" );
    common_scripts\utility::flag_init( "flag_drone_buzz_will" );
    common_scripts\utility::flag_init( "flag_drone_street_strafe" );
    common_scripts\utility::flag_init( "start_drone_turret_charge" );
    common_scripts\utility::flag_init( "end_drone_turret_charge" );
    common_scripts\utility::flag_init( "ok_to_land_assist" );
    common_scripts\utility::flag_init( "spawn_looping_planes" );
    common_scripts\utility::flag_init( "guy4_reached_goal" );
    common_scripts\utility::flag_init( "guy5_reached_goal" );
    common_scripts\utility::flag_init( "guy6_reached_goal" );
    common_scripts\utility::flag_init( "guy7_reached_goal" );
    common_scripts\utility::flag_init( "guy8_reached_goal" );
    common_scripts\utility::flag_init( "guy9_reached_goal" );
    common_scripts\utility::flag_init( "tank_is_clear" );
    common_scripts\utility::flag_init( "follow_tank_is_dead" );
    common_scripts\utility::flag_init( "wep_drone_dropoff_start" );
    common_scripts\utility::flag_init( "drones_cleared_building" );
    common_scripts\utility::flag_init( "flag_cormack_has_arrived_at_hill" );
    common_scripts\utility::flag_init( "flag_will_irons_has_arrived_at_hill" );
    common_scripts\utility::flag_init( "seoul_player_can_exit_x4walker" );
    common_scripts\utility::flag_init( "walker_tank_is_dead" );
    common_scripts\utility::flag_init( "boost_dodge_hint_off" );
    common_scripts\utility::flag_init( "pause_credits" );
    common_scripts\utility::flag_init( "kill_credits" );
    maps\_player_high_jump::main();

    if ( level.nextgen )
        maps\_drone_civilian::init();

    maps\_player_land_assist::land_assist_init();
    maps\_car_door_shield::init_door_shield();
    vehicle_scripts\_attack_drone_common::attack_drone_formation_init();
    vehicle_scripts\_attack_drone::drone_swarm_init();
    maps\_drone_ai::init();

    if ( level.currentgen )
    {
        thread maps\seoul_transients_cg::cg_tff_transition_eastview_to_fob();
        thread maps\seoul_transients_cg::cg_tff_transition_fob_to_droneswarmone();
        thread maps\seoul_transients_cg::cg_tff_transition_fob_to_truckpush();
        thread maps\seoul_transients_cg::cg_tff_transition_droneswarmone_to_mall();
        thread maps\seoul_transients_cg::cg_tff_transition_mall_to_shinkhole();
        thread maps\seoul_transients_cg::cg_tff_transition_shinkhole_to_subway();
        thread maps\seoul_transients_cg::cg_tff_transition_subway_to_shoppingdistrict();
        thread maps\seoul_transients_cg::cg_tff_transition_shopping_to_canaloverlook();
        thread maps\seoul_transients_cg::cg_tff_transition_canaloverlook_to_riverwalk();
        thread maps\seoul_transients_cg::cg_tff_set_up_transient_meshes();
        thread maps\seoul_transients_cg::cg_swap_tank_treads_mat();
    }

    level.fxtags_bigwar = [];
    level.fxtags_space = [];
    level.fxtags_streets = [];
    level.enemy_bullet = [];
    level.enemy_bullet[0] = "iw5_hbra3_sp";
    level.enemy_bullet[1] = "dshk_turret_so_osprey";
    level.enemy_bullet[2] = "ac130_25mm";
    level.drone_bullet = "iw5_attackdronegunseoul";
    level.cherry_picker_hud = "bls_ui_turret_overlay_sm_alt";
    level.cherry_picker_hud_emp = "bls_ui_turret_overlay_sm_alt_emp";
    level.cherry_picker_hud_drone = "bls_ui_turret_overlay_sm_alt_drone";
    level.cherry_picker_hud_drone2 = "bls_ui_turret_overlay_sm_alt_drone2";
    level.cherry_picker_hud_bar = "hud_white_box";
    level.vista_ents = [];
    level.walker_for_swarm = undefined;
    level.monitor_setup_group = [];
    level.walker_tank_reload_ok = 0;

    if ( level.nextgen )
        level.min_drone_swarm_size = randomintrange( 180, 210 );
    else
        level.min_drone_swarm_size = randomintrange( 70, 80 );

    _func_0D3( "r_hudoutlineenable", 1 );
    _func_0D3( "r_hudoutlinewidth", 2 );
    precacheitem( level.enemy_bullet[1] );
    precacheitem( level.enemy_bullet[2] );
    precacheitem( level.drone_bullet );
    precacheitem( "iw5_em1_sp_opticstargetenhancer" );
    precacheitem( "rpg_straight" );
    precacheitem( "ac130_25mm" );
    precacheitem( "dshk_turret_so_osprey" );
    precacheitem( "rpg_guided" );
    precacheitem( "hovertank_missile_small_straight" );
    precachemodel( "npc_zipline101ft" );
    precachemodel( "projectile_rpg7" );
    precachemodel( "vehicle_sentinel_survey_drone" );
    precachemodel( "vehicle_walker_tank" );
    precachemodel( "npc_atlas_suv_door_fr" );
    precachemodel( "npc_atlas_suv_door_fl" );
    precachemodel( "vm_atlas_suv_door_fl" );
    precachemodel( "vehicle_mil_cargo_truck_ai" );
    precachemodel( "vehicle_mil_drop_pod" );
    precachemodel( "vehicle_mil_drop_pod_seats" );

    if ( level.nextgen )
        precachemodel( "vehicle_mil_drop_pod_static_landed" );

    precachemodel( "mil_drop_pod_seat" );
    precachemodel( "vehicle_mil_drop_pod_intro" );

    if ( level.currentgen )
    {
        precacheshader( "mtl_mil_drop_pod_int" );
        precacheshader( "mtl_marines_assault_combine" );
        precacheshader( "mtl_marines_assault_loadouts" );
        precacheshader( "mtl_marines_smg_loadouts" );
        precacheshader( "mtl_marines_exo" );
        precacheshader( "mtl_cormack_marines_body_cg" );
        precacheshader( "mtl_cormack_marines_loadouts_cg" );
        precacheshader( "mtl_will_marines_lowerbody_body_cg" );
        precacheshader( "mtl_will_marines_upperbody_cg" );
    }

    precachemodel( "vehicle_mil_drop_pod_screens" );
    precachemodel( "mil_drop_pod_seat_rack" );
    precachemodel( "mil_drop_pod_seat_cpt" );
    precachemodel( "mil_drop_pod_seat_simple" );
    precachemodel( "projectile_javelin_missile" );
    precachemodel( "vehicle_civ_pickup_truck_01_wrecked" );
    precachemodel( "vehicle_mil_attack_drone_static_orange" );
    precachemodel( "vehicle_mil_attack_drone_static" );
    precachemodel( "vehicle_mil_mwp_static" );
    precachemodel( "vehicle_mil_drop_pod_static_gsq" );
    precachemodel( "crate_supply_01_long_full" );
    precacheshader( level.cherry_picker_hud );
    precacheshader( level.cherry_picker_hud_emp );
    precacheshader( level.cherry_picker_hud_bar );
    precacheshader( level.cherry_picker_hud_drone );
    precacheshader( level.cherry_picker_hud_drone2 );
    _func_251( "lag_snipper_laser" );
    precacheshader( "drone_turret_hud_target" );
    precacheshader( "drone_turret_hud_locking" );
    precacheshader( "hud_white_box" );
    precacheshader( "dpad_icon_land_assist" );
    precachemodel( "vm_himar_base_loot_sp" );
    precacherumble( "heavy_3s" );
    maps\_utility::add_hint_string( "jump_training", &"SEOUL_DOUBLE_TAP_A_FOR_BOOST_JUMP", ::boost_hint_breakout );
    maps\_utility::add_hint_string( "press_a_for_emp", &"SEOUL_PRESS_A_FOR_EMP", ::emp_prompt_breakout );
    maps\_utility::add_hint_string( "smart_grenade_training", &"SEOUL_USE_SMART_GRENADE", ::smart_hint_breakout );
    maps\_utility::add_hint_string( "car_door_throw", &"SEOUL_CARDOOR_THROW", ::cardoor_hint_breakout );
    maps\_utility::add_hint_string( "boost_slam_train", &"SEOUL_TRAIN_BOOST_SLAM", ::slam_hint_breakout );
    maps\_utility::add_control_based_hint_strings( "x_for_hover", &"SEOUL_PRESS_X_FOR_COUNTER_THRUSTERS", ::land_assist_hint_breakout, &"SEOUL_PRESS_X_FOR_COUNTER_THRUSTERS_PC" );
    maps\_utility::add_control_based_hint_strings( "x_for_hover_alt", &"SEOUL_PRESS_X_FOR_COUNTER_THRUSTERS", ::land_assist_hint_safe_descent_breakout, &"SEOUL_PRESS_X_FOR_COUNTER_THRUSTERS_PC" );
    maps\_utility::add_control_based_hint_strings( "x_for_hover_across", &"SEOUL_LAND_ASSIST_HOVER", ::hover_hint_breakout, &"SEOUL_LAND_ASSIST_HOVER_PC" );
    maps\_utility::add_control_based_hint_strings( "ads_train", &"SEOUL_ADS_TRAINING", ::ads_hint_breakout, &"SEOUL_ADS_TRAINING_PC" );
    maps\_utility::add_control_based_hint_strings( "lt_rt_harness", &"SEOUL_LT_OR_RT_TO_RELEASE_HARNESS", ::lt_rt_harness_breakout, &"SEOUL_LT_OR_RT_TO_RELEASE_HARNESS_PC" );
    maps\_utility::add_control_based_hint_strings( "rt_right_harness", &"SEOUL_RT_TO_RELEASE_RIGHT_HARNESS", ::rt_harness_breakout, &"SEOUL_RT_TO_RELEASE_RIGHT_HARNESS_PC" );
    maps\_utility::add_control_based_hint_strings( "lt_left_harness", &"SEOUL_LT_TO_RELEASE_LEFT_HARNESS", ::lt_harness_breakout, &"SEOUL_LT_TO_RELEASE_LEFT_HARNESS_PC" );
    maps\_utility::add_control_based_hint_strings( "a_to_open_hatch", &"SEOUL_PRESS_A_TO_OPEN_HATCH", ::open_hatch_breakout, &"SEOUL_PRESS_A_TO_OPEN_HATCH_PC", &"SEOUL_PRESS_A_TO_OPEN_HATCH_SP" );
    maps\_utility::add_control_based_hint_strings( "boost_dodge_train", &"SEOUL_TRAIN_BOOST_DODGE", ::dodge_hint_breakout, &"SEOUL_TRAIN_BOOST_DODGE_PC", &"SEOUL_TRAIN_BOOST_DODGE_SP" );
    common_scripts\utility::flag_set( "ok_to_land_assist" );
    thread gangnam_autosave();
    thread jump_type_select();
    thread handle_canal_intro_retreating();
    thread handle_shopping_district_retreating();
    thread handle_boost_dodge_training();
    thread smart_grenade_training();
    level.e3_presentation = 0;
    createthreatbiasgroup( "enemies_ignored_by_allies" );
    createthreatbiasgroup( "allies_ignored_by_enemies" );
    createthreatbiasgroup( "enemies_attack_player" );
    createthreatbiasgroup( "major_allies" );
    createthreatbiasgroup( "enemies_ignored_by_major_allies" );
    createthreatbiasgroup( "enemies_ignore_player" );
    createthreatbiasgroup( "player" );
    setignoremegroup( "enemies_ignored_by_allies", "allies" );
    setignoremegroup( "enemies_ignored_by_major_allies", "major_allies" );
    setignoremegroup( "major_allies", "enemies_ignored_by_major_allies" );
    setignoremegroup( "player", "enemies_ignore_player" );
    setignoremegroup( "major_allies", "enemies_attack_player" );
    level.player _meth_8177( "player" );
    animscripts\traverse\boost::precache_boost_fx_npc();
    thread debug_will_exo_breach();
}

debug_will_exo_breach()
{
    level waittill( "exo_breach_impact" );
    waitframe();
}

debug_hero_pathing()
{
    for (;;)
    {
        self waittill( "bad_path", var_0 );
        common_scripts\utility::draw_line_for_time( self _meth_80A8(), var_0, randomfloat( 1 ), randomfloat( 1 ), randomfloat( 1 ), 0.1 );
    }
}

debug_player_fall()
{
    for (;;)
    {
        level.player waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( var_4 == "MOD_FALLING" || var_4 == "mod_falling" )
            level.player.health = 1;
    }
}

prep_cinematic( var_0 )
{
    _func_0D3( "cg_cinematicFullScreen", "0" );
    _func_057( var_0, 1 );
    level.current_cinematic = var_0;
}

play_cinematic( var_0, var_1, var_2 )
{
    if ( isdefined( level.current_cinematic ) )
    {
        pausecinematicingame( 0 );
        _func_0D3( "cg_cinematicFullScreen", "1" );
        level.current_cinematic = undefined;
    }
    else
        _func_057( var_0 );

    if ( !isdefined( var_2 ) || !var_2 )
        _func_0D3( "cg_cinematicCanPause", "1" );

    wait 1;

    while ( _func_05B() )
        wait 0.05;

    if ( !isdefined( var_2 ) || !var_2 )
        _func_0D3( "cg_cinematicCanPause", "0" );
}

play_seoul_videolog()
{
    _func_0D3( "cg_cinematicfullscreen", "0" );
    thread slow_allies_while_videolog_plays();
    thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    thread emergency_break_videolog();
    thread reduce_player_movement_videolog();
    soundscripts\_snd::snd_message( "seo_video_log_start" );
    common_scripts\utility::flag_set( "video_log_playing" );
    maps\_shg_utility::play_videolog( "seoul_videolog", "screen_add" );
    thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
    thread return_allies_after_videolog_plays();
    thread return_player_movement_videolog();
}

reduce_player_movement_videolog()
{
    level.player maps\_utility::player_speed_percent( 70 );
}

return_player_movement_videolog()
{
    thread maps\seoul::gradually_return_player_speed( 70, 100, 10 );
}

emergency_break_videolog()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_sinkhole_enemy_setup" );

    if ( _func_05B() )
    {
        maps\_shg_utility::stop_videolog();
        wait 1;
        maps\seoul::ingame_movies();
    }
}

handle_player_skipping_setups()
{
    thread player_skipping_setup( "trig_convention_center_combat_05", "vol_tester_skipping_guys_pac", 2 );
    thread player_skipping_setup( "vol_tester_skipping_guys_sinkhole", "volume_sinkhole_enemy_defend", 2 );
    thread player_skipping_setup( "trig_move_to_final_color", "vol_canal_enemy_ai_check_01", 3 );
}

player_skipping_setup( var_0, var_1, var_2 )
{
    maps\_shg_design_tools::waittill_trigger_with_name( var_0 );
    var_3 = getent( var_1, "targetname" );
    var_4 = _func_0D6( "axis" );
    var_5 = [];

    foreach ( var_7 in var_4 )
    {
        if ( var_7 _meth_80A9( var_3 ) )
            var_5[var_5.size] = var_7;
    }

    if ( var_5.size > var_2 )
        thread attack_player_for_time( 10, var_5 );
}

attack_player_for_time( var_0, var_1 )
{
    if ( !isdefined( level.player_is_skipping_setups ) )
        level.player_is_skipping_setups = 1;
    else
        level.player_is_skipping_setups++;

    thread return_threat_bias_from_agro( var_0 );
    var_2 = _func_0D6( "axis" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4 ) & !isdefined( var_4.old_threatbias ) )
        {
            var_4.old_threatbias = var_4 _meth_8178();
            var_4 _meth_8177( "enemies_attack_player" );
            var_4.accuracy = 1;
        }
    }

    foreach ( var_7 in var_1 )
    {
        if ( isdefined( var_7 ) )
            var_7 thread maps\_utility::player_seek( var_0 );
    }
}

return_threat_bias_from_agro( var_0 )
{
    wait(var_0);
    var_1 = _func_0D6( "axis" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        if ( isdefined( var_3.old_threatbias ) )
        {
            var_3 _meth_8177( var_3.old_threatbias );
            continue;
        }

        var_3 _meth_8177( "" );
    }
}

slow_allies_while_videolog_plays()
{
    level.cormack maps\_utility::enable_cqbwalk();
    level.will_irons maps\_utility::enable_cqbwalk();
    level.jackson maps\_utility::enable_cqbwalk();
    level.cormack maps\_utility::set_moveplaybackrate( 0.8 );
    level.will_irons maps\_utility::set_moveplaybackrate( 0.8 );
    level.jackson maps\_utility::set_moveplaybackrate( 0.8 );
}

return_allies_after_videolog_plays()
{
    level.cormack maps\_utility::set_moveplaybackrate( 1 );
    level.will_irons maps\_utility::set_moveplaybackrate( 1 );
    level.jackson maps\_utility::set_moveplaybackrate( 1 );
}

jump_type_select()
{
    wait 1;
    self endon( "death" );
    common_scripts\utility::flag_wait( "ok_to_land_assist" );
    level.player _meth_821B( "actionslot4", "dpad_icon_land_assist" );

    for (;;)
    {
        for (;;)
        {
            level.player waittill( "dpad_right" );

            if ( maps\_player_exo::player_exo_is_active() )
                break;
        }

        level.player thread maps\_player_land_assist::monitor_land_assist_think();
        common_scripts\utility::flag_set( "land_assist_activated" );
        wait 0.5;
        level.player waittill( "dpad_right" );
        level.player notify( "clear_land_assist_process" );
        common_scripts\utility::flag_clear( "land_assist_activated" );
        wait 0.5;
    }
}

waittill_player_uses_land_assist( var_0 )
{
    level.player endon( "dpad_right" );
    level.player endon( "dpad_left" );
    level.player endon( "dpad_up" );
    level.player endon( "landassist_button" );

    while ( common_scripts\utility::flag( "land_assist_activated" ) )
    {
        if ( common_scripts\utility::flag( "ignore_land_assist_hint" ) )
            return;

        var_1 = bullettrace( level.player.origin, level.player.origin - ( 0, 0, 1000 ), 1, level.player, 1, 0 );

        if ( isdefined( var_1["position"] ) )
        {
            if ( distance( var_1["position"], level.player.origin ) > 128 )
                break;
        }

        waitframe();
    }

    level.player waittill( "end_jump_hud" );
}

gangnam_autosave()
{
    level endon( "missionfailed" );
    thread save_game_drone_swarm_street_begin();
    thread save_game_start_building_fob();

    for (;;)
    {
        level waittill( "autosave_request" );
        waitframe();
        maps\_utility::autosave_tactical();
    }
}

save_game_drone_swarm_street_begin()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "seoul_streets_02" );
    level notify( "autosave_request" );
}

save_game_start_building_fob()
{
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    level notify( "autosave_request" );
}

objective_01_on_cormack()
{
    wait 1;

    if ( !common_scripts\utility::flag( "begin_looping_fob_functions" ) )
        level waittill( "droppod_empty" );

    objective_onentity( maps\_utility::obj( "objective_demo_team" ), level.cormack, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    _func_0D3( "objectiveAlphaEnabled", 1 );
    common_scripts\utility::flag_wait( "flag_start_fob_meet_scene" );
    wait 2;
    _func_0D3( "objectiveAlphaEnabled", 0 );
}

objective_01_on_cardoor()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_drone_swarm_flank" );
    var_0 = getentarray( "trig_door_shield", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2.door_clip = getent( var_2.target, "targetname" );
        var_2.door_model = getent( var_2.door_clip.target, "targetname" );
    }

    thread x_on_closest_cardoor();

    foreach ( var_2 in var_0 )
    {
        var_2.door_model notify( "end_hud_outline" );
        var_2.door_model thread stencil_when_cardoor_in_range();
    }

    thread monitor_clear_cardoor_buttons();
}

x_on_closest_cardoor()
{
    level.player endon( "player_has_cardoor" );
    level.player endon( "turret_objective_active" );
    level.cardoor_buttons = [];
    var_0 = common_scripts\utility::getstructarray( "struct_door_ripoff_scene_prompt", "targetname" );
    var_1 = undefined;

    for (;;)
    {
        var_2 = get_best_cardoor_struct( level.player.origin, var_0, 1000 );

        if ( isdefined( var_2 ) && ( !isdefined( var_1 ) || var_1 != var_2 ) )
        {
            foreach ( var_4 in level.cardoor_buttons )
            {
                if ( isdefined( var_4 ) )
                    var_4 maps\_shg_utility::hint_button_clear();
            }

            level.cardoor_buttons[level.cardoor_buttons.size] = maps\_shg_utility::hint_button_position( "x", var_2.origin, 32, 1500 );
            var_1 = var_2;
        }

        waitframe();
    }
}

get_best_cardoor_struct( var_0, var_1, var_2 )
{
    var_3 = getent( "vol_cardoor_objective_vol_a", "targetname" );
    var_4 = getent( "vol_cardoor_objective_vol_b", "targetname" );
    var_5 = getent( "vol_cardoor_objective_vol_c", "targetname" );

    if ( level.player _meth_80A9( var_4 ) )
    {
        foreach ( var_7 in var_1 )
        {
            if ( isdefined( var_7.script_noteworthy ) && issubstr( var_7.script_noteworthy, "vol_b" ) )
                return var_7;
        }
    }
    else
        return common_scripts\utility::getclosest( var_0, var_1, var_2 );
}

stencil_when_cardoor_in_range()
{
    self endon( "death" );
    self endon( "door_weapon_removed" );
    level.player endon( "player_has_cardoor" );
    level.player endon( "turret_objective_active" );
    _func_09A( self );
    _func_0A6( self, level.player );
    _func_0D3( "r_hudoutlinewidth", 4 );
    self.normal_stencil = 0;
    thread handle_cardoor_outline_on();
    thread handle_cardoor_outline_off();
}

handle_cardoor_outline_off()
{
    level.player common_scripts\utility::waittill_either( "player_has_cardoor", "turret_objective_active" );
    self _meth_83FB();
}

handle_cardoor_outline_on()
{
    self endon( "death" );
    self endon( "door_weapon_removed" );
    level.player endon( "player_has_cardoor" );
    level.player endon( "turret_objective_active" );

    while ( isdefined( self ) )
    {
        var_0 = distance( level.player.origin, self.origin );

        if ( var_0 < 1500 && _func_09F( self, level.player, 65, 150 ) )
            self _meth_83FA( 6, 1 );
        else
            self _meth_83FB();

        wait 0.05;
    }
}

monitor_clear_cardoor_buttons()
{
    level.player common_scripts\utility::waittill_any( "player_has_cardoor", "turret_objective_active" );

    if ( isdefined( level.cardoor_buttons ) )
    {
        foreach ( var_1 in level.cardoor_buttons )
        {
            if ( isdefined( var_1 ) )
                var_1 maps\_shg_utility::hint_button_clear();
        }
    }
}

objective_01_on_turret()
{
    thread maps\_shg_design_tools::trigger_to_notify( "trigger_cardoor_strafe" );
    level common_scripts\utility::waittill_either( "turret_objective_given", "trigger_cardoor_strafe" );

    if ( common_scripts\utility::flag( "objective_cardoor" ) )
    {
        common_scripts\utility::flag_waitopen( "objective_cardoor" );
        maps\_utility::objective_clearadditionalpositions( 1 );
    }

    common_scripts\utility::flag_set( "objective_mobile_turret" );
    level.player notify( "turret_objective_active" );
    wait 2;
    _func_0D3( "r_hudoutlinewidth", 1 );
    level.mobile_turret _meth_83FA( 6, 1 );
    level.mobile_turret.mgturret[0] _meth_83FA( 6, 1 );
    var_0 = getent( "mobile_turret_drone_street", "targetname" );
    objective_onentity( maps\_utility::obj( "objective_demo_team" ), var_0.hint_button_locations[1] );
    objective_setpointertextoverride( maps\_utility::obj( "objective_demo_team" ), &"SEOUL_ENTER_MOBILE_TURRET" );

    while ( distance( level.player.origin, level.mobile_turret.origin ) > 450 )
        waitframe();

    level.mobile_turret _meth_83FB();
    level.mobile_turret.mgturret[0] _meth_83FB();
    level.mobile_turret maps\_utility::ent_flag_wait( "player_in_transition" );
    objective_position( maps\_utility::obj( "objective_demo_team" ), ( 0, 0, 0 ) );
    level.player waittill( "player_in_x4walker" );
}

objective_01_on_will()
{
    level waittill( "end_cherry_picker" );
    objective_onentity( maps\_utility::obj( "objective_demo_team" ), level.cormack, ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "objective_demo_team" ), "" );
}

gangnam_objectives()
{
    objective_add( maps\_utility::obj( "objective_demo_team" ), "active", "Regroup with D Company" );
    objective_current( maps\_utility::obj( "objective_demo_team" ) );

    while ( !isdefined( level.cormack ) )
        wait 0.05;

    thread objective_01_on_cormack();
    thread objective_01_on_cardoor();
    thread objective_01_on_turret();
    thread objective_01_on_will();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_teleport_ally_squad_shopping" );
    objective_onentity( maps\_utility::obj( "objective_demo_team" ), level.will_irons, ( 0, 0, 0 ) );
}

seoul_start()
{
    soundscripts\_snd::snd_message( "start_seoul_intro" );
    level.player _meth_83C0( "space_entry" );
    level.player _meth_8490( "clut_seoul_pod_v3", 0 );
    common_scripts\utility::flag_set( "spawn_guys_for_intro" );
    thread setup_building_traverse_and_vista();
    setup_gangnam_station_intersection();
    level.player notify( "disable_player_boost_jump" );
}

seoul_land_assist()
{
    soundscripts\_snd::snd_message( "start_seoul_first_land_assist" );
    maps\_utility::array_delete( getentarray( "start_building_ext_hide", "targetname" ) );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    var_0 = common_scripts\utility::getstruct( "struct_start_first_land_assist", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_start_first_land_assist_npc", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    common_scripts\utility::flag_set( "set_seoul_hotel_lighting" );
    common_scripts\utility::flag_set( "objective_start" );
    setup_gangnam_station_intersection();
    level.will_irons _meth_81C6( var_1[0].origin, var_1[0].angles );
    level.cormack _meth_81C6( var_1[1].origin, var_1[1].angles );
    level.jackson _meth_81C6( var_1[2].origin, var_1[2].angles );
    allies_to_first_land_assist_debug();
    level.player notify( "disable_player_boost_jump" );
}

seoul_encounter_01()
{
    soundscripts\_snd::snd_message( "start_seoul_enemy_encounter_01" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    var_0 = common_scripts\utility::getstruct( "struct_player_start_encounter_01", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_npc_start_encounter_01", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player _meth_83C0( "seoul_hotel_top" );
    level.player _meth_8490( "clut_seoul_hotel_atrium", 0 );
    maps\_utility::vision_set_fog_changes( "seoul_hotel_interior", 0 );
    common_scripts\utility::flag_set( "set_seoul_hotel_lighting" );
    common_scripts\utility::flag_set( "objective_start" );
    setup_gangnam_station_intersection();
    level.will_irons _meth_81C6( var_1[0].origin, var_1[0].angles );
    level.cormack _meth_81C6( var_1[1].origin, var_1[1].angles );
    level.jackson _meth_81C6( var_1[2].origin, var_1[2].angles );
    level.player notify( "glass_gag_done" );
    level.player notify( "disable_player_boost_jump" );
}

seoul_missile_evade()
{
    soundscripts\_snd::snd_message( "start_seoul_missle_evade_sequence" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    var_0 = common_scripts\utility::getstruct( "struct_missile_evade_start", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_missile_evade_start_01", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    common_scripts\utility::flag_set( "set_seoul_hotel_lighting" );
    common_scripts\utility::flag_set( "objective_start" );
    setup_gangnam_station_intersection();
    level.will_irons _meth_81C6( var_1[0].origin, var_1[0].angles );
    level.cormack _meth_81C6( var_1[1].origin, var_1[1].angles );
    level.jackson _meth_81C6( var_1[2].origin, var_1[2].angles );
}

seoul_fob()
{
    soundscripts\_snd::snd_message( "start_seoul_forward_operating_base" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    var_0 = common_scripts\utility::getstruct( "struct_start_point_fob", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_start_point_fob_1", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player _meth_83C0( "seoul_streets" );
    level.player _meth_8490( "clut_seoul_fob", 0 );
    maps\_utility::vision_set_fog_changes( "seoul_streets", 0 );
    common_scripts\utility::flag_set( "set_seoul_fob_lighting" );
    common_scripts\utility::flag_set( "end_lobby_loopers" );
    common_scripts\utility::flag_set( "objective_start" );
    common_scripts\utility::flag_set( "begin_looping_fob_functions" );
    common_scripts\utility::flag_set( "stop_flooding_grunts" );
    setup_gangnam_station_intersection();
    level.jackson _meth_81C6( var_1[2].origin, var_1[2].angles );
    var_2 = common_scripts\utility::getstruct( "struct_building_exit_cormack_idle", "targetname" );
    var_3 = common_scripts\utility::getstruct( "struct_building_exit_will_idle", "targetname" );
    var_2 thread maps\_anim::anim_loop_solo( level.cormack, var_2.animation );
    var_3 thread maps\_anim::anim_loop_solo( level.will_irons, "casual_stand_idle" );
    level.will_irons maps\_utility::disable_cqbwalk();
    level.cormack maps\_utility::disable_cqbwalk();
    level.jackson maps\_utility::disable_cqbwalk();
    level.will_irons maps\_utility::set_run_anim( "seo_react_to_war_run_npc2" );
    level.cormack maps\_utility::set_run_anim( "seo_react_to_war_run_npc1" );
    level.jackson maps\_utility::set_run_anim( "seo_react_to_war_run_npc2" );
    wait 0.3;
    common_scripts\utility::flag_set( "begin_fob_combat_vignette" );
    var_2 notify( "stop_loop" );
    level.cormack _meth_8141();
    var_3 notify( "stop_loop" );
    level.will_irons _meth_8141();
    level.player notify( "trigger_allies_to_fob" );
    wait 0.3;
    level.player notify( "disable_player_boost_jump" );
}

seoul_drone_swarm_intro()
{
    soundscripts\_snd::snd_message( "start_seoul_drone_swarm_intro" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    var_0 = common_scripts\utility::getstruct( "struct_start_point_drone_swarm_intro", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_start_point_drone_swarm_intro_1", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player _meth_83C0( "seoul_streets" );
    maps\_utility::vision_set_fog_changes( "seoul_streets", 0 );
    common_scripts\utility::flag_set( "set_seoul_drone_swarm_intro_lighting" );
    common_scripts\utility::flag_set( "objective_start" );
    var_2 = getent( "fob_player_clipblock", "targetname" );
    var_2 delete();
    thread fob_blocking();
    setup_gangnam_station_intersection();
    level.will_irons _meth_81C6( var_1[0].origin, var_1[0].angles );
    level.cormack _meth_81C6( var_1[1].origin, var_1[1].angles );
    level.jackson _meth_81C6( var_1[2].origin, var_1[2].angles );
    var_3 = getnode( "node_hill_pause_will", "targetname" );
    level.will_irons _meth_81A5( var_3 );
    var_3 = getnode( "node_hill_pause_guy", "targetname" );
    level.jackson _meth_81A5( var_3 );
    var_3 = getnode( "node_hill_pause_cormack", "targetname" );
    level.cormack _meth_81A5( var_3 );
    level.player notify( "disable_player_boost_jump" );
    thread get_will_to_walker_scene();
    thread get_cormack_to_walker_scene();
}

seoul_truck_push()
{
    soundscripts\_snd::snd_message( "start_seoul_truck_push" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    var_0 = common_scripts\utility::getstruct( "struct_start_truck_push_player", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_start_truck_push_01", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player _meth_83C0( "seoul_streets" );
    maps\_utility::vision_set_fog_changes( "seoul_streets", 0 );
    common_scripts\utility::flag_set( "set_seoul_drone_swarm_intro_lighting" );
    setup_gangnam_station_intersection();
    common_scripts\utility::flag_set( "objective_start" );
    level.will_irons _meth_81C6( var_1[0].origin, var_1[0].angles );
    level.cormack _meth_81C6( var_1[1].origin, var_1[1].angles );
    level.jackson _meth_81C6( var_1[2].origin, var_1[2].angles );

    for ( var_2 = 0; var_2 < 30; var_2++ )
    {
        level notify( "end_cherry_picker" );
        waitframe();
    }
}

seoul_hotel_entrance()
{
    soundscripts\_snd::snd_message( "start_seoul_hotel_entrance" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    var_0 = common_scripts\utility::getstruct( "struct_start_point_hotel_entrance", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_start_point_hotel_entrance_1", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    level.player _meth_83C0( "seoul_street" );

    if ( level.nextgen )
        maps\_utility::vision_set_fog_changes( "seoul_streets_dimfog", 0 );
    else
        maps\_utility::vision_set_fog_changes( "seoul_convention_center", 0 );

    common_scripts\utility::flag_set( "set_seoul_hotel_entrance_lighting" );
    setup_gangnam_station_intersection();
    common_scripts\utility::flag_set( "objective_start" );
    level.will_irons _meth_81C6( var_1[0].origin, var_1[0].angles );
    level.cormack _meth_81C6( var_1[1].origin, var_1[1].angles );
    level.jackson _meth_81C6( var_1[2].origin, var_1[2].angles );

    for ( var_2 = 0; var_2 < 30; var_2++ )
    {
        level notify( "end_cherry_picker" );
        waitframe();
    }
}

seoul_building_jump_sequence()
{
    soundscripts\_snd::snd_message( "start_seoul_building_jump_sequence" );
    thread maps\seoul_lighting::outerspacelighting_checkpoint();
    var_0 = common_scripts\utility::getstruct( "struct_start_point_building_jumps", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_start_point_building_jumps_1", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    common_scripts\utility::flag_set( "set_seoul_building_jump_sequence_lighting" );
    common_scripts\utility::flag_set( "objective_start" );
    setup_gangnam_station_intersection();
    level.will_irons _meth_81C6( var_1[0].origin, var_1[0].angles );
    level.cormack _meth_81C6( var_1[1].origin, var_1[1].angles );
    level.jackson _meth_81C6( var_1[2].origin, var_1[2].angles );
    thread anim_scene_building_jump();
    var_2 = getent( "trig_convention_center_combat_06", "targetname" );
    var_2 notify( "trigger" );
}

seoul_start_from_pod()
{
    level waittill( "dropped_from_pod" );
    setup_gangnam_station_intersection();
}

setup_building_traverse_and_vista()
{
    thread setup_openning_vista();
    thread setup_player_pod_exit();
}

reminder_boost_jump_drone_street()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "start_pod_landings_group_3" );
}

handle_boost_jump_training()
{
    thread reminder_boost_jump_drone_street();
    self endon( "death" );
    level endon( "missionfailed" );
    thread monitor_ever_used_boost();

    for (;;)
    {
        level waittill( "boost_jump_reminder" );

        if ( has_used_boost_recently( 60 ) )
            continue;

        maps\_utility::display_hint( "jump_training" );
        level.player waittill_till_timeout_or_boost( 3, 60 );
        var_0 = 1;
        waitframe();
    }
}

monitor_ever_used_boost()
{
    self endon( "death" );
    level endon( "missionfailed" );

    for (;;)
    {
        while ( !level.player _meth_83B4() )
            waitframe();

        level.player.has_used_boost = gettime() * 0.001;
        waitframe();
    }
}

waittill_till_timeout_or_boost( var_0, var_1 )
{
    self endon( "remove_boost_hint" );
    self endon( "death" );
    level endon( "missionfailed" );

    while ( !has_used_boost_recently( 60 ) )
        waitframe();
}

boost_hint_breakout()
{
    if ( !has_used_boost_recently( 60 ) )
        return 0;

    return 1;
}

has_used_boost_recently( var_0 )
{
    if ( !isdefined( level.player.has_used_boost ) )
        return 0;

    if ( level.player.has_used_boost > gettime() * 0.001 - var_0 )
        return 1;

    if ( level.player.has_used_boost < gettime() * 0.001 - var_0 )
        return 0;
}

handle_boost_slam_training()
{
    level.player thread monitor_boost_slamming();
    common_scripts\utility::flag_wait( "canal_jump_complete" );
    wait 1.25;
    thread maps\_utility::display_hint( "boost_slam_train" );
    level.player thread maps\_utility::notify_delay( "end_boost_slam_hint", 6 );
}

monitor_boost_slamming()
{
    self.has_used_boost_slam = gettime() * 0.001;

    for (;;)
    {
        level.player common_scripts\utility::waittill_either( "ground_slam", "end_boost_slam_hint" );
        self.has_used_boost_slam = gettime() * 0.001;
    }
}

slam_hint_breakout()
{
    if ( self.has_used_boost_slam < gettime() * 0.001 - 30 )
        return 0;
    else
        return 1;
}

handle_boost_dodge_training()
{
    level.player thread monitor_boost_dodging();
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_allies_enter_hotel" );
    thread maps\_utility::hintdisplayhandler( "boost_dodge_train" );
    thread maps\_utility::flag_set_delayed( "boost_dodge_hint_off", 6 );
}

dodge_hint_breakout()
{
    var_0 = gettime() * 0.001 - 20;

    if ( common_scripts\utility::flag( "boost_dodge_hint_off" ) )
        return 1;

    if ( !isdefined( self.has_used_boost_dodge ) )
        return 0;

    if ( self.has_used_boost_dodge > var_0 )
        return 1;

    return 0;
}

monitor_boost_dodging()
{
    self.has_used_boost_dodge = undefined;
    level.player waittill( "exo_dodge" );
    level.player waittill( "exo_dodge" );
    self.has_used_boost_dodge = 1;
    waitframe();
}

handle_land_assist_safe_descent_training()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_look_down_trigger" );
    thread get_player_velocity();
    common_scripts\utility::flag_set( "ignore_land_assist_hint" );

    while ( !common_scripts\utility::flag( "begin_looping_fob_functions" ) )
    {
        thread maps\_utility::hintdisplayhandler( "x_for_hover_alt" );

        while ( !common_scripts\utility::flag( "begin_looping_fob_functions" ) && level.player _meth_824C( "BUTTON_X" ) )
            waitframe();

        while ( !common_scripts\utility::flag( "begin_looping_fob_functions" ) && level.player.current_velocity > -400 )
            waitframe();

        waitframe();
    }

    common_scripts\utility::flag_clear( "ignore_land_assist_hint" );
    level.player notify( "HintDisplayHandlerEnd" );
}

land_assist_hint_safe_descent_breakout()
{
    if ( common_scripts\utility::flag( "begin_looping_fob_functions" ) )
        return 1;

    if ( level.player _meth_824C( "BUTTON_X" ) && level.player.current_velocity > -200 )
        return 1;

    return 0;
}

release_x_breakout()
{
    if ( !level.player _meth_824C( "BUTTON_X" ) && level.player.current_velocity < -200 )
        return 1;

    return 0;
}

get_player_velocity()
{
    for (;;)
    {
        var_0 = level.player getvelocity();
        level.player.current_velocity = var_0[2];
        wait 0.01;
    }
}

handle_land_assist_training_hover()
{
    var_0 = getent( "vol_land_assist_reminder_full", "targetname" );
    level.player.is_in_force_vol = 0;

    for (;;)
    {
        while ( !level.player _meth_80A9( var_0 ) )
        {
            level.player.is_in_force_vol = 0;
            waitframe();
        }

        level.player.is_in_force_vol = 1;
        maps\_player_land_assist::force_play_land_assist_hint();

        while ( !self.land_assist_activated && level.player _meth_80A9( var_0 ) )
            waitframe();

        thread maps\_utility::hintdisplayhandler( "x_for_hover_across" );

        while ( level.player _meth_80A9( var_0 ) && self.land_assist_activated )
            waitframe();
    }
}

hover_hint_breakout()
{
    if ( !level.player.is_in_force_vol )
        return 1;

    if ( !level.player.land_assist_activated )
        return 1;

    return 0;
}

handle_land_assist_training()
{
    thread handle_force_land_assist();
    self endon( "death" );
    level endon( "missionfailed" );

    for (;;)
    {
        while ( isdefined( level.player.show_land_assist_help ) && level.player.show_land_assist_help == 0 )
            waitframe();

        level waittill( "land_assist_reminder", var_0 );
        level.player.has_used_land_assist = undefined;
        level.land_assist_vol = var_0;

        if ( !common_scripts\utility::flag( "ignore_land_assist_hint" ) )
            maps\_utility::hintdisplayhandler( "x_for_hover" );

        waittill_player_uses_land_assist( var_0 );
        level.player.has_used_land_assist = 1;
        waitframe();
    }
}

handle_force_land_assist()
{

}

land_assist_hint_breakout()
{
    if ( !isdefined( level.player.has_used_land_assist ) )
        return 0;

    if ( level.player.land_assist_activated )
        return 1;

    if ( level.player.has_used_land_assist )
        return 1;
}

setup_gangnam_station_intersection()
{
    setup_allies();
    level.player thread handle_boost_jump_training();
    level.player thread handle_land_assist_training();
    level.player thread handle_land_assist_training_hover();
    level.player thread handle_land_assist_safe_descent_training();
    thread handle_npcs_paths();
    thread handle_npc_crowds();
    thread gangam_cinematic_warfare_manager();
    thread setup_npc_pod_landings();
    thread handle_fob();
    thread handle_swarm_scene();
    thread handle_alley_traversal();
    thread handle_hotel_entrance();
    thread handle_pac_interior();
    thread handle_wep_drone_dropoff();
    thread initial_ally_wave();
    thread setup_end_scene();
    thread setup_drone_street_fight();
    thread e3_jump_down();
    thread e3_first_fight_in_building();
    thread reset_friendly_fire_when_player_lands();
    maps\_utility::battlechatter_on( "allies" );
}

handle_sinkhole_enemy_setup()
{
    var_0 = getent( "volume_sinkhole_enemy_defend", "targetname" );
    var_1 = getent( "spawner_sinkhole_enemy_defend_g1", "targetname" );
    var_2 = 3;
    var_3 = getent( "spawner_sinkhole_enemy_defend_g2", "targetname" );
    var_4 = 3;
    var_5 = getnodearray( "node_sinkhole_enemy_g1", "targetname" );
    var_6 = [];
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_sinkhole_drones_attack_civs" );
    level notify( "autosave_request" );
    thread maps\_shg_design_tools::trigger_to_flag( "trig_move_allies_up_sinkhole_01", "spawn_sinkhole_reinforce" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_sinkhole_enemy_setup" );

    if ( level.currentgen )
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "killSinkHolePerf", undefined, 15, 0 );

    for ( var_7 = 0; var_7 < var_2; var_7++ )
    {
        var_8 = var_1 maps\_shg_design_tools::actual_spawn( 1 );
        var_8 _meth_81A9( var_0 );
        var_6[var_6.size] = var_8;
        wait(randomfloat( 1.5 ));
    }

    while ( var_6.size > var_5.size - 2 && !common_scripts\utility::flag( "spawn_sinkhole_reinforce" ) )
    {
        var_6 = common_scripts\utility::array_removeundefined( var_6 );
        waitframe();
    }

    for ( var_7 = 0; var_7 < var_4; var_7++ )
    {
        var_8 = var_3 maps\_shg_design_tools::actual_spawn( 1 );
        var_8 _meth_81A9( var_0 );
        var_6[var_6.size] = var_8;
        wait(randomfloatrange( 1.0, 2.0 ));
    }

    while ( var_6.size > 1 )
    {
        var_6 = common_scripts\utility::array_removeundefined( var_6 );
        waitframe();
    }

    maps\_utility::activate_trigger_with_targetname( "trig_move_allies_up_sinkhole_01" );

    while ( var_6.size > 0 )
    {
        var_6 = common_scripts\utility::array_removeundefined( var_6 );
        waitframe();
    }

    level notify( "vo_area_clear" );
}

handle_wep_drone_dropoff()
{
    level notify( "kill_wep_drone_dropoff_process" );
    level endon( "kill_wep_drone_dropoff_process" );
    var_0 = getentarray( "trig_sinkhole_ai_move_to_jump1", "targetname" );
    var_0[0] waittill( "trigger" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "vehicle_weapons_platform_flyover" );
    var_1 thread make_vehicl_invicible();
    var_2 = getent( "drone_reflection_05", "targetname" );
    var_3 = spawn( "script_model", var_1.origin );
    var_3 _meth_80B1( "vehicle_mil_mwp_static" );
    var_3.angles = var_1.angles;
    thread maps\seoul_fx::weaponplf_flyby_dustfx_sinkhole( var_1 );
    var_3.origin = var_1.origin;
    var_3.angles = var_1.angles;
    var_3 _meth_804D( var_1, "tag_origin" );
    var_1 _meth_8283( 0, 10, 10 );
    maps\_shg_design_tools::waittill_trigger_with_name( "seoul_weapons_platform_trigger" );
    var_1 soundscripts\_snd::snd_message( "seo_sinkhole_wp_flyby" );
    var_1 _meth_8283( 10, 10, 10 );
    var_3 _meth_83AB( var_2.origin );
    var_1 hide();
    common_scripts\utility::flag_wait( "wep_drone_dropoff_start" );
    common_scripts\utility::flag_wait( "wp_at_end_of_path" );
    var_3 delete();
}

make_vehicl_invicible()
{
    while ( isdefined( self ) )
    {
        self.health = 100000;
        waitframe();
    }
}

handle_npc_crowds()
{
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
}

smart_grenade_training()
{
    thread smart_hint();
    thread maps\_shg_design_tools::trigger_to_notify( "trig_convention_center_combat_02", "smart_grenade_training" );
    thread maps\_shg_design_tools::trigger_to_notify( "trig_restaurant_spawn", "smart_grenade_training" );
}

smart_hint()
{
    thread smart_hint_think();

    for (;;)
    {
        level waittill( "smart_grenade_training" );
        thread maps\_utility::flag_set_delayed( "end_smart_grenade_hint", 6 );
        thread maps\_utility::flag_clear_delayed( "end_smart_grenade_hint", 7 );
        thread maps\_utility::display_hint( "smart_grenade_training" );
    }
}

player_used_grenade_recently()
{
    if ( !isdefined( level.player.has_used_smart_or_timeout ) )
        return 0;

    if ( level.player.has_used_smart_or_timeout > gettime() * 0.001 - 45 )
        return 1;

    return 0;
}

has_grenades_to_throw()
{
    var_0 = level.player _meth_8345();
    var_1 = _func_1E1( var_0 );
    var_2 = level.player getammocount( var_0 );

    if ( var_2 > 0 )
        return 1;

    return 0;
}

smart_hint_think()
{
    level.player.has_used_smart_or_timeout = undefined;

    for (;;)
    {
        level.player waittill( "rb_pressed" );
        level.player.has_used_smart_or_timeout = gettime() * 0.001;
    }
}

smart_hint_breakout()
{
    if ( common_scripts\utility::flag( "end_smart_grenade_hint" ) )
        return 1;

    if ( player_used_grenade_recently() )
        return 1;

    if ( !has_grenades_to_throw() )
        return 1;

    return 0;
}

ads_hint()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_starte_first_fight" );
    thread ads_hint_breakout_think();
    thread maps\_utility::hintdisplayhandler( "ads_train" );
}

ads_hint_breakout_think()
{
    thread maps\_utility::notify_delay( "3sectimeout", 3 );
    level common_scripts\utility::waittill_either( "first_fight_guy_dead", "3sectimeout" );
    level.player.has_used_ads_or_timeout = 1;
}

ads_hint_breakout()
{
    if ( !isdefined( level.player.has_used_ads_or_timeout ) )
        return 0;

    if ( level.player.has_used_ads_or_timeout )
        return 1;
}

e3_first_fight_in_building()
{
    level waittill( "droppod_empty" );
    level endon( "cormack_to_first_land_assist" );
    var_0 = getent( "spawner_enemy_building_traverse_crush_gag", "targetname" );
    thread ads_hint();
    thread maps\_shg_design_tools::trigger_to_flag( "trig_break_first_fight_anims", "wake_up_ambush_guys" );
    thread setup_first_fight_left_guy( var_0, "struct_e3_building_first_fight_left_1" );
    thread setup_first_fight_right_guy1( var_0, "struct_e3_building_first_fight_right_2" );
    thread setup_first_fight_right_guy2( var_0, "struct_e3_building_first_fight_right_1" );

    for ( var_1 = 0; var_1 < 3; var_1++ )
        level waittill( "first_fight_guy_dead" );

    level notify( "first_fight_done" );
    maps\_utility::activate_trigger_with_targetname( "trig_guys_move_up_after_first_fight" );
    level notify( "autosave_request" );
}

setup_first_fight_right_guy1( var_0, var_1 )
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_starte_first_fight" );
    common_scripts\utility::flag_set( "vo_nk_first_contact_start" );
    var_2 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
    var_3 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
    var_2 endon( "end_ambush_behavior" );
    var_3 endon( "end_ambush_behavior" );
    var_4 = common_scripts\utility::getstruct( "struct_first_fight_teaser_01a", "targetname" );
    var_5 = common_scripts\utility::getstruct( "struct_first_fight_teaser_01b", "targetname" );
    var_6 = common_scripts\utility::getstruct( "struct_first_fight_teaser_02a", "targetname" );
    var_7 = common_scripts\utility::getstruct( "struct_first_fight_teaser_02b", "targetname" );
    var_2 _meth_81C6( var_4.origin, var_4.angles );
    var_3 _meth_81C6( var_4.origin, var_4.angles );
    level thread maps\_utility::notify_delay( "enter_e3_first_fight_enemies", 4.2 );
    var_2 maps\_utility::enable_cqbwalk();
    var_2 thread maps\_shg_design_tools::notify_on_death( var_2, "first_fight_guy_dead" );
    var_2.goalradius = 32;
    var_2.ignoreall = 1;
    var_2 maps\_utility::disable_long_death();
    var_2 _meth_81A6( var_5.origin );
    var_2 thread end_first_fight_behavior_think();
    var_3 maps\_utility::enable_cqbwalk();
    var_3 thread maps\_shg_design_tools::notify_on_death( var_2, "first_fight_guy_dead" );
    var_3.goalradius = 32;
    var_3 maps\_utility::disable_long_death();
    var_3 _meth_81A6( var_7.origin );
    var_3.ignoreall = 1;
    var_3 thread end_first_fight_behavior_think();
    wait 1.5;
    level notify( "nk_soldier_spotted" );
    wait 3.5;

    if ( isdefined( var_2 ) )
        var_2.ignoreall = 0;

    if ( isdefined( var_3 ) )
        var_3.ignoreall = 0;

    wait 2.5;

    if ( isdefined( var_2 ) )
        var_2 _meth_81A7( level.player );

    if ( isdefined( var_3 ) )
        var_3 _meth_81A7( level.player );
}

setup_first_fight_left_guy( var_0, var_1 )
{
    var_2 = common_scripts\utility::getstruct( var_1, "targetname" );
    var_3 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
    thread maps\_shg_design_tools::notify_on_death( var_3, "first_fight_guy_dead" );
    var_3 thread fake_anim_shoot( "first_fight_guy_dead" );
    var_3 thread end_first_fight_behavior_think( var_2, "det_corner_check_left_enter" );
    var_3 endon( "death" );
    var_3 endon( "end_ambush_behavior" );
    var_2 thread maps\_anim::anim_generic_first_frame( var_3, "det_corner_check_left_enter" );
    var_3.allowdeath = 1;
    var_3 maps\_utility::disable_long_death();
    var_3.anim_1 = "det_corner_check_left_enter";
    var_3.anim_2 = "det_corner_check_left_loop";
    var_3.anim_3 = "det_corner_check_left_exit";
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_starte_first_fight" );
    common_scripts\utility::flag_wait_or_timeout( "wake_up_ambush_guys", 3 );

    if ( common_scripts\utility::flag( "wake_up_ambush_guys" ) )
        var_3 maps\_utility::anim_stopanimscripted();
    else
    {
        var_3 thread monitor_player_sprinting_past_ambush( "wake_up_ambush_guys" );
        var_3 thread common_scripts\utility::delaycall( 1, ::_meth_80B2, "lag_snipper_laser" );
        var_3 maps\_utility::anim_stopanimscripted();
        var_3 thread allow_death_delay();
        var_2 maps\_anim::anim_generic( var_3, var_3.anim_1 );
        var_3.allowdeath = 1;

        if ( !isdefined( var_3.ambush_breakout ) )
        {
            var_3 thread maps\_anim::anim_generic( var_3, var_3.anim_3 );
            var_3.allowdeath = 1;
        }

        var_3 notify( "ambush_anims_done" );
    }

    var_3 common_scripts\utility::waittill_any( "damage", "death" );
    level notify( "e3_first_fight_is_on" );
}

monitor_player_sprinting_past_ambush( var_0 )
{
    self endon( "death" );
    self endon( "ambush_anims_done" );
    common_scripts\utility::flag_wait( var_0 );
    maps\_utility::anim_stopanimscripted();
    self.ambush_breakout = 1;
}

setup_first_fight_right_guy2( var_0, var_1 )
{
    var_2 = common_scripts\utility::getstruct( var_1, "targetname" );
    var_3 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
    var_3 maps\_utility::disable_long_death();
    var_3 thread end_first_fight_behavior_think( var_2, "det_corner_check_right_into" );
    thread maps\_shg_design_tools::notify_on_death( var_3, "first_fight_guy_dead" );
    var_3 thread fake_anim_shoot( "first_fight_guy_dead" );
    var_3 endon( "death" );
    var_3 endon( "end_ambush_behavior" );
    var_2 thread maps\_anim::anim_generic_first_frame( var_3, "det_corner_check_right_into" );
    var_3.anim_struct = var_2;
    var_3.anim_1 = "det_corner_check_right_into";
    var_3.anim_2 = "det_corner_check_right_loop";
    var_3.anim_3 = "det_corner_check_right_exit";
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_starte_first_fight" );
    common_scripts\utility::flag_wait_or_timeout( "wake_up_ambush_guys", 3.5 );
    var_3 maps\_utility::anim_stopanimscripted();

    if ( !common_scripts\utility::flag( "wake_up_ambush_guys" ) )
    {
        var_3 thread monitor_player_sprinting_past_ambush( "wake_up_ambush_guys" );
        var_3 thread allow_death_delay();
        var_2 maps\_anim::anim_generic( var_3, var_3.anim_1 );
        var_3.allowdeath = 1;
        var_3 thread maps\_anim::anim_generic_loop( var_3, var_3.anim_2 );
        common_scripts\utility::flag_wait_or_timeout( "wake_up_ambush_guys", 2 );
        var_3 maps\_utility::anim_stopanimscripted();
        var_3 notify( "stop_loop" );

        if ( !common_scripts\utility::flag( "wake_up_ambush_guys" ) )
        {
            var_3 thread maps\_anim::anim_generic( var_3, var_3.anim_3 );
            var_3.allowdeath = 1;
        }

        var_3 notify( "ambush_anims_done" );
    }

    if ( common_scripts\utility::flag( "wake_up_ambush_guys" ) )
        var_3 maps\_utility::anim_stopanimscripted();
    else
    {
        var_3 thread common_scripts\utility::delaycall( 1, ::_meth_80B2, "lag_snipper_laser" );
        var_3 maps\_utility::anim_stopanimscripted();
        var_3 thread allow_death_delay();
        var_2 maps\_anim::anim_generic( var_3, var_3.anim_1 );
        var_3.allowdeath = 1;
        var_3 thread maps\_anim::anim_generic( var_3, var_3.anim_3 );
        var_3.allowdeath = 1;
    }
}

end_first_fight_behavior_think( var_0, var_1 )
{
    self endon( "death" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_break_first_fight_anims" );
    self notify( "end_ambush_behavior" );
    maps\_utility::anim_stopanimscripted();
    self notify( "stop_loop" );

    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_0 thread maps\_anim::anim_generic( self, var_1 );
        waitframe();
        maps\_utility::anim_stopanimscripted();
        self notify( "stop_loop" );
    }

    self.ignoreall = 0;
    self _meth_81A7( level.player );
}

fake_anim_shoot( var_0 )
{
    var_1 = self;
    var_1 endon( "death" );
    level waittill( var_0 );

    while ( isdefined( var_1 ) )
    {
        for ( var_2 = 0; var_2 < 5; var_2++ )
        {
            var_1 _meth_81E7();
            wait 0.1;
        }

        wait 0.5;
    }
}

handle_alley_traversal()
{
    var_0 = getent( "model_exo_push_car_gag", "targetname" );
    var_1 = common_scripts\utility::getstruct( "struct_exo_car_push_gag_1", "targetname" );
    var_2 = common_scripts\utility::getstruct( "struct_exo_car_push_gag_2", "targetname" );
}

jump_anim_with_gravity( var_0, var_1, var_2, var_3 )
{
    maps\_anim::anim_generic( var_0, var_1 );
    var_0 maps\_anim::anim_generic_gravity( var_0, "boost_jump_256_across_256_down" );
    var_0.anim_tag = var_2 common_scripts\utility::spawn_tag_origin();
    var_0.anim_tag thread maps\_shg_design_tools::anim_simple( var_0, var_3 );
}

handle_npcs_paths()
{
    thread setup_npc_paths();
    thread allies_to_first_land_assist();
    thread allies_to_building_exit();
    thread allies_to_fob();
    thread allies_to_hill();
    thread allies_to_drone_swarm();
    thread allies_to_truck_jump();
    thread allies_to_weapons_platform_video_log();
}

e3_handle_bus_top_enemies( var_0 )
{
    var_1 = getent( "e3_vol_enemy_bus_vol", "targetname" );
    var_2 = getnode( "e3_node_enemy_cover_group_04", "targetname" );
    var_3 = undefined;

    for (;;)
    {
        while ( !isdefined( var_3 ) )
        {
            var_3 = common_scripts\utility::random( var_0 );
            wait 0.05;
        }

        var_3 _meth_8177( "enemies_ignored_by_allies" );
        var_3 thread threat_bias_remove_delay( 18 );
        var_3 _meth_81A5( var_2 );
        var_3 thread ragdolldeath();
        var_3 waittill( "death" );
    }
}

threat_bias_remove_delay( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self _meth_8177();
}

handle_ally_movement()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_drone_street_move_position2" );
    var_0 = getnode( "e3_node_will_position_2", "targetname" );
    var_1 = getnode( "e3_node_cormack_position_2", "targetname" );
    var_2 = getnode( "e3_node_jackson_position_2", "targetname" );
    level.will_irons _meth_81A5( var_0 );
    level.cormack _meth_81A5( var_1 );
    level.jackson _meth_81A5( var_2 );
    common_scripts\utility::flag_wait( "snake_swarm_first_flyby_begin" );
    var_3 = getnodearray( "e3_node_ally_cover_group_02", "targetname" );
    level notify( "end_drone_street_reinforce" );

    foreach ( var_6, var_5 in level.drone_street_allies )
    {
        if ( !isdefined( var_5 ) )
            continue;

        if ( !isdefined( var_3[var_6] ) )
        {
            var_5 _meth_8052();
            continue;
        }

        var_5 _meth_81A5( var_3[var_6] );
    }
}

save_game_big_jump()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_land_assist_jump_01" );
    level notify( "autosave_request" );
}

e3_jump_down()
{
    var_0 = common_scripts\utility::getstructarray( "struct_e3_drop_hack_01", "targetname" );
    thread save_game_big_jump();
    thread get_cormack_to_building_doorway();
    thread get_will_to_building_doorway();
    var_1 = common_scripts\utility::getstruct( "struct_ally_big_drop_jack", "targetname" );
    var_2 = common_scripts\utility::getstruct( "struct_ally_big_drop_cormack", "targetname" );
    level waittill( "e3_jump_end_scene_end" );
    var_3 = maps\_shg_design_tools::getthing( "struct_land_assist_cormack_01b", "targetname" );
    level.jackson guy_jump_to_breach_stackup_jackson( var_3 );
    common_scripts\utility::flag_wait( "player_landed_in_hotel" );
}

reset_friendly_fire_when_player_lands()
{
    common_scripts\utility::flag_wait( "player_landed_in_hotel" );
    level.player.participation = 0;
}

get_cormack_to_building_doorway()
{
    var_0 = common_scripts\utility::getstruct( "struct_ally_big_drop_cormack", "targetname" );
    var_1 = common_scripts\utility::getstruct( "struct_bottom_of_building_cormack", "targetname" );
    level.cormack waittill( "i_have_landed" );
    level.cormack maps\_shg_design_tools::anim_stop( level.cormack.anim_org );
    level.cormack maps\_shg_design_tools::anim_stop( level.cormack.anim_tag );
    waittillframeend;
    level notify( "e3_jump_end_scene_end" );
    level.cormack maps\_utility::disable_cqbwalk();
    level.cormack.ignoreall = 1;
    level.cormack maps\_utility::set_run_anim( "seo_react_to_war_run_npc1" );
    level.cormack thread anim_scene_building_exit_cormack( "struct_building_exit_cormack" );
}

get_will_to_building_doorway()
{
    level.will_irons waittill( "i_have_landed" );
    level.will_irons maps\_shg_design_tools::anim_stop( level.will_irons.anim_org );
    level.will_irons maps\_shg_design_tools::anim_stop( level.will_irons.anim_tag );
    waittillframeend;
    level notify( "e3_jump_end_scene_end" );
    level.will_irons maps\_utility::disable_cqbwalk();
    level.will_irons.ignoreall = 1;
    level.will_irons maps\_utility::set_run_anim( "seo_react_to_war_run_npc2" );
    level.will_irons thread anim_scene_building_exit_will( "struct_building_exit_will" );
}

handle_drone_teasers()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "start_pod_landings_group_3" );
    wait 5;
    var_0 = getentarray( "spawner_drone_street_teasers", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
        var_3 soundscripts\_snd::snd_message( "seo_single_drones_flyby" );
        wait(randomfloatrange( 0.05, 0.35 ));
    }
}

handle_player_on_left_street()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_player_on left_street" );
    var_0 = _func_0D6( "axis" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        if ( common_scripts\utility::cointoss() )
            var_2 _meth_8177( "enemies_attack_player" );
    }
}

setup_drone_street_fight()
{
    level waittill( "begin_e3_fight" );
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
    level.e3_enemies = [];
    thread handle_ally_movement();
    thread handle_player_on_left_street();
    level.player notify( "enable_player_boost_jump" );
    var_0 = getentarray( "clip_only_when_boost_off", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.origin += ( 0, 0, 30000 );

    var_4 = getentarray( "e3_spawner_enemy_drone_street", "targetname" );
    var_5 = getentarray( "e3_spawner_trench_allies_group_01", "targetname" );
    var_6 = getnodearray( "e3_node_enemy_cover_group_01", "targetname" );
    var_7 = getnodearray( "e3_node_enemy_cover_group_02", "targetname" );
    var_8 = getentarray( "e3_node_enemy_cover_group_03", "targetname" );
    var_9 = getnodearray( "e3_node_ally_cover_group_01", "targetname" );
    var_10 = getent( "e3_vol_enemey_retreat", "targetname" );
    var_11 = getent( "e3_vol_enemey_retreat2", "targetname" );

    if ( level.currentgen )
    {
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "snake_charge_initiated", undefined, 10, 0 );
        var_12 = getent( "cg_street_spawn_trigger", "targetname" );
        var_12 waittill( "trigger" );
        common_scripts\utility::flag_set( "player_passed_fob" );
    }

    if ( level.currentgen && !_func_21E( "seoul_drone_swarm_one_tr" ) )
    {
        while ( !_func_21E( "seoul_drone_swarm_one_tr" ) )
            wait 0.05;
    }

    var_13 = [];

    foreach ( var_15 in var_6 )
    {
        var_16 = common_scripts\utility::random( var_4 );
        var_17 = drone_street_fight_enemy_func( var_16, var_15 );
        var_13[var_13.size] = var_17;

        if ( level.currentgen )
            wait 0.1;
    }

    var_19 = [];

    foreach ( var_15 in var_7 )
    {
        var_16 = common_scripts\utility::random( var_4 );
        var_17 = drone_street_fight_enemy_func( var_16, var_15 );
        var_19[var_19.size] = var_17;

        if ( level.currentgen )
            wait 0.1;
    }

    level.drone_street_allies = [];
    wait 3;

    if ( level.nextgen )
        thread spawn_drone_street_allies_and_reinforce( var_9, var_5 );

    thread e3_drone_swarm_strafe( level.drone_street_allies );
    var_13 = common_scripts\utility::array_combine( var_13, var_19 );
    thread e3_handle_bus_top_enemies( var_13 );
    thread monitor_drone_street_enemy_count( var_13 );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_drone_street_move_position2" );
    var_13 = _func_0D6( "axis" );

    foreach ( var_17 in var_13 )
    {
        if ( isdefined( var_17 ) )
        {
            var_17 _meth_81A9( var_11 );
            var_17 thread common_scripts\utility::delaycall( randomfloat( 4.0 ), ::_meth_8052 );
            wait(randomfloat( 1.0 ));
        }
    }

    var_24 = _func_0D6( "allies" );

    foreach ( var_17 in var_24 )
    {
        if ( isdefined( var_17 ) )
            var_17.accuracy = 0;
    }

    level.player waittill( "player_in_x4walker" );

    foreach ( var_17 in var_13 )
    {
        if ( isdefined( var_17 ) )
            var_17 _meth_8052();
    }
}

monitor_drone_street_enemy_count( var_0 )
{
    while ( var_0.size > 2 )
    {
        var_0 = maps\_utility::array_removedead_or_dying( var_0 );
        waitframe();
    }

    maps\_utility::activate_trigger_with_targetname( "trigger_drone_street_move_position2" );
}

drone_street_fight_enemy_func( var_0, var_1 )
{
    var_2 = var_0 maps\_shg_design_tools::actual_spawn( 1 );
    var_2 thread maps\_shg_design_tools::killonbadpath();
    var_2 thread e3_handle_threat_detection();
    var_2 thread ragdolldeath();
    var_2 thread handle_drone_street_health_hack();
    var_2 _meth_81A5( var_1 );
    var_2.grenadeammo = 0;
    var_2.accuracy = 0.2;
    var_2.goalradius = 196;
    var_2.dropweapon = 1;

    if ( !isdefined( var_2 ) )
        return;

    if ( isalive( var_2 ) )
        var_2 maps\_utility::disable_long_death();

    return var_2;
}

handle_drone_street_health_hack()
{
    self endon( "death" );
    level endon( "player_on_scene" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1 );

        if ( var_1 != level.player && isdefined( self ) )
        {
            self.health += int( var_0 * 0.75 );
            continue;
        }

        if ( isdefined( self ) )
            level thread maps\_utility::notify_delay( "player_on_scene", 3 );
    }
}

ragdolldeath()
{
    self waittill( "death" );

    if ( isdefined( self ) )
        self _meth_8023();
}

spawn_drone_street_allies_and_reinforce( var_0, var_1 )
{
    level endon( "end_drone_street_reinforce" );

    foreach ( var_3 in var_0 )
        thread spawn_drone_street_ally( var_3, var_1 );
}

spawn_drone_street_ally( var_0, var_1 )
{
    level endon( "end_drone_street_reinforce" );
    var_2 = undefined;

    while ( !isdefined( var_2 ) )
    {
        var_2 = common_scripts\utility::random( var_1 ) maps\_utility::spawn_ai();
        waitframe();
    }

    if ( !isdefined( var_2 ) )
        return;

    level.drone_street_allies[level.drone_street_allies.size] = var_2;
    var_2 _meth_81A5( var_0 );
    var_2.canjumppath = 1;
    var_2 maps\_utility::disable_pain();
    var_2.accuracy = 0;
    var_2 thread reinforce_on_death( var_0, var_1 );
    return var_2;
}

reinforce_on_death( var_0, var_1, var_2 )
{
    level endon( "end_drone_street_reinforce" );

    if ( isdefined( var_2 ) )
        level endon( var_2 );

    var_3 = self;

    for (;;)
    {
        var_3 waittill( "death" );
        wait 1;
        var_3 = spawn_drone_street_ally( var_0, var_1 );
    }
}

e3_handle_threat_detection()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "detected" );
        level notify( "threat_detected" );
        level.walker_tank.targetlist[level.walker_tank.targetlist.size] = self;

        if ( common_scripts\utility::cointoss() )
            badplace_cylinder( "temp_detected_badplace", 5, self.origin, 32, 96, "axis" );
    }
}

e3_drone_swarm_strafe( var_0 )
{
    common_scripts\utility::flag_wait( "flag_drone_street_strafe" );
    level notify( "end_drone_strret_fight" );
    var_1 = common_scripts\utility::getclosest( level.player.origin, level.flock_drones, 3000 );
    var_0 = maps\_shg_design_tools::sortbydistanceauto( level.drone_street_allies, var_1.origin );

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        var_4 = common_scripts\utility::getclosest( var_3.origin, level.flock_drones, 3000 );
        var_5 = var_4.origin;
        var_4 delete();
        var_6 = magicbullet( "remote_missile_drone_light", var_5, var_3.origin );

        if ( common_scripts\utility::cointoss() )
        {
            wait 0.2;
            var_6 = magicbullet( "remote_missile_drone_light", var_5, var_3.origin );
        }

        wait(randomfloatrange( 1.0, 2.0 ));
    }
}

e3_handle_threat_shooting()
{
    self.targetlist = [];

    while ( maps\_shg_design_tools::isvehiclealive( self ) )
    {
        level waittill( "threat_detected" );
        var_0 = [];
        var_0[0] = "launcher_right";
        var_0[1] = "launcher_left";
        wait 2.5;

        if ( !maps\_shg_design_tools::isvehiclealive( self ) )
            continue;

        var_1 = randomintrange( 2, 4 );
        vehicle_scripts\_walker_tank::fire_missles_at_target_array( self.targetlist, var_1 );
    }
}

handle_walker_tank_firing()
{
    waitframe();
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_1 = common_scripts\utility::getstructarray( "enemy_fire", "targetname" );
    vehicle_scripts\_walker_tank::enable_firing( -1 );
    vehicle_scripts\_walker_tank::disable_firing( 0 );
    vehicle_scripts\_walker_tank::disable_firing( 1 );
    vehicle_scripts\_walker_tank::disable_firing( 2 );
    vehicle_scripts\_walker_tank::enable_tracking( -1 );
    vehicle_scripts\_walker_tank::disable_tracking( 0 );
    vehicle_scripts\_walker_tank::disable_tracking( 1 );
    vehicle_scripts\_walker_tank::disable_tracking( 2 );

    while ( !common_scripts\utility::flag( "player_in_x4walker" ) )
    {
        wait(randomintrange( 3, 8 ));
        var_2 = common_scripts\utility::random( var_1 );
        var_0.origin = var_2.origin;

        if ( maps\_shg_design_tools::isvehiclealive( self ) )
            vehicle_scripts\_walker_tank::set_forced_target( var_0, -1 );
        else
            return;

        waitframe();
    }

    vehicle_scripts\_walker_tank::disable_firing( -1 );
    vehicle_scripts\_walker_tank::disable_tracking( -1 );
    vehicle_scripts\_walker_tank::enable_tracking( 1 );
    vehicle_scripts\_walker_tank::enable_tracking( 2 );
    vehicle_scripts\_walker_tank::enable_firing( 1 );
    vehicle_scripts\_walker_tank::enable_firing( 2 );
    thread fire_missiles_at_drone_swarm();

    while ( maps\_shg_design_tools::isvehiclealive( self ) )
    {
        var_3 = common_scripts\utility::getclosest( self.origin, level.flock_drones );
        vehicle_scripts\_walker_tank::set_forced_target( var_3, 1 );
        wait 0.1;

        if ( !maps\_shg_design_tools::isvehiclealive( self ) )
            continue;

        var_4 = common_scripts\utility::getclosest( self.origin, level.flock_drones );
        vehicle_scripts\_walker_tank::set_forced_target( var_4, 2 );

        while ( isdefined( var_3 ) )
            waitframe();

        waitframe();
    }
}

fire_missiles_at_drone_swarm()
{
    level endon( "end_cherry_picker" );
    self endon( "death" );

    for (;;)
    {
        wait(randomfloatrange( 4, 5 ));
        var_0 = 4;
        var_1 = [];

        for ( var_2 = 0; var_2 < var_0; var_2++ )
            var_1[var_2] = common_scripts\utility::random( level.flock_drones );

        self.missiles_loaded_count = var_1.size;
        vehicle_scripts\_walker_tank::fire_missles_at_target_array( var_1, 1 );
        self notify( "tank_shot" );
    }
}

make_walker()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_fob" ) )
        level waittill( "transients_intro_to_fob" );

    var_0 = getent( "walker_tank_for_stepover", "targetname" );
    var_0.script_disconnectpaths = 0;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "walker_tank_for_stepover" );
    var_1 notify( "stop_vehicle_shoot_shock" );
    var_1.script_disconnectpaths = 0;
    var_1.animname = "walker_tank";
    var_1 maps\_anim::setanimtree();

    if ( level.currentgen )
    {

    }

    return var_1;
}

handle_stepover_scene_clip()
{
    var_0 = getent( "temp_clip_for_walker_anim_scene", "targetname" );
    level waittill( "stepover_anim_scene_done_character" );
    var_0.origin += ( 0, 0, 100000 );
}

anim_scene_walker_stepover()
{
    if ( level.nextgen )
        thread handle_stepover_scene_clip();

    var_0 = common_scripts\utility::getstruct( "struct_walker_walkover_scene", "targetname" );
    var_1 = make_walker();
    wait 1;
    var_2 = var_0 common_scripts\utility::spawn_tag_origin();
    var_2 thread maps\_anim::anim_loop_solo( var_1, "walker_step_idle_1" );
    var_1 thread handle_walker_tank_firing();
    level.walker_tank = var_1;
    thread make_walker_invulnerable();
    var_1 thread e3_handle_threat_shooting();
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_hill_event_00" );
    common_scripts\utility::flag_set( "dialogue_trench_demo_team" );
    level notify( "remove_path_blockers_fob" );
    level.cormack maps\_utility::disable_cqbwalk();
    level.will_irons maps\_utility::disable_cqbwalk();
    waittill_has_reached_hill_idle();
    level notify( "begin_e3_fight" );
    common_scripts\utility::flag_wait( "dialogue_trench_demo_team" );
    level.cormack.anim_struct notify( "stop_loop" );
    level.cormack maps\_utility::anim_stopanimscripted();
    level.will_irons.anim_struct notify( "stop_loop" );
    level.will_irons maps\_utility::anim_stopanimscripted();
    level.will_irons.anim_struct thread maps\_anim::anim_single_solo( level.will_irons, "fob_meet_post_exit_2" );
    level.cormack.anim_struct maps\_anim::anim_single_solo( level.cormack, "fob_meet_post_exit_1" );
    level.cormack maps\_utility::set_moveplaybackrate( 1 );
    level.will_irons maps\_utility::set_moveplaybackrate( 1 );
    var_3 = [ level.cormack, level.will_irons ];
    var_4 = getnode( "node_hill_pause_guy2", "targetname" );
    level.jackson _meth_81A5( var_4 );
    var_1 thread maps\_shg_design_tools::anim_stop( var_2 );
    thread actor_playscene_walker_stepover_cormack();
    thread actor_playscene_walker_stepover_will();
    thread actor_playscene_walker_stepover_jackson();
    level notify( "autosave_request" );
    level thread maps\seoul_fx::titan_camera_shake( var_1 );
    var_1 soundscripts\_snd::snd_message( "walker_step_over" );
    var_1 thread handle_allow_death_for_walker_tank();
    var_0 maps\_anim::anim_single_solo( var_1, "walker_step_over" );

    if ( isdefined( var_1 ) )
        var_0 thread maps\_anim::anim_loop_solo( var_1, "walker_step_idle_2" );

    level notify( "anim_walker_stepoaver_scene_done" );
}

handle_allow_death_for_walker_tank()
{
    for ( var_0 = 0; var_0 < 20; var_0++ )
    {
        self.allowdeath = 1;
        waitframe();
    }
}

waittill_has_reached_hill_idle()
{
    common_scripts\utility::flag_wait_all( "flag_will_irons_has_arrived_at_hill", "flag_cormack_has_arrived_at_hill" );
}

actor_playscene_walker_stepover_will()
{
    var_0 = common_scripts\utility::getstruct( "struct_walker_walkover_scene", "targetname" );
    var_0 maps\_anim::anim_single_solo_run( level.will_irons, "walker_step_over" );
    level.will_irons maps\_utility::clear_run_anim();
    level.will_irons maps\_utility::set_moveplaybackrate( 1 );
    level notify( "heroes_done_with_walker_anim_scene" );
    var_1 = getnode( "node_drone_section_will_01", "targetname" );
    level.will_irons _meth_81A5( var_1 );
    level.will_irons.fixednode = 1;
    level.will_irons maps\_utility::set_force_color( "o" );
}

actor_playscene_walker_stepover_jackson()
{
    level waittill( "heroes_done_with_walker_anim_scene" );
    var_0 = getnode( "node_drone_section_jackson_01", "targetname" );
    level.jackson _meth_81A5( var_0 );
    level.jackson.fixednode = 1;
}

actor_playscene_walker_stepover_cormack()
{
    var_0 = common_scripts\utility::getstruct( "struct_walker_walkover_scene", "targetname" );
    var_0 maps\_anim::anim_single_solo_run( level.cormack, "walker_step_over" );
    level.cormack maps\_utility::clear_run_anim();
    level.cormack maps\_utility::set_moveplaybackrate( 1 );
    var_1 = getnode( "node_drone_section_cormack_01", "targetname" );
    level.cormack _meth_81A5( var_1 );
    level.cormack.fixednode = 1;
    level notify( "stepover_anim_scene_done_character" );
}

disable_exo_during_land_assist()
{
    level waittill( "begin_land_assist_training" );
    level.player thread maps\_player_exo::unsetexoslam();
    level.player _meth_848D( 0 );
    common_scripts\utility::flag_wait( "player_landed_in_hotel" );
    wait 2;
    level.player thread maps\_player_exo::setexoslam();
    level.player _meth_848D( 1 );
}

allies_to_first_land_assist()
{
    level endon( "e3_jump_end_scene" );
    thread change_fall_tollerance( 600, 800, "player_landed_in_hotel" );
    var_0 = maps\_shg_design_tools::getthing( "struct_land_assist_first_jump", "targetname" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    level waittill( "begin_building_traversal" );
    maps\_utility::activate_trigger( "trigger_start_script_color_will", "targetname" );
    maps\_utility::activate_trigger( "trigger_start_script_color", "targetname" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_guys_to_first_land_assist" );
    maps\_utility::player_speed_percent( 100 );
    thread disable_exo_during_land_assist();
    thread get_cormack_into_first_landassist();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_cormack_trigger_will_first_landassist" );
    thread get_will_into_first_landassist();
    wait 2;
    common_scripts\utility::flag_set( "dialogue_hotel_top_floor_landassist" );
    level notify( "begin_land_assist_training" );
    common_scripts\utility::flag_wait( "player_landed_in_hotel" );
    wait 2;
    return_fall_tollerance();
}

move_player_view_at_ledge()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_look_down_trigger" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    level.player _meth_8091( var_0 );

    for ( var_1 = 0; var_1 < 45; var_1++ )
    {
        if ( !level.player maps\_player_land_assist::is_land_assist_activated() )
        {
            var_2 = var_1;
            var_3 = level.player _meth_8036()[1];
            var_0 _meth_82B5( ( var_2, var_3, 0 ), 0.05 );
            maps\_utility::lerp_player_view_to_position( var_0.origin, var_0.angles, 0.05 );
            waitframe();
        }
    }
}

rotate_ent_towards_center( var_0 )
{
    var_1 = ( 0, vectortoangles( var_0.origin - self.origin )[1], 0 );
    var_2 = 0.5;
    var_3 = ( var_2, var_1[1], 0 );
    var_4 = transformmove( self.origin, var_3, self.origin, var_1, self.origin, self.angles );
    return var_4["angles"];
}

allies_to_first_land_assist_debug()
{
    var_0 = maps\_shg_design_tools::getthing( "struct_land_assist_first_jump", "targetname" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    thread get_cormack_into_first_landassist();
    thread get_will_into_first_landassist();
    thread disable_exo_during_land_assist();
    wait 2;
    thread change_fall_tollerance( 600, 800, "player_landed_in_hotel" );
    common_scripts\utility::flag_set( "dialogue_hotel_top_floor_landassist" );
    level notify( "begin_land_assist_training" );
    common_scripts\utility::flag_wait( "player_landed_in_hotel" );
    wait 3;
    return_fall_tollerance();
}

change_fall_tollerance( var_0, var_1, var_2 )
{
    while ( !common_scripts\utility::flag( var_2 ) )
    {
        _func_0D3( "bg_fallDamageMinHeight", var_0 );
        _func_0D3( "bg_fallDamageMaxHeight", var_1 );
        waitframe();
    }
}

return_fall_tollerance()
{
    for ( var_0 = 0; var_0 < 30; var_0++ )
    {
        _func_0D3( "bg_fallDamageMinHeight", 490 );
        _func_0D3( "bg_fallDamageMaxHeight", 640 );
        waitframe();
    }
}

get_cormack_into_first_landassist()
{
    level endon( "e3_jump_end_scene" );
    level notify( "cormack_to_first_land_assist" );
    level.cormack notify( "goal" );
    level.cormack maps\_utility::disable_ai_color();
    var_0 = maps\_shg_design_tools::getthing( "struct_land_assist_cormack_01b", "targetname" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_1 maps\_anim::anim_reach_solo( level.cormack, "first_landassist_enter" );
    var_1 maps\_anim::anim_single_solo( level.cormack, "first_landassist_enter" );
    level.cormack.anim_org = var_1;

    if ( !common_scripts\utility::flag( "flag_first_land_assist" ) || !common_scripts\utility::flag( "land_assist_activated" ) || !common_scripts\utility::flag( "begin_looping_fob_functions" ) )
    {
        var_1 thread maps\_anim::anim_loop_solo( level.cormack, "first_landassist_idle" );
        waittill_player_uses_land_assist_or_is_a_jerk();
    }

    level notify( "e3_trigger_big_jump_hack" );
    level.cormack thread guy_jump_to_breach_stackup_cormack( var_1 );
    level.cormack maps\_utility::enable_ai_color();
}

waittill_player_uses_land_assist_or_is_a_jerk()
{
    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_first_land_assist" ) && common_scripts\utility::flag( "land_assist_activated" ) )
            break;

        if ( common_scripts\utility::flag( "begin_looping_fob_functions" ) )
            break;

        if ( common_scripts\utility::flag( "dialogue_hotel_top_floor_landassist_end" ) )
            break;

        waitframe();
    }
}

get_will_into_first_landassist()
{
    level endon( "e3_jump_end_scene" );
    var_0 = maps\_shg_design_tools::getthing( "struct_land_assist_cormack_01b", "targetname" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_1 maps\_anim::anim_reach_solo( level.will_irons, "first_landassist_enter" );
    var_1 maps\_anim::anim_single_solo( level.will_irons, "first_landassist_enter" );
    level.will_irons.anim_org = var_1;

    if ( !common_scripts\utility::flag( "flag_first_land_assist" ) || !common_scripts\utility::flag( "land_assist_activated" ) || !common_scripts\utility::flag( "begin_looping_fob_functions" ) )
    {
        var_1 thread maps\_anim::anim_loop_solo( level.will_irons, "first_landassist_idle" );
        waittill_player_uses_land_assist_or_is_a_jerk();
        level.will_irons maps\_utility::anim_stopanimscripted();
        level.will_irons maps\_shg_design_tools::anim_stop( var_1 );
    }

    level.will_irons guy_jump_to_breach_stackup_will( var_1 );
}

guy_jump_to_breach_stackup_cormack( var_0 )
{
    level endon( "exo_breach_impact" );
    level endon( "exo_breach_begin" );
    level endon( "e3_jump_end_scene" );
    var_0 maps\_anim::anim_single_solo( self, "first_landassist_jump_e3" );
    self notify( "i_have_landed" );
    level.cormack maps\_utility::anim_stopanimscripted();
    level.cormack maps\_shg_design_tools::anim_stop( var_0 );
}

guy_jump_to_breach_stackup_will( var_0 )
{
    level endon( "exo_breach_impact" );
    level endon( "exo_breach_begin" );
    level endon( "e3_jump_end_scene" );
    var_0 maps\_anim::anim_single_solo( self, "first_landassist_jump_e3" );
    self notify( "i_have_landed" );
}

guy_jump_to_breach_stackup_jackson( var_0 )
{
    var_0 maps\_anim::anim_reach_solo( self, "first_landassist_jump_e3" );
    var_0 maps\_anim::anim_single_solo( self, "first_landassist_jump_e3" );
    self notify( "i_have_landed" );
    var_1 = getnode( "node_jackson_take_position_building", "targetname" );
    self _meth_81A5( var_1 );
}

jump_down_when_in_view( var_0 )
{
    while ( !common_scripts\utility::flag( "flag_second_land_assist_go" ) && !jump_down_now() )
        waitframe();

    if ( isdefined( self.anim_tag ) )
        maps\_shg_design_tools::anim_stop( self.anim_tag );

    self _meth_81A5( var_0 );
}

jump_down_when_in_view_cormack( var_0, var_1 )
{
    while ( !common_scripts\utility::flag( "flag_second_land_assist_go" ) && !jump_down_now() )
        waitframe();

    var_1 maps\_anim::anim_generic( self, var_1.animation );
    self _meth_81A5( var_0 );
}

jump_down_now()
{
    if ( !isdefined( level.test_tag ) )
    {
        level.test_tag = common_scripts\utility::spawn_tag_origin();
        _func_09A( level.test_tag );
        _func_0A6( level.test_tag, level.player );
    }

    level.test_tag.origin = self.origin + ( 0, 0, 34 );

    if ( _func_09F( level.test_tag, level.player, 65, 200 ) )
        return 1;

    return 0;
}

to_second_land_assist_idles_cormack( var_0 )
{
    var_0 maps\_anim::anim_generic_reach( self, var_0.animation );
    self.anim_tag = var_0 common_scripts\utility::spawn_tag_origin();
    self notify( "second_land_assist_arrive" );
    self.anim_tag thread maps\_anim::anim_generic_first_frame( self, var_0.animation );
    self.anim_tag.animation = var_0.animation;
}

to_second_land_assist_idles( var_0 )
{
    var_1 = var_0.animation + "_single";
    self.anim_tag = var_0 common_scripts\utility::spawn_tag_origin();
    self.anim_tag maps\_anim::anim_generic_reach( self, var_1 );
    self notify( "second_land_assist_arrive" );

    if ( !common_scripts\utility::flag( "flag_second_land_assist_go" ) )
        self.anim_tag thread maps\_anim::anim_generic_loop( self, var_0.animation );
}

guy_exit_missile_explode_room()
{
    var_0 = level.jackson;
    var_0.anim_struct = common_scripts\utility::getstruct( "struct_guy_explosion_dodge_jump", "targetname" );
    var_0.anim_struct2 = maps\_shg_design_tools::getthing( "struct_bottom_of_building_guy", "targetname" );
    var_0.anim_struct maps\_anim::anim_generic_reach( var_0, var_0.anim_struct.animation );
    var_0.anim_struct jump_anim_with_gravity( var_0, var_0.anim_struct.animation, var_0.anim_struct2, var_0.anim_struct2.animation );
}

allies_to_building_exit()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_building_traverse_exit_start_anim" );
    thread maps\_utility::flag_set_delayed( "dialogue_hotel_exit", 4 );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_building_exit_allies" );

    if ( !isdefined( level.cormack.building_exit_arrived ) )
        level.cormack.building_exit_arrived = 0;

    if ( !isdefined( level.will_irons.building_exit_arrived ) )
        level.will_irons.building_exit_arrived = 0;

    while ( !level.cormack.building_exit_arrived || !level.will_irons.building_exit_arrived )
        wait 0.05;
}

anim_scene_building_exit_cormack( var_0 )
{
    self.building_exit_arrived = 0;
    level.cormack maps\_utility::set_moveplaybackrate( 1 );
    var_1 = common_scripts\utility::getstruct( "struct_building_exit_cormack_wait", "targetname" );
    var_1 maps\_anim::anim_reach_solo( self, "seo_react_to_war_run_2_idle" );

    if ( !common_scripts\utility::flag( "begin_fob_combat_vignette" ) )
    {
        var_1 maps\_anim::anim_single_solo( self, "seo_react_to_war_run_2_idle" );

        if ( !common_scripts\utility::flag( "begin_fob_combat_vignette" ) )
            thread maps\_anim::anim_loop_solo( self, "seo_react_to_war_idle" );

        common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
        self notify( "stop_loop" );
        maps\_utility::anim_stopanimscripted();
        maps\_anim::anim_single_solo_run( self, "seo_react_to_war_idle_2_run" );
    }

    level.player notify( "trigger_allies_to_fob" );
}

anim_scene_building_exit_will( var_0 )
{
    self.building_exit_arrived = 0;
    var_1 = common_scripts\utility::getstruct( "struct_building_exit_will_wait", "targetname" );
    var_1 maps\_anim::anim_reach_solo( self, "seo_react_to_war_run_2_idle" );

    if ( !common_scripts\utility::flag( "begin_fob_combat_vignette" ) )
    {
        var_1 maps\_anim::anim_single_solo( self, "seo_react_to_war_run_2_idle" );

        if ( !common_scripts\utility::flag( "begin_fob_combat_vignette" ) )
        {
            thread maps\_anim::anim_loop_solo( self, "seo_react_to_war_idle" );
            common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
            wait 0.35;
        }

        common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
        self notify( "stop_loop" );
        maps\_utility::anim_stopanimscripted();
        maps\_anim::anim_single_solo_run( self, "seo_react_to_war_idle_2_run" );
    }
}

get_will_to_fob_anim_scene()
{
    var_0 = common_scripts\utility::getstruct( "struct_fob_wait_will_exit", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.will_irons, "seo_react_to_war_poseA_in" );
    level.will_irons maps\_utility::set_moveplaybackrate( 0.85 );

    if ( !common_scripts\utility::flag( "flag_start_fob_meet_scene" ) )
    {
        var_0 maps\_anim::anim_single_solo( level.will_irons, "seo_react_to_war_poseA_in" );
        level.will_irons thread maps\_anim::anim_loop_solo( level.will_irons, "seo_react_to_war_poseA_idle" );
        common_scripts\utility::flag_wait( "flag_start_fob_meet_scene" );
        wait 0.5;
        level.will_irons notify( "end_loop" );
        level.will_irons maps\_utility::anim_stopanimscripted();
        level.will_irons maps\_anim::anim_single_solo_run( level.will_irons, "seo_react_to_war_poseA_out" );
    }

    var_1 = common_scripts\utility::getstruct( "will_irons_fobmeetup_idle_org", "targetname" );
    var_1 maps\_anim::anim_reach_solo( level.will_irons, "fob_meet_will_into" );
    var_1 maps\_anim::anim_single_solo_run( level.will_irons, "fob_meet_will_into" );
    level.will_irons thread maps\_anim::anim_loop_solo( level.will_irons, "seo_react_to_war_idle" );
    level waittill( "fob_cormack_wave" );
}

allies_to_fob()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_vista_scene_end" );
    var_0 = common_scripts\utility::getstructarray( "struct_fob_talk_scene_cormack", "targetname" );
    var_1 = var_0[0];
    var_2 = var_1 common_scripts\utility::spawn_tag_origin();
    var_3 = var_1 common_scripts\utility::spawn_tag_origin();
    var_4 = getent( "temp_anim_scene_spawner", "targetname" );
    var_5 = getent( "fob_sergeant", "targetname" );
    level.guide = var_5 maps\_shg_design_tools::actual_spawn( 1 );
    level.guide.animname = "daniels";
    level.guide.anim_tag = var_2;
    level.guide maps\_utility::deletable_magic_bullet_shield();
    wait 0.1;
    level.marine_3 = var_4 maps\_shg_design_tools::actual_spawn( 1 );
    level.marine_3 maps\_utility::gun_remove();
    level.marine_3.animname = "generic";
    var_3 thread maps\_anim::anim_loop_solo( level.marine_3, "fob_meet_guy1_idle" );
    level.guide.anim_tag thread maps\_anim::anim_loop_solo( level.guide, "fob_meet_guy2_idle" );
    level.player waittill( "trigger_allies_to_fob" );
    allies_to_fob_think();
}

allies_to_fob_think()
{
    var_0 = common_scripts\utility::getstruct( "struct_fob_wait_comack_exit", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_fob_talk_scene_cormack", "targetname" );
    var_2 = var_1[0];
    var_3 = var_2 common_scripts\utility::spawn_tag_origin();
    var_4 = var_2 common_scripts\utility::spawn_tag_origin();
    var_5 = getnode( "node_fob_allies_02a", "targetname" );
    var_6 = getnode( "node_fob_allies_02", "targetname" );
    level.jackson.goalradius = 256;
    level.jackson _meth_81A5( var_5 );

    if ( level.currentgen )
    {
        var_5 = getnode( "node_fob_section_jackson_01", "targetname" );
        level.jackson _meth_81A5( var_5 );
    }

    thread get_will_to_fob_anim_scene();
    var_0 maps\_anim::anim_reach_solo( level.cormack, "seo_react_to_war_run_2_idle" );
    level.cormack thread maps\_utility::set_run_anim( "seo_react_to_war_run_npc1", 0 );

    if ( !common_scripts\utility::flag( "flag_start_fob_meet_scene" ) )
    {
        var_0 maps\_anim::anim_single_solo( level.cormack, "seo_react_to_war_run_2_idle" );
        level.cormack thread maps\_anim::anim_loop_solo( level.cormack, "seo_react_to_war_idle" );
        common_scripts\utility::flag_wait( "flag_start_fob_meet_scene" );
        level.cormack notify( "end_loop" );
        level.cormack maps\_utility::anim_stopanimscripted();
        level.cormack maps\_anim::anim_single_solo_run( level.cormack, "seo_react_to_war_idle_2_run" );
    }

    common_scripts\utility::flag_wait( "flag_start_fob_meet_scene" );
    level notify( "fob_talk_scene_start" );
    level notify( "the_fob_scene_is_live" );
    level.jackson _meth_81A5( var_6 );
    var_3 maps\_anim::anim_reach_solo( level.cormack, "fob_meet_cormack" );
    thread guide_anim_scene_fob_meet( var_3 );
    thread cormack_anim_scene_fob_meet( var_3 );
}

guide_anim_scene_fob_meet( var_0 )
{
    level.guide maps\_utility::anim_stopanimscripted();
    level.guide maps\_shg_design_tools::anim_stop( level.guide.anim_tag );
    var_0 maps\_anim::anim_single_solo( level.guide, "fob_meet_guy2" );
    var_0 thread maps\_anim::anim_loop_solo( level.guide, "fob_meet_guy2_idle" );
    level notify( "fob_talk_scene_end" );
}

send_will_wait()
{
    wait 15.75;
    level notify( "send_will_2secs_early" );
}

cormack_anim_scene_fob_meet( var_0 )
{
    thread cormack_wait( 12 );
    thread send_will_wait();
    common_scripts\utility::flag_set( "dialogue_start_fob_meetup" );
    var_0 maps\_anim::anim_single_solo_run( level.cormack, "fob_meet_cormack" );
    level notify( "walker_step_over_anim_scene" );
    level.cormack maps\_utility::clear_run_anim();
    common_scripts\utility::flag_set( "destroy_fob_blocking" );
    get_cormack_to_walker_scene();
}

get_cormack_to_walker_scene()
{
    level.cormack.anim_struct = common_scripts\utility::getstruct( "struct_walker_walkover_scene", "targetname" );
    level.cormack maps\_utility::set_moveplaybackrate( 1.1 );
    level.cormack.anim_struct maps\_anim::anim_reach_solo( level.cormack, "fob_meet_post_enter_1" );
    level.cormack maps\_utility::set_moveplaybackrate( 1.4 );
    level.cormack.anim_struct maps\_anim::anim_single_solo_run( level.cormack, "fob_meet_post_enter_1" );
    common_scripts\utility::flag_set( "flag_cormack_has_arrived_at_hill" );
    level.cormack.anim_struct thread maps\_anim::anim_loop_solo( level.cormack, "fob_meet_post_idle_1" );
    level notify( "begin_walker_stepover_anim" );
}

get_will_to_walker_scene()
{
    level.will_irons maps\_utility::clear_run_anim();
    level.will_irons notify( "stop_loop" );
    level.will_irons _meth_8141();
    level.will_irons maps\_anim::anim_single_solo_run( level.will_irons, "seo_react_to_war_idle_2_run" );
    level.will_irons.anim_struct = common_scripts\utility::getstruct( "struct_walker_walkover_scene", "targetname" );
    level.will_irons maps\_utility::set_moveplaybackrate( 1.1 );
    level.will_irons.anim_struct maps\_anim::anim_reach_solo( level.will_irons, "fob_meet_post_enter_2" );
    level.will_irons maps\_utility::set_moveplaybackrate( 1.4 );
    level.will_irons.anim_struct maps\_anim::anim_single_solo( level.will_irons, "fob_meet_post_enter_2" );
    common_scripts\utility::flag_set( "flag_will_irons_has_arrived_at_hill" );
    level.will_irons.anim_struct thread maps\_anim::anim_loop_solo( level.will_irons, "fob_meet_post_idle_2" );
}

cormack_wait( var_0 )
{
    wait(var_0);
    common_scripts\utility::flag_set( "fob_animation_complete" );
}

allies_to_hill()
{
    level waittill( "fob_cormack_wave" );
    thread get_will_to_walker_scene();
    wait 1.5;
    var_0 = getnode( "node_hill_pause_guy", "targetname" );
    level.jackson _meth_81A5( var_0 );
    level.jackson maps\_utility::clear_run_anim();
    level waittill( "fob_talk_scene_end" );
}

allies_to_drone_swarm()
{
    level waittill( "anim_walker_stepoaver_scene_done" );
    var_0 = getnode( "node_drone_section_guy_01", "targetname" );
    level.jackson _meth_81A5( var_0 );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_drone_swarm_flank" );
}

allies_to_truck_jump()
{
    level waittill( "end_cherry_picker" );

    if ( isdefined( level.mobile_turret ) )
        level.mobile_turret maps\_utility::ent_flag_wait( "player_in_transition" );

    wait 1;
    thread jump_training_hint();
    thread jump_training_vo_think();
    var_0 = common_scripts\utility::getstructarray( "struct_start_truck_push_01", "targetname" );
    level.cormack maps\_shg_design_tools::anim_stop();
    level.jackson maps\_shg_design_tools::anim_stop();
    level.will_irons maps\_shg_design_tools::anim_stop();
    level.will_irons _meth_81C6( var_0[0].origin, var_0[0].angles );
    level.cormack _meth_81C6( var_0[1].origin, var_0[1].angles );
    level.jackson _meth_81C6( var_0[2].origin, var_0[2].angles );
    wait 0.1;
    var_1 = getnode( "node_jump_train_cormack", "targetname" );
    level.cormack.goalradius = 32;
    level.cormack _meth_81A5( var_1 );
    var_2 = getnode( "node_jump_train_will", "targetname" );
    level.will_irons.goalradius = 32;
    level.will_irons _meth_81A5( var_2 );
    level.will_irons remove_cardoor_from_npc( 1 );
    var_3 = getnode( "node_jump_train_jackson", "targetname" );
    level.jackson.goalradius = 32;
    level.jackson _meth_81A5( var_3 );
    var_4 = getentarray( "trigger_jump_training_done", "targetname" );
    var_4[0] waittill( "trigger" );
    level notify( "jump_training_done" );
}

jump_training_vo_think()
{
    var_0 = getent( "vol_jump_training_vo_01", "targetname" );
    thread monitor_jump_training_end();

    while ( !level.cormack _meth_80A9( var_0 ) )
        waitframe();

    common_scripts\utility::flag_set( "vo_jump_training_start" );
}

monitor_jump_training_end()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_jump_training_done" );
    common_scripts\utility::flag_set( "jump_training_ended" );
    level notify( "jump_training_end" );
}

jump_training_hint()
{
    var_0 = getent( "vol_jump_training_drone_street", "targetname" );
    thread maps\_shg_design_tools::trigger_to_flag( "trigger_jump_training_done", "trigger_jump_training_done_flag" );

    while ( !common_scripts\utility::flag( "trigger_jump_training_done_flag" ) )
    {
        if ( level.player _meth_80A9( var_0 ) )
        {
            maps\_utility::display_hint( "jump_training" );

            while ( level.player _meth_80A9( var_0 ) )
                waitframe();
        }

        waitframe();
    }
}

generic_get_player_to_rig( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = spawn_player_rig( "player_rig", var_0.origin );
    var_8 hide();
    maps\_shg_utility::setup_player_for_scene( 1 );
    var_9 = 0.4;

    if ( isdefined( var_2 ) )
        var_9 = 0;

    var_0 thread maps\_anim::anim_first_frame_solo( var_8, var_1 );

    if ( !isdefined( var_3 ) || !var_3 )
        self _meth_8080( var_8, "tag_player", var_9 );
    else
        self _meth_807D( var_8, "tag_player", 0.5, var_4, var_5, var_6, var_7, 1, 1 );

    wait(var_9);
    var_8 show();
    return var_8;
}

restrict_player_view_to_rig_anim()
{
    var_0 = self;
    level.player _meth_804F();
    var_1 = 0.4;
    level.player _meth_8080( self, "tag_player", var_1 );
}

release_player_view_to_rig_anim( var_0, var_1, var_2, var_3 )
{
    var_4 = self;
    level.player _meth_804F();
    level.player _meth_807D( self, "tag_player", 0.5, var_0, var_1, var_2, var_3, 1, 1 );
}

generic_get_rig_to_player( var_0, var_1 )
{
    var_2 = spawn_player_rig( "player_rig", level.player.origin + ( 0, 0, -42 ) );
    var_2.angles = ( 0, 0, 0 );
    var_2 hide();
    self freezecontrols( 1 );
    maps\_shg_utility::setup_player_for_scene( 1 );
    var_3 = 0.4;
    var_0 thread maps\_anim::anim_first_frame_solo( var_2, var_1 );
    self _meth_8080( var_2, "tag_player", var_3 );
    wait(var_3);
    var_2 show();
    return var_2;
}

generic_get_player_to_arms( var_0, var_1 )
{
    var_2 = spawn_player_rig( "player_arms", var_0.origin );
    var_2 hide();
    self freezecontrols( 1 );
    maps\_shg_utility::setup_player_for_scene( 1 );
    var_3 = 0.4;
    var_0 thread maps\_anim::anim_first_frame_solo( var_2, var_1 );
    self _meth_8080( var_2, "tag_player", var_3 );
    wait(var_3);
    var_2 show();
    return var_2;
}

generic_remove_player_rig( var_0 )
{
    level.player _meth_804F();
    var_0 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player freezecontrols( 0 );
}

allies_to_weapons_platform_video_log()
{
    level.will_irons waittill( "ready_to_rally", var_0 );
    maps\_utility::flag_set_delayed( "dialogue_performing_arts_entrance_2", 3 );
    var_0 maps\_anim::anim_single_solo( level.will_irons, "rally_up_enter" );
    var_1 = [ "rally_up_idle_a", "rally_up_idle_b", "rally_up_idle_c" ];

    while ( !common_scripts\utility::flag( "corner_rally_begin" ) )
    {
        var_2 = common_scripts\utility::random( var_1 );
        var_0 maps\_anim::anim_single_solo( level.will_irons, var_2 );
    }

    level.will_irons maps\_shg_design_tools::anim_stop( var_0 );
    var_0 maps\_anim::anim_single_solo( level.will_irons, "rally_up_exit" );
}

handle_hotel_entrance()
{
    thread handle_performing_art_center_video_log();
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_setup_guide_kill" );
    level notify( "vo_keep_moving" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_combat_03" );
    level notify( "vo_keep_moving" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_combat_06" );
    level notify( "vo_keep_moving" );
}

handle_performing_art_center_video_log()
{
    level waittill( "never" );
    level waittill( "end_cherry_picker" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_seoul_video_log" );
    common_scripts\utility::flag_set( "dialogue_performing_arts_entrance_2" );
    prep_cinematic( "seoul_videolog" );
    play_seoul_videolog();
    wait 0.15;
    maps\seoul::ingame_movies();
}

spawn_player_rig( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "player_rig";

    if ( !isdefined( var_1 ) )
        var_1 = level.player.origin;

    var_2 = maps\_utility::spawn_anim_model( var_0 );
    return var_2;
}

setup_npc_paths()
{
    level waittill( "droppod_empty" );
    thread spawn_warbird_spotlight_gag();
    level notify( "vista_warbird_spot_allies" );
    common_scripts\utility::flag_wait( "vista_warbird_gag_done" );
}

spawn_warbird_spotlight_gag()
{
    level waittill( "vista_warbird_spot_allies" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "vehicle_vista_ally_warbird_spotlight" );

    if ( level.currentgen )
        var_0 thread maps\seoul::tff_cleanup_vehicle( "east_view" );

    thread maps\seoul_fx::vista_warbird_fx( var_0 );
    var_0 soundscripts\_snd::snd_message( "hotel_razorback_fly_by" );
    var_0 _meth_8283( 15, 5, 15 );
    wait 8.5;
    level notify( "spotlight_switch" );
}

setup_openning_vista()
{
    thread cleanup_vista();
    thread handle_vista_tanks();
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_start_vista_vehicle_flyby" );

    if ( level.currentgen )
    {
        if ( !_func_21E( "seoul_fob_tr" ) )
            level waittill( "transients_intro_to_fob" );
    }

    thread handle_vista_pods();
    thread handle_vista_vehicles();
    thread handle_vista_jets();
    thread handle_vista_missile_outrun();
}

handle_vista_missile_outrun()
{
    var_0 = getentarray( "vehicle_outrun_missiles_missile", "targetname" );
    var_1 = getent( "vehicle_outrun_missiles_jet", "targetname" );
    wait 8;
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "vehicle_outrun_missiles_jet" );

    foreach ( var_4 in var_0 )
    {
        var_5 = var_4 maps\_vehicle::spawn_vehicle_and_gopath();
        var_5 thread match_speed_to_jet( var_2 );
        wait 0.25;
    }
}

match_speed_to_jet( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );

    for (;;)
    {
        var_1 = var_0.speed * randomfloatrange( 0.85, 1.1 );

        if ( var_1 <= 0 )
            var_1 = 1;

        self _meth_8283( var_1, 50, 90 );
        wait 1;
    }
}

handle_vista_tanks()
{
    level waittill( "pod_deform" );

    if ( level.currentgen && !issubstr( level.transient_zone, "fob" ) )
        level waittill( "transients_intro_to_fob" );

    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "vehicle_vista_warbird_flyby_00" );
    var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "vehcile_vista_tank_01" );

    foreach ( var_3 in var_1 )
    {
        thread delete_on_path_end();

        if ( level.currentgen )
            thread maps\seoul_transients_cg::cg_kill_entity_on_transition( var_3, "pre_transients_drone_seq_one_to_trusk_push" );
    }

    if ( level.currentgen )
    {
        foreach ( var_6 in var_0 )
            thread maps\seoul_transients_cg::cg_kill_entity_on_transition( var_6, "pre_transients_drone_seq_one_to_trusk_push" );
    }
}

delete_on_path_end()
{
    self waittill( "reached_end_node" );
    self delete();
}

handle_vista_jets()
{
    thread vista_jets_reflection_override();
    wait 10;
    var_0 = getentarray( "vehicle_vista_jet_02", "targetname" );
    level.vista_jet_array = [];
    thread handle_bombing_runs();

    if ( var_0.size > 0 )
    {
        while ( !common_scripts\utility::flag( "flag_first_land_assist" ) )
        {
            foreach ( var_2 in var_0 )
            {
                var_3 = undefined;

                if ( level.nextgen )
                    var_3 = 12;
                else
                    var_3 = 6;

                if ( safe_to_spawn_vehciles() && level.vista_jet_array.size < var_3 && maps\_shg_design_tools::percentchance( 75 ) )
                {
                    var_4 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
                    var_4 soundscripts\_snd::snd_message( "aud_handle_vista_jets" );

                    if ( isdefined( var_4 ) )
                        level.vista_jet_array[level.vista_jet_array.size] = var_4;
                    else
                        continue;

                    var_4 _meth_8283( randomintrange( 400, 650 ), 200, 900 );
                    wait(randomfloatrange( 0.5, 3.0 ));
                    continue;
                }

                wait(randomfloatrange( 3.0, 6.0 ));
                level.vista_jet_array = common_scripts\utility::array_removeundefined( level.vista_jet_array );
            }
        }
    }
}

safe_to_spawn_vehciles()
{
    var_0 = maps\_utility::getvehiclearray();

    if ( var_0.size < 18 )
        return 1;

    return 0;
}

vista_jets_reflection_override()
{
    wait 30;
    var_0 = getentarray( "vehicle_vista_jet_02", "targetname" );
    wait 3;
    var_1 = getent( "main_street_reflection", "targetname" );
    var_0 = getentarray( "vehicle_vista_jet_01", "targetname" );

    foreach ( var_3 in var_0 )
        wait(randomfloatrange( 0.5, 2.0 ));
}

handle_bombing_runs()
{
    var_0 = common_scripts\utility::getstructarray( "struct_vista1_bomb_01", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_vista1_bomb_02", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "struct_vista1_bomb_03", "targetname" );
    var_3 = common_scripts\utility::getstructarray( "struct_vista1_bomb_04", "targetname" );
    var_4 = common_scripts\utility::getstructarray( "struct_vista1_bomb_05", "targetname" );
    var_5[0] = sortbydistance( var_0, level.player.origin );
    var_5[1] = sortbydistance( var_1, level.player.origin );
    var_5[2] = sortbydistance( var_2, level.player.origin );
    var_5[3] = sortbydistance( var_3, level.player.origin );
    var_5[4] = sortbydistance( var_4, level.player.origin );

    for (;;)
    {
        var_6 = common_scripts\utility::flag_wait_any_return( "vista_bomber_trigger_01", "vista_bomber_trigger_02", "vista_bomber_trigger_03" );
        common_scripts\utility::flag_clear( var_6 );
        var_7 = common_scripts\utility::random( var_5 );

        foreach ( var_9 in var_7 )
        {
            if ( common_scripts\utility::cointoss() )
            {
                playfx( common_scripts\utility::getfx( "ambient_explosion_fireball" ), var_9.origin );
                soundscripts\_snd::snd_message( "seo_vista_bombing_run", var_9.origin );
            }

            waitframe();
        }

        waitframe();
    }
}

handle_vista_vehicles()
{
    if ( level.nextgen )
        var_0 = getent( "vista_reflection_02", "targetname" );
    else
        var_0 = getent( "main_street_reflection", "targetname" );

    var_1 = getentarray( "vehicle_vista_ally_warbird_01", "targetname" );
    var_2 = getentarray( "vehicle_vista_warbird_flyby", "targetname" );
    var_1 = common_scripts\utility::array_combine( var_1, var_2 );
    common_scripts\utility::array_thread( var_1, ::spawn_vista_vehicle );
}

spawn_vista_vehicle()
{
    if ( level.currentgen )
        level endon( maps\seoul::tff_get_zone_unload_notify( "east_view" ) );

    wait(randomfloat( 3.5 ));
    var_0 = thread maps\_vehicle::spawn_vehicle_and_gopath();
    level.vista_ents[level.vista_ents.size] = var_0;

    if ( level.currentgen )
        var_0 thread maps\seoul::tff_cleanup_vehicle( "east_view" );

    if ( level.nextgen )
        var_1 = getent( "vista_reflection_02", "targetname" );
    else
        var_1 = getent( "main_street_reflection", "targetname" );

    foreach ( level.vista_ent in level.vista_ents )
        level.vista_ent _meth_83AB( var_1.origin );
}

handle_vista_pods()
{
    var_0 = getentarray( "droppod_exterior_vista_01", "targetname" );

    foreach ( var_2 in var_0 )
    {
        wait(randomfloatrange( 1.0, 2.0 ));
        var_3 = maps\_utility::spawn_anim_model( "npc_droppod" );
        var_2 thread maps\_anim::anim_single_solo( var_3, "pod_landing" );
    }

    level waittill( "never" );
    var_5 = getentarray( "model_droppod_exterior_vista_crashers", "targetname" );
    thread handle_vista_landing_pods( var_0 );
    thread handle_vista_crashing_pods( var_5 );
    level.vista_ents = common_scripts\utility::array_combine( level.vista_ents, var_0 );
    level.vista_ents = common_scripts\utility::array_combine( level.vista_ents, var_5 );
}

handle_vista_landing_pods( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        wait(randomfloat( 2.0 ));
        var_2 thread land_pod_cleanly( 1 );
    }
}

handle_vista_crashing_pods( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        wait(randomfloat( 2.0 ));
        var_2 thread land_pod_badly();
    }
}

cleanup_vista()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "start_pod_landings" );
    level notify( "end_vista_view" );
    common_scripts\utility::array_thread( level.vista_ents, maps\_shg_design_tools::delete_auto );
}

temp_handle_fob_anim_scene()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_fob_scene" );

    if ( !common_scripts\utility::flag( "hault_column" ) )
        common_scripts\utility::flag_set( "hault_column" );
}

kill_on_trigger( var_0 )
{
    maps\_shg_design_tools::waittill_trigger_with_name( var_0 );
    maps\_shg_design_tools::delete_auto();
}

setup_ambient_walker_tank()
{
    common_scripts\utility::flag_wait( "player_passed_fob" );
}

handle_path_blocking_fob()
{
    var_0 = getent( "brush_fob_path_blocker_trench", "targetname" );
    var_1 = getent( "brush_blocker_fob_droppod_landing_guys", "targetname" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_fob_scene" );
    var_1.origin += ( 0, 0, 10000 );
    var_1 _meth_8058();
    level waittill( "remove_path_blockers_fob" );
    var_0.origin += ( 0, 0, 1000 );
    var_0 _meth_8058();
}

handle_fob_runners()
{
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    var_0 = getentarray( "spawner_ambient_fob_group_01", "targetname" );
    var_1 = getnodearray( "delete_me_node_array", "targetname" );

    if ( level.nextgen )
        var_2 = 4;
    else
        var_2 = 3;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = common_scripts\utility::random( var_0 ) maps\_shg_design_tools::actual_spawn();

        if ( !isdefined( var_4 ) )
            continue;

        var_5 = common_scripts\utility::random( var_1 );
        var_4.goalradius = 32;
        var_4.ignoreall = 1;
        var_4 _meth_81A6( var_5.origin );
        var_4 thread delete_me_on_goal();
        wait 1;
    }
}

handle_fob_runners_second_wave()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "hault_column" );
    var_0 = getentarray( "spawner_ambient_fob_group_01", "targetname" );
    var_1 = getnodearray( "delete_me_node_array", "targetname" );
    var_2 = 6;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = common_scripts\utility::random( var_0 ) maps\_shg_design_tools::actual_spawn();

        if ( !isdefined( var_4 ) )
            continue;

        var_5 = common_scripts\utility::random( var_1 );
        var_4.goalradius = 32;
        var_4.ignoreall = 1;
        var_4 _meth_81A6( var_5.origin );
        var_4 thread delete_me_on_goal();
        wait(randomfloatrange( 0.5, 1.75 ));
    }
}

handle_lobby_ambient_troops()
{
    thread maps\_shg_design_tools::trigger_to_flag( "trigger_end_looping_anims", "end_lobby_loopers" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_vista_scene_end" );
    thread spawn_guy_loopers();
    thread spwan_vehicle_loopers();
}

spawn_guy_loopers()
{
    var_0 = getent( "spawner_lobby_loopers", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_lobby_looper_01", "targetname" );
    var_2 = getnode( "node_spawner_lobby_loopers", "targetname" );

    if ( level.currentgen )
    {
        if ( !_func_21E( "seoul_fob_tr" ) )
            level waittill( "transients_intro_to_fob" );
    }

    while ( !common_scripts\utility::flag( "end_lobby_loopers" ) )
    {
        if ( level.nextgen )
            var_3 = randomint( 3 );
        else
            var_3 = 1;

        for ( var_4 = 0; var_4 < var_3; var_4++ )
        {
            if ( common_scripts\utility::flag( "end_lobby_loopers" ) )
                return;

            var_5 = var_0 maps\_shg_design_tools::actual_spawn( 1 );

            if ( level.currentgen )
            {
                wait 0.05;
                var_6 = getnode( "lobby_looper_tele", "targetname" );
                var_5 _meth_81C5( var_6.origin, var_6.angles );
            }

            var_7 = common_scripts\utility::random( var_1 );
            var_5 thread play_anim_and_delete( var_7, var_7.animation, var_2 );
            var_5.allowdeath = 1;
            wait(randomfloat( 2.0 ));
        }

        if ( level.nextgen )
        {
            wait 2;
            continue;
        }

        wait(randomfloatrange( 6.0, 10.0 ));
    }
}

spwan_vehicle_loopers()
{
    var_0 = getentarray( "vehicle_spawner_lobby_loopers", "targetname" );

    while ( !common_scripts\utility::flag( "end_lobby_loopers" ) )
    {
        var_1 = common_scripts\utility::random( var_0 );
        var_2 = var_1 maps\_vehicle::spawn_vehicle_and_gopath();
        var_2 thread delete_on_path_end();

        if ( level.nextgen )
        {
            wait(randomfloatrange( 3.0, 8.0 ));
            continue;
        }

        wait(randomfloatrange( 10.0, 15.0 ));
    }
}

play_anim_and_delete( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_0 maps\_anim::anim_generic_reach( self, var_1 );

    if ( _func_294( self ) )
        return;

    if ( !isdefined( self ) )
        return;

    var_0 maps\_anim::anim_generic( self, var_1 );

    if ( !isdefined( self ) )
        return;

    self _meth_81A6( var_2.origin );
    self.goalradius = 32;
    self waittill( "goal" );
    self delete();
}

handle_fob()
{
    thread handle_lobby_ambient_troops();
    thread temp_handle_fob_anim_scene();
    thread setup_tank_battle();
    thread setup_injured_soldiers();
    thread handle_friendly_fob_razorback();
    thread setup_ambient_walker_tank();
    thread handle_path_blocking_fob();
    thread anim_scene_walker_stepover();
    thread handle_fob_runners();

    if ( level.nextgen )
        thread handle_fob_runners_second_wave();

    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_opening_view_off_01" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_opening_view_off_02" );
    maps\_shg_design_tools::remove_monitored_tags( "building_01" );
    var_0 = getentarray( "vehicle_ally_openning_ambient", "targetname" );
    common_scripts\utility::array_call( var_0, maps\_shg_design_tools::delete_auto );
    common_scripts\utility::flag_set( "opening_view_off" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_opening_view_off_02" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_opening_view_off_01" );
    common_scripts\utility::flag_clear( "opening_view_off" );
}

handle_friendly_fob_razorback()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "start_pod_landings" );
}

setup_injured_soldiers()
{
    level.fob_injured_guys = [];
    thread injured_by_base();
}

injured_by_main_exit_door()
{
    var_0 = getent( "ally_spawner_fob_injured", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_fob_injured_soldier_maindoor", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_0.idleanim = level.scr_anim["generic"][var_3.animation][0];
        var_4 = var_0 maps\_utility::dronespawn();
        var_4 maps\_utility::anim_stopanimscripted();
        var_3 thread maps\_anim::anim_generic_loop( var_4, var_3.animation );
        var_4 maps\_utility::gun_remove();
        wait 0.05;
    }
}

injured_by_base()
{
    var_0 = getent( "ally_spawner_fob_injured_by_base", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_fob_injured_soldier_base", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_0.idleanim = level.scr_anim["generic"][var_3.animation][0];
        var_4 = var_0 maps\_utility::dronespawn();
        var_4 maps\_utility::anim_stopanimscripted();
        var_4 maps\_utility::gun_remove();
        var_3 thread maps\_anim::anim_generic_loop( var_4, var_3.animation );
        wait 0.05;
    }
}

injured_guy_dialogue()
{
    level endon( "the_fob_scene_is_live" );

    for (;;)
    {
        is_1_near_2( level.player, self, 400 );
        common_scripts\utility::flag_set( "soldier_injured_dialogue" );
        return;
    }
}

is_1_near_2( var_0, var_1, var_2 )
{
    for (;;)
    {
        if ( distance2d( var_0.origin, var_1.origin ) < var_2 )
            return;

        wait 0.05;
    }
}

setup_tank_battle()
{
    var_0 = getentarray( "enemy_tanks_group_01", "targetname" );
    var_1 = common_scripts\utility::getstruct( "struct_missile_fire_point_test", "targetname" );
    var_2 = getentarray( "missile_test", "targetname" );
    var_3 = getentarray( "missile_test_02", "targetname" );

    for (;;)
    {
        while ( common_scripts\utility::flag( "opening_view_off" ) )
            wait 0.05;

        wait(randomfloatrange( 6.0, 12.0 ));
        var_4 = common_scripts\utility::array_randomize( var_2 );
        var_5 = randomint( var_4.size );

        for ( var_6 = 0; var_6 < var_5; var_6++ )
        {
            if ( !safe_to_spawn_vehciles() )
            {
                waitframe();
                continue;
            }

            var_7 = var_4[var_6] maps\_vehicle::spawn_vehicle_and_gopath();
            var_7 soundscripts\_snd::snd_message( "sidewinder_missile" );
            var_7 _meth_8283( 100, 50, 100 );
            var_7 thread sidewinder_explode_impact();
            wait 0.175;
        }
    }
}

sidewinder_explode_impact()
{
    self waittill( "reached_end_node" );
    wait 3;
    playfxontag( common_scripts\utility::getfx( "aa_explosion_runner_single" ), self, "tag_origin" );
    self hide();
    common_scripts\utility::flag_set( "kill_rocket_scene_guy" );
    wait 1;
    self delete();
}

missile_delete()
{
    self waittill( "reached_end_node" );
    self delete();
}

handle_pac_laser_on_vols()
{
    level endon( "end_PAC_combat" );
    var_0 = getentarray( "vol_pac_laser_on_vol", "targetname" );

    for (;;)
    {
        foreach ( var_2 in var_0 )
        {
            var_3 = _func_0D6( "axis" );

            foreach ( var_5 in var_3 )
            {
                if ( isdefined( var_5.force_laser_on ) )
                    continue;

                if ( var_5 _meth_80A9( var_2 ) )
                    var_5 thread monitor_lazer_on_vol( var_2 );
            }
        }

        wait 0.5;
    }
}

monitor_lazer_on_vol( var_0 )
{
    self endon( "death" );
    level endon( "missionfailed" );
    level endon( "end_PAC_combat" );

    for (;;)
    {
        self _meth_80B2( "lag_snipper_laser" );

        while ( self _meth_80A9( var_0 ) )
            waitframe();

        self _meth_80B3();

        while ( !self _meth_80A9( var_0 ) )
            waitframe();
    }
}

handle_testers_skipping_pac_combat()
{
    var_0 = getent( "glass_gate_pac_01", "targetname" );
    var_0 delete();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_player_in_air_building_jump" );
    var_1 = getnodearray( "node_fucker_node_in_pac", "targetname" );

    if ( !isdefined( level.pac_enemy_group ) || level.pac_enemy_group.size == 0 )
        return;

    level.pac_enemy_group = maps\_utility::array_removedead_or_dying( level.pac_enemy_group );

    foreach ( var_4, var_3 in level.pac_enemy_group )
    {
        if ( isdefined( var_3 ) )
        {
            if ( isdefined( var_1[var_4] ) )
            {
                var_3 _meth_81A5( var_1[var_4] );
                var_3.accuracy = 0.9;
                continue;
            }

            var_3 delete();
        }
    }
}

handle_pac_retreating2()
{
    thread maps\_shg_design_tools::trigger_to_flag( "trig_player_in_air_building_jump", "player_jumped_building_traverse" );
    var_0 = getentarray( "pac_retraversal_fail", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2.set_org = var_2.origin;
        var_2.origin += ( 0, 0, 100000 );
    }

    common_scripts\utility::flag_wait( "player_jumped_building_traverse" );
    common_scripts\utility::flag_wait( "player_starting_sinkhole" );

    foreach ( var_2 in var_0 )
        var_2.origin = var_2.set_org;
}

handle_pac_ally_movement()
{
    thread move_forward_if_safe( "trig_convention_center_combat_05" );
    thread move_forward_if_safe( "trig_convention_center_combat_04" );
}

move_forward_if_safe( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_2 = var_0 + "_c";
    var_3 = getent( var_2, "targetname" );
    var_4 = getent( var_1.target, "targetname" );
    var_1 waittill( "trigger" );

    for (;;)
    {
        var_5 = var_4 maps\_utility::get_ai_touching_volume( "axis" );

        if ( var_5.size <= 1 || level.player _meth_80A9( var_4 ) )
        {
            var_3 notify( "trigger" );
            break;
        }

        waitframe();
    }
}

handle_pac_interior()
{
    thread handle_testers_skipping_pac_combat();
    thread handle_pac_retreating();
    thread handle_pac_retreating2();
    thread handle_pac_combat();
    thread handle_pac_zipline_intos();
    thread handle_pac_snipers();
    thread handle_pac_ally_movement();
    thread anim_scene_building_jump();
    thread handle_pac_laser_on_vols();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_setup" );
    level notify( "stop_group_spawning" );
    maps\_utility::autosave_by_name();
}

handle_pac_entrance_fight()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_weapons_platform_takeoff_hotel" );

    if ( level.currentgen )
    {
        var_0 = [ "cg_pac_into_spawner" ];
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "dialogue_performing_arts_exit", var_0, 15, 0 );
    }

    var_1 = getent( "spawner_hotel_enemies_patrollers", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "struct_hotel_patrollers_01", "targetname" );
    var_3 = common_scripts\utility::getstructarray( "struct_hotel_patrollers_02", "targetname" );
    var_4 = [];

    foreach ( var_6 in var_3 )
    {
        var_7 = var_1 maps\_shg_design_tools::actual_spawn( 1 );
        var_7.anim_struct = var_6;
        var_6 thread maps\_anim::anim_generic_loop( var_7, var_6.animation );
        var_7 thread hotel_wake_think();
        var_7 thread group_patrol_wakeup( "wake_PAC_patrollers" );
        var_7.grenadeammo = 0;
        var_4[var_4.size] = var_7;
    }

    foreach ( var_6 in var_2 )
    {
        var_7 = var_1 maps\_shg_design_tools::actual_spawn( 1 );
        var_7 _meth_81C6( var_6.origin, var_6.angles );
        var_7.target = var_6.target;
        var_7 thread maps\_patrol_extended::force_patrol_anim_set( undefined, 0, 1 );
        var_7 thread hotel_wake_think();
        var_7 thread group_patrol_wakeup( "wake_PAC_patrollers" );
        var_7.grenadeammo = 0;
        var_4[var_4.size] = var_7;
    }

    var_11 = getent( "vol_hotel_zipline_defend_02", "script_noteworthy" );

    for ( var_12 = 0; var_12 < 6; var_12++ )
    {
        var_7 = var_1 maps\_shg_design_tools::actual_spawn( 1 );
        var_7 _meth_81A9( var_11 );
        var_7 thread pac_attack_when_alert();
        var_7.grenadeammo = 0;
    }

    level waittill( "wake_PAC_patrollers" );
    var_13 = getent( "clip_pac_entrance_01", "targetname" );
    var_13.origin += ( 0, 0, 10000 );

    foreach ( var_7 in var_4 )
    {
        if ( !isdefined( var_7 ) )
            return;

        var_7 notify( "end_patrol" );
        var_7 notify( "enemy" );

        if ( isdefined( var_7.anim_struct ) )
        {
            var_7.anim_struct notify( "stop_loop" );
            var_7 maps\_shg_design_tools::anim_stop();
        }

        var_7 maps\_shg_design_tools::end_anim_loop();
    }
}

pac_attack_when_alert()
{
    self endon( "death" );
    level waittill( "wake_PAC_patrollers" );
    self notify( "enemy" );
    self notify( "end_patrol" );
}

group_patrol_wakeup( var_0 )
{
    common_scripts\utility::waittill_any( "enemy", "end_patrol", "damage" );
    level notify( var_0 );
    var_1 = getent( "vol_pac_entrance_fallback", "targetname" );

    if ( common_scripts\utility::cointoss() )
        self _meth_81A9( var_1 );
}

hotel_wake_think()
{

}

glass_break_think()
{
    var_0 = getglass( "glass_building_jump" );

    while ( !isglassdestroyed( var_0 ) )
    {
        level waittill( "cormack_shot_glass" );

        if ( !isglassdestroyed( var_0 ) )
        {
            level.cormack _meth_81E7();
            destroyglass( var_0 );
        }
    }
}

handle_off_mission_pac()
{
    var_0 = getentarray( "pac_jerk_skip", "targetname" );
    common_scripts\utility::flag_wait( "dialogue_building_jump" );

    foreach ( var_2 in var_0 )
        var_2.origin += ( 0, 0, 90000 );
}

anim_scene_building_jump()
{
    level notify( "end_anim_scene_building_jump" );
    level endon( "end_anim_scene_building_jump" );
    thread glass_break_think();
    thread maps\_shg_design_tools::trigger_to_flag( "trig_player_in_air_building_jump", "player_building_jump" );
    thread handle_off_mission_pac();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_combat_06" );
    var_0 = getnode( "node_building_jump_prep_will", "targetname" );
    var_1 = getnode( "node_building_jump_prep_cormack", "targetname" );
    level.will_irons _meth_81A5( var_0 );
    level.cormack _meth_81A5( var_1 );
    level notify( "autosave_request" );
    level notify( "end_PAC_combat" );
    wait 0.2;
    var_0 = getnode( "node_building_jump_prep_will", "targetname" );
    var_1 = getnode( "node_building_jump_prep_cormack", "targetname" );
    level.will_irons _meth_81A5( var_0 );
    level.cormack _meth_81A5( var_1 );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_building_jump1" );
    level notify( "autosave_request" );
    jump_scene_think();
}

monitor_player_leaving_squad_hotel()
{
    common_scripts\utility::flag_wait( "player_leaving_squad" );

    if ( common_scripts\utility::flag( "player_leaving_squad" ) & !isdefined( level.cormack.building_jump_initiate ) )
        jump_scene_think( 1 );
}

jump_scene_think( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "struct_building_jump1_cormack", "targetname" );
    var_2 = common_scripts\utility::getstruct( "struct_building_jump1_will", "targetname" );
    common_scripts\utility::flag_set( "dialogue_performing_arts_exit" );
    level.cormack maps\_utility::enable_ai_color();
    var_3 = getent( "vol_test_for_will_and_cormack", "targetname" );

    if ( isdefined( var_0 ) && var_0 )
    {
        level.cormack thread play_building_jump_1_scene( var_1, "node_building_jump_land_cormack", 1, 1, 1 );
        level.will_irons thread play_building_jump_1_scene( var_2, "node_building_jump_land_will", undefined, undefined, 1 );
    }
    else if ( level.cormack _meth_80A9( var_3 ) && level.will_irons _meth_80A9( var_3 ) )
    {
        level.cormack thread play_building_jump_1_scene( var_1, "node_building_jump_land_cormack", 1, 1 );
        level.will_irons thread play_building_jump_1_scene( var_2, "node_building_jump_land_will" );
    }
    else
    {
        level.cormack thread play_building_jump_1_scene( var_1, "node_building_jump_land_cormack", 0 );
        level waittill( "cormack_jumping_buildings" );
        level.will_irons thread play_building_jump_1_scene( var_2, "node_building_jump_land_will", 0 );
    }
}

play_building_jump_1_scene( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "warping" );
    self.in_position_building_jump = 0;

    if ( isdefined( var_4 ) && var_4 )
        teleport_building_jump( var_0, var_3 );
    else if ( isdefined( var_3 ) && var_3 )
        loop_wait_building_jump( var_0, var_2, var_3 );
    else if ( !isdefined( var_2 ) || var_2 )
        frame_wait_building_jump( var_0, var_2, var_3 );
    else
        no_wait_building_jump( var_0, var_3 );

    level notify( "building_jump_anim_done" );
    self.building_jump_done = 1;

    if ( !common_scripts\utility::flag( "first_building_jump_complete" ) )
    {
        var_5 = getnode( var_1, "targetname" );
        self _meth_81A5( var_5 );
    }
}

no_wait_building_jump( var_0, var_1 )
{
    self endon( "warping" );
    var_2 = var_0 common_scripts\utility::spawn_tag_origin();
    var_2 thread maps\_anim::anim_reach_solo( self, var_0.animation, undefined, 1 );
    var_3 = common_scripts\utility::waittill_any_return( "anim_reach_complete", "override_anim_reach_play_binoc_scene" );
    common_scripts\utility::flag_set( "dialogue_building_jump" );
    level thread maps\_utility::notify_delay( "cormack_jumping_buildings", 4 );
    self.building_jump_initiate = 1;
    var_0 maps\_anim::anim_single_solo( self, var_0.animation );
    self.jump_complete = 1;
    var_2 delete();
}

teleport_building_jump( var_0, var_1 )
{
    self endon( "warping" );
    var_2 = var_0 common_scripts\utility::spawn_tag_origin();
    common_scripts\utility::flag_set( "dialogue_building_jump" );
    level thread maps\_utility::notify_delay( "cormack_jumping_buildings", 4 );
    self.building_jump_initiate = 1;
    var_0 maps\_anim::anim_single_solo( self, var_0.animation );
    self.jump_complete = 1;
    var_2 delete();
}

loop_wait_building_jump( var_0, var_1, var_2 )
{
    self endon( "warping" );
    var_3 = var_0 common_scripts\utility::spawn_tag_origin();
    var_3 maps\_anim::anim_reach_solo( self, var_0.animation );
    self.building_jump_initiate = 1;
    var_3 thread maps\_anim::anim_loop_solo( self, "seo_mall_sizeup_jump_cormack_idle" );
    self.in_position_building_jump = 1;

    if ( !isdefined( var_1 ) || var_1 )
    {
        while ( !common_scripts\utility::flag( "player_leaving_squad" ) && !isdefined( level.cormack.in_position_building_jump ) )
            waitframe();

        while ( !common_scripts\utility::flag( "player_leaving_squad" ) && !isdefined( level.will_irons.in_position_building_jump ) )
            waitframe();

        while ( !common_scripts\utility::flag( "player_leaving_squad" ) && ( !level.cormack.in_position_building_jump || !level.will_irons.in_position_building_jump ) )
            wait 0.05;
    }

    common_scripts\utility::flag_set( "dialogue_building_jump" );
    level thread maps\_utility::notify_delay( "cormack_jumping_buildings", 4 );

    if ( isdefined( var_2 ) && var_2 )
        maps\_shg_design_tools::anim_stop( var_3 );

    if ( common_scripts\utility::flag( "player_leaving_squad" ) )
    {
        self.building_jump_initiate = 1;
        self.jump_complete = 1;
        var_3 delete();
        return;
    }

    self.building_jump_initiate = 1;
    var_0 maps\_anim::anim_single_solo( self, var_0.animation );
    self.jump_complete = 1;
    var_3 delete();
}

frame_wait_building_jump( var_0, var_1, var_2 )
{
    self endon( "warping" );
    var_3 = var_0 common_scripts\utility::spawn_tag_origin();
    var_3 maps\_anim::anim_reach_solo( self, var_0.animation );
    self.building_jump_initiate = 1;
    var_0 thread maps\_anim::anim_first_frame_solo( self, var_0.animation );
    self.in_position_building_jump = 1;

    if ( !isdefined( var_1 ) || var_1 )
    {
        while ( !isdefined( level.cormack.in_position_building_jump ) )
            waitframe();

        while ( !isdefined( level.will_irons.in_position_building_jump ) )
            waitframe();

        while ( !level.cormack.in_position_building_jump || !level.will_irons.in_position_building_jump )
            wait 0.05;
    }

    common_scripts\utility::flag_set( "dialogue_building_jump" );
    level thread maps\_utility::notify_delay( "cormack_jumping_buildings", 4 );
    self.building_jump_initiate = 1;
    var_0 maps\_anim::anim_single_solo( self, var_0.animation );
    self.jump_complete = 1;
    var_3 delete();
}

handle_pac_snipers()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_enemy_waterfall" );
    var_0 = getnodearray( "cover_hotel_laser_snipers", "targetname" );
    var_1 = getentarray( "spawner_hotel_enemies_laser_guys", "targetname" );

    foreach ( var_3 in var_0 )
    {
        var_4 = common_scripts\utility::random( var_1 ) maps\_shg_design_tools::actual_spawn();

        if ( !isdefined( var_4 ) )
            continue;

        var_4 _meth_81A5( var_3 );
        var_4.fixednode = 1;
        var_4 pac_enemy_stats();
        var_4 thread forcelaser();
        wait 0.1;
    }

    var_6 = common_scripts\utility::getstructarray( "struct_sniper_line_gag", "targetname" );

    foreach ( var_8 in var_6 )
    {
        var_4 = common_scripts\utility::random( var_1 ) maps\_shg_design_tools::actual_spawn();

        if ( !isdefined( var_4 ) )
            continue;

        var_4 pac_enemy_stats();
        var_4 thread forcelaser();
        var_8 thread maps\_anim::anim_generic_loop( var_4, var_8.animation );
        wait(randomfloatrange( 0.1, 0.5 ));
    }

    level waittill( "never" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_combat_05" );
    var_10 = common_scripts\utility::getstructarray( "struct_laser_sniper_group1", "targetname" );
    var_11 = common_scripts\utility::getstructarray( "struct_laser_sniper_group2", "targetname" );
    var_12 = common_scripts\utility::getstructarray( "struct_laser_sniper_group1_targets", "targetname" );
    var_13 = common_scripts\utility::getstructarray( "struct_laser_sniper_group2_targets", "targetname" );
    thread turn_on_laser_group_and_scan( var_10, var_12 );
    thread turn_on_laser_group_and_scan( var_11, var_13 );
}

turn_on_laser_group_and_scan( var_0, var_1 )
{
    var_1 = common_scripts\utility::array_randomize( var_1 );

    foreach ( var_5, var_3 in var_0 )
    {
        var_4 = spawn( "script_model", var_3.origin );
        var_4 _meth_80B1( "tag_laser" );
        var_4 thread scan_space_with_noise( var_1[var_5] );
    }
}

scan_space_with_noise( var_0 )
{
    wait(randomfloat( 2.0 ));
    self _meth_80B2();
    var_1 = randomintrange( 4, 6 );
    var_2 = randomintrange( 3, 5 );
    var_3 = randomintrange( 2, 3 );
    var_4 = randomfloatrange( 0.25, 0.5 );
    var_5 = randomint( 100 );

    for (;;)
    {
        var_6 = maps\_shg_design_tools::getperlinovertime( var_1, var_2, var_3, var_4, var_5 );
        self.angles = vectortoangles( var_0.origin - self.origin + var_6 );
        wait 0.05;
    }
}

forcelaser()
{
    self endon( "death" );

    for (;;)
    {
        self _meth_80B2( "lag_snipper_laser" );
        wait 0.25;
    }
}

handle_hotel_enemy_fallback()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_combat_02" );
    var_0 = getent( "vol_hotel_zipline_defend_01", "script_noteworthy" );
    var_1 = getent( "vol_hotel_zipline_defend_02", "script_noteworthy" );
    level notify( "hotel_fallback" );

    foreach ( var_3 in level.monitor_setup_group )
    {
        if ( isdefined( var_3 ) && var_3 _meth_80A9( var_0 ) )
            var_3 _meth_81A9( var_1 );
    }

    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_combat_03" );
    var_0 = getent( "vol_hotel_zipline_defend_02", "script_noteworthy" );
    var_1 = getentarray( "vol_hotel_zipline_defend_03", "script_noteworthy" );
    level notify( "hotel_fallback" );

    foreach ( var_3 in level.monitor_setup_group )
    {
        if ( isdefined( var_3 ) && var_3 _meth_80A9( var_0 ) )
            var_3 _meth_81A9( common_scripts\utility::random( var_1 ) );
    }

    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_combat_04" );
    var_0 = getentarray( "vol_hotel_zipline_defend_03", "script_noteworthy" );
    var_1 = getentarray( "vol_hotel_zipline_defend_04", "script_noteworthy" );
    level notify( "hotel_fallback" );

    foreach ( var_3 in level.monitor_setup_group )
    {
        foreach ( var_9 in var_0 )
        {
            if ( isdefined( var_3 ) && var_3 _meth_80A9( var_9 ) )
                var_3 _meth_81A9( common_scripts\utility::random( var_1 ) );
        }
    }

    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_combat_06" );
    var_0 = getentarray( "vol_hotel_zipline_defend_04", "script_noteworthy" );
    var_1 = getentarray( "vol_hotel_zipline_defend_04b", "script_noteworthy" );
    level notify( "hotel_fallback" );

    foreach ( var_3 in level.monitor_setup_group )
    {
        foreach ( var_9 in var_0 )
        {
            if ( isdefined( var_3 ) && var_3 _meth_80A9( var_9 ) )
                var_3 _meth_81A9( common_scripts\utility::random( var_1 ) );
        }
    }
}

handle_hotel_zipline_break_glass()
{
    var_0 = getglass( "big_screen_glass_01" );
    var_1 = getglass( "big_screen_glass_02" );
    var_2 = getent( "big_screen_video_01", "targetname" );
    var_3 = getent( "big_screen_video_02", "targetname" );
    var_4 = getentarray( "big_screen_static_01", "targetname" );
    var_5 = getentarray( "big_screen_static_02", "targetname" );
    var_6 = common_scripts\utility::getstructarray( "big_screen_struct_01", "targetname" );
    var_7 = common_scripts\utility::getstructarray( "big_screen_struct_02", "targetname" );
    common_scripts\utility::array_call( var_4, ::hide );
    common_scripts\utility::array_call( var_5, ::hide );
    var_8 = getglass( "big_screen_glass_03" );
    var_9 = getglass( "big_screen_glass_04" );
    var_10 = getent( "big_screen_video_03", "targetname" );
    var_11 = getent( "big_screen_video_04", "targetname" );
    var_12 = getentarray( "big_screen_static_03", "targetname" );
    var_13 = getentarray( "big_screen_static_04", "targetname" );
    var_14 = common_scripts\utility::getstructarray( "big_screen_struct_03", "targetname" );
    var_15 = common_scripts\utility::getstructarray( "big_screen_struct_04", "targetname" );
    common_scripts\utility::array_call( var_12, ::hide );
    common_scripts\utility::array_call( var_13, ::hide );
    var_16 = [ "sparks_burst_a_nolight" ];

    for ( var_17 = 0; var_17 < 4; var_17++ )
        destroy_screen_pac( var_1, var_3, var_5, var_7, var_16 );

    destroy_screen_pac( var_0, var_2, var_4, var_6, var_16 );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_enemy_waterfall" );
    destroy_screen_pac( var_8, var_10, var_12, var_14, var_16 );
    destroy_screen_pac( var_9, var_11, var_13, var_15, var_16 );
}

destroy_screen_pac( var_0, var_1, var_2, var_3, var_4 )
{
    level waittill( "zipline_triggered", var_5, var_6 );

    if ( !isglassdestroyed( var_0 ) )
    {
        destroyglass( var_0, var_6 - var_5 );
        var_1 hide();
        common_scripts\utility::array_call( var_2, ::show );

        foreach ( var_8 in var_3 )
        {
            playfx( common_scripts\utility::getfx( "glass_shatter_xlarge" ), var_8.origin );
            playfx( common_scripts\utility::getfx( common_scripts\utility::random( var_4 ) ), var_8.origin );

            if ( common_scripts\utility::cointoss() )
                var_8 thread play_persistent_fx_on_screen( var_4 );
        }
    }
}

play_persistent_fx_on_screen( var_0 )
{
    self endon( "end_persistent_fx" );
    thread maps\_utility::notify_delay( "end_persistent_fx", randomfloatrange( 4.0, 10.0 ) );

    for (;;)
    {
        if ( common_scripts\utility::cointoss() )
            playfx( common_scripts\utility::getfx( common_scripts\utility::random( var_0 ) ), self.origin );

        wait(randomfloat( 2.0 ));
    }
}

handle_pac_zipline_intos()
{
    level.monitor_setup_group = [];
    thread handle_hotel_enemy_fallback();
    thread handle_hotel_zipline_break_glass();
    var_0 = getent( "vol_hotel_zipline_defend_01", "script_noteworthy" );
    var_1 = getentarray( "struct_reverse_zipline_start_group2", "targetname" );
    var_2 = getentarray( "struct_reverse_zipline_start_group3", "targetname" );
    var_3 = getent( "spawner_hotel_zipline_guys", "targetname" );
    var_4 = getentarray( "vol_hotel_zipline_defend", "targetname" );
    var_5 = getentarray( "vol_hotel_waterfall_defend_2", "targetname" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_hotel_zipline_gag" );

    if ( level.currentgen )
    {
        if ( !_func_21E( "seoul_mall_offices_tr" ) )
            level waittill( "transients_truck_push_to_mall_office" );
    }

    common_scripts\utility::flag_set( "dialogue_performing_arts_interior" );

    if ( level.currentgen )
    {
        var_6 = getentarray( "hotel_zipline_panel", "targetname" );

        for ( var_7 = 0; var_7 < var_6.size; var_7++ )
        {
            var_6[var_7] hide();
            var_6[var_7] _meth_8058();
            var_6[var_7] setcontents( 0 );
        }
    }

    var_8 = 70;
    var_9 = level.player.origin;
    var_10 = getnodearray( "node_zipline1_covers", "targetname" );
    var_1 = sortbydistance( var_1, level.player.origin );
    var_11 = [];
    thread zipline_guy_laser_think();
    thread zipline_guy_shoot_think();

    foreach ( var_7, var_13 in var_1 )
    {
        if ( !isdefined( var_13.script_noteworthy ) )
            continue;

        var_14 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_3, var_13 );
        var_14 pac_enemy_stats();
        level.monitor_setup_group[level.monitor_setup_group.size] = var_14;
        var_15 = distance( var_9, var_13.origin );
        var_16 = var_15 / var_8 * 0.05;
        wait(var_16);
        var_9 = var_13.origin;

        if ( !isdefined( var_14 ) )
            return;

        var_11[var_11.size] = var_14;
    }

    assign_nodes_to_zipline_guys( var_11, var_10, var_4 );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_enemy_waterfall" );

    foreach ( var_13 in var_2 )
    {
        if ( !isdefined( var_13.script_noteworthy ) )
            continue;

        level.monitor_setup_group[level.monitor_setup_group.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_3, var_13 );
        var_15 = distance( var_9, var_13.origin );
        var_16 = var_15 / var_8 * 0.05;
        wait(var_16);
        var_9 = var_13.origin;
    }
}

zipline_guy_laser_think()
{
    level waittill( "zipline_guys_spawned", var_0 );

    if ( isdefined( var_0 ) )
    {
        var_0.force_laser_on = 1;
        var_0 thread forcelaser();
    }

    for (;;)
    {
        level waittill( "zipline_guys_spawned", var_0 );

        if ( !isdefined( var_0 ) )
            continue;

        var_0.force_laser_on = 1;

        if ( maps\_shg_design_tools::percentchance( 25 ) )
            var_0 thread forcelaser();
    }
}

zipline_guy_shoot_think()
{
    level waittill( "zipline_guys_spawned", var_0 );

    if ( isdefined( var_0 ) )
        var_0 thread shoot_while_ziplining();

    for (;;)
    {
        level waittill( "zipline_guys_spawned", var_0 );

        if ( !isdefined( var_0 ) )
            continue;

        if ( maps\_shg_design_tools::percentchance( 35 ) )
            var_0 thread shoot_while_ziplining();
    }
}

shoot_while_ziplining()
{
    self endon( "end_allow_death_during_zipline" );
    self endon( "death" );

    for (;;)
    {
        var_0 = randomintrange( 5, 18 );

        for ( var_1 = 0; var_1 < var_0; var_1++ )
        {
            self _meth_81E7();
            waitframe();
        }

        wait 0.5;
    }
}

assign_nodes_to_zipline_guys( var_0, var_1, var_2 )
{
    var_3 = [];

    foreach ( var_5 in var_0 )
    {
        var_6 = maps\_shg_design_tools::sortbydistanceauto( var_1, var_5.zipline_end_org );
        var_7 = 0;

        foreach ( var_9 in var_6 )
        {
            if ( var_7 )
                continue;

            if ( !maps\_utility::is_in_array( var_3, var_9 ) )
            {
                var_5 _meth_81A5( var_9 );
                var_3[var_3.size] = var_9;
                var_7 = 1;
            }
        }

        if ( !var_7 )
        {
            var_11 = common_scripts\utility::random( var_2 );
            var_5 _meth_81A9( var_11 );
            iprintln( "node find fail" );
        }
    }
}

interior_fallback_think( var_0 )
{
    self endon( "death" );
    var_1[0] = getentarray( "vol_hotel_zipline_defend_02", "script_noteworthy" );
    var_1[1] = getentarray( "vol_hotel_zipline_defend_03", "script_noteworthy" );
    var_1[2] = getentarray( "vol_hotel_zipline_defend_04", "script_noteworthy" );
    var_2 = var_0;

    for (;;)
    {
        if ( !isdefined( var_1[var_2] ) )
            break;

        if ( isdefined( self ) )
            self _meth_81A9( common_scripts\utility::random( var_1[var_2] ) );

        var_2++;
        level waittill( "hotel_fallback" );
    }
}

handle_pac_combat()
{
    var_0 = getentarray( "spawner_convention_center_ar_01", "targetname" );
    var_1 = getentarray( "spawner_convention_center_ar_01b", "targetname" );
    var_2 = getentarray( "spawner_convention_center_ar_02", "targetname" );
    var_3 = getentarray( "spawner_convention_center_ar_03", "targetname" );
    var_4 = getentarray( "spawner_convention_center_ar_04", "targetname" );
    var_5 = getentarray( "spawner_convention_center_ar_04b", "targetname" );
    var_6 = getentarray( "spawner_convention_center_smg_01", "targetname" );
    var_7 = getentarray( "spawner_convention_center_smg_02", "targetname" );
    var_8 = getentarray( "spawner_convention_center_smg_03", "targetname" );
    var_9 = getentarray( "spawner_convention_center_smg_04", "targetname" );
    var_10 = getentarray( "spawner_hotel_enemies_laser_guys", "targetname" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_hotel_zipline_gag" );
    var_11 = 3;

    if ( level.gameskill > 1 )
        var_11 = 5;

    for ( var_12 = 0; var_12 < var_11; var_12++ )
    {
        var_13 = common_scripts\utility::random( var_0 ) maps\_shg_design_tools::actual_spawn( 1 );
        var_13 thread interior_fallback_think( 0 );
        var_13 pac_enemy_stats();
        wait 1.5;
    }

    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_combat_03" );

    for ( var_12 = 0; var_12 < var_11; var_12++ )
    {
        var_13 = common_scripts\utility::random( var_10 ) maps\_shg_design_tools::actual_spawn( 1 );
        var_13 thread interior_fallback_think( 1 );
        var_13 pac_enemy_stats();
        wait 1.5;
    }
}

pac_enemy_stats( var_0 )
{
    self.grenadeammo = 0;
    self.goalradius = 128;

    if ( !isdefined( level.pac_enemy_group ) )
        level.pac_enemy_group = [];

    level.pac_enemy_group[level.pac_enemy_group.size] = self;
}

make_exploder_truck( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_model", var_0.origin );
    var_3 _meth_80B1( var_2 );
    var_3.animname = var_1;
    var_3 maps\_anim::setanimtree();
    return var_3;
}

vehicle_explosions_for_drone_swarm()
{
    waitframe();
    wait 2;

    if ( level.currentgen && !issubstr( level.transient_zone, "_droneswarm1" ) )
        level waittill( "transients_fob_to_drone_seq_one" );

    var_0 = common_scripts\utility::getstruct( "struct_truck_explode_01", "targetname" );
    var_1 = make_exploder_truck( var_0, "truck_explode_01", "vehicle_civ_pickup_truck_01_wrecked" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "truck_explode" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_e3_fallback_01" );
    common_scripts\utility::flag_set( "dialogue_drone_swarm_intro" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "truck_explode" );
    var_1 thread destroy_truck_01( var_0 );
    var_1 thread fire_at_truck_01();
    thread drone_car_exploders();
}

drone_car_exploders()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_1 = getent( "model_phys_car_01", "targetname" );
    var_1.explode = common_scripts\utility::getstruct( "struct_phys_launch_01", "targetname" );
    var_0 maps\_shg_design_tools::angles_and_origin( var_1.explode );
    var_2 = var_0 maps\_shg_design_tools::offset_position_from_tag( "forward", "tag_origin", 30 );
    var_1.vec = var_2 - var_1.explode.origin;
    var_3 = undefined;

    if ( level.nextgen )
    {
        var_3 = getent( "model_phys_car_02", "targetname" );
        var_3.explode = common_scripts\utility::getstruct( "struct_phys_launch_02", "targetname" );
        var_0 maps\_shg_design_tools::angles_and_origin( var_3.explode );
        var_2 = var_0 maps\_shg_design_tools::offset_position_from_tag( "forward", "tag_origin", 30 );
        var_3.vec = var_2 - var_3.explode.origin;
    }

    var_4 = getent( "model_phys_car_04", "targetname" );
    var_4.explode = common_scripts\utility::getstruct( "struct_phys_launch_04", "targetname" );
    var_0 maps\_shg_design_tools::angles_and_origin( var_4.explode );
    var_2 = var_0 maps\_shg_design_tools::offset_position_from_tag( "forward", "tag_origin", 30 );
    var_4.vec = var_2 - var_4.explode.origin;
    var_1 thread launch_car_with_missiles( 115 );
    soundscripts\_snd::snd_message( "start_drone_barrage_submix" );
    playfxontag( common_scripts\utility::getfx( "seo_car_explo_fire_trail" ), var_1, "tag_origin" );
    wait 0.5;

    if ( level.nextgen )
    {
        var_3 thread launch_car_with_missiles( 50 );
        thread fire_drone_swarm_at_walker();
        playfxontag( common_scripts\utility::getfx( "seo_car_explo_fire_trail" ), var_3, "tag_origin" );
    }

    wait 9;
    var_4 thread launch_car_with_missiles( 50 );
    playfxontag( common_scripts\utility::getfx( "seo_car_explo_fire_trail" ), var_4, "tag_origin" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_brush_guide_group1" );
    var_0 delete();
}

fire_drone_swarm_at_walker()
{
    var_0 = randomintrange( 2, 4 );

    for ( var_1 = 0; var_1 < var_0; var_1++ )
    {
        if ( !isdefined( level.walker_tank ) )
            return;

        var_2 = common_scripts\utility::getclosest( level.walker_tank.origin, level.flock_drones, 3000 );

        if ( !isdefined( var_2 ) )
        {
            if ( var_1 == 0 )
                return;
            else
                break;
        }

        var_3 = var_2.origin;
        var_2 delete();
        var_4 = magicbullet( "remote_missile_drone_light", var_3, level.walker_tank.origin + ( randomintrange( -100, 100 ), randomintrange( -100, 100 ), randomintrange( -100, 100 ) ) );
        wait 0.25;
    }
}

launch_car_with_missiles( var_0 )
{
    var_1 = 1;

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_3 = common_scripts\utility::getclosest( self.origin, level.flock_drones, 3000 );

        if ( !isdefined( var_3 ) )
        {
            if ( var_2 == 0 )
                return;
            else
                break;
        }

        var_4 = var_3.origin;
        var_3 delete();
        var_5 = magicbullet( "remote_missile_drone_light", var_4, self.origin + ( randomintrange( -100, 100 ), randomintrange( -100, 100 ), randomintrange( -100, 100 ) ) );
        wait 0.1;
    }

    playfx( common_scripts\utility::getfx( "seo_drones_car_explo" ), self.origin );
    self _meth_8276( self.explode.origin, self.vec * var_0 );
    soundscripts\_snd::snd_message( "seo_big_car_explo" );
    self waittill( "physics_finished" );
    playfx( common_scripts\utility::getfx( "seo_drones_car_explo" ), self.origin );
    soundscripts\_snd::snd_message( "seo_big_car_explo" );
    self delete();
}

destroy_truck_01( var_0 )
{
    level waittill( "truck_01_explode" );
    playfx( common_scripts\utility::getfx( "seo_drones_car_explo" ), self.origin );
    soundscripts\_snd::snd_message( "seo_truck_explo" );
}

fire_at_truck_01()
{
    level endon( "truck_01_explode" );

    for (;;)
    {
        var_0 = common_scripts\utility::getclosest( self.origin, level.flock_drones, 2000 );
        var_0 hide();
        var_1 = magicbullet( "remote_missile_drone_light", var_0.origin, self.origin );
        soundscripts\_snd::snd_message( "seo_drone_missile", var_1 );
        wait(randomfloatrange( 0.5, 1.0 ));
    }
}

snake_shoot_allies()
{
    while ( !isdefined( level.drone_street_allies ) )
        waitframe();

    while ( level.drone_street_allies.size > 0 )
    {
        foreach ( var_1 in level.drone_street_allies )
        {
            if ( !isdefined( var_1 ) )
                continue;

            if ( common_scripts\utility::cointoss() )
                var_1 shoot_drone_at_ally( 1 );
        }

        waitframe();
    }
}

shoot_drone_at_ally( var_0 )
{
    self endon( "death" );
    var_1 = common_scripts\utility::getclosest( self.origin, level.flock_drones, 1000 );
    var_2 = distance( level.player.origin, self.origin );

    if ( !isdefined( var_1 ) )
    {
        wait 1;
        return;
    }

    if ( isdefined( var_0 ) && var_0 )
    {
        if ( var_2 < 356 )
            return;
    }

    var_3 = var_1.origin;
    var_1 delete();
    var_4 = magicbullet( "remote_missile_drone_light", var_3, self.origin );
    soundscripts\_snd::snd_message( "seo_drone_missile_impact", self.origin );
    wait 1.5;
}

disable_turret_missiles()
{
    level.mobile_turret endon( "death" );

    for (;;)
    {
        level.mobile_turret notify( "end_rocket_think" );
        level.mobile_turret notify( "disable_missile_input" );
        waitframe();
    }
}

monitor_x4_vm_swap()
{
    level waittill( "swapped_x4walker", var_0 );
    var_1 = var_0 setcontents( 0 );
    common_scripts\utility::flag_waitopen( "player_in_x4walker" );
    var_0 setcontents( var_1 );
}

setup_mobile_turret()
{
    thread monitor_x4_vm_swap();
    wait 5;
    level.x4walker_wheels_seoul_turret = 1;
    level.x4walker_player_invulnerability = 0;
    level.killable_kamikazes = 1;
    var_0 = getent( "mobile_turret_drone_street", "targetname" );
    var_0 thread make_modile_turret_invincible();
    var_0 thread fake_drone_shooting();

    foreach ( var_2 in level.mt_use_tags )
    {
        if ( level.player common_scripts\utility::is_player_gamepad_enabled() )
        {
            var_2 _meth_80DB( &"SEOUL_ENTER_MOBILE_TURRET_SEOUL" );
            continue;
        }

        var_2 _meth_80DB( &"SEOUL_ENTER_MOBILE_TURRET_SEOUL_PC" );
    }

    level.mobile_turret = var_0;
    thread disable_turret_missiles();
    level.player waittill( "player_in_x4walker" );
    var_0 hide();
    var_0.origin -= ( 0, 0, 100 );
    common_scripts\utility::flag_set( "will_cardoor_watcher_flag" );
    var_4 = common_scripts\utility::getstructarray( "struct_start_point_hotel_entrance_1", "targetname" );

    foreach ( var_7, var_6 in level.squad )
        var_6 _meth_81C6( var_4[var_7].origin, var_4[var_7].angles );

    common_scripts\utility::flag_waitopen( "player_in_x4walker" );
    var_0 show();
    var_0.origin += ( 0, 0, 100 );
}

mobile_turret_health_1()
{
    self endon( "death" );
    self endon( "stop_mobile_turret_health_1" );
    level.player endon( "player_exited_mobile_turret" );
    var_0 = "seo_spark_droppod_door";
    var_1 = "TAG_turret";
    var_2 = "TAG_turret";
    playfxontag( common_scripts\utility::getfx( var_0 ), self, var_1 );
    wait(randomfloat( 3.75 ));
    playfxontag( common_scripts\utility::getfx( var_0 ), self, var_2 );
    wait(randomfloat( 1.75 ));
    playfxontag( common_scripts\utility::getfx( var_0 ), self, var_1 );
}

mobile_turret_health_2()
{
    self endon( "death" );
    self endon( "stop_mobile_turret_health_2" );
    level.player endon( "player_exited_mobile_turret" );
    level endon( "end_cherry_picker" );
    level endon( "missionfailed" );

    if ( isdefined( self.mgturret ) && isdefined( self.mgturret[0] ) )
        playfxontag( common_scripts\utility::getfx( "mobile_turret_fire_small" ), self.mgturret[0], "TAG_FIRE_1" );

    wait(randomfloat( 2 ));

    if ( isdefined( self.mgturret ) && isdefined( self.mgturret[0] ) )
        playfxontag( common_scripts\utility::getfx( "mobile_turret_fire_small" ), self.mgturret[0], "TAG_FIRE_2" );
}

mobile_turret_health_3()
{
    self endon( "death" );
    self endon( "stop_mobile_turret_health_3" );
    level.player endon( "player_exited_mobile_turret" );
    var_0 = "mobile_turret_fire_large";
    var_1 = "TAG_FIRE_2";

    if ( isdefined( self.mgturret ) && isdefined( self.mgturret[0] ) )
        playfxontag( common_scripts\utility::getfx( var_0 ), self.mgturret[0], var_1 );
}

fake_drone_shooting()
{
    level.player waittill( "player_in_x4walker" );
    thread fake_drone_shooting_internal();
}

fake_drone_shooting_internal()
{
    level.player endon( "player_exited_mobile_turret" );
    level.player.num_drones_killed = 0;
    var_0 = 0.5;

    for (;;)
    {
        if ( level.player attackbuttonpressed() )
        {
            var_1 = getarrayelementsincone( level.flock_drones, level.player _meth_80A8(), anglestoforward( level.player getangles() ), var_0, 12 );
            var_2 = 0;

            foreach ( var_4 in var_1 )
            {
                if ( !isdefined( var_4 ) )
                    continue;

                if ( isdefined( var_4.kamikaze ) )
                {
                    var_4 vehicle_scripts\_attack_drone_common::totally_fake_drone_death( 0, 1, undefined, 1 );
                    continue;
                }

                if ( maps\_shg_design_tools::percentchance( 25 ) )
                {
                    if ( !var_2 )
                        var_4 vehicle_scripts\_attack_drone_common::totally_fake_drone_death( 0, 1 );
                    else
                        var_4 vehicle_scripts\_attack_drone_common::totally_fake_drone_death( 0, 1, undefined, undefined, 1 );

                    level.player.num_drones_killed++;
                    var_2 = 1;
                }
            }
        }

        waitframe();
    }
}

play_explosion_sound_drone_success( var_0 )
{
    var_1 = var_0.origin;

    for ( var_2 = 0; var_2 < 3; var_2++ )
    {
        soundscripts\_snd_playsound::snd_play_at( "exp_amb_mid_air", level.player.origin );
        soundscripts\_snd::snd_message( "seo_ambient_ground_explosions", level.player.origin );
        wait 0.1;
    }
}

zap_local_drones( var_0 )
{
    var_1 = maps\_shg_design_tools::sortbydistanceauto( level.flock_drones, var_0.origin );
    var_2 = 400;

    for ( var_3 = 0; var_3 < 20; var_3++ )
    {
        if ( distance( var_1[var_3].origin, var_0.origin ) < var_2 )
            var_1[var_3] vehicle_scripts\_attack_drone_common::totally_fake_drone_death( 0 );
    }
}

getarrayelementsincone( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = cos( var_3 );

    if ( isdefined( var_4 ) )
        var_6 = var_1 - var_2 * var_4 / tan( var_3 );
    else
        var_6 = var_1;

    var_7 = [];

    foreach ( var_9 in var_0 )
    {
        if ( isdefined( var_9 ) && vectordot( vectornormalize( var_9.origin - var_6 ), var_2 ) > var_5 && ( !isdefined( var_4 ) || vectordot( var_9.origin - var_1, var_2 ) > 0 ) )
            var_7[var_7.size] = var_9;
    }

    return var_7;
}

monitor_mobile_turret_missiles()
{
    self.drone_targets = [];

    for (;;)
    {
        level.player waittill( "attack_pressed" );

        if ( self.drone_targets.size > 0 )
        {
            foreach ( var_1 in self.drone_targets )
            {
                wait(randomfloat( 0.25 ));

                if ( isdefined( var_1 ) )
                {
                    var_2 = magicbullet( "hovertank_missile_small_straight", self.origin + ( 0, 0, 96 ), var_1.origin );
                    var_2 _meth_81D9( var_1 );
                }
            }
        }
    }
}

make_modile_turret_invincible()
{
    var_0 = self.maxhealth;
    self.makeinvul = 1;

    for (;;)
    {
        if ( self.makeinvul )
        {
            self.maxhealth = var_0 * 2;
            self.health = self.maxhealth;
        }

        waitframe();
    }
}

setup_mobile_turret_gameplay()
{
    thread setup_mobile_turret();
    wait 1;
    thread snake_gameplay_for_turret();
    level.player waittill( "player_in_x4walker" );
    common_scripts\utility::flag_set( "dialogue_drone_turret_sequence" );
    level notify( "end_drone_kamikaze_player" );
    level notify( "cherry_picker_turret_in_use" );
    level.mobile_turret cherry_picker_turret_gameplay();
}

mobile_turret_hint_button()
{
    level.player endon( "player_in_x4walker" );
    level.player waittill( "player_has_cardoor" );
    var_0 = level.mobile_turret gettagorigin( "tag_body" );
    var_1 = maps\_shg_utility::hint_button_position( "x", var_0, 48, 1000 );
    thread mobile_turret_hint_button_clear( var_1 );
}

mobile_turret_hint_button_clear( var_0 )
{
    level.player waittill( "player_in_x4walker" );
    var_0 maps\_shg_utility::hint_button_clear();
}

snake_cloud_get_target_boids( var_0, var_1 )
{
    level endon( "end_cherry_picker" );
    level endon( "snake_charge_ended" );

    if ( !isdefined( level.player.drone_target_center ) )
        level.player.drone_target_center = common_scripts\utility::spawn_tag_origin();

    level.player.drone_target_center _meth_804F();
    level.player.drone_target_center.boids = [];
    var_2 = [];
    var_3 = ( 0, 0, 0 );

    foreach ( var_5 in self.snakes )
        var_3 += var_5 _meth_8287();

    var_3 = vectornormalize( var_3 );
    level.player.drone_target_center thread follow_drone_turret_target( var_1 );
    var_7 = 70;

    for ( var_8 = 0; var_8 < var_0; var_8++ )
    {
        var_9 = spawn( "script_model", level.player.drone_target_center.origin );
        var_9 _meth_80B1( "vehicle_mil_attack_drone_ai" );
        var_9.tag_ent = common_scripts\utility::spawn_tag_origin();
        var_10 = ( randomintrange( var_7 * -1, var_7 ), randomintrange( var_7 * -1, var_7 ), randomintrange( var_7 * -1, var_7 ) );
        var_9.tag_ent.origin = level.player.drone_target_center.origin + var_10;
        var_9.tag_ent _meth_804D( level.player.drone_target_center, "tag_origin" );
        var_9 thread cleanup_drone_tags();
        var_2[var_2.size] = var_9;
        level.player.drone_target_center.boids[level.player.drone_target_center.boids.size] = var_9;
    }

    return var_2;
}

cleanup_drone_tags()
{
    var_0 = self.tag_ent;

    while ( isdefined( self ) )
        waitframe();

    var_0 maps\_shg_design_tools::delete_auto();
}

make_drone_turret_target()
{
    level.flock_drones = common_scripts\utility::array_add( level.flock_drones, self );
    self.is_drone_turret_target = 1;
    self.drone_really_hit = 0;
    soundscripts\_snd::snd_message( "cherry_picker_target_add" );
    thread make_drone_turret_target_2();
    return self;
}

cherry_picker_damage_alarm()
{
    level endon( "EMP_triggered" );

    for (;;)
    {
        level.player waittill( "play_damage_alarm" );
        soundscripts\_snd_playsound::snd_play_2d( "droppod_missile_hit_alarms", "EMP_triggered" );
        wait 4;
    }
}

make_drone_turret_target_2()
{
    self.is_drone_turret_target = 1;
    self.drone_really_hit = 0;
    level notify( "new_drone_target" );
    var_0 = 0;
    var_1 = "drone_turret_hud_target";
    var_2 = 256;
    var_3 = 256;
    var_4 = 156;

    if ( !isdefined( level.player.drone_hud_targets ) )
        level.player.drone_hud_targets = [];

    var_5 = newclienthudelem( level.player );
    var_5 _meth_80CC( var_1, var_2, var_3 );
    var_5.positioninworld = 1;
    var_5.alignx = "center";
    var_5.aligny = "middle";
    var_5.alpha = 1;
    var_5.foreground = 1;
    var_5.hidewheninmenu = 1;
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6.origin = self.origin;
    var_5 _meth_80CD( var_6 );
    level.player playsound( "sensor_fusion_new_target" );
    var_7 = 0;

    while ( isdefined( self ) && !self.drone_really_hit )
    {
        var_8 = level.player _meth_80A8();
        var_9 = self.origin + ( 0, 0, var_0 );
        var_10 = distance( var_9, var_8 );
        var_7 += 0.05;

        if ( var_10 > 200 )
            var_11 = var_4 / var_10;
        else
            var_11 = 100;

        var_12 = _func_246( var_7, [ [ 0, 0 ], [ 0.8, 2.6 ], [ 1, 1 ] ] );
        var_13 = var_11 * var_12;
        var_14 = self.origin;
        var_5 _meth_80CC( var_1, int( var_2 * var_13 ), int( var_3 * var_13 ) );
        var_6.origin = var_14 + ( 0, 0, var_0 );
        wait 0.05;
    }

    var_5 destroy();
    var_6 delete();
}

handle_drone_turret_targeting()
{
    level endon( "end_cherry_picker" );
    level endon( "snake_charge_ended" );
    level.player endon( "cherrypicker_exit" );
    var_0 = randomintrange( 1, 3 );
    var_1 = [];
    var_2 = 0;

    foreach ( var_4 in self.boids )
    {
        var_5 = var_4 make_drone_turret_target();

        while ( isdefined( var_5 ) && !var_5.drone_really_hit )
        {
            if ( isdefined( var_5.drone_was_hit ) && var_5.drone_was_hit && !isdefined( var_5.is_drone_turret_target ) )
                var_5.drone_was_hit = undefined;

            if ( isdefined( var_5.drone_was_hit ) && var_5.drone_was_hit )
            {
                var_5.drone_dead = 1;
                var_6 = 1;
                var_1 = common_scripts\utility::array_remove( var_1, var_5 );
                var_5.drone_really_hit = 1;
            }

            waitframe();
        }
    }

    level notify( "all_targeted_drones_killed" );
    common_scripts\utility::flag_set( "all_targeted_drones_dead" );
}

follow_drone_turret_target( var_0 )
{
    level endon( "end_cherry_picker" );
    level endon( "snake_charge_ended" );
    level.player endon( "cherrypicker_exit" );

    while ( self.boids.size <= 0 )
        waitframe();

    thread end_follow_drone_on_emp();
    thread handle_drone_turret_targeting();
    thread handle_drone_turret_target_movement( var_0 );
    thread remove_drone_turret_drones();
}

remove_drone_turret_drones()
{
    level waittill( "snake_charge_ended" );

    foreach ( var_1 in self.boids )
        var_1 maps\_shg_design_tools::delete_auto();
}

handle_drone_turret_target_movement( var_0 )
{
    level endon( "end_cherry_picker" );
    level endon( "snake_charge_ended" );
    level.player endon( "cherrypicker_exit" );
    var_1 = ( randomfloatrange( -5, 5 ), randomfloatrange( -5, 5 ), randomfloatrange( -5, 5 ) );

    while ( self.boids.size > 0 )
    {
        level.snake_cloud.snakes = common_scripts\utility::array_removeundefined( level.snake_cloud.snakes );

        if ( level.snake_cloud.snakes.size == 0 )
            break;

        var_2 = maps\_utility::get_average_origin( level.snake_cloud.snakes ) * 0.8;
        var_3 = var_0.origin * 0.2;
        self.origin = var_2 + var_3;
        self.angles += var_1;

        foreach ( var_5 in self.boids )
        {
            if ( isdefined( var_5 ) )
            {
                var_6 = maps\_shg_design_tools::getperlinovertime( 5, 3, 2, 0.5, 10 );
                var_7 = vectortoangles( self.origin - var_5.origin );
                var_8 = var_7 * 5;
                var_5.origin = var_5.tag_ent.origin;
                var_5.angles = vectortoangles( level.player.origin - var_5.origin );
            }
        }

        self.boids = common_scripts\utility::array_removeundefined( self.boids );
        waitframe();
    }
}

end_follow_drone_on_emp()
{
    level common_scripts\utility::waittill_any( "snake_charge_ended", "end_cherry_picker" );

    foreach ( var_1 in self.boids )
        var_1 maps\_shg_design_tools::delete_auto();

    maps\_shg_design_tools::delete_auto();
}

handle_snake_firing()
{
    level endon( "end_cherry_picker" );
    var_0 = undefined;

    for (;;)
    {
        level waittill( "snake_charge_initiated" );
        var_1 = [];

        foreach ( var_3 in level.snake_cloud.snakes )
        {
            if ( isdefined( var_3.lead_snake ) )
                var_0 = var_3;
        }

        if ( isdefined( var_0 ) )
        {
            var_5 = maps\_shg_design_tools::sortbydistanceauto( level.flock_drones, var_0.origin );

            for ( var_6 = 0; var_6 < 6; var_6++ )
                var_1[var_1.size] = var_5[var_6];
        }
        else
        {
            for ( var_6 = 0; var_6 < 6; var_6++ )
                var_1[var_1.size] = level.flock_drones[var_6];
        }

        foreach ( var_8 in var_1 )
            var_8 thread drone_fire_at_turret();
    }
}

drone_fire_at_turret()
{
    level endon( "snake_charge_ended" );
    level endon( "end_cherry_picker" );

    while ( isdefined( self ) )
    {
        var_0 = ( randomintrange( -80, 80 ), randomintrange( -80, 80 ), 48 );
        drone_bullet( level.mobile_turret.origin + var_0, 50 );

        if ( level.nextgen )
        {
            wait(randomfloat( 0.15 ));
            continue;
        }

        wait(randomfloat( 0.25 ));
    }
}

drone_bullet( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 95;

    if ( !isdefined( var_2 ) )
        var_3 = ( 0, 0, 0 );
    else
        var_3 = ( randomfloatrange( var_2 * -1, var_2 ), randomfloatrange( var_2 * -1, var_2 ), randomfloatrange( var_2 * -1, var_2 ) );

    if ( maps\_shg_design_tools::percentchance( var_1 ) && distance( level.player.origin, var_0 ) > 96 )
        var_4 = maps\seoul::cheapmagicbullet( level.drone_bullet, self.origin, var_0 + var_3 );
    else
        var_4 = magicbullet( level.drone_bullet, self.origin, var_0 + var_3 );
}

handle_attack_drone_flyby_magnets()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "player_in_x4walker" );
        level.player.magnet_radius = 192;
        common_scripts\utility::flag_waitopen( "player_in_x4walker" );
        level.player.magnet_radius = 288;
        waitframe();
    }
}

handle_drones_attacking_walker()
{
    level endon( "end_cherry_picker" );
    level endon( "snake_charge_initiated" );
    level.walker_tank endon( "death" );

    while ( isdefined( level.walker_tank ) && level.walker_tank.classname != "script_vehicle_corpse" )
    {
        var_0 = [];

        for ( var_1 = 0; var_1 < 10; var_1++ )
        {
            var_2 = common_scripts\utility::random( level.flock_drones );

            if ( isdefined( var_2 ) )
                var_0[var_0.size] = var_2;
        }

        if ( var_0.size < 10 )
            return;

        var_3 = maps\_utility::get_average_origin( var_0 );
        var_4 = distance( var_3, level.walker_tank.origin );
        var_5 = distance( var_3, level.player.origin );

        while ( var_5 < var_4 )
        {
            var_4 = distance( var_3, level.walker_tank.origin );
            var_5 = distance( var_3, level.player.origin );
            waitframe();
        }

        while ( var_5 > var_4 )
        {
            drones_attack_walker_turret();
            wait 2;
        }
    }
}

handle_kamikaze_drone_visibility()
{
    level endon( "end_cherry_picker" );

    while ( !isdefined( level.spawned_kamikaze_drones ) )
        waitframe();

    for (;;)
    {
        foreach ( var_1 in level.spawned_kamikaze_drones )
        {
            if ( isdefined( var_1 ) && !isdefined( var_1.outlined ) )
            {
                var_1.outlined = 1;
                var_1 _meth_83FA( 1, 1 );
            }

            if ( isdefined( var_1 ) )
                maps\seoul::cheapmagicbullet( level.drone_bullet, var_1.origin, level.player _meth_80A8() + ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), randomintrange( -50, 50 ) ) );
        }

        waitframe();
    }
}

drones_attack_walker_turret()
{
    level.walker_tank thread fire_bullets_at_ent( 15, "drone_swarm_hit" );

    if ( level.nextgen )
        level.walker_tank thread fire_drones_at_ent( 3, "drone_swarm_hit" );

    level waittill( "drone_swarm_hit" );
}

snake_gameplay_for_turret()
{
    level.player waittill( "player_in_x4walker" );
    level notify( "autosave_request" );
    level waittill( "drone_swarm_hit" );
    level.big_kamikaze_death = 1;
    common_scripts\utility::flag_init( "drone_turret_pass_won" );
    thread monitor_snake_gameplay_failure();
    thread handle_snake_firing();
    thread handle_attack_drone_flyby_magnets();
    thread handle_kamikaze_drone_visibility();
    var_0 = 1;
    var_1 = "2";

    for (;;)
    {
        if ( var_0 )
        {
            var_0 = 0;
            var_2 = 0;
        }
        else
        {
            var_3 = var_1;

            while ( var_3 == var_1 )
            {
                var_1 = common_scripts\utility::random( [ "1", "2", "3" ] );
                waitframe();
            }

            var_2 = 0;
        }

        level.drone_turret_fake_death_awesome = 0;
        var_4 = "snake_gameplay_wait_" + var_1;
        level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( var_4, undefined, 0, undefined, 1 );
        level notify( "snake_moving_to_new_attack_path" );
        thread handle_drones_attacking_walker();
        common_scripts\utility::flag_clear( "snake_gameplay_attack_succeeded" );
        level.snakes_attacking_turret = 1;
        var_5 = var_4 + "_end";
        common_scripts\utility::flag_clear( var_5 );
        level waittill( var_5, var_6 );
        common_scripts\utility::flag_wait( var_5 );
        wait(var_2);
        level.player notify( "play_damage_alarm" );
        var_4 = "snake_gameplay_attack_" + var_1;
        level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( var_4, undefined, 0, undefined, 1 );
        var_7 = randomintrange( 4, 7 );
        var_8 = [];
        level notify( "snake_charge_initiated", var_8[0] );

        foreach ( var_10 in var_8 )
        {
            var_10.drone_was_hit = undefined;
            var_10.drone_is_target = 1;
        }

        var_5 = var_4 + "_end";
        common_scripts\utility::flag_clear( var_5 );
        var_12 = 0;

        while ( !common_scripts\utility::flag( "all_targeted_drones_dead" ) && !common_scripts\utility::flag( var_5 ) )
        {
            var_12 = 1;

            foreach ( var_10 in var_8 )
            {
                if ( !isdefined( var_10.drone_really_hit ) )
                {
                    var_12 = 0;
                    break;
                }
            }

            waitframe();
        }

        if ( common_scripts\utility::flag( "all_targeted_drones_dead" ) & !common_scripts\utility::flag( "snake_gameplay_attack_succeeded" ) )
        {
            common_scripts\utility::flag_clear( "all_targeted_drones_dead" );
            level.snakes_attacking_turret = undefined;
            level.player.magnet_radius = 320;
            level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_stop_dynamic_control();
            level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_set_boid_settings( level.boid_settings_presets["frozen_snake"] );
            level notify( "snake_charge_ended" );
            wait 1.5;
            level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_resume_dynamic_control();
        }

        level.snakes_attacking_turret = undefined;
        var_4 = "snake_gameplay_retreat_" + var_1;
        level notify( "snake_charge_ended", var_4 );
        level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( var_4, undefined, 0.75, undefined, 1, level.boid_settings_presets["default_snake"] );

        foreach ( var_10 in var_8 )
        {
            if ( isdefined( var_10.drone_is_target ) )
            {
                var_10.drone_was_hit = undefined;
                var_10.drone_is_target = undefined;
            }
        }

        var_5 = var_4 + "_end";
        common_scripts\utility::flag_clear( var_5 );
        common_scripts\utility::flag_wait( var_5 );
    }
}

wait_till_snakes_nearby()
{
    var_0 = 3;
    var_1 = squared( 128 );
    var_2 = 0;

    while ( var_2 < var_0 )
    {
        if ( isdefined( level.snake_cloud ) )
        {
            foreach ( var_4 in level.snake_cloud.snakes )
            {
                if ( distancesquared( var_4.origin, level.player.origin ) < var_1 )
                    return;
            }
        }

        var_2 += 0.05;
        wait 0.05;
    }
}

monitor_player_health_in_turret()
{
    level.player _meth_80EF();
    level waittill( "end_cherry_picker" );
    level.player _meth_80F0();
}

monitor_snake_gameplay_failure()
{
    level endon( "EMP_triggered" );
    var_0 = 3;
    var_1 = 0;
    thread monitor_player_health_in_turret();
    thread cherry_picker_damage_alarm();

    for (;;)
    {
        for ( var_2 = 0; var_2 < 11; var_2++ )
        {
            level.player waittill( "kamikaze_hit_player" );
            level.player notify( "play_damage_alarm" );

            if ( var_2 == 0 )
                level.mobile_turret mobile_turret_health_2();

            if ( var_2 == 1 )
                level.mobile_turret mobile_turret_health_2();

            if ( var_2 == 3 )
                level.mobile_turret mobile_turret_health_3();
        }

        level.player.magnet_radius = 256;
        wait_till_snakes_nearby();
        var_1++;
        level.mobile_turret.makeinvul = 0;
        level.player _meth_8051( level.player.health * 2, level.player.origin );
        level.mobile_turret _meth_8051( level.mobile_turret.maxhealth * 5, level.mobile_turret.origin );
        level notify( "stop_hud_overlay_update" );
        setdvar( "ui_deadquote", &"SEOUL_FAILED_DRONE_SWARM" );
        thread maps\_utility::missionfailedwrapper();
        level notify( "end_crash_into_player" );
    }
}

random_damage()
{
    level endon( "stop_random_damage" );

    for (;;)
    {
        level.player _meth_8051( 10, level.player.origin );
        wait(randomfloat( 1 ));
    }
}

handle_drone_swarm_skipping()
{
    var_0 = getentarray( "drone_swarm_skip", "targetname" );
    level waittill( "end_cherry_picker" );

    foreach ( var_2 in var_0 )
        var_2.origin += ( 0, 0, 10000 );
}

handle_drone_swarm_retreating()
{
    var_0 = getentarray( "drone_swarm_retreat", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.origin += ( 0, 0, 10000 );

    maps\_shg_design_tools::waittill_trigger_with_name( "start_pod_landings_group_3" );

    foreach ( var_2 in var_0 )
        var_2.origin -= ( 0, 0, 10000 );
}

handle_pac_retreating()
{
    var_0 = getentarray( "hotel_retreat_left_map", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.origin += ( 0, 0, 10000 );

    maps\_shg_design_tools::waittill_trigger_with_name( "trig_convention_center_setup" );

    foreach ( var_2 in var_0 )
        var_2.origin -= ( 0, 0, 10000 );
}

handle_shopping_district_retreating()
{
    var_0 = getentarray( "shopping_district_retreat_left_map", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.origin += ( 0, 0, 10000 );

    maps\_shg_design_tools::waittill_trigger_with_name( "trig_restaurant_spawn" );

    foreach ( var_2 in var_0 )
        var_2.origin -= ( 0, 0, 10000 );
}

handle_canal_intro_retreating()
{
    var_0 = getentarray( "canal_intro_retreat_left_map", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.origin += ( 0, 0, 10000 );

    common_scripts\utility::flag_wait( "sd_escaped_swarm" );

    foreach ( var_2 in var_0 )
        var_2.origin -= ( 0, 0, 10000 );
}

handle_swarm_scene()
{
    level endon( "e3_presentation_cleanup" );
    level.drones_vs_car_shield = 1;
    var_0 = getentarray( "attack_drone_kamikaze_spawner", "targetname" );
    thread handle_drone_swarm_skipping();
    thread handle_drone_swarm_retreating();
    thread setup_cherry_picker_turret();
    thread setup_mobile_turret_gameplay();
    thread spawn_ally_ground_vehicles();
    thread anim_scene_will_grabs_car_door();
    thread maps\_shg_design_tools::trigger_to_flag( "trigger_drone_swarm_flank", "flag_trigger_drones" );
    thread vehicle_explosions_for_drone_swarm();
    thread check_seoul_achievements();
    maps\_shg_design_tools::waittill_trigger_with_name( "start_pod_landings_group_3" );

    if ( level.nextgen )
    {
        var_1 = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "queen_drone_cloud_2", "snake_swarm_initial_area" );
        var_1 thread cleanup_snake_cloud_on_flag( "dialogue_performing_arts_interior" );
        level.snake_cloud = var_1;
    }

    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_e3_fallback_01" );

    if ( level.currentgen )
    {
        var_1 = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "queen_drone_cloud_2", "snake_swarm_initial_area", 8, 12, undefined, 65 );
        var_1 thread cleanup_snake_cloud_on_flag( "dialogue_performing_arts_interior" );
        level.snake_cloud = var_1;
    }

    level notify( "drone_swarm_spawning" );
    var_2 = getent( "vol_cardoor_objective_vol_a", "targetname" );
    var_3 = getent( "vol_cardoor_objective_vol_b", "targetname" );
    var_4 = getent( "vol_cardoor_objective_vol_c", "targetname" );
    var_5 = "snake_swarm_first_flyby";

    if ( level.player _meth_80A9( var_3 ) )
        var_5 = "snake_swarm_first_flyby_2";

    if ( level.player _meth_80A9( var_4 ) )
        var_5 = "snake_swarm_first_flyby_path3";

    level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( var_5, undefined, 3.25 );
    thread snake_pick_intro_path();
    thread snake_follow_player( level.snake_cloud );
    thread snake_strafe_player_gets_cardoor();
    thread snake_shoot_allies();
    thread snake_crash_into_player_after_timeout( var_0 );
    thread snake_shoot_ambient();
    thread snake_fight_walker_tank();
    thread snake_fight_before_turret();
    level notify( "swarm_attack_column" );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "3" );
        _func_0D3( "r_mbVelocityScalar", "1" );
    }

    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_drone_swarm_flank" );
    level notify( "new_drone_swarm" );
    thread delay_drone_kamikaze_player( var_0[0] );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_brush_guide_group1" );
    wait 15;
    level notify( "end_crash_into_player" );
}

snake_fight_walker_tank()
{
    level endon( "drone_swarm_hit" );
    level waittill( "player_in_x4walker" );
    level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "struct_swarm_circle_walker_tank_01", undefined, 3.25 );
    level notify( "stop_kamikaze_player" );
}

make_walker_tank_invulnerable_for_time( var_0 )
{

}

make_walker_invulnerable()
{
    level.player endon( "player_in_x4walker" );
    level endon( "walker_is_now_vulnerable" );
    level.walker_tank endon( "death" );

    for (;;)
    {
        level.walker_tank.health = 22000;
        level.walker_tank.currenthealth = 22000;
        waitframe();
    }
}

debug_show_walker_tank_health()
{
    level.walker_tank endon( "death" );

    for (;;)
    {
        iprintln( level.walker_tank.health );
        wait 0.5;
    }
}

snake_fight_before_turret()
{
    level endon( "drone_swarm_hit" );
    thread handle_walker_tank_shooting_himself();
    thread handle_walker_tank_death();
    thread make_walker_invulnerable();
    thread handle_drone_swarm_shoot_at_player();
    common_scripts\utility::flag_wait_any( "snake_swarm_first_flyby_end", "player_in_x4walker", "snake_swarm_cardoor_charge_end" );

    if ( level.nextgen )
        thread spawn_allies_for_swarm_turret_segment();

    level thread maps\_utility::notify_delay( "walker_is_now_vulnerable", 20 );
    level.walker_tank thread fire_bullets_at_ent( 15, "drone_swarm_hit" );

    if ( level.nextgen )
        level.walker_tank thread fire_drones_at_ent( 0.25, "drone_swarm_hit", 1 );

    level.walker_tank waittill( "death" );
    common_scripts\utility::flag_set( "walker_tank_is_dead" );
    waitframe();
    level notify( "drone_swarm_hit" );
}

handle_drone_swarm_shoot_at_player()
{
    level.player endon( "player_in_x4walker" );
    common_scripts\utility::flag_wait_any( "snake_swarm_first_flyby_end", "snake_swarm_cardoor_charge_end" );
    wait 8;
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.origin = level.player _meth_80A8();
    var_1 = var_0 maps\_shg_design_tools::offset_position_from_tag( "forward", "tag_origin", 800 );
    var_0.origin = var_1;
    var_0 _meth_80A6( level.player, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ), 0 );

    for (;;)
    {
        var_2 = [];

        for ( var_3 = 0; var_3 < 5; var_3++ )
        {
            var_4 = common_scripts\utility::random( level.flock_drones );
            var_2[var_2.size] = var_4;
        }

        foreach ( var_4 in var_2 )
        {
            while ( isdefined( var_4 ) && distance( var_0.origin, var_4.origin ) < 600 )
            {
                var_4 drone_bullet( level.player _meth_80A8(), undefined, 64 );
                wait(randomfloat( 0.25 ));
            }
        }

        waitframe();
    }
}

fire_drones_at_ent( var_0, var_1, var_2 )
{
    level endon( var_1 );
    self endon( var_1 );
    self endon( "death" );
    level endon( "end_cherry_picker" );

    while ( isdefined( self ) )
    {
        swarm_shoot_random_drone_at_ent( self );

        if ( isdefined( var_2 ) )
        {
            wait(randomfloatrange( var_0, var_2 ));
            continue;
        }

        wait(randomfloat( var_0 ));
    }
}

fire_bullets_at_ent( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0; var_2++ )
    {
        var_3 = common_scripts\utility::random( level.flock_drones );

        if ( isdefined( var_3 ) )
        {
            var_3 thread drone_shoot_at_ent( self, var_1 );
            continue;
        }

        var_2 -= 1;
    }
}

handle_walker_tank_death()
{
    if ( level.nextgen )
    {
        while ( level.walker_tank.classname != "script_vehicle_corpse" && level.walker_tank.health > 21000 )
            waitframe();

        playfx( common_scripts\utility::getfx( "razorback_death_explosion" ), level.walker_tank.origin );
        level.walker_tank notify( "death" );
        level.walker_tank delete();
    }
    else
    {
        var_0 = undefined;

        while ( isdefined( level.walker_tank ) )
        {
            var_0 = level.walker_tank.origin;
            waitframe();
        }

        playfx( common_scripts\utility::getfx( "razorback_death_explosion" ), var_0 );
    }
}

handle_walker_tank_shooting_himself()
{
    level endon( "end_walker_tank_health_process" );

    while ( isdefined( level.walker_tank ) )
    {
        level.walker_tank waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( var_1 == level.walker_tank )
            level.walkertank.health += var_0;

        waitframe();
    }
}

spawn_allies_for_swarm_turret_segment()
{
    var_0 = getentarray( "node_ally_cover_group_swarm_battle", "targetname" );
    var_1 = getentarray( "e3_spawner_trench_allies_group_01", "targetname" );

    foreach ( var_3 in var_0 )
    {
        var_4 = spawn_drone_street_ally( var_3, var_1 );
        var_4 thread get_shot_by_drone_swarm();
        var_4 thread reinforce_on_death( var_3, var_1, "end_cherry_picker" );
    }
}

drone_shoot_at_ent( var_0, var_1 )
{
    level endon( var_1 );
    var_0 endon( "death" );

    while ( isdefined( self ) )
    {
        if ( !isdefined( var_0 ) )
            return;

        var_2 = ( randomintrange( -120, 120 ), randomintrange( -120, 120 ), 0 );
        drone_bullet( var_0.origin + var_2 );

        if ( level.nextgen )
        {
            wait(randomfloat( 0.1 ));
            continue;
        }

        wait(randomfloat( 0.25 ));
    }
}

get_shot_by_drone_swarm()
{
    self endon( "death" );

    for (;;)
    {
        wait(randomfloatrange( 10 ));
        swarm_shoot_random_drone_at_ent( self );
    }
}

swarm_shoot_random_drone_at_ent( var_0 )
{
    var_1 = undefined;

    while ( !isdefined( var_1 ) )
    {
        var_1 = common_scripts\utility::random( level.flock_drones );

        if ( !isdefined( var_1 ) )
            continue;
    }

    var_2 = var_1.origin;
    var_1 delete();
    var_3 = magicbullet( "remote_missile_drone_light", var_2, var_0.origin );
    soundscripts\_snd::snd_message( "seo_drone_missile_impact", var_0.origin );
}

snake_pick_intro_path()
{
    common_scripts\utility::flag_wait( "flag_drone_intro_pick_path" );
    var_0 = getent( "vol_cardoor_objective_vol_a", "targetname" );
    var_1 = getent( "vol_cardoor_objective_vol_b", "targetname" );
    var_2 = getent( "vol_cardoor_objective_vol_c", "targetname" );
    var_3 = undefined;

    if ( level.player _meth_80A9( var_0 ) )
        var_3 = "snake_swarm_first_flyby_path1";
    else if ( level.player _meth_80A9( var_1 ) )
        var_3 = "snake_swarm_first_flyby_path2";
    else
        var_3 = "snake_swarm_first_flyby_path3";

    level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( var_3, undefined, 3.25 );
}

pick_player_location_vol()
{
    var_0 = getent( "vol_cardoor_objective_vol_a", "targetname" );
    var_1 = getent( "vol_cardoor_objective_vol_b", "targetname" );
    var_2 = getent( "vol_cardoor_objective_vol_c", "targetname" );

    if ( level.player _meth_80A9( var_0 ) )
        return var_0;
    else if ( level.player _meth_80A9( var_1 ) )
        return var_1;
    else
        return var_2;
}

setup_safe_vols_near_cardoors()
{
    level.player endon( "player_has_cardoor" );
    var_0 = getentarray( "vol_safe_drone_strafe_vol", "targetname" );

    for (;;)
    {
        level.player waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7 );

        if ( var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_PROJECTILE_SPLASH" )
        {
            foreach ( var_9 in var_0 )
            {
                if ( level.player _meth_80A9( var_9 ) )
                {
                    level.player.maxhealth = 100;

                    if ( level.player.health + int( var_1 * 0.9 ) < level.player.maxhealth )
                    {
                        level.player.health += int( var_1 * 0.9 );
                        continue;
                    }

                    level.player.health = int( level.player.maxhealth * 0.9 );
                }
            }
        }
    }
}

soften_player_damage()
{

}

snake_strafe_player_gets_cardoor()
{
    thread setup_safe_vols_near_cardoors();
    level.player waittill( "player_has_cardoor" );
    common_scripts\utility::flag_wait( "flag_drone_intro_pick_path" );
    var_0 = getent( "vol_cardoor_objective_vol_a", "targetname" );
    var_1 = getent( "vol_cardoor_objective_vol_b", "targetname" );
    var_2 = getent( "vol_cardoor_objective_vol_c", "targetname" );

    if ( level.player _meth_80A9( var_0 ) )
        var_3 = "snake_swarm_cardoor_charge";
    else if ( level.player _meth_80A9( var_1 ) )
        var_3 = "snake_swarm_cardoor_charge_altpath";
    else
        return;

    common_scripts\utility::flag_set( "player_just_grabbed_door" );
    level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( var_3, undefined, 3.25, undefined, 1 );
    common_scripts\utility::flag_wait( "snake_swarm_cardoor_charge_end" );
    common_scripts\utility::flag_clear( "player_just_grabbed_door" );
}

snake_shoot_ambient()
{
    common_scripts\utility::flag_wait( "drones_cleared_building" );
    thread bullet_rain_drone_swarm();
    var_0 = common_scripts\utility::getstructarray( "initial_drone_targets", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2 thread shoot_drone_at_ally( 1 );

        if ( common_scripts\utility::cointoss() )
        {
            wait 0.5;
            var_2 thread shoot_drone_at_ally( 1 );
        }

        if ( level.nextgen )
        {
            wait(randomfloat( 1.0 ));
            continue;
        }

        wait(randomfloatrange( 1.0, 2.0 ));
    }
}

bullet_rain_drone_swarm()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0 thread move_drone_target_along_path();

    for ( var_1 = 0; var_1 < 10; var_1++ )
    {
        var_2 = common_scripts\utility::random( level.flock_drones );

        if ( isdefined( var_2 ) )
        {
            var_2 thread drone_shoot_down( var_0 );
            continue;
        }

        var_1 -= 1;
    }
}

move_drone_target_along_path()
{
    var_0 = common_scripts\utility::getstructarray( "struct_drone_swarm_shoot_loc", "targetname" );
    var_0 = maps\_shg_design_tools::sortbydistanceauto( var_0, level.player.origin );
    var_0 = common_scripts\utility::array_reverse( var_0 );
    self.origin = var_0[0].origin;

    foreach ( var_2 in var_0 )
    {
        var_3 = ( var_2.origin[0], level.player.origin[1], var_2.origin[2] );
        self _meth_82AE( var_3, 1.25 );
        wait 1.25;
    }

    wait 1;
    level notify( "end_drone_shoot_run" );
}

drone_shoot_down( var_0 )
{
    level endon( "end_drone_shoot_run" );

    while ( isdefined( self ) )
    {
        var_1 = ( randomintrange( -150, 150 ), randomintrange( -150, 150 ), 0 );
        drone_bullet( var_0.origin + var_1 );
        wait(randomfloat( 0.25 ));
    }
}

snake_crash_into_player_after_timeout( var_0 )
{
    level.player thread maps\_utility::notify_delay( "drone_crash_into_player_now", 20 );
    level.player common_scripts\utility::waittill_any( "player_has_cardoor", "drone_crash_into_player_now" );
    snake_crash_into_player( var_0 );
}

snake_crash_into_player( var_0 )
{
    level endon( "end_crash_into_player" );
    level endon( "end_drone_snake_processes" );

    for (;;)
    {
        foreach ( var_2 in level.snakes )
        {
            while ( isdefined( var_2 ) && snakeisinfrontofplayer( var_2 ) )
            {
                vehicle_scripts\_attack_drone::force_kamikaze( common_scripts\utility::random( var_0 ) );
                wait 0.5;
            }
        }

        waitframe();
    }
}

snakeisinfrontofplayer( var_0 )
{
    var_1 = level.player _meth_80A8();
    var_2 = anglestoforward( level.player _meth_8036() );
    var_3 = var_1 + var_2 * 148;

    if ( distance( var_0.origin, var_3 ) < 96 )
        return 1;

    return 0;
}

cleanup_snake_cloud_on_flag( var_0 )
{
    common_scripts\utility::flag_wait( var_0 );
    vehicle_scripts\_attack_drone_common::cleanup_snake_cloud();
}

snake_follow_player( var_0 )
{
    level endon( "player_in_x4walker" );
    var_1 = getent( "vol_cardoor_objective_vol_a", "targetname" );
    var_2 = getent( "vol_cardoor_objective_vol_b", "targetname" );
    var_3 = getent( "vol_cardoor_objective_vol_c", "targetname" );
    var_4 = getent( "vol_cardoor_objective_vol_a2", "targetname" );
    var_5 = getent( "vol_cardoor_objective_vol_b2", "targetname" );
    var_6 = getent( "vol_cardoor_objective_vol_c2", "targetname" );
    common_scripts\utility::flag_wait_any( "snake_swarm_first_flyby_end", "snake_swarm_cardoor_charge_end" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "player_just_grabbed_door" ) )
            waitframe();

        if ( maps\_utility::any_players_istouching( var_1 ) )
        {
            var_0 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "snake_swarm_first_flyby", undefined, 2.25 );

            while ( maps\_utility::any_players_istouching( var_1 ) )
                waitframe();
        }

        if ( maps\_utility::any_players_istouching( var_2 ) )
        {
            var_0 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "snake_swarm_first_flyby_path2", undefined, 2.25 );

            while ( maps\_utility::any_players_istouching( var_2 ) )
                waitframe();
        }

        if ( maps\_utility::any_players_istouching( var_3 ) )
        {
            var_0 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "snake_swarm_first_flyby_path3", undefined, 2.25 );

            while ( maps\_utility::any_players_istouching( var_3 ) )
                waitframe();
        }

        if ( maps\_utility::any_players_istouching( var_4 ) )
        {
            var_0 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "snake_swarm_follow_player_forward_1", undefined, 2.25 );

            while ( maps\_utility::any_players_istouching( var_4 ) )
                waitframe();
        }

        if ( maps\_utility::any_players_istouching( var_5 ) )
        {
            var_0 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "snake_swarm_follow_player_forward_2", undefined, 2.25 );

            while ( maps\_utility::any_players_istouching( var_5 ) )
                waitframe();
        }

        if ( maps\_utility::any_players_istouching( var_6 ) )
        {
            var_0 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( "snake_swarm_follow_player_forward_3", undefined, 2.25 );

            while ( maps\_utility::any_players_istouching( var_6 ) )
                waitframe();
        }

        waitframe();
    }
}

delay_drone_kamikaze_player( var_0 )
{
    level.player waittill( "player_has_cardoor" );
    thread vehicle_scripts\_attack_drone::handle_drones_vs_car_shield( var_0 );
    level.player waittill( "player_in_x4walker" );
    level notify( "end_drone_kamikaze_player" );
}

button_prompt_on_cardoor()
{
    var_0 = getent( "vol_cardoor_objective_vol_a", "targetname" );
    var_1 = getent( "vol_cardoor_objective_vol_b", "targetname" );
    var_2 = getent( "vol_cardoor_objective_vol_c", "targetname" );

    if ( level.player _meth_80A9( var_0 ) )
        var_3 = common_scripts\utility::getstruct( "struct_door_ripoff_scene_prompt", "targetname" );
    else if ( level.player _meth_80A9( var_1 ) )
        var_3 = common_scripts\utility::getstruct( "struct_door_ripoff_scene_prompt_altpath", "targetname" );
    else
        return;

    var_4 = maps\_shg_utility::hint_button_position( "x", var_3.origin, 32 );
    common_scripts\utility::flag_set( "player_initiated_door_ripoff" );
    var_4 maps\_shg_utility::hint_button_clear();
}

show_throw_hint_close_to_turret()
{
    while ( distance( level.player.origin, level.mobile_turret.origin ) > 400 )
        waitframe();

    maps\_utility::display_hint_timeout( "hint_door_throw", 5 );
}

handle_player_cardoor_health()
{
    level endon( "end_cherry_picker" );
    level waittill( "player_owns_cardoor_shield" );
    level.player notify( "donot_show_throw_hint" );
    thread show_throw_hint_close_to_turret();
    level.player _meth_80EF();
    thread handle_player_cardoor_health_switch_weapon();
    var_0 = level.player common_scripts\utility::waittill_any_return( "car_door_thrown", "car_door_broken", "death" );
    level.player _meth_80F0();
    thread reduce_damage_while_holding_cardoor( 0.75 );

    if ( var_0 == "car_door_broken" )
        level.player thread handle_car_door_throw_hint();
}

reduce_damage_while_holding_cardoor( var_0 )
{
    level notify( "kill_damage_reduction" );
    level endon( "kill_damage_reduction" );
    level endon( "end_cherry_picker" );

    for (;;)
    {
        level.player waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6 );
        var_7 = level.player _meth_8311();

        if ( issubstr( var_7, "door" ) )
        {
            level.player.maxhealth = 100;

            if ( level.player.health + int( var_1 * var_0 ) < level.player.maxhealth )
            {
                level.player.health += int( var_1 * var_0 );
                continue;
            }

            level.player.health = int( level.player.maxhealth * var_0 );
        }
    }
}

handle_car_door_throw_hint()
{
    var_0 = level.player _meth_8311();

    if ( !issubstr( var_0, "_door_" ) )
        return;

    thread cardoor_hint_breakout();
    thread maps\_utility::notify_delay( "car_door_hint_timeout", 3 );
    maps\_utility::display_hint( "car_door_throw" );
    common_scripts\utility::waittill_either( "car_door_hint_timeout", "car_door_thrown" );
    self.has_thrown_door_timeout = 1;
}

cardoor_hint_breakout()
{
    if ( !isdefined( level.player.has_thrown_door_timeout ) )
        return 0;

    if ( level.player.has_thrown_door_timeout )
        return 1;
}

handle_player_cardoor_health_switch_weapon()
{
    level.player endon( "car_door_thrown" );
    level endon( "end_cherry_picker" );

    for (;;)
    {
        while ( maps\_car_door_shield::is_current_weapon_shield( level.player _meth_8311() ) || level.player _meth_8311() == "none" )
            waitframe();

        level.player _meth_80F0();

        while ( !maps\_car_door_shield::is_current_weapon_shield( level.player _meth_8311() ) )
            waitframe();

        level.player _meth_80EF();
    }
}

anim_scene_will_grabs_car_door()
{
    level.will_irons endon( "force_end_will_grabs_door" );
    thread handle_player_cardoor_health();
    var_0 = getent( "model_door_grab_suv", "targetname" );
    var_0.animname = "door_grab_suv";
    var_0 maps\_anim::setanimtree();
    var_0 thread maps\_anim::anim_first_frame_solo( var_0, "seo_door_slide_in_suv" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_drone_swarm_flank" );
    var_1 = level.will_irons;
    var_1.fixednode = 0;
    level.cormack thread cormack_dodge_drones();
    level.jackson thread jackson_dodge_drones();
    common_scripts\utility::flag_wait( "snake_swarm_first_flyby_begin" );
    var_2 = common_scripts\utility::getstruct( "struct_will_grabs_car_door", "targetname" );
    var_3 = var_2 maps\_anim::anim_reach_solo( var_1, "will_door_shield_intro", undefined, 1 );

    if ( common_scripts\utility::flag( "will_cardoor_watcher_flag" ) )
    {
        level.will_irons maps\_utility::set_force_color( "o" );
        return;
    }

    var_0 thread maps\_anim::anim_single_solo( var_0, "seo_door_slide_in_suv" );
    var_2 maps\_anim::anim_single_solo( var_1, "will_door_shield_intro" );
    level notify( "explosion_for_will_grab_scene" );
    thread make_react_explosion();
    var_0 thread maps\_anim::anim_single_solo( var_0, "seo_door_grab_suv" );
    var_1 thread put_cardoor_on_will();
    thread maps\_utility::flag_set_delayed( "dialogue_drone_swarm_intro_pt2", 3 );
    var_1 maps\_anim::anim_single_solo( var_1, "will_door_shield_grab" );

    if ( !common_scripts\utility::flag( "player_inplace_for_will_door_grab_2" ) && !common_scripts\utility::flag( "player_has_cardoor" ) )
        var_1 maps\_anim::anim_single_solo( var_1, "will_door_shield_twitch" );

    if ( !common_scripts\utility::flag( "player_inplace_for_will_door_grab_2" ) && !common_scripts\utility::flag( "player_has_cardoor" ) )
        var_1 thread maps\_anim::anim_loop_solo( var_1, "will_door_shield_hold_idle" );

    var_1 maps\_utility::anim_stopanimscripted();
    level notify( "ready_drone_kamikaze" );
    var_4 = getent( "brush_car_door_blocker_01", "targetname" );
    var_4.origin += ( 0, 0, 10000 );
    var_4 _meth_8058();
    var_1 maps\_utility::set_run_anim( "seo_door_grab_walk_forward", 1 );
    var_1.ignoreall = 1;
    var_1 thread get_to_cherry_picker();
    level waittill( "all_drones_in_swarm_dead" );
    anim_scene_will_grabs_car_door_post_cherrypicker();
}

anim_scene_will_grabs_car_door_post_cherrypicker()
{
    level.will_irons.ignoreall = 0;

    if ( level.nextgen )
        maps\_utility::delaythread( 6, maps\seoul_lighting::disable_motion_blur );
}

make_react_explosion()
{
    var_0 = common_scripts\utility::getstruct( "struct_will_drone_dodge_explosion", "script_noteworthy" );
    playfx( common_scripts\utility::getfx( "drone_explode" ), var_0.origin );
    soundscripts\_snd::snd_message( "seo_will_car_door_explo", var_0.origin );
}

cormack_dodge_drones()
{
    common_scripts\utility::flag_wait( "snake_swarm_first_flyby_begin" );
    var_0 = common_scripts\utility::getstruct( "struct_cormack_position_3_drone_dodge", "targetname" );
    var_1 = var_0 maps\_anim::anim_reach_solo( self, "swarm_cover_cormack_into", undefined, 1 );

    if ( var_1 )
    {
        var_0 maps\_anim::anim_single_solo( self, "swarm_cover_cormack_into" );
        thread maps\_anim::anim_loop_solo( self, "swarm_cover_cormack" );
    }
}

jackson_dodge_drones()
{
    common_scripts\utility::flag_wait( "snake_swarm_first_flyby_begin" );
    var_0 = common_scripts\utility::getstruct( "struct_jackson_position_3_drone_dodge", "targetname" );
    var_1 = var_0 maps\_anim::anim_reach_solo( self, "swarm_cover_jackson_into", undefined, 1 );

    if ( var_1 )
    {
        var_0 maps\_anim::anim_single_solo( self, "swarm_cover_jackson_into" );
        maps\_anim::anim_loop_solo( self, "swarm_cover_jackson" );
    }
}

get_to_cherry_picker()
{
    level.player endon( "player_in_x4walker" );
    var_0 = common_scripts\utility::getstruct( "struct_will_drop_door_goto_vehicle", "targetname" );
    var_1 = var_0.animation;
    var_0 maps\_anim::anim_reach_solo( self, var_1, undefined, 1 );
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    remove_cardoor_from_npc();
    self _meth_81A6( self.origin );
    self.goalradius = 512;
}

remove_cardoor_from_npc( var_0 )
{
    if ( isdefined( self.door ) )
        self.door _meth_804F();

    maps\_utility::clear_run_anim();
    self.door_thrown = 1;

    if ( isdefined( var_0 ) && var_0 && isdefined( self.door ) )
        self.door delete();
}

put_cardoor_on_will()
{
    level.will_irons endon( "force_end_will_grabs_door" );
    level waittill( "will_swap_door" );
    var_0 = getent( "model_door_grab_suv", "targetname" );
    var_1 = self gettagorigin( "tag_weapon_left" );
    self.door = spawn( "script_model", var_1 );
    self.door.angles = self gettagangles( "tag_weapon_left" );
    self.door _meth_80B1( "npc_atlas_suv_door_fr" );
    var_0 _meth_8048( "front_door_right_jnt" );
    self.door _meth_804D( self, "tag_weapon_left" );
}

setup_cherry_picker_turret()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_hill_event_01" );
}

handle_drone_targetting_overlays()
{
    level endon( "emp_ready_for_use" );
    level endon( "stop_hud_overlay_update" );

    for (;;)
    {
        var_0 = level common_scripts\utility::waittill_any_return( "new_drone_target", "drone_target_tracking" );

        if ( !isdefined( self.cherry_turret_hud["overlay1"] ) )
            break;

        if ( var_0 == "new_drone_target" )
            self.cherry_turret_hud["overlay1"] _meth_80CC( level.cherry_picker_hud_drone, 640, 480 );
        else
            self.cherry_turret_hud["overlay1"] _meth_80CC( level.cherry_picker_hud_drone2, 640, 480 );

        if ( isdefined( self.cherry_turret_hud["overlay1"] ) )
            self.cherry_turret_hud["overlay1"].alpha = 0.85;
        else
            break;

        var_0 = level common_scripts\utility::waittill_any_return( "drone_target_dead", "drone_target_tracking_off" );

        if ( isdefined( self.cherry_turret_hud["overlay1"] ) )
        {
            self.cherry_turret_hud["overlay1"] _meth_80CC( level.cherry_picker_hud, 640, 480 );
            continue;
        }

        break;
    }
}

turret_hud_init()
{
    self endon( "death" );
    var_0 = 50000;
    var_1 = 60;
    self.cherry_turret_hud["overlay1"] = newclienthudelem( self );
    self.cherry_turret_hud["overlay1"] _meth_80CC( level.cherry_picker_hud, 640, 480 );
    self.cherry_turret_hud["overlay1"].alignx = "left";
    self.cherry_turret_hud["overlay1"].aligny = "top";
    self.cherry_turret_hud["overlay1"].x = 0;
    self.cherry_turret_hud["overlay1"].y = 0;
    self.cherry_turret_hud["overlay1"].horzalign = "fullscreen";
    self.cherry_turret_hud["overlay1"].vertalign = "fullscreen";
    self.cherry_turret_hud["overlay1"].alpha = 0.5;
    thread handle_drone_targetting_overlays();
    thread handle_display_of_drones_number();
    thread handle_remove_overlay();
    level waittill( "emp_ready_for_use" );
    common_scripts\utility::flag_set( "dialogue_drone_turret_sequence_emp_2" );
    waitframe();
    self.cherry_turret_hud["overlay1"] _meth_80CC( level.cherry_picker_hud_emp, 640, 480 );
    self.cherry_turret_hud["drone_nums"].label = "EMP ready";
    self.cherry_turret_hud["drone_nums"].fontscale = 1.65;
}

handle_display_of_drones_number()
{
    level endon( "emp_ready_for_use" );
    var_0[0] = maps\_shg_design_tools::convert_8bit_color( 11 );
    var_0[1] = maps\_shg_design_tools::convert_8bit_color( 96 );
    var_0[2] = maps\_shg_design_tools::convert_8bit_color( 236 );
    var_1[0] = maps\_shg_design_tools::convert_8bit_color( 226 );
    var_1[1] = maps\_shg_design_tools::convert_8bit_color( 208 );
    var_1[2] = maps\_shg_design_tools::convert_8bit_color( 146 );
    var_2[0] = maps\_shg_design_tools::convert_8bit_color( 233 );
    var_2[1] = maps\_shg_design_tools::convert_8bit_color( 21 );
    var_2[2] = maps\_shg_design_tools::convert_8bit_color( 21 );
    var_3 = ( var_1[0], var_1[1], var_1[2] );
    var_4 = ( var_2[0], var_2[1], var_2[2] );
    self.cherry_turret_hud["drone_nums"] = maps\_shg_design_tools::create_pulsing_text( -2, 0, level.flock_drones.size, self, var_4, var_3, 0 );

    while ( isdefined( self.cherry_turret_hud["drone_nums"] ) )
    {
        self.cherry_turret_hud["drone_nums"].label = level.flock_drones.size;
        self.cherry_turret_hud["drone_nums"].fontscale = 2;
        waitframe();
    }
}

handle_remove_overlay()
{
    level.player common_scripts\utility::waittill_any( "cherrypicker_exit", "missionfailed", "death" );

    if ( isdefined( self.cherry_turret_hud["overlay1"] ) )
        self.cherry_turret_hud["overlay1"] destroy();
}

handle_turret_hud_target_text()
{
    level endon( "end_cherry_picker" );
    var_0[0] = maps\_shg_design_tools::convert_8bit_color( 11 );
    var_0[1] = maps\_shg_design_tools::convert_8bit_color( 96 );
    var_0[2] = maps\_shg_design_tools::convert_8bit_color( 236 );
    var_1[0] = maps\_shg_design_tools::convert_8bit_color( 226 );
    var_1[1] = maps\_shg_design_tools::convert_8bit_color( 208 );
    var_1[2] = maps\_shg_design_tools::convert_8bit_color( 146 );
    var_2[0] = maps\_shg_design_tools::convert_8bit_color( 233 );
    var_2[1] = maps\_shg_design_tools::convert_8bit_color( 21 );
    var_2[2] = maps\_shg_design_tools::convert_8bit_color( 21 );
    var_3 = ( var_1[0], var_1[1], var_1[2] );
    var_4 = ( var_2[0], var_2[1], var_2[2] );
    var_5 = "Aquiring Nexus Drones";
    var_6 = "Attack Drones Aquired";

    for (;;)
    {
        level waittill( "snake_charge_ended", var_7 );
        wait 5;

        if ( isdefined( self.cherry_turret_hud["target_text"] ) )
            self.cherry_turret_hud["target_text"] destroy();

        waitframe();
        self.cherry_turret_hud["target_text"] = maps\_shg_design_tools::create_pulsing_text( 0, 0, var_5, self, var_3, var_3, 0 );
        level waittill( "snake_charge_initiated" );
        self.cherry_turret_hud["target_text"] destroy();
        waitframe();
        self.cherry_turret_hud["target_text"] = maps\_shg_design_tools::create_pulsing_text( 0, 0, var_6, self, var_4, var_3, 0 );
        self.cherry_turret_hud["target_text"].fontscale = 1.65;
        self.cherry_turret_hud["target_text"].alpha = 0.75;
    }
}

aquiring_targets_think()
{
    level endon( "snake_charge_initiated" );
    level endon( "end_cherry_picker" );

    for (;;)
    {
        var_0 = randomint( 8 );

        for ( var_1 = 0; var_1 < var_0; var_1++ )
        {
            var_2 = common_scripts\utility::random( level.flock_drones );

            if ( isdefined( var_2 ) && !_func_0A3( var_2 ) )
            {
                _func_09A( var_2 );
                _func_09C( var_2, "drone_turret_hud_locking" );
                var_2 thread remove_target_on_timeout( randomfloat( 0.5 ) );
                level notify( "drone_target_tracking" );
                wait 0.15;
            }
        }

        wait(randomfloat( 0.5 ));
    }
}

remove_target_on_timeout( var_0 )
{
    self endon( "death" );
    wait(var_0);

    if ( isdefined( self ) && _func_0A3( self ) )
        _func_09B( self );

    level notify( "drone_target_tracking_off" );
}

cycle_charging_hud( var_0 )
{
    while ( !common_scripts\utility::flag( "dialogue_drone_turret_sequence_emp_2" ) )
    {
        foreach ( var_3, var_2 in var_0 )
        {
            if ( common_scripts\utility::flag( "dialogue_drone_turret_sequence_emp_2" ) )
                break;

            if ( isdefined( var_2 ) )
                var_2.alpha = 0.55;
            else
                return;

            wait 0.01;

            if ( isdefined( var_2 ) )
            {
                var_2 fadeovertime( 0.75 );
                var_2.alpha = 0;
            }
        }
    }

    foreach ( var_3, var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2.alpha = 0;
    }
}

monitor_drone_hit_or_timeout()
{
    level notify( "kill_monitor_drone_hit_process" );
    level endon( "kill_monitor_drone_hit_process" );
    var_0 = level.flock_drones.size;

    for (;;)
    {
        level thread notify_delay_endon( "emp_countdown_timeout", 1, "drone_swarm_hit" );
        level common_scripts\utility::waittill_either( "drone_swarm_hit", "emp_countdown_timeout" );
        level notify( "ok_to_decrement_emp_bar", var_0 - level.flock_drones.size );
        var_0 = level.flock_drones.size;
    }
}

notify_delay_endon( var_0, var_1, var_2 )
{
    self endon( var_2 );
    wait(var_1);
    self notify( var_0 );
}

handle_emp_countdown( var_0 )
{
    thread monitor_drone_hit_or_timeout();
    self endon( "death" );
    var_1 = var_0.size;
    var_2 = var_0[0];
    var_3 = var_0[1];
    thread cycle_charging_hud( var_3 );
    var_4[0] = maps\_shg_design_tools::convert_8bit_color( 7 );
    var_4[1] = maps\_shg_design_tools::convert_8bit_color( 7 );
    var_4[2] = maps\_shg_design_tools::convert_8bit_color( 245 );
    var_5[0] = maps\_shg_design_tools::convert_8bit_color( 226 );
    var_5[1] = maps\_shg_design_tools::convert_8bit_color( 208 );
    var_5[2] = maps\_shg_design_tools::convert_8bit_color( 146 );
    var_6[0] = maps\_shg_design_tools::convert_8bit_color( 233 );
    var_6[1] = maps\_shg_design_tools::convert_8bit_color( 21 );
    var_6[2] = maps\_shg_design_tools::convert_8bit_color( 21 );
    var_7 = int( ( level.flock_drones.size - level.min_drone_swarm_size ) / var_2.size / 2 );

    if ( var_7 <= 0 )
        var_7 = 1;

    var_8 = 0;

    foreach ( var_13, var_10 in var_2 )
    {
        if ( !isdefined( var_10 ) )
            continue;

        for ( var_11 = 0; var_11 < var_7; var_11++ )
            level waittill( "ok_to_decrement_emp_bar", var_8 );

        var_10.color = ( var_6[0], var_6[1], var_6[2] );
        var_10.alpha = 0.75;
        var_12 = var_2[var_13 - 1];

        if ( isdefined( var_12 ) )
            var_12.color = ( var_5[0], var_5[1], var_5[2] );

        if ( !common_scripts\utility::flag( "dialogue_drone_turret_sequence_emp_1" ) && var_13 > var_2.size / 2 )
            common_scripts\utility::flag_set( "dialogue_drone_turret_sequence_emp_1" );
    }

    level notify( "emp_ready_for_use" );

    foreach ( var_10 in var_2 )
    {
        wait 0.01;

        if ( !isdefined( var_10 ) )
            continue;

        var_10.color = ( var_4[0], var_4[1], var_4[2] );
        var_10.alpha = 0.55;
    }

    common_scripts\utility::flag_set( "dialogue_drone_turret_sequence_emp_2" );
}

charge_blink( var_0, var_1 )
{
    var_0.alpha = 0;
}

createempclientbar( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8[0] = maps\_shg_design_tools::convert_8bit_color( 226 );
    var_8[1] = maps\_shg_design_tools::convert_8bit_color( 208 );
    var_8[2] = maps\_shg_design_tools::convert_8bit_color( 146 );
    var_9[0] = maps\_shg_design_tools::convert_8bit_color( 233 );
    var_9[1] = maps\_shg_design_tools::convert_8bit_color( 21 );
    var_9[2] = maps\_shg_design_tools::convert_8bit_color( 21 );
    var_10 = [];
    var_11 = [];
    var_12 = var_1 * var_7;
    var_10[0] = newclienthudelem( self );
    var_10[0].x = var_12 - 17;
    var_10[0].y = var_2 + var_6;
    var_10[0].sort = 10;
    var_10[0].horzalign = "center";
    var_10[0].vertalign = "top";
    var_10[0].alpha = 0.55;
    var_10[0] settext( "EMP" );
    var_10[0].fontscale = 1.5;

    for ( var_13 = 0; var_13 < var_0; var_13++ )
    {
        var_14 = newclienthudelem( self );
        var_14.x = var_12;
        var_14.y = var_2 - ( var_5 + var_6 ) * var_13;
        var_14.sort = 10;
        var_14.horzalign = "center";
        var_14.vertalign = "top";
        var_14.alpha = 0.25;
        var_14 _meth_80CC( var_3, var_4, var_5 );
        var_10[var_10.size] = var_14;
        var_15 = newclienthudelem( self );
        var_15.x = var_12 + var_4 * var_7 + 3 * var_7;
        var_15.y = var_2 - ( var_5 + var_6 ) * var_13;
        var_15.sort = 10;
        var_15.horzalign = "center";
        var_15.vertalign = "top";
        var_15.alpha = 0;
        var_15.color = ( var_8[0], var_8[1], var_8[2] );
        var_15 _meth_80CC( var_3, 4, 2 );
        var_11[var_11.size] = var_15;
    }

    var_16 = [ var_10, var_11 ];
    thread clear_hud_on_notify( var_10, "end_cherry_picker" );
    thread clear_hud_on_notify( var_11, "end_cherry_picker" );
    return var_16;
}

clear_hud_on_notify( var_0, var_1 )
{
    level waittill( var_1 );

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3 ) )
            var_3 destroy();
    }
}

check_seoul_achievements()
{
    level waittill( "end_cherry_picker" );

    if ( isalive( level.walker_tank ) )
        maps\_utility::giveachievement_wrapper( "LEVEL_1A" );
}

turret_hud_clear()
{
    level waittill( "end_cherry_picker" );

    foreach ( var_1 in self.cherry_turret_hud )
    {
        if ( !isarray( var_1 ) )
        {
            var_1 destroy();
            continue;
        }

        foreach ( var_3 in var_1 )
        {
            if ( !isarray( var_3 ) )
            {
                var_3 destroy();
                continue;
            }

            foreach ( var_5 in var_3 )
            {
                if ( !isarray( var_5 ) )
                {
                    if ( isdefined( var_5 ) )
                        var_5 destroy();
                }
            }
        }
    }
}

monitor_num_drones_in_swarm()
{
    level endon( "end_cherry_picker" );

    for (;;)
    {
        if ( level.flock_drones.size > level.min_drone_swarm_size )
            level notify( "drone_swarm_weak_ready_emp" );

        level.flock_drones = common_scripts\utility::array_removeundefined( level.flock_drones );
        waitframe();
    }
}

cherry_picker_turret_gameplay()
{
    if ( level.e3_presentation )
        return;

    level.player thread turret_hud_init();
    level.player thread turret_hud_clear();
    level.player thread turret_player_init();
    level.player thread turret_emp_ready();
    level.player thread monitor_num_drones_in_swarm();
    level.player thread walker_drone_fight();
    level.player thread reset_player_stats_on_exit();
    level.player thread monitor_cherry_picker_stick_movement();
    level.player thread monitor_cherry_picker_height();
    level.player thread monitor_cherry_picker_cancel( self );
    level.mobile_turret thread drone_vs_turret_monitor_damage();
}

reset_player_stats_on_exit()
{
    level waittill( "end_cherry_picker" );
    level.player.health = 100;
    level.player.maxhealth = 100;
}

walker_drone_fight()
{

}

monitor_drone_number()
{
    while ( level.flock_drones.size > 0 )
        waitframe();

    common_scripts\utility::flag_set( "all_drones_dead" );
    level.player notify( "all_drones_dead" );
}

play_emp_nag_lines()
{
    level endon( "EMP_triggered" );
}

turret_emp_ready()
{
    var_0 = 320;
    var_1 = 340;
    var_2 = 10;
    var_3 = 2;
    var_4 = 1;
    thread play_emp_reboot_bik();
    thread monitor_drone_number();
    level waittill( "emp_ready_for_use" );
    common_scripts\utility::flag_wait( "dialogue_drone_turret_sequence_emp_2" );
    thread play_emp_audio();
    thread play_emp_nag_lines();
    level.player waittill_player_hits_a();
    self notify( "cherrypicker_exit" );
    level notify( "EMP_triggered" );
    level notify( "stop_kamikaze_player" );
    common_scripts\utility::flag_set( "dialogue_drone_turret_sequence_emp_3" );
    thread emp_wave();
    soundscripts\_snd::snd_message( "seo_swarm_emp_wave" );
    level waittill( "emp_complete" );
    common_scripts\utility::flag_set( "seoul_player_can_exit_x4walker" );
    common_scripts\utility::flag_set( "drone_swarm_complete" );
    level.player thread maps\_utility::notify_delay( "dismount_vehicle_and_turret", 3 );
    level.mobile_turret thread maps\_utility::notify_delay( "dismount_vehicle_and_turret", 3 );
    common_scripts\utility::flag_waitopen( "player_in_x4walker" );
    level.mobile_turret notify( "disable_mobile_turret" );
    level.mobile_turret thread vehicle_scripts\_x4walker_wheels_turret::make_mobile_turret_unusable();
    level.mobile_turret thread vehicle_scripts\_x4walker_wheels_turret::clean_up_vehicle_seoul();
    level.mt_use_tags = common_scripts\utility::array_removeundefined( level.mt_use_tags );
    common_scripts\utility::array_call( level.mt_use_tags, ::delete );
}

play_emp_reboot_bik()
{
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    level waittill( "drone_swarm_hit" );

    for ( var_4 = 0; var_4 < 3; var_4++ )
        maps\_shg_utility::play_videolog( "seoul_turret_loading_loop", "screen_add", var_0, var_1, var_2, var_3, 0 );

    thread maps\_utility::flag_set_delayed( "dialogue_drone_turret_sequence_emp_1", 8 );
    maps\_shg_utility::play_videolog( "seoul_turret_reboot", "screen_add", var_0, var_1, var_2, var_3, 0 );
    thread maps\_shg_utility::play_videolog( "seoul_turret_emp_ready", "screen_add", var_0, var_1, var_2, var_3, 0 );
    level notify( "emp_ready_for_use" );
    level waittill( "EMP_triggered" );
    maps\_shg_utility::stop_videolog();
}

waittill_player_hits_a()
{
    self endon( "all_drones_dead" );
    thread maps\_utility::display_hint( "press_a_for_emp", undefined, undefined, undefined, 30 );
    common_scripts\utility::waittill_any( "a_pressed", "all_drones_dead" );
    self.has_used_emp = 1;
}

emp_prompt_breakout()
{
    if ( level.missionfailed )
        return 1;

    if ( common_scripts\utility::flag( "all_drones_dead" ) )
        return 1;

    if ( !isdefined( level.player.has_used_emp ) )
        return 0;

    if ( level.player.has_used_emp )
        return 1;
}

play_emp_audio()
{

}

emp_wave()
{
    playfx( common_scripts\utility::getfx( "seo_mobile_turret_emp" ), level.mobile_turret.origin );
    soundscripts\_snd::snd_message( "emp_grenade_detonate" );
    thread destroy_drones_in_wave();
    thread handle_emp_kamikaze_drones();
    thread monitor_drones_hit_ground();

    foreach ( var_1 in level.snake_cloud.snakes )
        var_1 thread emp_snake();

    level notify( "all_drones_in_swarm_dead" );
    level notify( "end_cherry_picker" );
}

handle_emp_kamikaze_drones()
{
    while ( common_scripts\utility::flag( "player_in_x4walker" ) )
    {
        if ( !isdefined( level.spawned_kamikaze_drones ) || level.spawned_kamikaze_drones.size <= 0 )
            return;

        foreach ( var_1 in level.spawned_kamikaze_drones )
        {
            if ( isdefined( var_1 ) )
            {
                var_1 _meth_8284( 0, 5, 5 );
                var_1 vehicle_scripts\_attack_drone_common::totally_fake_drone_death( 0, 1, 0, 1 );
            }
        }

        wait 0.25;
    }
}

kill_kamikaze_drones()
{
    if ( !isdefined( level.spawned_kamikaze_drones ) )
        return;

    foreach ( var_1 in level.spawned_kamikaze_drones )
    {
        if ( isdefined( var_1 ) )
            var_1 vehicle_scripts\_attack_drone_common::totally_fake_drone_death( 0, 1, 0, 1 );
    }
}

emp_snake()
{
    level notify( "stop_kamikaze_player" );
    var_0 = 1760.0;
    wait(distance( self.flock.queen.origin, level.player.origin ) / var_0);
    level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_stop_dynamic_control();
    vehicle_scripts\_attack_drone_common::snake_set_boid_settings( level.boid_settings_presets["frozen_snake"] );
    wait 1.5;
    vehicle_scripts\_attack_drone_common::snake_set_boid_settings( level.boid_settings_presets["emp_snake"] );
    soundscripts\_snd::snd_message( "seo_swarm_die", self.origin );
    level notify( "emp_complete" );
    wait 5;
    vehicle_scripts\_attack_drone_common::cleanup_snake();
}

monitor_drones_hit_ground()
{
    var_0 = level.mobile_turret.origin[2];

    foreach ( var_2 in level.flock_drones )
        var_2 thread explode_on_ground_impact( var_0 );
}

explode_on_ground_impact( var_0 )
{
    while ( isdefined( self ) )
    {
        if ( self.origin[2] < var_0 )
        {
            vehicle_scripts\_attack_drone_common::totally_fake_drone_death( 0, 1, 0 );
            break;
        }

        waitframe();
    }
}

destroy_drones_in_wave( var_0, var_1, var_2, var_3 )
{
    level.drone_turret_fake_death_awesome = 1;
    var_4 = [];

    for ( var_5 = 0; var_5 < 75; var_5++ )
    {
        var_4[var_4.size] = common_scripts\utility::random( level.flock_drones );

        if ( maps\_shg_design_tools::percentchance( 10 ) )
            waitframe();
    }

    var_3 = 1760.0;
    var_2 = level.player.origin;
    var_4 = maps\_shg_design_tools::sortbydistanceauto( var_4, var_2 );
    var_6 = var_2;

    foreach ( var_8 in var_4 )
    {
        if ( !isdefined( var_8 ) )
            continue;

        if ( var_8 maps\_vehicle::isvehicle() )
            continue;

        var_9 = distance( var_6, var_8.origin );
        var_10 = var_9 / var_3 * 0.05;
        wait(var_10);

        if ( !isdefined( var_8 ) )
            continue;

        var_6 = var_8.origin;
        var_11 = vectornormalize( var_8.origin - var_2 );
        var_11 = vectornormalize( var_11 + ( 0, 0, 0.2 ) );

        if ( maps\_shg_design_tools::percentchance( 50 ) )
        {
            var_8 vehicle_scripts\_attack_drone_common::totally_fake_drone_death( 0, 1, 0 );
            continue;
        }

        playfx( common_scripts\utility::getfx( "drone_death_cheap" ), var_8.origin );
    }
}

turret_player_init()
{

}

drone_vs_turret_monitor_damage()
{
    var_0 = self;

    foreach ( var_2 in level.flock_drones )
    {
        var_2 thread vehicle_scripts\_attack_drone_common::monitor_drone_cloud_health( 1 );
        wait 0.05;
    }
}

monitor_cherry_picker_cancel( var_0 )
{
    level waittill( "end_cherry_picker" );
}

monitor_cherry_picker_height()
{
    self endon( "cherry_picker_deactivate" );
    var_0 = 0;

    for (;;)
    {
        if ( level.player _meth_82EE() )
            var_0 = 1;
        else if ( level.player _meth_82EF() )
            var_0 = -1;
        else
            var_0 = 0;

        level.player.cherry_picker["z_change"] = ( 0, 0, var_0 );
        wait 0.05;
    }
}

monitor_cherry_picker_stick_movement()
{
    self endon( "cherry_picker_deactivate" );

    for (;;)
    {
        var_0 = self _meth_82F3();
        var_0 = ( var_0[0], var_0[1] * -1, 0 );
        var_1 = self.angles;
        var_2 = vectortoangles( var_0 );
        var_3 = common_scripts\utility::flat_angle( combineangles( var_1, var_2 ) );
        var_4 = anglestoforward( var_3 ) * length( var_0 );
        self.cherry_picker["stick_input_move"] = var_4;
        wait 0.05;
    }
}

spawn_ally_ground_vehicles()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "start_pod_landings" );
}

setup_npc_pod_landings()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "start_pod_landings" );
    var_0 = getentarray( "model_droppod_exterior_group1", "targetname" );
    common_scripts\utility::array_thread( var_0, ::land_pod_cleanly );
    thread spawn_crashing_pods();
    maps\_shg_design_tools::waittill_trigger_with_name( "start_pod_landings_group_2" );
    var_0 = getentarray( "model_droppod_exterior_group2", "targetname" );
    common_scripts\utility::array_thread( var_0, ::land_pod_cleanly );
}

spawn_crashing_pods()
{
    wait 4;
    var_0 = getentarray( "model_droppod_exterior_bad_group", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2 thread land_pod_badly();
        wait 1.4;
    }
}

land_pod_badly()
{
    if ( !isdefined( self.target ) )
        thread land_pod_cleanly();

    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_2 = randomintrange( 1000, 1500 );
    maps\_shg_design_tools::lerp_to_position( var_0.origin, var_2 );
    var_3 = randomfloatrange( 2.0, 4.5 );
    thread maps\_shg_design_tools::gravity_arc( self.origin, var_1.origin, var_3, 800, 800 );
    thread crashed_pod_rotation();
    self waittill( "item_landed" );
    kill_local_units( 700 );
    wait 0.05;
    self delete();
}

kill_local_units( var_0 )
{
    var_1 = _func_0D6();
    var_2 = maps\_utility::getvehiclearray();
    thread maps\_shg_design_tools::impulse_wave( var_1, var_0, self.origin - ( 0, 0, 100 ) );

    foreach ( var_4 in var_2 )
    {
        if ( distance( self.origin, var_4.origin ) < var_0 )
        {
            var_4 _meth_8051( self.health * 5, self.origin );
            var_4 notify( "im_killed" );
        }
    }

    if ( distance( self.origin, level.player.origin ) < var_0 )
        level.player _meth_8051( self.health / 2, self.origin );
}

crashed_pod_rotation()
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

land_pod_cleanly( var_0 )
{
    self endon( "death" );
    thread pod_fx_create();

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    self.old_position = self.origin;
    self.old_angles = self.angles;
    self.origin += ( 0, 1000, 5000 );
    var_1 = randomintrange( 1000, 1500 );
    var_2 = ( 0, 0, 0 );
    var_3 = 6;

    if ( !var_0 )
        wait(randomfloat( 5 ));

    self notify( "begin_entry_trajectory" );
    maps\_shg_design_tools::lerp_to_position( self.old_position + ( 0, 0, randomfloatrange( 400, 600 ) ), var_1 );
    self notify( "begin_landing" );
    var_4 = randomint( 1000 );

    for (;;)
    {
        var_5 = ( perlinnoise2d( gettime() * 0.001 * 0.05, var_4, 5, 2, 3 ) / 2, perlinnoise2d( gettime() * 0.001 * 0.05, var_4, 5, 2, 3 ) / 2, perlinnoise2d( gettime() * 0.001 * 0.05, var_4, 5, 2, 3 ) / 2 );
        var_6 = ( perlinnoise2d( gettime() * 0.001 * 0.05, var_4, 2, 2, 2 ), perlinnoise2d( gettime() * 0.001 * 0.05, var_4, 2, 2, 2 ), perlinnoise2d( gettime() * 0.001 * 0.05, var_4, 2, 2, 2 ) );

        if ( self.origin[2] > self.old_position[2] + 50 )
        {
            self.origin += var_5;
            self.origin -= ( 0, 0, int( ( self.origin[2] - self.old_position[2] ) / 20 ) );
            var_7 = 0;

            if ( self.angles[0] + var_5[0] < self.old_angles[0] + var_3 && self.angles[0] + var_5[0] > self.old_angles[0] - var_3 )
                var_7 = var_6[0];

            var_8 = 0;

            if ( self.angles[1] + var_5[1] < self.old_angles[1] + var_3 && self.angles[1] + var_5[0] > self.old_angles[1] - var_3 )
                var_8 = var_6[1];

            var_9 = 0;

            if ( self.angles[2] + var_5[2] < self.old_angles[2] + var_3 && self.angles[2] + var_5[2] > self.old_angles[2] - var_3 )
                var_9 = var_6[2];

            self.angles += ( var_7, var_8, var_9 );
        }
        else if ( self.origin[2] > self.old_position[2] )
        {
            self.angles = self.old_angles;
            self.origin -= ( 0, 0, 1 );
        }
        else
        {
            self notify( "pod_landed" );
            break;
        }

        wait 0.05;
    }
}

pod_fx_create()
{
    self endon( "pod_landed" );
    self endon( "death" );
    self waittill( "begin_landing" );
    thread maps\_shg_design_tools::set_entflag_on_notify( "pod_landed" );
}

make_seat_cormack( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2 _meth_80B1( "mil_drop_pod_seat_cpt" );
    var_2.animname = var_1;
    var_2 maps\_anim::setanimtree();
    return var_2;
}

make_seat_npc( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2 _meth_80B1( "mil_drop_pod_seat" );
    var_2.animname = var_1;
    var_2 maps\_anim::setanimtree();
    return var_2;
}

make_seat_rack( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2 _meth_80B1( "mil_drop_pod_seat_rack" );
    var_2.animname = var_1;
    var_2 maps\_anim::setanimtree();
    return var_2;
}

make_droppods( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2 _meth_80B1( "vehicle_mil_drop_pod" );
    var_2.animname = var_1;
    var_2 maps\_anim::setanimtree();
    return var_2;
}

make_drop_missile( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2 _meth_80B1( "projectile_javelin_missile" );
    var_2.animname = var_1;
    var_2 maps\_anim::setanimtree();
    return var_2;
}

handle_pod_swap( var_0 )
{
    level waittill( "pod_swap_pod" );
    var_0 _meth_80B1( "vehicle_mil_drop_pod" );
}

handle_player_fov_indroppod()
{
    for (;;)
    {
        level waittill( "droppod_fov_change_start" );
        maps\_utility::lerp_fov_overtime( 1, 90 );
        level waittill( "droppod_fov_change_end" );
        maps\_utility::lerp_fov_overtime( 1, 65 );
    }
}

handle_pod_door_deform( var_0 )
{
    var_0 _meth_8048( "emergencyShield_dam_F" );
    level waittill( "pod_deform" );
    var_0 _meth_8048( "emergencyShield_F" );
    var_0 _meth_804B( "emergencyShield_dam_F" );
}

handle_hide_droppod_building()
{
    var_0 = getentarray( "start_building_ext_hide", "targetname" );
    level waittill( "building_2_crash" );
    maps\_utility::array_delete( var_0 );
}

play_soul_intro_movie()
{
    _func_0D3( "cg_cinematicfullscreen", "1" );
    level.player _meth_831D();
    level.player freezecontrols( 1 );
    thread maps\_shg_utility::play_chyron_video( "chyron_text_seoul", 1, 2 );
    common_scripts\utility::flag_wait( "chyron_video_done" );
    level notify( "intro_movie_done" );
}

show_city_vista( var_0, var_1 )
{
    wait 14;
    var_0.origin = var_0.oldorigin;
    var_1.origin = var_1.oldorigin;
}

handle_button_prompts_on_pod( var_0, var_1 )
{
    level.player waittill( "start_droppod_qte" );
    thread maps\_shg_utility::hint_button_create_flashing( "emergencyhandle", "x", "end_process_buttonmash", ( 5, 5, 5 ) );
}

pod_rumble()
{
    level endon( "end_rumble_listener" );

    while ( !common_scripts\utility::flag( "end_rumble_listener" ) )
    {
        var_0 = level common_scripts\utility::waittill_any_return( "droppod_rumble", "droppod_rumble_start", "droppod_rumble_end", "heavy_rumble", "manual_heavy_rumble_start", "manual_heavy_rumble_end" );

        if ( var_0 == "droppod_rumble" )
        {
            level.player _meth_80AD( "damage_light" );
            continue;
        }

        if ( var_0 == "droppod_rumble_start" )
        {
            thread do_continuous_rumble( "droppod_rumble_end", "damage_light" );
            continue;
        }

        if ( var_0 == "heavy_rumble" )
        {
            level.player _meth_80AD( "damage_heavy" );
            continue;
        }

        if ( var_0 == "manual_heavy_rumble_start" )
            thread do_continuous_rumble( "manual_heavy_rumble_end", "damage_heavy" );
    }
}

do_continuous_rumble( var_0, var_1 )
{
    level endon( var_0 );
    level endon( "end_rumble_listener" );

    while ( !common_scripts\utility::flag( "end_rumble_listener" ) )
    {
        level.player _meth_80AD( var_1 );
        wait 0.1;
    }
}

setup_player_pod_exit()
{
    if ( common_scripts\utility::flag( "ok_to_land_assist" ) )
        common_scripts\utility::flag_clear( "ok_to_land_assist" );

    maps\_player_exo::player_exo_deactivate();
    thread play_soul_intro_movie();
    level waittill( "intro_movie_done" );
    thread maps\seoul_drop_pod_credits::credits_start();
    common_scripts\utility::flag_set( "set_pre_seoul_intro_lighting" );
    maps\_utility::vision_set_fog_changes( "seoul_pre_space_entry_nofog", 0 );
    level.player _meth_83C0( "seoul_intro" );
    level.player _meth_8490( "clut_seoul_pod", 0 );
    thread maps\seoul_lighting::intro_spotlight_setup();
    thread maps\seoul_lighting::dof_intro();
    thread maps\seoul_lighting::dof_intro_pre();
    thread pod_rumble();
    common_scripts\utility::flag_set( "vfx_seoul_intro_start" );
    _func_0D3( "g_friendlynamedist", 0 );
    thread handle_hide_droppod_building();
    thread maps\seoul_code_drop_pod::handle_portal_scripting_vista( "portal_group_vista_on" );
    maps\_utility::player_speed_percent( 75 );
    var_0 = getent( "pod_reflection", "targetname" );
    var_1 = getent( "brush_seoul_city_view", "targetname" );
    var_2 = getent( "brush_seoul_city_view_ems", "targetname" );

    if ( level.currentgen )
        var_2 hide();

    var_1.oldorigin = var_1.origin;
    var_2.oldorigin = var_2.origin;

    if ( level.nextgen )
    {
        var_1.origin += ( 900000, 0, 0 );
        var_2.origin += ( 900000, 0, 0 );
    }

    common_scripts\utility::flag_set( "dialogue_droppod_prelaunch" );
    var_3 = common_scripts\utility::getstructarray( "struct_pod_exit", "targetname" );
    var_4 = common_scripts\utility::getstruct( "struct_anim_node_space_skybox", "targetname" );
    var_5 = var_3[0] common_scripts\utility::spawn_tag_origin();
    var_6 = var_4 common_scripts\utility::spawn_tag_origin();
    var_7 = spawn( "script_model", var_5.origin );
    var_7 _meth_80B1( "vehicle_mil_drop_pod_intro" );
    level.pod_screen = spawn( "script_model", var_7 gettagorigin( "body_T" ) );
    level.pod_screen _meth_80B1( "vehicle_mil_drop_pod_screens" );
    level.pod_screen.targetname = "drop_pod_glass_idle";
    level.pod_screen _meth_804D( var_7, "body_T", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.pod_screen.tag_screen_off = "TAG_SCREEN_JOINT_OFF";
    level.pod_screen.tag_screen_on = "TAG_SCREEN_JOINT_ON";
    level.pod_screen.tag_screen_load = "TAG_SCREEN_JOINT_LOAD";
    level.pod_screen.video_idle = 1;
    level.pod_screen.video_chrome_ab = 1;
    level.pod_screen.video_cab_count = 0;
    level.pod_screen.video_warn_count = 0;
    level.pod_screen.fov_screen_count = 0;
    level.pod_screen.fov_face_count = 0;
    level.entrance_room = getent( "drop_pod_entrance_room", "targetname" );
    level.entrance_room _meth_804D( var_7, "body_T", ( 0, 0, -50 ), ( 0, 115, 0 ) );
    var_7.animname = "droppod";
    var_7 maps\_anim::setanimtree();
    thread maps\seoul_code_drop_pod::handle_drop_pod_screen_start();
    thread maps\seoul_code_drop_pod::handle_pod_screen_show( var_7 );
    thread maps\seoul_code_drop_pod::handle_pod_screen_off( var_7 );
    thread maps\seoul_code_drop_pod::handle_pod_screen_bootup( var_7 );
    thread maps\seoul_code_drop_pod::handle_pod_crash_building1();
    thread handle_pod_swap( var_7 );
    thread handle_player_fov_indroppod();
    thread handle_pod_door_deform( var_7 );
    var_8[0] = make_seat_cormack( var_5, "pod_seat_c" );
    var_8[1] = make_seat_npc( var_5, "pod_seat_w" );
    var_8[2] = make_seat_npc( var_5, "pod_seat_j" );
    var_8[3] = make_seat_npc( var_5, "pod_seat_p" );
    var_8[4] = make_seat_rack( var_5, "pod_seat_1" );
    var_8[5] = make_seat_rack( var_5, "pod_seat_2" );
    var_8[6] = make_seat_rack( var_5, "pod_seat_3" );
    var_8[0] thread handle_button_prompts_on_pod();
    var_9[0] = make_drop_missile( var_5, "pod_missile_1" );
    var_9[1] = make_drop_missile( var_5, "pod_missile_2" );
    var_9[2] = make_drop_missile( var_5, "pod_missile_3" );
    var_9[3] = make_drop_missile( var_5, "pod_missile_4" );
    var_9[4] = make_drop_missile( var_5, "pod_missile_5" );
    var_9[5] = make_drop_missile( var_5, "pod_missile_6" );
    var_9[6] = make_drop_missile( var_5, "pod_missile_final" );
    var_10 = level.player generic_get_player_to_rig( var_5, "pod_phase2b", 1 );
    var_11 = var_8[0];
    var_12 = [ level.cormack_intro, level.will_irons_intro, level.jackson_intro, var_7, var_10 ];
    var_12 = common_scripts\utility::array_combine( var_12, var_8 );
    var_13 = [ level.cormack, level.will_irons, level.jackson, var_7, var_10 ];
    var_14 = level.will_irons.origin;
    var_15 = getent( "pod_origin", "targetname" );
    var_7 _meth_847B( var_15.origin );
    thread maps\seoul_lighting::pod_light_intro( var_7 );
    thread maps\seoul_lighting::pod_light_intro_pre( var_7 );
    waittillframeend;
    level.cormack_intro maps\_utility::gun_remove();
    level.will_irons_intro maps\_utility::gun_remove();
    level.jackson_intro maps\_utility::gun_remove();
    level.will_irons maps\_utility::gun_remove();
    var_16 = [ level.cormack_intro, level.will_irons, level.jackson_intro, var_7, var_10 ];
    var_16 = common_scripts\utility::array_combine( var_16, var_8 );
    thread maps\seoul_lighting::reflection_pod_guys( var_16, var_0, var_7, var_10 );
    thread maps\_introscreen::introscreen_generic_black_fade_in( 0.05, 1 );
    wait 0.25;
    level.pod_screen _meth_83AB( var_0.origin );
    var_6 maps\_anim::anim_first_frame( var_16, "pod_phase1a" );

    foreach ( var_18 in var_16 )
        var_18 _meth_8092();

    level.player setorigin( level.player.origin, 1 );
    level.pod_screen _meth_8092();
    soundscripts\_snd::snd_message( "pod_phase1a_start" );
    var_6 maps\_anim::anim_single( var_16, "pod_phase1a" );

    if ( level.nextgen )
        thread show_city_vista( var_2, var_1 );

    level notify( "swap_wills" );
    var_16 = common_scripts\utility::array_remove( var_16, level.will_irons );
    var_16 = common_scripts\utility::array_add( var_16, level.will_irons_intro );
    thread maps\seoul_lighting::reflection_pod_guys( var_16, var_0, var_7, var_10 );
    var_20[0] = make_droppods( var_5, "droppod1" );
    var_20[1] = make_droppods( var_5, "droppod2" );
    var_20[2] = make_droppods( var_5, "droppod3" );
    var_20[3] = make_droppods( var_5, "droppod4" );
    var_20[4] = make_droppods( var_5, "droppod5" );
    var_20[5] = make_droppods( var_5, "droppod6" );
    var_21[0] = maps\_utility::spawn_anim_model( "blimp" );
    var_21[1] = maps\_utility::spawn_anim_model( "blimp_main_01" );
    var_21[2] = maps\_utility::spawn_anim_model( "blimp_main_02" );
    var_21[3] = maps\_utility::spawn_anim_model( "blimp_main_03" );
    var_21[4] = maps\_utility::spawn_anim_model( "blimp_main_04" );
    var_22 = maps\_utility::spawn_anim_model( "pod_missile_blimp" );
    var_23[0] = make_droppods( var_5, "droppod8" );
    var_23[1] = make_droppods( var_5, "droppod9" );
    var_23[2] = make_droppods( var_5, "droppod10" );
    var_24 = common_scripts\utility::array_combine( var_16, var_20 );
    var_24 = common_scripts\utility::array_combine( var_24, var_21 );
    var_24 = common_scripts\utility::array_combine( var_24, var_23 );
    var_24 = common_scripts\utility::array_combine( var_24, [ var_22 ] );

    foreach ( var_18 in var_24 )
        var_18 _meth_8092();

    level.player setorigin( level.player.origin, 1 );
    level.pod_screen _meth_8092();
    level.will_irons hide();
    level.will_irons _meth_81C6( var_14, level.will_irons.angles );
    thread maps\_utility::flag_set_delayed( "dialogue_droppod_intro_phase_2b_2", 8 );
    var_6 maps\_anim::anim_single( var_24, "pod_phase1b" );
    level.will_irons maps\_utility::gun_recall();
    level.will_irons show();
    common_scripts\utility::array_call( var_23, ::delete );
    common_scripts\utility::array_call( var_21, ::delete );
    var_22 delete();
    common_scripts\utility::flag_set( "dialogue_droppod_intro_phase_2b" );
    common_scripts\utility::flag_set( "vfx_start_drop_pod_intro_phase_2b" );
    level.pod_screen _meth_83AB( var_0.origin );
    common_scripts\utility::flag_clear( "set_pre_seoul_intro_lighting" );
    common_scripts\utility::flag_set( "set_seoul_intro_lighting" );
    level thread maps\seoul_fx::intro_droppod_thrusters( var_20 );
    var_12 = common_scripts\utility::array_combine( var_12, var_20 );
    var_12 = common_scripts\utility::array_combine( var_12, var_9 );
    soundscripts\_snd::snd_message( "droppod_phase_2b_begin" );
    var_6 maps\_anim::anim_first_frame( var_12, "pod_phase2b" );

    foreach ( var_18 in var_12 )
        var_18 _meth_8092();

    level.player setorigin( level.player.origin, 1 );
    level.pod_screen _meth_8092();
    var_6 maps\_anim::anim_single( var_12, "pod_phase2b" );
    level notify( "autosave_request" );
    common_scripts\utility::flag_set( "dialogue_droppod_intro_phase_3" );
    var_6 maps\_anim::anim_first_frame( var_16, "pod_phase3" );
    var_29 = var_6 maps\seoul_drop_pod_qte::anim_single_droppod_custom( var_16, var_10, "pod_phase3" );

    if ( var_29 == 0 )
    {
        var_30 = [ var_8[1], var_8[2], level.will_irons_intro ];
        var_31 = common_scripts\utility::array_remove_array( var_16, var_30 );
        maps\_anim::anim_set_rate( var_16, "pod_phase3", 0.0 );
        var_6 maps\_anim::anim_first_frame( var_31, "pod_phase3_fail" );

        foreach ( var_18 in var_31 )
            var_18 _meth_8092();

        level.player setorigin( level.player.origin, 1 );
        level.pod_screen _meth_8092();
        var_6 thread maps\_anim::anim_single( var_31, "pod_phase3_fail" );
        level.player _meth_8091( var_10 );
        level.player _meth_8091( undefined );
        setdvar( "ui_deadquote", &"SEOUL_FAILED_TO_SAVE_JACKSON" );
        maps\_utility::missionfailedwrapper();
        var_34 = getanimlength( level.jackson_intro maps\_utility::getanim( "pod_phase3_fail" ) );
        wait(var_34 - 0.05);
        maps\_anim::anim_set_rate_single( var_31, "pod_phase3_fail", 0 );
        level.player freezecontrols( 1 );
        wait 1000;
    }

    var_5 maps\_anim::anim_first_frame( var_16, "pod_phase4a_intro" );

    foreach ( var_18 in var_16 )
        var_18 _meth_8092();

    level.player setorigin( level.player.origin, 1 );
    level.pod_screen _meth_8092();
    var_5 maps\_anim::anim_single( var_16, "pod_phase4a_intro" );
    common_scripts\utility::flag_set( "dialogue_droppod_intro_phase_4a" );
    level notify( "manual_heavy_rumble_start" );
    var_5 maps\_anim::anim_first_frame( var_16, "pod_phase4a" );

    foreach ( var_18 in var_16 )
        var_18 _meth_8092();

    level.player setorigin( level.player.origin, 1 );
    level.pod_screen _meth_8092();
    soundscripts\_snd::snd_message( "droppod_first_building_impact" );
    var_5 maps\_anim::anim_single( var_16, "pod_phase4a" );
    level notify( "manual_heavy_rumble_end" );
    var_5 maps\_anim::anim_first_frame( var_16, "pod_phase4b" );

    foreach ( var_18 in var_16 )
        var_18 _meth_8092();

    level.player setorigin( level.player.origin, 1 );
    level.pod_screen _meth_8092();
    level thread maps\_utility::notify_delay( "manual_heavy_rumble_start", 3 );
    level thread maps\_utility::notify_delay( "manual_heavy_rumble_end", 4 );
    var_5 maps\_anim::anim_single( var_16, "pod_phase4b" );
    var_16 = [ level.cormack_intro, level.will_irons_intro, level.jackson_intro, var_7, var_10 ];
    var_16 = common_scripts\utility::array_combine( var_16, var_8 );

    foreach ( var_18 in var_16 )
        var_18 _meth_8092();

    level.player setorigin( level.player.origin, 1 );
    level.pod_screen _meth_8092();
    soundscripts\_snd::snd_message( "droppod_final_impact" );
    common_scripts\utility::flag_set( "spawn_regular_heroes" );
    thread maps\seoul_lighting::reflection_pod_guys_landing( var_16 );
    thread maps\_utility::flag_clear_delayed( "pause_credits", 3 );
    var_43 = common_scripts\utility::array_remove( var_16, var_10 );
    var_43 = common_scripts\utility::array_remove( var_43, var_8[3] );
    var_5 play_entire_interactive_pod_exit( var_10, var_8[3], var_43 );
    level notify( "dialogue_hotel_pod_exit_begin" );
    level thread maps\_utility::notify_delay( "heavy_rumble", 1 );
    level thread maps\_utility::notify_delay( "heavy_rumble", 2.25 );
    level thread maps\_utility::notify_delay( "heavy_rumble", 20.75 );
    var_44 = [ level.cormack_intro, level.will_irons_intro, level.jackson_intro ];
    var_16 = common_scripts\utility::array_remove_array( var_16, var_44 );
    common_scripts\utility::array_call( var_44, ::delete );
    var_16 = [ level.cormack, level.will_irons, level.jackson, var_7, var_10 ];
    var_16 = common_scripts\utility::array_combine( var_16, var_8 );
    thread maps\seoul_lighting::reflection_pod_guys2( var_16 );
    var_5 maps\_anim::anim_single( var_16, "pod_exit" );
    level notify( "droppod_begin_fall" );
    maps\_player_exo::player_exo_activate();
    level.player generic_remove_player_rig( var_10 );
    level notify( "droppod_empty" );
    level notify( "autosave_request" );
    level notify( "vfx_player_control_after_pod_landed" );
    level.player notify( "disable_player_boost_jump" );
    common_scripts\utility::flag_set( "ok_to_land_assist" );
    common_scripts\utility::flag_set( "objective_start" );
    thread maps\_utility::autosave_now();

    if ( level.currentgen )
        thread maps\seoul_transients_cg::cg_kill_entity_on_transition( var_7, "pre_transients_intro_to_fob" );

    var_16 = common_scripts\utility::array_remove( var_16, var_7 );
    var_16 = common_scripts\utility::array_remove( var_16, var_10 );

    foreach ( var_46 in var_8 )
        var_16 = common_scripts\utility::array_remove( var_16, var_46 );

    foreach ( var_18 in var_16 )
    {
        var_18.temp_tag = var_5 common_scripts\utility::spawn_tag_origin();
        var_18.temp_tag thread maps\_anim::anim_loop_solo( var_18, "pod_exit_idle" );
    }

    level notify( "autosave_request" );
    level waittill( "begin_building_traversal" );
    level.cormack maps\_shg_design_tools::anim_stop( level.cormack.temp_tag );
    var_5 thread maps\_anim::anim_single_solo_run( level.cormack, "pod_exit_outro" );
    level.cormack.temp_tag delete();
    level.will_irons maps\_shg_design_tools::anim_stop( level.will_irons.temp_tag );
    var_5 thread maps\_anim::anim_single_solo_run( level.will_irons, "pod_exit_outro" );
    level.will_irons.temp_tag delete();
    wait 0.5;
    level.jackson maps\_shg_design_tools::anim_stop( level.jackson.temp_tag );
    var_5 thread maps\_anim::anim_single_solo_run( level.jackson, "pod_exit_outro" );
    level.jackson.temp_tag delete();
    _func_0D3( "g_friendlynamedist", 1024 );
}

animate_the_other_guys( var_0 )
{
    var_1 = undefined;
    var_2 = "pod_seat_c";

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4.animname ) && var_4.animname == var_2 )
            var_1 = var_4;
    }

    var_6 = common_scripts\utility::getstruct( "struct_anim_node_space_skybox", "targetname" );
    var_7 = var_6 common_scripts\utility::spawn_tag_origin();
    var_0 = common_scripts\utility::array_remove_array( var_0, [ level.will_irons_intro, level.cormack_intro ] );
    var_0 = common_scripts\utility::array_remove( var_0, var_1 );
    var_7 maps\_anim::anim_first_frame( var_0, "pod_wakeup" );

    foreach ( var_9 in var_0 )
        var_9 _meth_8092();

    level.pod_screen _meth_8092();
    thread maps\_anim::anim_single( var_0, "pod_wakeup" );
    maps\_anim::anim_single( [ level.will_irons_intro, level.cormack_intro, var_1 ], "pod_wakeup" );
    var_0 = common_scripts\utility::array_add( var_0, level.cormack_intro );
    var_0 = common_scripts\utility::array_add( var_0, level.will_irons_intro );
    var_0 = common_scripts\utility::array_add( var_0, var_1 );
    level.player setorigin( level.player.origin, 1 );
    maps\_anim::anim_loop( var_0, "pod_wakeup_idle" );
}

repeat_hint_until_comply( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_1 ) )
        self endon( var_1 );

    if ( isdefined( var_2 ) )
        self endon( var_2 );

    if ( isdefined( var_3 ) )
        self endon( var_3 );

    if ( isdefined( var_4 ) )
        self endon( var_4 );

    for (;;)
    {
        thread maps\_utility::hintdisplayhandler( var_0, 5 );
        wait 15;
    }
}

repeat_hint_until_comply_oldstyle( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_1 ) )
        self endon( var_1 );

    if ( isdefined( var_2 ) )
        self endon( var_2 );

    if ( isdefined( var_3 ) )
        self endon( var_3 );

    if ( isdefined( var_4 ) )
        self endon( var_4 );

    for (;;)
    {
        thread maps\_utility::display_hint( var_0 );
        wait 15;
    }
}

waittill_player_presses_triggers( var_0 )
{
    var_1 = "end_trigger_watcher" + randomfloat( 1000 );
    level.player _meth_849C( "BUTTON_LTRIG", "+speed_throw" );
    level.player _meth_849C( "BUTTON_LTRIG", "+toggleads_throw" );
    level.player _meth_849C( "BUTTON_LTRIG", "+ads_akimbo_accessible" );
    level.player _meth_849C( "BUTTON_RTRIG", "+attack" );
    level.player _meth_849C( "BUTTON_RTRIG", "+attack_akimbo_accessible" );

    if ( isdefined( var_0 ) && var_0 == "BUTTON_LTRIG" )
    {
        level.player _meth_82DD( "BUTTON_LTRIG", "+speed_throw" );
        level.player _meth_82DD( "BUTTON_LTRIG", "+toggleads_throw" );
        level.player _meth_82DD( "BUTTON_LTRIG", "+ads_akimbo_accessible" );
    }
    else if ( isdefined( var_0 ) && var_0 == "BUTTON_RTRIG" )
    {
        level.player _meth_82DD( "BUTTON_RTRIG", "+attack" );
        level.player _meth_82DD( "BUTTON_RTRIG", "+attack_akimbo_accessible" );
    }
    else
    {
        level.player _meth_82DD( "BUTTON_LTRIG", "+speed_throw" );
        level.player _meth_82DD( "BUTTON_LTRIG", "+toggleads_throw" );
        level.player _meth_82DD( "BUTTON_LTRIG", "+ads_akimbo_accessible" );
        level.player _meth_82DD( "BUTTON_RTRIG", "+attack" );
        level.player _meth_82DD( "BUTTON_RTRIG", "+attack_akimbo_accessible" );
    }

    for (;;)
    {
        var_2 = level.player common_scripts\utility::waittill_any_return( "BUTTON_RTRIG", "BUTTON_LTRIG", "death" );

        if ( isdefined( var_0 ) && var_0 != var_2 )
            continue;

        return var_2;
    }
}

monitor_right_trigger_interaction_r( var_0, var_1 )
{
    level endon( var_1 );

    for (;;)
    {
        while ( !level.player _meth_824C( var_0 ) && !level.player attackbuttonpressed() )
            waitframe();

        level.player notify( "triggers_pressed", var_0 );
        waitframe();
    }
}

monitor_right_trigger_interaction_l( var_0, var_1 )
{
    level endon( var_1 );

    for (;;)
    {
        while ( !level.player _meth_824C( var_0 ) && !level.player adsbuttonpressed() )
            waitframe();

        level.player notify( "triggers_pressed", var_0 );
        waitframe();
    }
}

monitor_right_trigger_interaction_l_ps3( var_0, var_1 )
{
    if ( level.ps3 )
    {
        level.player _meth_82DD( var_0, "+speed_throw" );
        level.player waittill( var_0 );
        level.player notify( "triggers_pressed", var_0 );
    }
}

play_entire_interactive_pod_exit( var_0, var_1, var_2 )
{
    thread animate_the_other_guys( var_2 );
    thread pod_door_button_prompt();
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_4 = [ var_0, var_1 ];
    var_3 maps\_anim::anim_first_frame( var_4, "pod_wakeup" );

    foreach ( var_6 in var_4 )
        var_6 _meth_8092();

    level.player setorigin( level.player.origin, 1 );
    var_3 maps\_anim::anim_single( var_4, "pod_wakeup" );
    var_3 thread maps\_anim::anim_loop( var_4, "pod_wakeup_idle" );
    level.player thread repeat_hint_until_comply( "lt_rt_harness", "ads_pressed", "attack_pressed" );
    var_8 = level.player waittill_player_presses_triggers();
    level.player.has_used_lt_rt = 1;
    var_3 maps\_utility::anim_stopanimscripted();

    if ( var_8 == "BUTTON_LTRIG" )
    {
        soundscripts\_snd::snd_message( "droppod_harness_left_1" );
        level thread maps\_utility::notify_delay( "heavy_rumble", 2.25 );
        var_3 maps\_anim::anim_single( var_4, "pod_wakeup_left_1" );
        level.player thread repeat_hint_until_comply( "rt_right_harness", "attack_pressed" );
        var_3 thread maps\_anim::anim_loop( var_4, "pod_wakeup_left_1_idle" );
        thread player_climb_wall_head_sway();
        level.player waittill_player_presses_triggers( "BUTTON_RTRIG" );
        level.player notify( "stop_head_sway" );
        level.player.has_used_rt = 1;
        var_3 maps\_utility::anim_stopanimscripted();
        soundscripts\_snd::snd_message( "droppod_harness_right_2" );
        level thread maps\_utility::notify_delay( "heavy_rumble", 1.35 );
        var_3 maps\_anim::anim_single( var_4, "pod_wakeup_right_2" );
        level.player notify( "walking_towards_hatch" );
    }
    else
    {
        soundscripts\_snd::snd_message( "droppod_harness_right_1" );
        level thread maps\_utility::notify_delay( "heavy_rumble", 2.25 );
        var_3 maps\_anim::anim_single( var_4, "pod_wakeup_right_1" );
        level.player thread repeat_hint_until_comply( "lt_left_harness", "ads_pressed" );
        var_3 thread maps\_anim::anim_loop( var_4, "pod_wakeup_right_1_idle" );
        thread player_climb_wall_head_sway();
        level.player waittill_player_presses_triggers( "BUTTON_LTRIG" );
        level.player notify( "stop_head_sway" );
        level.player.has_used_lt = 1;
        var_3 maps\_utility::anim_stopanimscripted();
        soundscripts\_snd::snd_message( "droppod_harness_left_2" );
        level thread maps\_utility::notify_delay( "heavy_rumble", 2.15 );
        var_3 maps\_anim::anim_single( var_4, "pod_wakeup_left_2" );
        level.player notify( "walking_towards_hatch" );
    }

    var_3 thread maps\_anim::anim_loop( var_4, "pod_wakeup_kick_idle" );
    thread player_climb_wall_head_sway();
    level.player thread repeat_hint_until_comply( "a_to_open_hatch", "r3_pressed" );

    while ( !level.player meleebuttonpressed() )
        waitframe();

    common_scripts\utility::flag_set( "kill_credits" );
    level.player notify( "stop_head_sway" );
    level notify( "vo_start_spaceman_warn" );
    level.player.has_kicked_door = 1;
    level notify( "player_drop_pod_door_kick" );
    maps\_utility::anim_stopanimscripted();
    var_3 maps\_utility::anim_stopanimscripted();
    var_3 delete();
}

player_climb_wall_head_sway()
{
    level.player endon( "stop_head_sway" );

    for (;;)
    {
        _func_234( level.player.origin, 3, 3, 2, 3, 0.2, 0.2, 0, 0.3, 0.275, 0.125 );
        wait 1.0;
    }
}

pod_door_button_prompt()
{
    level.player waittill( "walking_towards_hatch" );
    var_0 = common_scripts\utility::getstruct( "struct_pod_exit_door_button", "targetname" );
    var_1 = maps\_shg_utility::hint_button_position( "rs", var_0.origin, 80, 120 );
    level waittill( "player_drop_pod_door_kick" );
    var_1 maps\_shg_utility::hint_button_clear();
}

open_hatch_breakout()
{
    if ( !isdefined( level.player.has_kicked_door ) )
        return 0;

    if ( level.player.has_kicked_door )
        return 1;
}

lt_harness_breakout()
{
    if ( !isdefined( level.player.has_used_lt ) )
        return 0;

    if ( level.player.has_used_lt )
        return 1;
}

rt_harness_breakout()
{
    if ( !isdefined( level.player.has_used_rt ) )
        return 0;

    if ( level.player.has_used_rt )
        return 1;
}

lt_rt_harness_breakout()
{
    if ( !isdefined( level.player.has_used_lt_rt ) )
        return 0;

    if ( level.player.has_used_lt_rt )
        return 1;
}

setup_allies()
{
    var_0 = getent( "hero_will_irons_spawner", "targetname" );
    level.will_irons = var_0 maps\_shg_design_tools::actual_spawn();
    level.will_irons hero_stats( "will_irons", "o" );
    var_0 = getent( "hero_cormack_spawner", "targetname" );
    level.cormack = var_0 maps\_shg_design_tools::actual_spawn();
    level.cormack hero_stats( "cormack", "r" );
    var_0 = getent( "hero_guy_spawner", "targetname" );
    level.jackson = var_0 maps\_shg_design_tools::actual_spawn();
    level.jackson hero_stats( "jackson", "y" );

    if ( common_scripts\utility::flag( "spawn_guys_for_intro" ) )
    {
        var_1 = getent( "hero_cormack_spawner_intro", "targetname" );
        level.cormack_intro = var_1 maps\_shg_design_tools::actual_spawn();
        level.cormack_intro.animname = "cormack";
        var_1 = getent( "hero_will_irons_spawner_intro", "targetname" );
        level.will_irons_intro = var_1 maps\_shg_design_tools::actual_spawn();
        level.will_irons_intro.animname = "will_irons";
        var_1 = getent( "hero_guy_spawner_intro", "targetname" );

        if ( !isdefined( var_1 ) )
            var_1 = getent( "hero_guy_spawner", "targetname" );

        level.jackson_intro = var_1 maps\_shg_design_tools::actual_spawn();
        level.jackson_intro.animname = "jackson";
        common_scripts\utility::flag_wait( "spawn_regular_heroes" );
    }

    level.squad = [ level.will_irons, level.cormack, level.jackson ];
    thread seoul_color_think();
}

hero_stats( var_0, var_1 )
{
    self.a.disablepain = 1;
    thread maps\_utility::deletable_magic_bullet_shield();
    self _meth_8177( "allies" );
    self _meth_8177( "major_allies" );
    maps\_utility::set_force_color( var_1 );
    self.animname = var_0;
    maps\_utility::enable_cqbwalk();
    maps\_utility::disable_surprise();
    self.canjumppath = 1;
}

seoul_color_think()
{
    level.player waittill( "end_drone_swarm" );

    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "0" );

    maps\_utility::activate_trigger_with_targetname( "trig_color_ro5" );
}

setup_end_scene()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "end_army_view_trigger" );
    level waittill( "never_true" );
    maps\_utility::nextmission();
}

initial_ally_wave()
{
    thread spawn_initial_forces_tanks();
    thread spawn_initial_forces_warbirds();
    maps\_shg_design_tools::waittill_trigger_with_name( "player_exit_pod_trigger" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "tank_group_00" );
}

spawn_initial_forces_warbirds()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "start_pod_landings" );
    var_0 = getentarray( "warbird_ambient_01", "targetname" );
    wait 1.5;

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
        var_3 soundscripts\_snd::snd_message( "seo_fob_razorback_02" );
        var_4 = getent( "main_street_reflection", "targetname" );
        var_3 _meth_83AB( var_4.origin );
        thread vehicle_scripts\_attack_drone::boid_add_vehicle_to_targets( var_3 );
        wait 0.2;
    }
}

spawn_initial_forces_tanks()
{
    var_0 = getentarray( "tank_group_01", "targetname" );
    var_1 = getentarray( "tank_group_02", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\_utility::spawn_vehicle );
    common_scripts\utility::array_thread( var_1, ::spawn_tank_column );
}

spawn_tank_column()
{
    var_0 = maps\_utility::spawn_vehicle();
    maps\_shg_design_tools::waittill_trigger_with_name( "leaving_cpk" );
    var_0 maps\_vehicle::gopath();
    var_0 waittill( "reached_end_node" );
    var_0 delete();
}

gangam_cinematic_warfare_manager()
{
    common_scripts\utility::flag_wait( "begin_looping_fob_functions" );
    thread fob_blocking();
    thread injured_soldier_loop();
    thread fob_ignore_management();
    thread fob_drop_pod_1();
    thread fob_drop_pod_fake();

    if ( level.nextgen )
    {
        thread radio_run_guy();
        thread very_first_tank();
    }

    thread very_first_tank_close();
    thread disable_pod_door_clip();
    thread mechs_upclose();
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    common_scripts\utility::flag_init( "begin_drag_animation" );

    if ( level.nextgen )
        thread signal_turn_guy();

    if ( level.currentgen )
        wait 0.2;

    thread soldiers_go_through_tunnel();

    if ( level.currentgen )
        wait 0.05;

    thread cinematic_rocket_guys();

    if ( level.currentgen )
        wait 0.05;

    thread return_fire_rocket();
    thread fake_rocket_explode_moment();
    thread looping_tank_spawner();
    thread looping_airplanes();
    thread fob_block_player_in();
    thread cleanup_fob_guys();

    if ( level.nextgen )
    {
        thread walker_jet_flyby();
        thread special_flyby_jet();
    }

    thread player_clip_pod_door();
}

injured_soldier_loop()
{
    var_0 = getent( "ally_spawner_fob_injured_by_base_unique", "targetname" );
    var_1 = getent( "cinematic_injured_soldier_spawner", "targetname" );
    var_2 = var_0 maps\_utility::spawn_ai( 1 );

    if ( level.currentgen )
        wait 0.05;

    var_3 = var_1 maps\_utility::spawn_ai( 1 );
    var_2.animname = "generic";
    var_3.animname = "generic";
    level.healer = var_2;
    level.healer thread injured_guy_dialogue();
    var_4 = getent( "injured_soldier_revive_loop_animorg", "targetname" );
    var_4 thread maps\_anim::anim_loop_solo( var_2, "seo_injured_soldier_idle02_guy01", "stop_loop" );
    var_4 thread maps\_anim::anim_loop_solo( var_3, "seo_injured_soldier_idle02_guy02", "stop_loop" );
}

signal_turn_guy()
{
    var_0 = getent( "ally_spawner_fob_turn_signal", "targetname" );
    var_1 = common_scripts\utility::getstruct( "struct_fob_injured_soldier_turn_order", "targetname" );
    var_2 = getnode( "sarge_movehere_after_orders", "targetname" );
    var_3 = getnode( "mech_carry_high_goalnode", "targetname" );
    var_4 = var_0 maps\_utility::spawn_ai( 1 );
    var_4.animname = "generic";
    var_1 thread maps\_anim::anim_generic( var_4, "seo_turn_gesturetomove_guy01" );
    var_4 _meth_81A5( var_2 );
    var_4 waittill( "goal" );
    var_4 _meth_81A5( var_3 );
    var_4 thread delete_me_on_goal();
    var_4.goalradius = 15;
    wait 1.5;
    common_scripts\utility::flag_set( "begin_mech_reload" );
    wait 3.67;
    common_scripts\utility::flag_set( "orders_given_lets_move_out" );
}

cinematic_rocket_guys()
{
    var_0 = getent( "cinematic_rocket_guys_loop", "targetname" );
    var_1 = getent( "cinematic_rocket_guys_spawner", "targetname" );
    var_2 = getent( "cinematic_rocket_guys_spawner2", "targetname" );
    var_3 = var_1 maps\_utility::spawn_ai( 1 );

    if ( level.currentgen )
        wait 0.05;

    var_4 = var_2 maps\_utility::spawn_ai( 1 );
    var_3.animname = "generic";
    var_4.animname = "generic";
    wait 0.05;
    var_3 maps\_utility::gun_remove();
    var_4 maps\_utility::gun_remove();
    var_4 thread fire_fake_rocket_function();
    var_3 attach( "npc_stingerm7_base_black", "tag_weapon_right" );
    var_4 attach( "weapon_binocular", "tag_weapon_left" );
    var_0 thread maps\_anim::anim_loop_solo( var_3, "seo_cover_launcher_idle_guy01" );
    var_0 thread maps\_anim::anim_loop_solo( var_4, "seo_cover_launcher_idle_guy02" );
}

fire_fake_rocket_function()
{
    self endon( "death" );
    var_0 = getent( "rocket_shoot_here_loop_org", "targetname" );
    var_1 = getent( "rocket_spawn_here_org", "targetname" );

    for (;;)
    {
        level waittill( "fire_fake_rocket_now" );
        magicbullet( "rpg_straight", var_1.origin, var_0.origin );
    }
}

soldiers_go_through_tunnel()
{
    maps\_utility::trigger_wait_targetname( "trigger_fob_scene" );
    var_0 = getent( "go_through_tunnel_guy1_spawner", "targetname" );
    var_1 = getnode( "go_through_tunnel_guy1_goalnode", "targetname" );
    var_2 = var_0 maps\_utility::spawn_ai( 1 );
    var_2.animname = "generic";
    var_2 maps\_utility::set_run_anim( "seo_run_gununderarm_guy01" );
    var_2 _meth_81A5( var_1 );
    wait 5;
    var_2 maps\_utility::enable_cqbwalk();
}

traffic_manager( var_0, var_1, var_2, var_3 )
{
    var_4 = getent( var_0, "targetname" );

    while ( !common_scripts\utility::flag( var_2 ) )
    {
        if ( anythingistouching( var_1, var_4 ) )
            maps\_utility::set_moveplaybackrate( var_3 );
        else
            maps\_utility::set_moveplaybackrate( 1 );

        waitframe();
    }
}

anythingistouching( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
    {
        if ( var_3 _meth_80A9( var_1 ) )
            return 1;
    }

    return 0;
}

mechs_upclose()
{
    var_0 = getent( "mech_taking_orders_spawner", "targetname" );
    var_1 = getent( "mech_taking_orders_spawner2", "targetname" );
    var_2 = var_0 maps\_utility::spawn_ai( 1 );
    var_3 = [ level.cormack, level.will_irons ];
    var_2 thread traffic_manager( "vol_mech_slow_vol_01", var_3, "npc_pods_landed", 0.5 );
    var_2.ignoreall = 1;
    var_2.goalradius = 15;
    var_4 = getent( "mech_orders1", "targetname" );
    var_5 = getent( "mech_orders_2", "targetname" );
    var_2.animname = "generic";
    var_2 maps\_utility::set_run_anim( "mech_unaware_walk" );
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    wait 4;
    var_2 _meth_81A6( var_4.origin );
    var_2 thread maps\_shg_design_tools::delete_at_goal();
}

return_fire_rocket()
{
    common_scripts\utility::flag_wait( "start_cinematic_rocket_scene" );
    var_0 = getent( "return_fire_rocket", "targetname" );
    var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
    var_1 thread sidewinder_explode_impact();
    common_scripts\utility::flag_set( "incoming_rocket_fire" );
}

tank_shoot_time( var_0 )
{
    self endon( "death" );
    var_1 = getent( "rocket_shoot_here_loop_org", "targetname" );
    wait(var_0 / 2);
    self _meth_8262( var_1 );
    wait(var_0 / 2);
    self _meth_8268();
}

tank_shoot_generic( var_0 )
{
    self endon( "death" );
    var_1 = maps\_shg_design_tools::offset_position_from_tag( "forward", "tag_flash", 1000 );
    var_2 = var_1 + ( randomintrange( -200, 200 ), randomintrange( -200, 200 ), 0 );
    wait(var_0 / 2);
    self _meth_8261( var_2 );
    wait(var_0 / 2);
    self _meth_8268();
}

fake_rocket_explode_moment()
{
    var_0 = getnode( "after_explode_safenode", "targetname" );
    var_1 = getent( "cinematic_combat_vignette_explosion_animorg", "targetname" );
    var_2 = getnode( "cinematic_combat_vignette_explode_safenode", "targetname" );
    var_3 = getnode( "vig_space2", "targetname" );
    var_4 = getent( "cinematic_combat_vignette_explosion_spawner", "targetname" );
    var_5 = getent( "cinematic_combat_vignette_explosion_spawner2", "targetname" );
    var_6 = var_4 maps\_utility::spawn_ai( 1 );

    if ( level.currentgen )
        wait 0.05;

    var_6.goalradius = 15;
    var_7 = var_5 maps\_utility::spawn_ai( 1 );
    var_7.goalradius = 15;
    var_7.animname = "generic";
    common_scripts\utility::flag_wait( "incoming_rocket_fire" );
    var_1 maps\_anim::anim_reach_solo( var_7, var_1.animation );
    var_7 _meth_81A5( var_3 );
    var_1 thread maps\_anim::anim_single_solo( var_7, var_1.animation );
    wait 1.5;
    var_6 _meth_81A5( var_0 );
    common_scripts\utility::flag_wait( "kill_rocket_scene_guy" );
    wait 2.3;
    var_6 _meth_8052();
}

fob_ignore_management()
{
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    wait 1;
    level.player.ignoreme = 1;
    level.cormack.ignoreme = 1;
    level.cormack.ignoreall = 1;
    level.will_irons.ignoreme = 1;
    level.will_irons.ignoreall = 1;
    level.jackson.ignoreme = 1;
    level.jackson.ignoreall = 1;
    maps\_utility::trigger_wait_targetname( "trigger_hill_event_01" );
    level.player.ignoreme = 0;
    level.cormack.ignoreme = 0;
    level.cormack.ignoreall = 0;
    level.will_irons.ignoreme = 0;
    level.will_irons.ignoreall = 0;
    level.jackson.ignoreme = 0;
    level.jackson.ignoreall = 0;
}

looping_tank_spawner()
{
    level endon( "stop_looping_death_soldiers" );

    if ( level.currentgen )
        level endon( "pre_transients_drone_seq_one_to_trusk_push" );

    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    wait 5;

    if ( level.currentgen )
    {
        if ( !_func_21E( "seoul_fob_tr" ) )
            level waittill( "transients_intro_to_fob" );
    }

    var_0 = getent( "looping_tank_spawner", "targetname" );

    for (;;)
    {
        var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();

        if ( level.currentgen )
            thread maps\seoul_transients_cg::cg_kill_entity_on_transition( var_1, "pre_transients_drone_seq_one_to_trusk_push" );

        var_1 soundscripts\_snd::snd_message( "seo_fob_tank_procedural" );
        var_1.ignoreme = 1;
        var_1 maps\_utility::deletable_magic_bullet_shield();
        var_1 thread delete_me_on_goal();
        thread tank_wait_flag_time( 14 );

        if ( !common_scripts\utility::flag( "follow_tank_is_dead" ) )
        {
            var_2 = getent( "run_behind_tank_followorg", "targetname" );
            var_2 _meth_804D( var_1 );
            var_2 thread tank_trail();
        }

        var_3 = randomintrange( 20, 30 );
        var_4 = randomint( 2 );

        if ( var_4 == 1 )
            var_1 thread tank_shoot_time( var_3 );

        wait(randomintrange( 26, 30 ));
    }
}

tank_trail()
{
    level.tanktrail = self.origin;
    common_scripts\utility::flag_set( "follow_tank_is_dead" );

    for (;;)
    {
        if ( isdefined( self ) )
            level.tanktrail = self.origin;
        else
            return;

        wait 0.05;
    }
}

tank_wait_flag_time( var_0 )
{
    wait(var_0);
    common_scripts\utility::flag_set( "tank_is_clear" );
}

delete_me_on_goal( var_0 )
{
    self endon( "death" );
    self waittill( "goal" );
    self delete();

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 delete();
    }
}

looping_airplanes()
{
    level endon( "stop_looping_death_soldiers" );
    common_scripts\utility::flag_wait( "spawn_looping_planes" );
    var_0 = getent( "looping_jetplane_1", "targetname" );
    var_1 = getent( "looping_jetplane_2", "targetname" );
    var_2 = getent( "looping_jetplane_3", "targetname" );
    var_3 = 0;
    wait 4;

    for (;;)
    {
        var_3 = randomint( 4 );

        if ( var_3 == 0 )
        {
            if ( isdefined( var_0 ) )
            {
                var_4 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
                var_4 soundscripts\_snd::snd_message( "aud_handle_gangam_jets" );
            }
        }
        else if ( var_3 == 1 )
        {
            if ( isdefined( var_1 ) )
            {
                var_4 = var_1 maps\_vehicle::spawn_vehicle_and_gopath();
                var_4 soundscripts\_snd::snd_message( "aud_handle_gangam_jets" );
            }
        }
        else if ( var_3 == 2 )
        {
            if ( isdefined( var_1 ) && isdefined( var_0 ) )
            {
                var_4 = var_1 maps\_vehicle::spawn_vehicle_and_gopath();
                var_5 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
                var_4 soundscripts\_snd::snd_message( "aud_handle_gangam_jets" );
            }
        }
        else if ( var_3 == 3 )
        {
            if ( isdefined( var_2 ) )
            {
                var_4 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
                var_4 soundscripts\_snd::snd_message( "aud_handle_gangam_jets" );
            }
        }

        wait(randomintrange( 18, 22 ));
    }
}

fob_block_player_in()
{
    thread fob_player_blocking();
}

fob_player_blocking()
{
    thread setup_fob_blocker_guy_loop( "struct_fob_blocker_guy_01" );
    thread setup_fob_blocker_guy_loop( "struct_fob_blocker_guy_04" );
    thread setup_fob_blocker_guy_loop( "struct_fob_blocker_guy_03", "patrol_bored_idle", "dialogue_start_fob_meetup", "crouch_wait2" );
    var_0 = getent( "fob_player_clipblock", "targetname" );
    common_scripts\utility::flag_wait( "destroy_fob_blocking" );
    var_0 delete();
}

setup_fob_blocker_guy_loop( var_0, var_1, var_2, var_3 )
{
    var_4 = 0;

    if ( issubstr( var_0, "04" ) )
        var_4 = 1;

    var_5 = common_scripts\utility::getstruct( var_0, "targetname" );
    var_6 = var_5 common_scripts\utility::spawn_tag_origin();
    var_7 = undefined;

    if ( isdefined( var_3 ) )
        var_7 = getnode( var_3, "targetname" );

    if ( !isdefined( var_1 ) )
        var_1 = var_5.animation;

    var_8 = getent( "gate_guard_spawner_lowlod", "targetname" );
    var_9 = var_8 maps\_shg_design_tools::actual_spawn( 1 );

    if ( var_4 )
        var_9 maps\_utility::gun_remove();

    var_6 thread maps\_anim::anim_generic_loop( var_9, var_1 );

    if ( isdefined( var_2 ) )
    {
        common_scripts\utility::flag_wait( var_2 );
        wait 16;
        var_9 maps\_shg_design_tools::anim_stop( var_6 );
        var_6 notify( "stop_loop" );
        var_9 _meth_81A5( var_7 );
    }

    common_scripts\utility::flag_wait( "cleanup_injury_team_now" );
    var_9 maps\_shg_design_tools::delete_auto();
    var_6 maps\_shg_design_tools::delete_auto();
}

cleanup_fob_guys()
{
    common_scripts\utility::flag_wait( "cleanup_injury_team_now" );
    var_0 = getentarray( "cleanup_injury_team", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        if ( !isspawner( var_2 ) )
            var_2 delete();
    }
}

walker_jet_flyby()
{
    var_0 = getent( "walker_jet_flyby", "targetname" );
    var_1 = getent( "walker_jet_flyby2", "targetname" );
    var_2 = getent( "missle_walker_1", "targetname" );
    var_3 = getent( "missle_walker_2", "targetname" );
    var_4 = getent( "missle_walker_3", "targetname" );
    maps\_utility::trigger_wait_targetname( "trigger_hill_event_00" );
    common_scripts\utility::flag_wait( "walker_walkby_jets_rockets" );
    var_5 = var_0 thread maps\_vehicle::spawn_vehicle_and_gopath();
    wait 2;
    var_6 = var_2 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_6 thread missile_delete();
    wait 0.3;
    var_7 = var_3 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_7 thread missile_delete();
    wait 0.3;
    var_8 = var_4 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_8 thread missile_delete();
}

fob_blocking()
{
    var_0 = getent( "fob_passed_blocking", "targetname" );
    var_0 _meth_8058();
    var_0 _meth_82BF();
    var_1 = getent( "fob_passed_blocking_art", "targetname" );
    var_1 hide();
    common_scripts\utility::flag_wait( "player_passed_fob" );
    level notify( "stop_looping_death_soldiers" );
    common_scripts\utility::flag_set( "cleanup_injury_team_now" );
}

fob_drop_pod_1()
{
    var_0 = getentarray( "animorg_pod_falling", "targetname" );
    var_1 = var_0[0];
    var_2 = getent( "drop_pod_1_spawner", "targetname" );
    var_3 = getent( "animorg_pod_falling_guy_exit_org", "targetname" );
    var_4 = getnode( "delete_me_here_right_org", "targetname" );

    if ( level.currentgen )
    {
        if ( !_func_21E( "seoul_fob_tr" ) )
            level waittill( "transients_intro_to_fob" );
    }

    thread fob_placed_unload( var_1, var_2, var_4 );
    thread monitor_droppod_destruction();
}

monitor_droppod_destruction()
{
    thread handle_debris_visibility( "pod_land_debris_01" );
    thread handle_debris_visibility( "pod_land_debris_02" );
}

handle_debris_visibility( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
        var_3 hide();

    for (;;)
    {
        level waittill( "npc_droppod_landed", var_5, var_6 );

        if ( distance( var_6, var_1[0].origin ) < 100 )
            break;
    }

    foreach ( var_3 in var_1 )
        var_3 show();
}

pod_shake_play( var_0, var_1, var_2 )
{
    wait(var_2);
    var_3 = distance( self.origin, level.player.origin );

    if ( var_3 < var_0 )
    {
        earthquake( 0.3, var_1, self.origin, var_0 );
        level.player _meth_80AD( "heavy_3s" );
        wait(var_1);
    }

    waitframe();
}

fob_placed_unload( var_0, var_1, var_2 )
{
    var_3 = maps\_utility::spawn_anim_model( "npc_droppod" );
    var_0 maps\_anim::anim_first_frame_solo( var_3, "pod_landing" );
    var_4 = getent( "player_pod_door_clip", "targetname" );
    var_5 = getnodearray( "delete_me_node_array", "targetname" );
    var_6 = var_0 setup_guy_for_droppod( var_1, "seo_fob_drop_guy_01" );
    var_7 = var_0 setup_guy_for_droppod( var_1, "seo_fob_drop_guy_02" );
    var_8 = var_0 setup_guy_for_droppod( var_1, "seo_fob_drop_guy_03" );
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    var_6 show();
    var_7 show();
    var_8 show();
    thread animated_pod_function( var_3, var_0, var_4 );
    var_0 thread maps\_anim::anim_single_solo_run( var_6, "seo_fob_drop_guy_01" );
    var_0 thread maps\_anim::anim_single_solo_run( var_7, "seo_fob_drop_guy_02" );
    var_0 thread maps\_anim::anim_single_solo_run( var_8, "seo_fob_drop_guy_03" );
    level notify( "spawn_fake_drop_pods" );
    var_6 thread goto_node_and_delete( var_5 );
    var_7 thread goto_node_and_delete( var_5 );
    var_8 thread goto_node_and_delete( var_5 );
}

setup_guy_for_droppod( var_0, var_1 )
{
    var_2 = var_0 maps\_shg_design_tools::actual_spawn( 1 );

    if ( !isdefined( var_2 ) )
        return;

    var_2 hide();
    var_2.animname = "generic";
    var_2.ignoreall = 1;
    var_2.canjumppath = 1;
    var_2 maps\_utility::disable_surprise();
    thread maps\_anim::anim_first_frame_solo( var_2, var_1 );
    var_2 maps\_utility::set_run_anim( "run_lowready_f" );
    return var_2;
}

goto_node_and_delete( var_0 )
{
    self.goalradius = 20;
    var_1 = common_scripts\utility::random( var_0 );
    self _meth_81A6( var_1.origin );
    thread delete_me_on_goal();
}

backup_drop_pod_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = var_2 maps\_utility::spawn_ai( 1 );

    if ( isalive( var_10 ) )
    {
        var_10 hide();
        var_10.animname = "generic";
        var_10.ignoreall = 1;
        var_10.canjumppath = 1;
        var_2.count = 1;
        wait 0.05;
    }

    var_11 = var_2 maps\_utility::spawn_ai( 1 );

    if ( isalive( var_11 ) )
    {
        var_11 hide();
        var_11.animname = "generic";
        var_11.ignoreall = 1;
        var_11.canjumppath = 1;
        var_2.count = 1;
        wait 0.05;
    }

    var_12 = var_2 maps\_utility::spawn_ai( 1 );

    if ( isalive( var_12 ) )
    {
        var_12 hide();
        var_12.animname = "generic";
        var_12.ignoreall = 1;
        var_12.canjumppath = 1;
    }

    var_13 = "casual_stand_idle";
    var_14 = "patrol_bored_idle";
    var_15 = "casual_stand_idle";
    thread animated_pod_function( var_0, var_1, var_9 );

    if ( isalive( var_10 ) )
    {
        var_10 show();
        var_1 thread maps\_anim::anim_single_solo_run( var_10, "seo_fob_drop_guy_01" );
        var_10.goalradius = 20;
        var_10 _meth_81A6( var_3.origin );
        var_10 thread animate_on_goal( var_13, var_3, var_6 );
        var_10 thread move_again_noflag( var_3, var_6 );
        var_10 thread kill_on_trigger( "trigger_fob_scene" );
    }

    if ( isalive( var_11 ) )
    {
        var_11 show();
        var_1 thread maps\_anim::anim_single_solo_run( var_11, "seo_fob_drop_guy_02" );
        var_11.goalradius = 20;
        var_11 _meth_81A6( var_4.origin );
        var_11 thread animate_on_goal( var_14, var_4, var_7 );
        var_11 thread move_again_noflag( var_4, var_7 );
        var_11 thread kill_on_trigger( "trigger_fob_scene" );
    }

    if ( isalive( var_12 ) )
    {
        var_12 show();
        var_1 thread maps\_anim::anim_single_solo_run( var_12, "seo_fob_drop_guy_03" );
        var_12.goalradius = 20;
        var_12 _meth_81A6( var_5.origin );
        var_12 thread animate_on_goal( var_15, var_5, var_8 );
        var_12 thread move_again_noflag( var_5, var_8 );
        var_12 thread kill_on_trigger( "trigger_fob_scene" );
    }
}

monitor_pod_landing_for_debris( var_0 )
{
    wait 0.25;
    level notify( "npc_droppod_landed", var_0, var_0.origin );
}

animated_pod_function( var_0, var_1, var_2 )
{
    var_0 thread pod_shake_play( 1250, 3, 4.3 );
    level notify( "aud_npc_droppod_landing", var_0, var_0.origin );
    var_1 maps\_anim::anim_single_solo( var_0, "pod_landing" );
    thread enable_pod_door_clip( var_2 );
    var_3 = spawn( "script_model", var_0.origin );
    var_3.angles = var_0.angles;
    var_3 _meth_80B1( "vehicle_mil_drop_pod_static_gsq" );
    var_0 delete();
    wait 2;
    common_scripts\utility::flag_set( "npc_pods_landed" );
}

move_again_noflag( var_0, var_1 )
{
    self endon( "death" );
    wait 9;

    if ( !common_scripts\utility::flag( var_1 ) )
        self _meth_81A6( var_0.origin );
}

animate_on_goal( var_0, var_1, var_2 )
{
    self endon( "death" );
    self waittill( "goal" );
    common_scripts\utility::flag_set( var_2 );
    var_1 maps\_anim::anim_loop_solo( self, var_0 );
}

radio_run_guy()
{
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    wait 2;
    var_0 = getent( "ally_spawner_fob_injured", "targetname" );
    level.resdhirt1 = var_0 maps\_utility::spawn_ai( 1 );
    level.resdhirt1 endon( "death" );

    if ( !isdefined( level.resdhirt1 ) )
        return;

    level.resdhirt1.ignoreall = 1;
    level.resdhirt1.goalradius = 64;
    level.resdhirt1.canjumppath = 1;
    level.resdhirt1.animname = "generic";
    var_1 = common_scripts\utility::getstructarray( "radio_run_guy_org", "targetname" );
    var_2 = var_1[0];
    var_2 maps\_anim::anim_reach_solo( level.resdhirt1, "seo_move_stoponradio_loop_guy1" );
    var_3 = getnode( "delete_me_node_2", "targetname" );
    common_scripts\utility::flag_set( "play_radio_walkby_guy_vo" );
    level.resdhirt1 thread allow_death_delay();
    var_2 maps\_anim::anim_single_solo_run( level.resdhirt1, "seo_move_stoponradio_loop_guy1" );
    var_4 = getent( "group3_orders_wait3", "targetname" );
    level.resdhirt1 _meth_81A6( var_4.origin );
    level.resdhirt1 thread kill_on_trigger( "trigger_hill_event_01" );
}

allow_death_delay()
{
    self endon( "death" );
    wait 0.1;
    self.allowdeath = 1;
}

very_first_tank()
{
    var_0 = getent( "very_first_tank", "targetname" );
    var_1 = var_0 maps\_utility::spawn_vehicle();
    var_1 soundscripts\_snd::snd_message( "seo_fob_tank_01" );
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    var_1 maps\_utility::deletable_magic_bullet_shield();
    var_1 maps\_vehicle::gopath();
    wait 1.5;
    var_1 _meth_8268();
}

very_first_tank_close()
{
    if ( level.currentgen )
    {
        if ( !_func_21E( "seoul_fob_tr" ) )
            level waittill( "transients_intro_to_fob" );
    }

    var_0 = getent( "very_first_tank_close", "targetname" );
    var_1 = getent( "very_first_tank_close_extra", "targetname" );
    var_2 = var_0 maps\_utility::spawn_vehicle();
    var_2 soundscripts\_snd::snd_message( "seo_fob_tank_02" );
    common_scripts\utility::flag_wait( "begin_fob_combat_vignette" );
    var_2 maps\_utility::deletable_magic_bullet_shield();
    var_2 maps\_vehicle::gopath();
    var_2 thread delete_me_on_goal();
    var_3 = var_1 maps\_utility::spawn_vehicle();
    var_3 soundscripts\_snd::snd_message( "seo_fob_tank_03" );
    var_3 maps\_utility::deletable_magic_bullet_shield();
    var_3 maps\_vehicle::gopath();
    var_3 thread delete_me_on_goal();

    if ( level.currentgen )
    {
        thread maps\seoul_transients_cg::cg_kill_entity_on_transition( var_2, "pre_transients_drone_seq_one_to_trusk_push" );
        thread maps\seoul_transients_cg::cg_kill_entity_on_transition( var_3, "pre_transients_drone_seq_one_to_trusk_push" );
    }

    wait 8;
    var_2 _meth_8268();
    wait 4;
    var_2 _meth_8268();
}

waiting_mechs()
{
    var_0 = getent( "waiting_mech_1", "targetname" );
    var_1 = getnode( "waiting_mech_one_node", "targetname" );
    var_2 = getent( "waiting_mech_one_origin", "targetname" );
    var_3 = getent( "waiting_mech_two_origin", "targetname" );
    var_4 = "mech_stand_idle_wbtest";
    var_5 = "mech_unaware_idle";
    var_6 = "mech_stand_reload";
    var_7 = var_0 maps\_utility::spawn_ai( 1 );
    var_7.animname = "generic";
    var_3 thread maps\_anim::anim_loop_solo( var_7, var_4 );
}

fob_drop_pod_fake()
{
    var_0 = getent( "animorg_pod_falling_fake1", "targetname" );
    var_1 = getent( "animorg_pod_falling_fake2", "targetname" );
    var_2 = maps\_utility::spawn_anim_model( "npc_droppod" );
    var_3 = maps\_utility::spawn_anim_model( "npc_droppod" );
    var_4 = getent( "drop_pod_1_spawner2", "targetname" );
    var_5 = getent( "drop_pod_1_spawner3", "targetname" );
    level waittill( "spawn_fake_drop_pods" );

    if ( level.currentgen )
    {
        if ( !_func_21E( "seoul_fob_tr" ) )
            level waittill( "transients_intro_to_fob" );
    }

    var_6 = getent( "group2_orders_wait1", "targetname" );
    var_7 = getent( "group2_orders_wait2", "targetname" );
    var_8 = getent( "group2_orders_wait3", "targetname" );
    var_9 = "guy4_reached_goal";
    var_10 = "guy5_reached_goal";
    var_11 = "guy6_reached_goal";
    var_12 = getent( "group3_orders_wait1", "targetname" );
    var_13 = getent( "group3_orders_wait2", "targetname" );
    var_14 = getent( "group3_orders_wait3", "targetname" );
    var_15 = "guy7_reached_goal";
    var_16 = "guy8_reached_goal";
    var_17 = "guy9_reached_goal";
    var_18 = getent( "player_pod_door_clip2", "targetname" );
    var_19 = getent( "player_pod_door_clip3", "targetname" );
    wait 1.15;
    wait 1.2;

    if ( level.nextgen )
        thread backup_drop_pod_function( var_3, var_1, var_5, var_12, var_13, var_14, var_15, var_16, var_17, var_19 );
    else
        thread animated_pod_function( var_3, var_1, var_19 );
}

fob_out_of_bounds_fail()
{
    level endon( "stop_looping_death_soldiers" );
    level.player endon( "death" );
    var_0 = getentarray( "player_out_of_bounds", "targetname" );

    for (;;)
    {
        foreach ( var_2 in var_0 )
        {
            if ( level.player _meth_80A9( var_2 ) )
            {
                maps\_player_death::set_deadquote( &"SEOUL_ON_MISSION" );
                level.player freezecontrols( 1 );
                maps\_utility::missionfailedwrapper();
            }
        }

        wait 0.05;
    }
}

play_out_of_bounds_vo( var_0 )
{
    var_1 = 2;

    if ( !isdefined( level.last_warning_line ) )
    {
        level.last_warning_line = -1;
        level.warning_lines = [ "seo_crk_overheremitchell", "seo_crk_mitchellmoveit" ];
    }

    for ( var_2 = randomint( var_1 ); var_2 == level.last_warning_line; var_2 = randomint( var_1 ) )
    {

    }

    level.last_warning_line = var_2;
    var_3 = level.warning_lines[var_2];
    var_0 maps\_utility::dialogue_queue( var_3 );
}

special_flyby_jet()
{
    var_0 = getent( "special_jet_flyby_spawner1", "targetname" );
    var_1 = getent( "special_jet_flyby_spawner2", "targetname" );
    var_2 = getent( "special_jet_flyby_spawner3", "targetname" );
    var_3 = [ var_0, var_1, var_2 ];
    common_scripts\utility::flag_wait( "special_jets_flyby" );

    foreach ( var_5 in var_3 )
    {
        var_6 = var_5 maps\_vehicle::spawn_vehicle_and_gopath();
        var_6 soundscripts\_snd::snd_message( "aud_handle_gangam_jets" );
        wait(randomintrange( 1, 3 ));
    }

    wait 6;
    common_scripts\utility::flag_set( "spawn_looping_planes" );
}

disable_pod_door_clip()
{
    var_0 = getent( "player_pod_door_clip", "targetname" );
    var_1 = getent( "player_pod_door_clip2", "targetname" );
    var_2 = getent( "player_pod_door_clip3", "targetname" );
    var_3 = [ var_0, var_1, var_2 ];

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5 ) )
            var_5 _meth_82BF();
    }
}

enable_pod_door_clip( var_0 )
{
    if ( isdefined( var_0 ) )
        var_0 _meth_82BE();
}

player_clip_pod_door( var_0 )
{
    common_scripts\utility::flag_wait( "enable_door_clip" );
    thread enable_pod_door_clip( var_0 );
}
