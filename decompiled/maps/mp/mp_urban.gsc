// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::urbancallbackstartgametype;
    maps\mp\mp_urban_precache::main();
    maps\createart\mp_urban_art::main();
    maps\mp\mp_urban_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_urban_lighting::main();
    maps\mp\mp_urban_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_urban" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.orbitalsupportoverridefunc = ::urbancustomospfunc;
    level.orbitallaseroverridefunc = ::urbanvulcancustomfunc;
    level.remote_missile_height_override = 20000;
    level thread urbanbombingruncustomfunc();
    level thread lockdownevent();

    if ( level.nextgen )
    {
        level thread urbansetuphoverbike();
        level thread urbananimateriders();
        level thread urbananimatedrones();
    }

    level thread setuppolicelights();
    level thread urbanruneffectsfloor();
    level thread urbanpatchwarbird();
    level thread urbanpatchclip();
    level thread urbanshiftbombdefusetrigger();
}

urbancallbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

urbancustomospfunc()
{
    level.orbitalsupportoverrides.spawnanglemin = 10;
    level.orbitalsupportoverrides.spawnanglemax = 90;
    level.orbitalsupportoverrides.spawnheight = 9275;
    level.orbitalsupportoverrides.spawnradius = 6000;
    level.orbitalsupportoverrides.speed = 246;
    level.orbitalsupportoverrides.leftarc = 20;
    level.orbitalsupportoverrides.rightarc = 20;
    level.orbitalsupportoverrides.toparc = -40;
    level.orbitalsupportoverrides.bottomarc = 60;
}

urbanvulcancustomfunc()
{
    if ( level.nextgen )
        level.orbitallaseroverrides.spawnpoint = ( 300, 0, 0 );
    else
        level.orbitallaseroverrides.spawnpoint = ( 300, 0, 800 );
}

urbanbombingruncustomfunc()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 100;
}

lockdownevent()
{
    if ( getdvarint( "r_reflectionProbeGenerate" ) )
        return;

    urbandoorssetup();
    urbansetupshutters();

    if ( level.gametype == "ball" || level.gametype == "twar" || level.gametype == "hp" || level.gametype == "infect" || level.gametype == "sr" || level.gametype == "sd" )
    {
        urbanreleaselockdown();
        return;
    }

    level.dynamicspawns = ::urbandynamicspawns;
    level thread maps\mp\_dynamic_events::dynamicevent( ::event_start, ::event_reset );
    level thread urbanlevelstart();
}

event_start()
{
    thread maps\mp\mp_urban_aud::aud_lockdown_siren();
    level thread playannouncementreleasevo();
    wait 5;
    urbanreleaselockdown();
}

playannouncementreleasevo()
{
    wait 0.5;
    playsoundatpos( ( -142, 6, 2550 ), "mp_anr_urb_dyn_off_r" );
    wait 3;
    playsoundatpos( ( -142, 6, 2550 ), "mp_anr_urb_dyn_off_spn_r" );
}

playannouncementlockdownvo()
{
    if ( level.currentgen )
    {
        wait 8.0;
        playsoundatpos( ( -142, 6, 2550 ), "mp_anr_urb_dyn_on_r" );
        wait 2.0;
        playsoundatpos( ( -142, 6, 2550 ), "mp_anr_urb_dyn_on_spn_r" );
    }
    else
    {
        wait 0.5;
        playsoundatpos( ( -142, 6, 2550 ), "mp_anr_urb_dyn_on_r" );
        wait 3.0;
        playsoundatpos( ( -142, 6, 2550 ), "mp_anr_urb_dyn_on_spn_r" );
    }
}

event_reset()
{
    urbanlockdown();
}

urbanlevelstart()
{
    level endon( "urbanReleaseLockdown" );
    urbanblockerssolid();
    urbananimateopenloop();
    urbandoorsswingshut();

    while ( !isdefined( level.prematchperiod ) )
        waitframe();

    var_0 = 5;

    if ( level.prematchperiod > 0 )
    {
        if ( level.prematchperiodend > 0 && !isdefined( level.hostmigrationtimer ) )
        {
            if ( level.prematchperiodend == 5 )
                wait 2;
            else if ( level.prematchperiodend > 5 )
                wait 3.5;
        }
    }
    else
        var_0 = 2;

    thread maps\mp\mp_urban_aud::aud_lockdown_siren();
    level thread playannouncementlockdownvo();
    wait(var_0);
    urbanlockdown();
}

