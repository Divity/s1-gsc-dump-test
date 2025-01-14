// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::spark_callbackstartgametype;
    maps\mp\mp_spark_precache::main();
    maps\createart\mp_spark_art::main();
    maps\mp\mp_spark_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_spark_lighting::main();
    maps\mp\mp_spark_aud::main();
    level.mapcustomkillstreakfunc = ::customkillstreakfunc;
    maps\mp\_compass::setupminimap( "compass_map_mp_spark" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level thread animatefusioncore();
    level thread animateassemblyarms();
    level thread animaterobotline();
    level thread animatehangingexos();
    level thread fixcarepackagelinkingtofans();

    if ( level.nextgen )
    {
        level thread vistadroppods();
        level thread spinfans();

        if ( level.gametype == "ball" )
            level thread uplinkballvisionset();
    }

    level.missileitemclipdelay = 0;
    level thread patchclip();
}

spark_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

customkillstreakfunc()
{
    maps\mp\killstreaks\streak_mp_spark::init();
}

animatefusioncore()
{
    var_0 = [ "fusion_core_spin" ];
    var_1 = [ "fusion_core_spin" ];
    var_2 = getent( "fusion_core", "targetname" );

    if ( isdefined( var_2 ) )
        maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename( var_2, "mp_spark_fusion_core_spin", "aud_fusion_core_notify", var_0, var_1, "fusionCore_end_01", "fusionCore_end_02", "fusionCore_end_03" );
}

animateassemblyarms()
{
    var_0 = common_scripts\utility::getstruct( "robot_anim_node", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0.angles ) )
        var_0.angles = ( 0, 0, 0 );

    var_1 = getentarray( "lab_assembly_robot_arm_02_scaled_anim", "targetname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        var_1[var_2] _meth_848B( "mp_spark_assembly_arm_0" + ( var_2 + 1 ), var_0.origin, var_0.angles, "nothing" );

    var_3 = getentarray( "spk_exolab_track_exo_hanger2", "targetname" );

    for ( var_2 = 0; var_2 < var_3.size; var_2++ )
        var_3[var_2] _meth_848B( "mp_spark_assembly_exo_0" + ( var_2 + 1 ), var_0.origin, var_0.angles, "nothing" );
}

animaterobotline()
{
    var_0 = common_scripts\utility::getstruct( "assembly_line_node", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0.angles ) )
        var_0.angles = ( 0, 0, 0 );

    var_1 = getentarray( "spk_exolab_track_robot_hanger", "targetname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        var_1[var_2] _meth_848B( "mp_spark_robot_line_0" + ( var_2 + 1 ), var_0.origin, var_0.angles, "nothing" );
}

animatehangingexos()
{
    var_0 = common_scripts\utility::getstruct( "assembly_line_node", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0.angles ) )
        var_0.angles = ( 0, 0, 0 );

    var_1 = getentarray( "spk_exolab_track_exo_hanger", "targetname" );

    if ( var_1.size < 3 )
        return;

    var_1[0] _meth_848B( "mp_spark_exo_line_01", var_0.origin, var_0.angles, "nothing" );
    var_1[1] _meth_848B( "mp_spark_exo_line_03", var_0.origin, var_0.angles, "nothing" );
    var_1[2] _meth_848B( "mp_spark_exo_line_05", var_0.origin, var_0.angles, "nothing" );
    var_1 = getentarray( "spk_exolab_track_hanger", "targetname" );

    if ( var_1.size < 2 )
        return;

    var_1[0] _meth_848B( "mp_spark_exo_line_02", var_0.origin, var_0.angles, "nothing" );
    var_1[1] _meth_848B( "mp_spark_exo_line_04", var_0.origin, var_0.angles, "nothing" );
}

