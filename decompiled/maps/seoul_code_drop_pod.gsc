// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

droppod_main()
{
    common_scripts\utility::flag_init( "turn_on_seo_advertisement" );
}

intro_space()
{
    common_scripts\utility::flag_set( "set_seoul_space_entry_lighting" );
    thread setup_orbital_entry();
}

setup_orbital_entry()
{
    thread setup_reentry();
    thread setup_lower_atmosphere_fall();
    thread handle_reentry_fx();
    level.player waittill( "y_pressed" );
    maps\_shg_design_tools::white_out( 5, 2, 1 );
    wait 1;
    level.player waittill( "a_pressed" );
    level notify( "open_hatch" );
    wait 1;
    level.player waittill( "a_pressed" );
    level notify( "start_deployment" );
}

handle_reentry_fx()
{
    var_0 = getentarray( "reentry_fire_01", "targetname" );
    common_scripts\utility::array_call( var_0, ::hide );
    var_1 = getentarray( "reentry_fire_brush", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 _meth_804D( level.center_universe, "tag_origin" );

    common_scripts\utility::array_call( var_1, ::hide );
    level waittill( "entering_upper_atmosphere" );
    thread rumble_cam_shake();

    if ( level.nextgen )
        thread maps\_utility::vision_set_fog_changes( "seoul_space_orange", 10 );

    earthquake( 0.2, 25, level.player.origin, 500 );
    wait 12;
    common_scripts\utility::array_call( var_1, ::show );
    level notify( "ok_to_teleport_player" );
    thread make_reentry_strobe();
    wait 2;

    if ( level.nextgen )
        thread maps\_utility::vision_set_fog_changes( "seoul_space_white", 10 );

    earthquake( 0.1, 5, level.player.origin, 500 );
    level waittill( "never_true" );
    level waittill( "should_telport_player" );
    level waittill( "should_telport_player" );
    common_scripts\utility::array_call( var_1, ::hide );

    if ( level.nextgen )
        thread maps\_utility::vision_set_fog_changes( "seoul", 12 );

    wait 5;
    earthquake( 0.2, 25, level.player.origin, 500 );
    thread make_reentry_strobe();
}

make_reentry_strobe()
{
    for ( var_0 = 0; var_0 < 2; var_0++ )
    {
        for ( var_1 = 0; var_1 < 10; var_1++ )
        {
            var_2 = randomfloatrange( 0.1, 0.5 );
            var_3 = randomfloatrange( 0.1, 1 );
            maps\_shg_design_tools::white_out( 0.1, var_2, var_3 );
            wait(randomfloatrange( 0.1, 1 ));
        }

        thread maps\_shg_design_tools::white_out( 0.1, 0.5, 1 );
        wait 0.1;
        level notify( "should_telport_player" );
    }
}

rumble_cam_shake()
{

}

setup_galaxy_hatch()
{
    var_0 = getentarray( "galaxy_back_hatch", "targetname" );
    var_1 = getent( "galaxy_back_hatch_org", "targetname" );
    var_2 = var_1 common_scripts\utility::spawn_tag_origin();

    foreach ( var_4 in var_0 )
        var_4 _meth_804D( var_2, "tag_origin" );

    level waittill( "open_hatch" );
    var_6 = ( -90, var_2.angles[1], var_2.angles[2] );
    var_2 _meth_82B5( var_6, 8, 3, 1 );
}

setup_lower_atmosphere_fall()
{
    setup_player_pod_b();
    move_universe_to_new_pod();
    level waittill( "reentry_fx_off" );
}

move_universe_to_new_pod()
{

}

setup_reentry()
{
    var_0 = getent( "pod_center", "targetname" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    level.center_universe = var_1;
    thread setup_player_pod();
    thread setup_space_transport();
    level.player waittill( "x_pressed" );
    level notify( "begin_deorbit" );
    earthquake( 0.2, 1, level.player.origin, 64 );
    thread handle_atmospheric_transition();
    thread handle_space_sky();
    thread handle_earth_disc();
    thread handle_sun_spotlight();
    thread rotate_the_universe( var_1 );
}

handle_sun_spotlight()
{
    var_0 = getent( "sunlight_location", "targetname" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_1.angles = vectortoangles( level.center_universe.origin - var_1.origin );
    level waittill( "begin_deorbit" );
    playfxontag( common_scripts\utility::getfx( "player_light" ), var_1, "tag_origin" );
    var_1 _meth_804D( level.center_universe, "tag_origin" );
    level waittill( "reentry" );
    stopfxontag( common_scripts\utility::getfx( "player_light" ), var_1, "tag_origin" );
}

handle_earth_disc()
{
    var_0 = getent( "earth_disc", "targetname" );
    var_0 thread move_earth_with_pod( level.center_universe );
    level waittill( "ok_to_teleport_player" );
    var_0 delete();
}

handle_space_sky()
{
    var_0 = getentarray( "space_brush", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_804D( level.center_universe, "tag_origin" );

    level waittill( "dropped_from_pod" );

    foreach ( var_2 in var_0 )
        var_2 delete();
}

handle_atmospheric_transition()
{
    var_0 = getentarray( "reentry_gray_brush", "targetname" );
    level waittill( "begin_deorbit" );
    common_scripts\utility::array_call( var_0, ::hide );
    common_scripts\utility::flag_wait( "entering_atmosphere" );
}

handle_drop_pod_screen_start()
{
    _func_05C();
    level.pod_screen _meth_804B( level.pod_screen.tag_screen_off );
    level waittill( "screen_intialize" );
    _func_0D3( "cg_cinematicFullScreen", "0" );
    _func_059( "drop_pod_glass_reboot" );
    wait 3.0;
    drop_pod_screen_on();
    common_scripts\utility::flag_wait( "turn_on_seo_advertisement" );
    maps\seoul::ingame_movies();
}

drop_pod_door_close( var_0 )
{
    level.entrance_room delete();
}

drop_pod_screen_on()
{
    level notify( "pod_screen_on" );

    if ( level.pod_screen.video_idle )
    {
        _func_059( "drop_pod_glass_idle" );
        level.pod_screen.video_idle = 0;
    }
}

drop_pod_screen_off( var_0 )
{
    level notify( "pod_screen_off" );
    _func_059( "drop_pod_glass_evacuate" );
    level notify( "portal_vista_off" );
}

drop_pod_screen_off_damage( var_0 )
{
    _func_059( "drop_pod_glass_damaged" );
    level notify( "pod_screen_off" );
}

drop_pod_screen_chrome_abber( var_0 )
{
    if ( level.pod_screen.video_cab_count < 2 )
    {
        _func_059( "drop_pod_glass_glitch" );
        waitframe();
        level.pod_screen.video_cab_count++;
    }
}

drop_pod_screen_bootup( var_0 )
{
    _func_059( "drop_pod_glass_reboot" );
    level thread maps\seoul_fx::intro_droppod_velocity_streaks( var_0 );
}

drop_pod_screen_on_warning( var_0 )
{
    _func_059( "drop_pod_glass_warning" );
    level notify( "pod_screen_bootup" );
}

drop_pod_screen_glitch_warning( var_0 )
{
    if ( level.pod_screen.video_warn_count == 1 )
        level notify( "building_2_crash" );

    level.pod_screen.video_warn_count++;
}

handle_pod_screen_show( var_0 )
{
    for (;;)
    {
        level waittill( "pod_screen_on" );
        level.pod_screen _meth_804B( level.pod_screen.tag_screen_on );
        level.pod_screen _meth_804B( level.pod_screen.tag_screen_load );
        var_0 _meth_8048( "TAG_ROOF" );
        level.pod_screen _meth_8048( level.pod_screen.tag_screen_off );
    }
}

handle_pod_screen_off( var_0 )
{
    for (;;)
    {
        level waittill( "pod_screen_off" );
        level.pod_screen _meth_804B( level.pod_screen.tag_screen_off );
        var_0 _meth_804B( "TAG_ROOF" );
    }
}

handle_pod_screen_bootup( var_0 )
{
    for (;;)
    {
        level waittill( "pod_screen_bootup" );
        level.pod_screen _meth_8048( level.pod_screen.tag_screen_off );
        var_0 _meth_8048( "TAG_ROOF" );
    }
}

fov_screen( var_0 )
{
    if ( level.pod_screen.fov_screen_count == 0 )
        level.player _meth_8031( 85, 3 );
    else
        level.player _meth_8031( 85, 0.3 );

    level.pod_screen.fov_screen_count++;
}

fov_face( var_0 )
{
    level.player _meth_8031( 65, 0.3 );
}

drop_pod_chromatic_abberation( var_0 )
{
    var_1 = 8;
    var_2 = 1;
    var_3 = 8;
    _func_0D3( "r_chromaticAberrationTweaks", 1 );
    _func_0D3( "r_chromaticAberrationAlpha", 0.85 );

    for ( var_4 = 0; var_4 < var_0; var_4++ )
    {
        _func_0D3( "r_chromaticAberration", 1 );
        var_5 = perlinnoise2d( gettime() * 0.001 * var_0, var_1, 4, 5, 2 );
        _func_0D3( "r_chromaticSeparationR", perlinnoise2d( gettime() * 0.001 * var_0, var_1, 4, 5, 2 ) );
        _func_0D3( "r_chromaticSeparationG", perlinnoise2d( gettime() * 0.001 * var_0, var_2, 4, 5, 2 ) );
        _func_0D3( "r_chromaticSeparationB", perlinnoise2d( gettime() * 0.001 * var_0, var_3, 4, 5, 2 ) );
        waitframe();
        _func_0D3( "r_chromaticAberration", 0 );
    }
}

handle_pod_crash_building1()
{
    level waittill( "pod_crash_hide_floor1" );

    if ( level.currentgen )
        level.player _meth_83C0( "space_entry_crash" );

    delete_pod_crash_floor( getentarray( "pod_crash_hide_floor1", "targetname" ) );
    _func_059( "drop_pod_glass_warning" );

    if ( level.currentgen )
    {
        wait 0.5;
        level.player _meth_83C0( "seoul_vista" );
    }
}

delete_pod_crash_floor( var_0 )
{
    maps\_utility::array_delete( var_0 );
}

handle_portal_scripting_vista( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    level waittill( "portal_vista_off" );
    var_1 _meth_8070( 0 );
    level waittill( "player_drop_pod_door_kick" );
    var_1 _meth_8070( 1 );
}

setup_space_transport()
{
    level waittill( "begin_deorbit" );
    wait 0.2;
    thread setup_rocket_pieces( "pod_npc_org" );
    thread setup_rocket_pieces( "pod_npc_org2" );
    thread setup_rocket_pieces( "pod_npc_org3" );
    thread setup_rocket_pieces( "pod_npc_org4" );
    thread setup_rocket_pieces( "entry_pod_connector_org" );
}

setup_rocket_pieces( var_0, var_1 )
{
    var_2 = getentarray( var_0, "targetname" );

    foreach ( var_4 in var_2 )
    {
        var_5 = var_4 common_scripts\utility::spawn_tag_origin();
        var_5.pieces = getentarray( var_4.target, "targetname" );

        foreach ( var_7 in var_5.pieces )
            var_7 _meth_804D( var_5, "tag_origin" );

        var_5 thread rotate_space_debris();
    }
}

rotate_space_debris()
{
    level endon( "reentry" );
    var_0 = self;
    var_1 = distance( level.center_universe.origin, self.origin );
    var_2 = 1 + var_1 / 100;
    var_3 = var_0.origin;
    var_4 = 1;

    if ( var_3[2] < level.center_universe.origin[2] )
        var_4 = -1;

    var_5 = ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) );
    var_6 = ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), 0 );
    var_7 = 0;
    var_8 = undefined;

    for (;;)
    {
        if ( distance( var_0.origin, var_3 ) > 250 )
        {
            var_0.angles += var_5;
            var_9 = ( var_6[0], var_6[1], var_2 );

            if ( !var_7 )
            {
                var_7 = 1;
                level notify( "begin_universe_twirl" );
                var_8 = var_0 common_scripts\utility::spawn_tag_origin();
                var_8 _meth_804D( level.center_universe, "tag_origin" );
            }

            var_0.origin = var_8.origin + ( var_9[0], var_9[1], var_2 * var_4 );
        }
        else
        {
            var_9 = ( 0, 0, var_2 * var_4 );
            var_0.origin += var_9;
        }

        waitframe();
    }
}