urbandoorssetup()
{
    var_0 = getent( "lockdown_doors", "targetname" );

    if ( isdefined( var_0 ) )
        var_0.lockdown = 1;

    var_0 = getentarray( "door_swing_left", "targetname" );

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
            var_2.open = 1;
    }

    var_0 = getentarray( "door_swing_right", "targetname" );

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
            var_2.open = 1;
    }
}

urbandoorsclose()
{
    var_0 = getent( "lockdown_doors", "targetname" );

    if ( !isdefined( var_0 ) || var_0.lockdown )
        return;

    var_0.lockdown = 0;
    var_0 _meth_82AE( var_0.startorg, 3, 1, 0.2 );
    wait 3.1;
    var_0 _meth_8057();
    urbandoorsswingshut();
}

urbandoorsswingshut()
{
    var_0 = getentarray( "door_swing_left", "targetname" );

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
        {
            if ( !var_2.open )
                continue;

            var_2 _meth_82B7( -90, 1.5, 0.5, 0.1 );
            var_2.open = 0;
        }
    }

    var_4 = getentarray( "door_swing_right", "targetname" );

    if ( isdefined( var_4 ) && var_4.size > 0 )
    {
        foreach ( var_2 in var_4 )
        {
            if ( !var_2.open )
                continue;

            var_2 _meth_82B7( 90, 1.5, 0.5, 0.1 );
            var_2.open = 0;
        }
    }
}

urbandoorsopen()
{
    var_0 = getent( "lockdown_doors", "targetname" );

    if ( !isdefined( var_0 ) || !var_0.lockdown )
        return;

    var_0.lockdown = 1;

    if ( !isdefined( var_0.startorg ) )
        var_0.startorg = var_0.origin;

    var_1 = var_0.startorg + ( 0, 0, -98 );
    var_0 _meth_82AE( var_1, 3, 1, 0.2 );
    wait 3.1;
    var_0 _meth_8057();
    urbandoorsswingopen();
}

urbandoorsswingopen()
{
    var_0 = getentarray( "door_swing_left", "targetname" );

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
        {
            if ( var_2.open )
                continue;

            var_2 _meth_82B7( 90, 1.5, 0.5, 0.1 );
            var_2.open = 1;
        }
    }

    var_4 = getentarray( "door_swing_right", "targetname" );

    if ( isdefined( var_4 ) && var_4.size > 0 )
    {
        foreach ( var_2 in var_4 )
        {
            if ( var_2.open )
                continue;

            var_2 _meth_82B7( -90, 1.5, 0.5, 0.1 );
            var_2.open = 1;
        }
    }
}

urbanlockdown()
{
    level notify( "urbanLockdown" );
    urbanblockerssolid();
    common_scripts\_exploder::activate_exploder( 50 );
    level thread urbandoorsclose();
    urbananimatelockdown();
}

urbanblockerssolid()
{
    var_0 = getent( "lockdown_blocker", "targetname" );
    var_0 show();
    var_0 _meth_8057();
    var_0 _meth_82BE();
    level.dynamicspawns = ::urbandynamicspawns;
}

urbanreleaselockdown()
{
    level notify( "urbanReleaseLockdown" );
    urbanblockersnonsolid();
    level thread urbandoorsopen();
    urbananimatereleaselockdown();
    common_scripts\_exploder::activate_exploder( 20 );
}

urbanblockersnonsolid()
{
    var_0 = getent( "lockdown_blocker", "targetname" );
    var_0 hide();
    var_0 _meth_8058();
    var_0 _meth_82BF();
    level.dynamicspawns = undefined;
}

urbandynamicspawns( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.script_noteworthy ) || var_3.script_noteworthy != "lockdown_spawn" )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

