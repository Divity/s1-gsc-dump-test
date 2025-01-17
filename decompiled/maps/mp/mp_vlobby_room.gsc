// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precachemodel( "archery_target_fr" );
    precachemodel( "bc_target_dummy_base" );
    precachemodel( "training_target_opfor1" );
    precachemodel( "training_target_civ1" );
    precacheshader( "ac130_overlay_pip_vignette_vlobby" );
    precacheshader( "ac130_overlay_pip_vignette_vlobby_cao" );
    maps\mp\mp_vlobby_room_precache::main();
    maps\createart\mp_vlobby_room_art::main();
    maps\mp\mp_vlobby_room_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_vlobby_room_lighting::main();
    maps\mp\mp_vlobby_room_aud::main();
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.vl_dof_based_on_focus = ::vl_dof_based_on_focus;
    level.vl_handle_mode_change = ::vl_handle_mode_change;
    level.vl_lighting_setup = ::vl_lighting_setup;
    thread vl_ground_setup();
    maps\mp\_vl_base::vl_init();
    level.dof_tuner = spawnstruct();
    level.dof_tuner.fstopperunit = 0.25;
    level.dof_tuner.scaler = -0.3;
    level.dof_tuner.fstopbase = 3;
    thread fade_from_black();
}

fade_from_black()
{
    level waittill( "connected", var_0 );
    var_0 waittill( "fade_in" );
    var_0 _meth_84D7( "mp_no_foley", 1 );
}

vl_ground_setup()
{
    var_0 = getent( "teleport_from", "targetname" );
    var_1 = getent( "teleport_to", "targetname" );
    var_2 = getentarray( "vlobby_floor_b", "targetname" );

    foreach ( var_4 in var_2 )
        var_4.origin += var_1.origin - var_0.origin;

    var_6 = getentarray( "vlobby_floor_a", "targetname" );

    foreach ( var_8 in var_6 )
        var_8 hide();
}

vl_lighting_setup()
{
    var_0 = self;
    var_0 _meth_84A9();

    if ( level.nextgen )
        var_0 _meth_84AB( 0.613159, 89.8318, level.camparams.dof_time, level.camparams.dof_time * 2 );
    else
        var_0 _meth_84AB( 4.01284, 95.2875, level.camparams.dof_time, level.camparams.dof_time * 2 );
}

vl_dof_based_on_focus( var_0 )
{
    var_1 = level.camparams.dof_time;
    var_2 = self;
    var_3 = var_0;
    var_2 = self;
    var_4 = level.dof_tuner.fstopperunit;
    var_5 = level.dof_tuner.scaler;
    var_6 = level.dof_tuner.fstopbase;

    if ( level.currentgen )
        var_6 += 2;

    var_7 = 104;
    var_8 = ( var_7 - var_3 ) * var_4;
    var_9 = var_6 + var_8 + var_8 * var_5;

    if ( var_9 < 0.125 )
        var_9 = 0.125;
    else if ( var_9 > 128 )
        var_9 = 128;

    var_2 _meth_84AB( var_9, var_3, var_1, var_1 * 2 );
}

vl_handle_mode_change( var_0, var_1, var_2 )
{
    var_3 = self;

    if ( var_0 == "cac" )
        var_3 setdefaultpostfx();
    else if ( var_0 == "cao" )
    {

    }

    if ( var_1 == "cac" )
    {
        var_3 _meth_82D4( "mp_vlobby_room_cac", 0 );
        var_3 _meth_83C0( "mp_vl_create_a_class" );
    }
    else if ( var_1 == "cao" )
    {
        if ( level.nextgen )
            var_3 _meth_84AB( 1.223, 156.419, level.camparams.dof_time, level.camparams.dof_time );
        else
            var_3 _meth_84AB( 3.223, 156.419, level.camparams.dof_time, level.camparams.dof_time );
    }
    else if ( var_1 == "clanprofile" )
    {
        var_3 setdefaultpostfx();
        var_3 maps\mp\_vl_camera::set_avatar_dof();
    }
    else if ( var_1 == "prelobby" )
    {
        var_3 setdefaultdof();
        var_3 setdefaultpostfx();
    }
    else
    {
        if ( var_0 == "prelobby_members" )
            return;

        if ( var_0 == "prelobby_loadout" )
            return;

        if ( var_0 == "prelobby_loot" )
            return;

        if ( var_1 == "game_lobby" )
        {
            var_3 setdefaultpostfx();
            var_3 maps\mp\_vl_camera::set_avatar_dof();
        }
        else
        {
            if ( var_0 == "startmenu" )
                return;

            if ( var_0 == "transition" )
                return;

            if ( var_1 == "clanprofile" )
            {
                var_3 setdefaultdof();
                var_3 setdefaultpostfx();
            }
            else
            {
                return;
                return;
                return;
                return;
            }
        }
    }
}

setdefaultpostfx()
{
    var_0 = self;
    var_0 _meth_82D4( "mp_vlobby_room", 0 );
    var_0 _meth_83C0( "mp_vlobby_room" );
}

setdefaultdof()
{
    var_0 = self;

    if ( level.nextgen )
        var_0 _meth_84AB( 0.613159, 89.8318, level.camparams.dof_time, level.camparams.dof_time );
    else
        var_0 _meth_84AB( 4.01284, 95.2875, level.camparams.dof_time, level.camparams.dof_time );
}