rotate_the_universe( var_0 )
{
    level endon( "reentry" );
    var_0.angles = ( 90, 180, var_0.angles[2] );
    level waittill( "begin_universe_twirl" );
    var_1 = ( 1, 0.2, 0 );
    var_2 = 140;
    var_3 = 1;
    var_4 = var_1[0] / var_2;
    var_5 = var_1[1] / var_2;
    var_6 = 0;

    while ( !common_scripts\utility::flag( "entering_atmosphere" ) )
    {
        if ( var_3 )
        {
            for ( var_7 = 0; var_7 < var_2; var_7++ )
            {
                var_0.angles += ( var_4 * var_7, var_5 * var_7, var_6 * var_7 );
                waitframe();
            }

            var_3 = 0;
        }
        else
            var_0.angles += var_1;

        waitframe();
    }

    var_8 = 90;
    var_9 = 180;
    var_10 = 0;

    for ( var_7 = 0; var_7 < var_2; var_7++ )
    {
        var_0.angles += ( var_1[0] - var_4 * var_7, var_1[1] - var_5 * var_7, var_6 * var_7 );
        waitframe();
    }
}

setup_player_pod()
{
    level.player _meth_831D();
    var_0 = getent( "player_pod_seat", "targetname" );

    if ( !isdefined( var_0 ) )
    {
        var_1 = getentarray( "player_pod_seat", "targetname" );
        var_0 = var_1[0];
    }

    var_2 = getentarray( "pod_ally_orgs", "targetname" );
    var_3 = getent( "entrypod_ally_spawner", "targetname" );

    if ( !isdefined( var_0 ) )
    {
        maps\seoul_code_gangnam::seoul_start();
        return;
    }

    level.player maps\_utility::teleport_player( var_0 );
    level.player.seattag = level.player common_scripts\utility::spawn_tag_origin();
    level.player _meth_807D( level.player.seattag, "tag_origin", 1, 60, 60, 60, 60, 1, 1 );
    level.player _meth_8119( 0 );
    level.podsquad = [];

    foreach ( var_5 in var_2 )
    {
        var_6 = var_5 common_scripts\utility::spawn_tag_origin();
        var_3.count = 1;
        var_7 = var_3 maps\_utility::spawn_ai( 1 );
        maps\_utility::spawn_failed( var_7 );
        var_7.tag = var_6;

        if ( common_scripts\utility::cointoss() )
            var_6 thread maps\_shg_design_tools::anim_simple( var_7, var_5.animation );
        else
            var_6 thread maps\_anim::anim_generic_first_frame( var_7, var_5.animation + "_single" );

        level.podsquad[level.podsquad.size] = var_7;
        wait 0.1;
    }
}