urbansetupshutters()
{
    level.urbanshutters = [];
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_side_bottom_right_01", "urban_front_bottom_shutter_1", "urban_front_bottom_shutter_close_1", "urban_front_bottom_shutter_loop_1" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_side_top_right_01", "urban_side_top_shutter_1", "urban_side_top_shutter_close_1", "urban_side_top_shutter_loop_1" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_side_top_right_02", "urban_side_top_shutter_1", "urban_side_top_shutter_close_1", "urban_side_top_shutter_loop_1" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_front_top_right_01", "urban_front_top_shutter_1", "urban_front_top_shutter_close_1", "urban_front_top_shutter_loop_1" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_front_top_right_02", "urban_front_top_shutter_2", "urban_front_top_shutter_close_2", "urban_front_top_shutter_loop_2" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_front_top_right_03", "urban_front_top_shutter_3", "urban_front_top_shutter_close_3", "urban_front_top_shutter_loop_3" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_front_top_right_04", "urban_front_top_shutter_4", "urban_front_top_shutter_close_4", "urban_front_top_shutter_loop_4" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_front_bottom_right_01", "urban_side_bottom_shutter_1", "urban_side_bottom_shutter_close_1", "urban_side_bottom_shutter_loop_1" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_side_bottom_left_01", "urban_front_bottom_shutter_1", "urban_front_bottom_shutter_close_1", "urban_front_bottom_shutter_loop_1" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_side_top_left_01", "urban_side_top_shutter_1", "urban_side_top_shutter_close_1", "urban_side_top_shutter_loop_1" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_side_top_left_02", "urban_side_top_shutter_1", "urban_side_top_shutter_close_1", "urban_side_top_shutter_loop_1" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_front_top_left_01", "urban_front_top_shutter_1", "urban_front_top_shutter_close_1", "urban_front_top_shutter_loop_1" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_front_top_left_02", "urban_front_top_shutter_2", "urban_front_top_shutter_close_2", "urban_front_top_shutter_loop_2" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_front_top_left_03", "urban_front_top_shutter_3", "urban_front_top_shutter_close_3", "urban_front_top_shutter_loop_3" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_front_top_left_04", "urban_front_top_shutter_4", "urban_front_top_shutter_close_4", "urban_front_top_shutter_loop_4" );
    level.urbanshutters[level.urbanshutters.size] = urbansetupshutter( "shutter_front_bottom_left_01", "urban_side_bottom_shutter_1", "urban_side_bottom_shutter_close_1", "urban_side_bottom_shutter_loop_1" );
}

urbansetupshutter( var_0, var_1, var_2, var_3 )
{
    var_4 = getent( var_0, "targetname" );
    var_5 = spawnstruct();
    var_5.name = var_0;
    var_5.closeanim = var_1;
    var_5.openanim = var_2;
    var_5.loopingopenanim = var_3;
    var_5.ent = var_4;
    return var_5;
}

urbananimateopenloop()
{
    foreach ( var_1 in level.urbanshutters )
    {
        if ( !isdefined( var_1.ent ) )
            continue;

        if ( var_1.closeanim != "" )
            var_1.ent _meth_827B( var_1.loopingopenanim );
    }
}

urbananimatelockdown()
{
    foreach ( var_1 in level.urbanshutters )
    {
        if ( !isdefined( var_1.ent ) )
            continue;

        var_1.ent _meth_827A();

        if ( var_1.closeanim == "" )
        {
            var_1.ent show();
            continue;
        }

        var_1.ent _meth_827B( var_1.closeanim );
    }
}

urbananimatereleaselockdown()
{
    foreach ( var_1 in level.urbanshutters )
    {
        if ( !isdefined( var_1.ent ) )
            continue;

        var_1.ent _meth_827A();

        if ( var_1.openanim == "" )
        {
            var_1.ent hide();
            continue;
        }

        var_1.ent _meth_827B( var_1.openanim );
    }
}

urbansetuphoverbike()
{
    var_0 = getentarray( "hoverbike", "targetname" );

    if ( !isdefined( var_0 ) || var_0.size == 0 )
        return;

    foreach ( var_2 in var_0 )
        var_2 _meth_8279( "urban_hoverbike_idle", "nothing" );
}