vistadroppods()
{
    var_0 = 24000;
    var_1 = 1;
    var_2 = 4;
    var_3 = 15;
    level.sparkdroppods = getentarray( "vistaMissilePods", "targetname" );
    level.sparkdroplocations = common_scripts\utility::getstructarray( "vistaMissileSpawn", "targetname" );
    level.sparkdroplocationindex = 0;

    if ( level.sparkdroplocations.size == 0 )
        return;

    if ( level.sparkdroppods.size == 0 )
    {
        for ( var_4 = 0; var_4 < 4; var_4++ )
        {
            var_5 = spawn( "script_model", ( 0, 0, -10000 ) );
            var_5 _meth_80B1( "spk_vehicle_mil_drop_pod" );
            level.sparkdroppods[level.sparkdroppods.size] = var_5;
        }
    }

    foreach ( var_7 in level.sparkdroplocations )
    {
        var_8 = common_scripts\utility::getstruct( var_7.target, "targetname" );
        var_7.end = var_8.origin;
        var_9 = vectornormalize( var_7.origin - var_8.origin );
        var_7.start = var_8.origin + var_9 * var_0;
        var_7.startangles = vectortoangles( var_9 ) + ( 270, 0, 0 );
    }

    wait 1;
    level.sparkdroplocations = common_scripts\utility::array_randomize( level.sparkdroplocations );

    for ( var_4 = 0; var_4 < level.sparkdroppods.size; var_4++ )
    {
        var_11 = level.sparkdroppods[var_4];
        level thread firepod( var_11 );
        var_12 = randomfloatrange( var_1, var_2 );
        wait(var_12);
    }

    for (;;)
    {
        level waittill( "podComplete", var_11 );
        var_13 = var_3 + var_1;
        var_14 = var_3 + var_2;
        var_12 = randomfloatrange( var_13, var_14 );
        level thread firepod( var_11, var_12 );
    }
}

firepod( var_0, var_1 )
{
    var_2 = 8;

    if ( isdefined( var_1 ) )
        wait(var_1);

    playfxontag( common_scripts\utility::getfx( "mp_spark_drop_pod" ), var_0, "tag_fx" );
    var_0 _meth_8075( "incoming_ambient_pods_lp" );

    if ( level.sparkdroplocationindex >= level.sparkdroplocations.size )
    {
        level.sparkdroplocations = common_scripts\utility::array_randomize( level.sparkdroplocations );
        level.sparkdroplocationindex = 0;
    }

    var_3 = level.sparkdroplocations[level.sparkdroplocationindex];
    level.sparkdroplocationindex++;
    var_0 _meth_8092();
    var_0.origin = var_3.start;
    var_0.angles = var_3.startangles;
    var_0 _meth_82AE( var_3.end, var_2, var_2, 0 );
    wait(var_2);
    killfxontag( common_scripts\utility::getfx( "mp_spark_drop_pod" ), var_0, "tag_fx" );
    var_0 _meth_80AB();
    playfx( common_scripts\utility::getfx( "mp_spark_drop_pod_impact" ), var_3.end );
    level notify( "podComplete", var_0 );
}

spinfans()
{
    var_0 = getentarray( "spk_wall_fan_blade_rotate_fast_01", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread fan1spin();
}

fan1spin()
{
    if ( !isdefined( self ) )
        return;

    var_0 = 500;
    var_1 = 20000;

    for (;;)
    {
        self _meth_82BD( ( var_0, 0, 0 ), var_1 );
        wait(var_1);
    }
}

fixcarepackagelinkingtofans()
{
    common_scripts\utility::array_thread( getentarray( "com_wall_fan_blade_rotate_slow", "targetname" ), ::fannocontents );
    common_scripts\utility::array_thread( getentarray( "com_wall_fan_blade_rotate", "targetname" ), ::fannocontents );
    common_scripts\utility::array_thread( getentarray( "com_wall_fan_blade_rotate_fast", "targetname" ), ::fannocontents );
    common_scripts\utility::array_thread( getentarray( "spk_wall_fan_blade_rotate_fast_01", "targetname" ), ::fannocontents );
}

fannocontents()
{
    self setcontents( 0 );
}

uplinkballvisionset()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread playerhandleuplinkvisionset();
    }
}

playerhandleuplinkvisionset()
{
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = self _meth_8312();

        if ( isdefined( var_0 ) )
        {
            if ( issubstr( var_0, "iw5_carrydrone" ) )
            {
                self _meth_847A( "mp_spark_uplink_inview", 0.3 );
                self _meth_83C1( "mp_spark_uplink_inview", 0.3 );
            }
            else
            {
                self _meth_847A( "", 0.5 );
                self _meth_83C2( 0.5 );
            }
        }

        waitframe();
    }
}

patchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( -63, 165, 896 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( 212, 129, 896 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( 493, 125, 896 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( 819, 216, 896 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( 819, 1082, 896 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( 496, 1170, 896 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( 209, 1168, 896 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( -57, 1128, 896 ), ( 90, 0, 0 ) );
}