flag_wait_any_or_timeout( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_0 * 1000;
    var_7 = gettime();
    var_8 = [ var_1, var_2, var_3, var_4, var_5 ];

    for (;;)
    {
        foreach ( var_10 in var_8 )
        {
            if ( common_scripts\utility::flag_exist( var_10 ) && common_scripts\utility::flag( var_10 ) )
                break;
        }

        if ( gettime() >= var_7 + var_6 )
            break;

        waitframe();
    }
}

setup_player_pod_b()
{
    level waittill( "never_true" );
    level waittill( "ok_to_teleport_player" );
    var_0 = getentarray( "pod_ally_orgs_b", "targetname" );
    var_1 = getentarray( "ally_pod_spawner_b", "targetname" );
    var_2 = var_1[0];

    foreach ( var_7, var_4 in var_0 )
    {
        var_2.count = 1;
        var_5 = var_4 common_scripts\utility::spawn_tag_origin();
        var_6 = var_2 maps\_utility::spawn_ai( 1 );
        var_6 maps\_utility::spawn_failed();

        if ( common_scripts\utility::cointoss() )
            var_5 thread maps\_shg_design_tools::anim_simple( var_6, var_4.animation );
        else
            var_5 thread maps\_anim::anim_generic_first_frame( var_6, var_4.animation + "_single" );

        waitframe();
    }

    level waittill( "should_telport_player" );
    level.player _meth_804F();
    level.player.seattag delete();
    var_8 = getent( "player_pod_seat_x", "targetname" );
    level.player.seattag = level.player common_scripts\utility::spawn_tag_origin();
    var_9 = level.player getangles();
    level.player _meth_807D( level.player.seattag, "tag_origin", 1, 60, 60, 60, 60, 1, 1 );
    level.player _meth_8118( 0 );
    level.player setangles( var_9 );
    var_10 = getent( "earth_disc_upper_atmosphere", "targetname" );
    var_10 notify( "stop_earth_movement" );
    var_10 delete();
    var_11 = getent( "pod_center_b", "targetname" );
    level.center_universe.origin = var_11.origin;
    common_scripts\utility::array_call( level.podsquad, ::delete );
    level waittill( "should_telport_player" );
    level waittill( "should_telport_player" );
    level notify( "dropped_from_pod" );
    level waittill( "should_telport_player" );
    level.player _meth_804F();
    level.player.seattag delete();
    var_12 = getent( "player_pod_seat_c", "targetname" );
    level.player.seattag = var_12 common_scripts\utility::spawn_tag_origin();
    level.player _meth_807D( level.player.seattag, "tag_origin", 1, 60, 60, 60, 60, 1, 1 );
    level.player _meth_8118( 0 );
    wait 2;
    var_13 = getent( "player_pod_door_01", "targetname" );
    var_13 _meth_82B5( var_13.angles + ( 0, 0, -95 ), 2, 0.2, 1 );
    wait 3;
    var_14 = getent( "player_pod_seat_c2", "targetname" );
    level.player.seattag _meth_82AE( var_14.origin, 3, 0.2, 0.5 );
    level.player.seattag _meth_82B5( var_14.angles, 1, 0.2, 0.5 );
    wait 4;
    level.player _meth_804F();
    level.player _meth_831E();
    level.player _meth_8118( 1 );
}

