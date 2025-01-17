// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_instinct_precache::main();
    maps\createart\mp_instinct_art::main();
    maps\mp\mp_instinct_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_instinct_lighting::main();
    maps\mp\mp_instinct_aud::main();
    level.ospvisionset = "mp_instinct_osp";
    level.osplightset = "mp_instinct_osp";
    level.warbirdvisionset = "mp_instinct_osp";
    maps\mp\_compass::setupminimap( "compass_map_mp_instinct" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.aerial_pathnode_offset = 350;
    level.orbitalsupportoverridefunc = ::instinctcustomospfunc;
    precachemodel( "ins_crane_drilling_mechanism" );
    precachemodel( "ins_cave_drill" );
    precachemodel( "ins_generator_engine_01_fan" );
    level.river_drills = getentarray( "river_drill", "targetname" );
    level.cave_drills = getentarray( "cave_drill", "targetname" );
    level.cave_drills_inside = getentarray( "cave_drill_inside", "targetname" );
    level thread drilling_animation();
    level thread generator_fans();
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
    thread scriptpatchclip();
    setdvar( "r_reactivemotionfrequencyscale", 0.5 );
    setdvar( "r_reactivemotionamplitudescale", 0.5 );
}

scriptpatchclip()
{
    thread treepatchclip();
    thread rockpillarpatchclip();
    thread rocklumppatchclip();
}

rocklumppatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 102, -933, 1093 ), ( 0, 326.6, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 102, -933, 1349 ), ( 0, 326.6, 0 ) );
}

treepatchclip()
{
    var_0 = ( 0, 348, 0 );
    var_1 = ( 1314, 60, 616 );
    var_2 = 0;

    for ( var_3 = 0; var_3 < 16; var_3++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", var_1 + ( 0, 0, var_2 ), var_0 );
        var_2 += 64;
    }
}

rockpillarpatchclip()
{
    stackclip( ( 0, 10, 0 ), ( 264, -1428, 1092 ), 256, "patchclip_player_16_256_256", 3 );
    stackclip( ( 0, 330, 0 ), ( 64, -1396, 1092 ), 256, "patchclip_player_16_256_256", 3 );
    stackclip( ( 0, 80, 0 ), ( 184, -1300, 1028 ), 128, "patchclip_player_16_128_128", 6 );
}

stackclip( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 0;

    for ( var_6 = 0; var_6 < var_4; var_6++ )
    {
        maps\mp\_utility::spawnpatchclip( var_3, var_1 + ( 0, 0, var_5 ), var_0 );
        var_5 += var_2;
    }
}

instinctcustomospfunc()
{
    level.orbitalsupportoverrides.spawnheight = 9615;
    level.orbitalsupportoverrides.toparc = -35;
    level.orbitalsupportoverrides.rightarc = 18;
    level.orbitalsupportoverrides.leftarc = 18;
}

set_lighting_values()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 _meth_82FD( "r_tonemap", "2", "r_tonemapLockAutoExposureAdjust", "0", "r_tonemapAutoExposureAdjust", "0" );
        }
    }
}

river_drilling_animation()
{
    level endon( "game_ended" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_3 = common_scripts\utility::spawn_tag_origin();
    wait 0.05;
    var_0 show();
    var_1 show();
    var_2 show();
    var_3 show();
    wait 0.4;
    var_0 _meth_804D( self, "poundee", ( 75, 0, 400 ), ( 0, 0, 0 ) );
    var_1 _meth_804D( self, "poundee", ( 75, 0, 400 ), ( 90, 0, 90 ) );
    var_2 _meth_804D( self, "tag_origin", ( 0, 0, 100 ), ( 0, 0, 0 ) );
    var_3 _meth_804D( self, "tag_origin", ( 0, 0, -100 ), ( 270, 180, 90 ) );
    common_scripts\utility::noself_delaycall( 1, ::playfxontag, common_scripts\utility::getfx( "diesel_drill_smk_loop" ), var_0, "tag_origin" );
    wait 0.1;

    for (;;)
    {
        earthquake( 0.15, 1, var_2.origin, 500 );
        common_scripts\utility::noself_delaycall( 0.4, ::playfxontag, common_scripts\utility::getfx( "drill_impact_dust" ), var_3, "tag_origin" );
        wait 2;
        common_scripts\utility::noself_delaycall( 0.4, ::playfxontag, common_scripts\utility::getfx( "diesel_drill_smk_ring" ), var_1, "tag_origin" );
    }
}

drilling_animation()
{
    level endon( "end_drill_anims" );
    wait 1;
    animate_drills();
}

animate_drills()
{
    if ( isdefined( level.river_drills ) )
        common_scripts\utility::array_thread( level.river_drills, ::update_river_drill_anim );

    if ( isdefined( level.cave_drills ) )
        common_scripts\utility::array_thread( level.cave_drills, ::update_cave_drill_anim );

    if ( isdefined( level.cave_drills_inside ) )
        common_scripts\utility::array_thread( level.cave_drills_inside, ::update_cave_drill_anim_inside );
}

update_river_drill_anim()
{
    level endon( "end_drill_anims" );
    var_0 = randomfloat( 2 );
    wait 0.05;
    wait(var_0);
    maps\mp\_audio::scriptmodelplayanimwithnotify( self, "ins_drilling_machine", "ps_ins_piledriver_hit", "ins_piledriver_hit", "end_drill_anims", "stop_sequencing_notetracks", "lagos_dyn_event" );
    thread river_drilling_animation();
}

update_cave_drill_anim()
{
    var_0 = randomfloat( 2 );
    wait 0.05;
    wait(var_0);
    maps\mp\_audio::scriptmodelplayanimwithnotify( self, "ins_cave_drill_idle", "ins_piledriver_cave_hit", "ins_piledriver_cave_hit", "end_drill_anims", "stop_sequencing_notetracks", "lagos_dyn_event" );

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "impact_fx" )
    {
        wait 0.5;
        thread maps\mp\mp_instinct_fx::cave_drill_rock_impact_fx();
    }
}

update_cave_drill_anim_inside()
{
    level endon( "end_drill_anims" );
    var_0 = randomfloat( 2 );
    wait(var_0);
    maps\mp\_audio::scriptmodelplayanimwithnotify( self, "ins_cave_drill_idle", "ins_piledriver_cave_hit", "ins_piledriver_cave_hit", "end_drill_anims", "stop_sequencing_notetracks", "lagos_dyn_event" );
}

generator_fans()
{
    var_0 = getentarray( "generator_fans", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_8279( "ins_generator_fan" );
}