urbananimateriders()
{
    var_0 = 380;
    var_1 = 30;
    var_2 = var_0 / var_1;
    var_3 = 20000;
    var_4 = common_scripts\utility::getstruct( "urban_event_scripted_node", "targetname" );

    if ( !isdefined( var_4 ) )
        return;

    if ( !isdefined( var_4.angles ) )
        var_4.angles = ( 0, 0, 0 );

    var_5 = spawn( "script_model", ( 0, 0, 0 ) );
    var_5 _meth_80B1( "vehicle_urb_police_hoverbike_ai" );
    var_6 = spawn( "script_model", ( 0, 0, 0 ) );
    var_6 _meth_80B1( "vehicle_urb_police_hoverbike_ai" );
    var_7 = spawn( "script_model", ( 0, 0, 0 ) );
    var_7 _meth_80B1( "urb_hoverbike_rider" );
    var_8 = spawn( "script_model", ( 0, 0, 0 ) );
    var_8 _meth_80B1( "urb_hoverbike_rider" );
    var_5 _meth_8075( "jtbk_engine" );
    waitframe();
    var_7 _meth_8446( var_5, "tag_driver", ( 0, 0, 0 ), ( 0, 90, 0 ) );
    var_8 _meth_8446( var_6, "tag_driver", ( 0, 0, 0 ), ( 0, 90, 0 ) );
    wait 1;
    level thread urbancalculatebikeunitspersecond( var_5 );
    level thread urbancalculatebikeunitspersecond( var_6 );

    for (;;)
    {
        var_5 _meth_848B( "urban_hoverbike_racer_1", var_4.origin, var_4.angles );
        var_6 _meth_848B( "urban_hoverbike_racer_2", var_4.origin, var_4.angles );
        wait(var_2);
        var_9 = max( var_5.unitspersecond, var_6.unitspersecond );
        var_10 = var_3 / var_9 * 3;
        var_11 = urbanmovebikeforward( var_5, var_3, var_10 );
        var_12 = urbanmovebikeforward( var_6, var_3, var_10 );
        var_13 = max( var_11, var_12 );
        wait(var_13 + 0.1);
    }
}

urbanmovebikeforward( var_0, var_1, var_2 )
{
    var_0 _meth_827A();
    var_3 = anglestoforward( var_0.angles );
    var_4 = var_0.origin + var_3 * var_1;
    var_0 _meth_82AE( var_4, var_2, 1, 0 );
    return var_2;
}

urbancalculatebikeunitspersecond( var_0 )
{
    var_1 = 2;
    var_0.unitspersecond = 0;

    for (;;)
    {
        var_2 = var_0.origin;
        wait(var_1);
        var_3 = var_0.origin;
        var_0.unitspersecond = distance( var_2, var_3 ) / var_1;
    }
}

urbananimatedrones()
{
    var_0 = common_scripts\utility::getstruct( "urban_event_scripted_node", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0.angles ) )
        var_0.angles = ( 0, 0, 0 );

    level thread urbanspawnautoloopingdrone( var_0, "urban_drone_patrol_1" );
    level thread urbanspawnmanualloopingdrone( var_0, "urban_drone_patrol_2" );
    level thread urbanspawnmanualloopingdrone( var_0, "urban_drone_patrol_3" );
}

urbanspawnautoloopingdrone( var_0, var_1 )
{
    var_2 = spawn( "script_model", ( 0, 0, 0 ) );
    var_2 _meth_80B1( "vehicle_urb_police_drone_01_group_anim" );
    wait 1;
    var_2 _meth_8075( "drone_group_flyby" );
    var_2 _meth_848B( var_1, var_0.origin, var_0.angles );
}

urbanspawnmanualloopingdrone( var_0, var_1 )
{
    var_2 = 1000;
    var_3 = 30;
    var_4 = var_2 / var_3;
    var_5 = spawn( "script_model", ( 0, 0, 0 ) );
    var_5 _meth_80B1( "vehicle_urb_police_drone_01_group_anim" );
    wait 1;
    var_5 _meth_8075( "drone_group_flyby" );

    for (;;)
    {
        var_5 _meth_848B( var_1, var_0.origin, var_0.angles );
        wait(var_4);
        wait(randomintrange( 0, 10 ));
    }
}