move_earth_with_pod( var_0 )
{
    level endon( "ok_to_teleport_player" );
    var_1 = 80;
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2 _meth_804D( var_0, "tag_origin" );
    var_3 = common_scripts\utility::spawn_tag_origin();
    thread monitor_dist_from_earth( self );
    level.earth_tag = var_2;
    level.earth_tag = var_2;
    var_4 = var_3.origin;

    for (;;)
    {
        self.angles = var_2.angles;
        var_5 = maps\_shg_design_tools::getlerpfraction( var_3.origin, var_0.origin, var_1, 5 );
        var_3.origin = vectorlerp( var_3.origin, var_0.origin, var_5 );
        var_6 = distance( var_4, var_3.origin );
        self.origin = var_2 maps\_shg_design_tools::offset_position_from_tag( "up", "tag_origin", var_6 );
        level.earth_angles = [ self.origin, self.angles, var_6 ];
        waitframe();
    }
}

move_earth2_with_pod()
{
    var_0 = 80;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_2 = var_1.origin;

    for (;;)
    {
        self.angles = level.earth_tag.angles;
        var_3 = maps\_shg_design_tools::getlerpfraction( var_1.origin, level.center_universe.origin, var_0, 5 );
        var_1.origin = vectorlerp( var_1.origin, level.center_universe.origin, var_3 );
        var_4 = distance( var_2, var_1.origin );
        self.origin = level.earth_tag maps\_shg_design_tools::offset_position_from_tag( "up", "tag_origin", var_4 );
        waitframe();
    }
}

monitor_dist_from_earth( var_0 )
{
    while ( distance( var_0.origin, level.center_universe.origin ) > 1600 )
        waitframe();

    common_scripts\utility::flag_set( "entering_atmosphere" );
    level notify( "entering_upper_atmosphere" );
}