setuppolicelights()
{
    if ( getdvarint( "r_reflectionProbeGenerate" ) )
        return;

    var_0 = _func_231( "police_light", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( 0, 1 );
}

urbanruneffectsfloor()
{
    var_0 = getent( "urban_fx_floor", "targetname" );
    level.urbflooreffectsents = getentarray( "urban_fx_step", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( level.players ) )
    {
        foreach ( var_2 in level.players )
        {
            var_2 playerassigneffectsent();
            var_2 thread playerruneffectsfloor( var_0 );
        }
    }

    level thread onplayerconnectedeffectsfloor( var_0 );
}

onplayerconnectedeffectsfloor( var_0 )
{
    for (;;)
    {
        level waittill( "connected", var_1 );
        var_1 playerassigneffectsent();
        var_1 thread playerruneffectsfloor( var_0 );
    }
}

playerassigneffectsent()
{
    foreach ( var_1 in level.urbflooreffectsents )
    {
        if ( !isdefined( var_1.assigned ) )
        {
            var_1.assigned = self;
            var_1.angles = ( -90, 0, 0 );
            self.urbflooreffectsent = var_1;
            return;
        }
    }

    var_1 = spawn( "script_model", ( 0, 0, 0 ) );
    var_1 _meth_80B1( "tag_origin" );
    var_1.angles = ( -90, 0, 0 );
    level.urbflooreffectsents[level.urbflooreffectsents.size] = var_1;
    var_1.assigned = self;
    self.urbflooreffectsent = var_1;
}

playerruneffectsfloor( var_0 )
{
    self endon( "disconnect" );
    var_1 = 0.5;
    var_2 = 1;
    var_3 = 1;

    for (;;)
    {
        var_2 = var_3;

        if ( !isalive( self ) )
        {
            var_3 = 0;
            waitframe();
            continue;
        }

        var_3 = self _meth_8341();

        if ( !var_3 )
        {
            waitframe();
            continue;
        }

        var_4 = length( self getvelocity() );

        if ( var_4 == 0 && var_2 && var_3 )
        {
            waitframe();
            continue;
        }

        var_5 = self _meth_80A9( var_0 );

        if ( !var_5 )
        {
            waitframe();
            continue;
        }

        self.urbflooreffectsent _meth_8092();
        self.urbflooreffectsent.origin = ( self.origin[0], self.origin[1], 2043.5 );
        self.urbflooreffectsent.angles = ( -90, self.angles[1], 0 );
        playfxontag( common_scripts\utility::getfx( "mp_ub_foot_digital" ), self.urbflooreffectsent, "tag_origin" );
        wait(var_1);
    }
}

urbanpatchwarbird()
{
    level.warbirdaiattackbasespeed = 20;
    level.warbirdaiattackneargoal = 300;
    maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( 147, 1524, 4400 ), ( 467, 1524, 4400 ) );
    maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( 129, -11, 4372 ), ( 449, -11, 4372 ) );
    maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( 772, 1692, 4400 ), ( 1028, 1692, 4400 ) );
    maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( 1252, 1156, 4404 ), ( 1508, 1156, 4404 ) );
    maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( 1424, -1368, 4360 ), ( 1508, -1368, 4360 ) );
    maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( 428, -1992, 4400 ), ( 748, -1992, 4400 ) );
    maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( 148, -1556, 4392 ), ( 468, -1556, 4392 ) );
    maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( 544.5, -1392, 4384 ), ( 864.5, -1392, 4384 ) );
}

urbanpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -354, -1280, 2688 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -354, -1024, 2688 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -354, -768, 2688 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -354, 768, 2688 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -354, 1024, 2688 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -354, 1280, 2688 ), ( 0, 0, 0 ) );
}

urbanshiftbombdefusetrigger()
{
    if ( level.gametype != "sd" && level.gametype != "sr" )
        return;

    var_0 = getentarray( "bombzone", "targetname" );
    var_1 = var_0[0];

    if ( var_0[1].origin[0] < 0 )
        var_1 = var_0[1];

    var_2 = getentarray( var_1.target, "targetname" );
    var_3 = getent( var_2[0].target, "targetname" );

    for (;;)
    {
        level waittill( "bomb_planted", var_4 );

        if ( isdefined( var_4 ) && isdefined( var_4.bombdefusetrig ) && var_4.bombdefusetrig == var_3 && var_3.origin[0] < -555 )
            var_3.origin = ( -555, var_3.origin[1], var_3.origin[2] );
    }
}
