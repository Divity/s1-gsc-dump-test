// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precache_boost_fx_npc()
{
    level._effect["boost_dust_npc"] = loadfx( "vfx/smoke/jetpack_exhaust_npc" );
    level._effect["boost_dust_impact_ground"] = loadfx( "vfx/smoke/jetpack_ground_impact_runner" );
}

#using_animtree("generic_human");

rocket_jump_human( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3["traverseAnim"] = var_0;
    var_3["traverseNotetrackFunc"] = ::newhandletraversenotetracks;

    if ( isdefined( var_2 ) && var_2 == "landassist" )
        var_3["traverseNotetrackFunc"] = ::newhandletraversenotetracks_landassist;

    self.is_using_boost = 1;
    animscripts\traverse\shared::dotraverse( var_3 );

    if ( isdefined( self ) && isalive( self ) && isdefined( var_1 ) && var_1 )
    {
        soundscripts\_snd::snd_message( "boost_land_npc" );
        self _meth_8110( "boostJumpLand", %boost_jump_land_2_run_b, %body, 1, 0.2, 1 );
        animscripts\shared::donotetracks( "boostJumpLand", ::newhandletraversenotetracks );
    }

    self.is_using_boost = undefined;
}

newhandletraversenotetracks_landassist( var_0 )
{
    switch ( var_0 )
    {
        case "boost_begin":
            break;
        case "land_assist":
            thread land_assist_thrusters( self );
            break;
        case "assist_thrusters":
            thread land_assist_thrusters( self );
            break;
        case "boost_end":
            break;
        case "distort_begin":
            break;
        default:
            animscripts\traverse\shared::handletraversenotetracks( var_0 );
            break;
    }
}

newhandletraversenotetracks( var_0 )
{
    switch ( var_0 )
    {
        case "boost_begin":
            thread newhandleboostbegin();
            break;
        case "boost_end":
            thread newhandleboostend();
            break;
        default:
            animscripts\traverse\shared::handletraversenotetracks( var_0 );
            break;
    }
}

newhandleboostbegin()
{
    soundscripts\_snd::snd_message( "boost_jump_npc" );

    if ( !maps\_utility::ent_flag_exist( "boost_end" ) )
        maps\_utility::ent_flag_init( "boost_end" );

    thread newhandlespawngroundimpact();
    playfxontag( common_scripts\utility::getfx( "boost_dust_npc" ), self, "J_SpineLower" );
    maps\_utility::ent_flag_wait( "boost_end" );
    stopfxontag( common_scripts\utility::getfx( "boost_dust_npc" ), self, "J_SpineLower" );
    maps\_utility::ent_flag_clear( "boost_end" );
}

newhandleboostend()
{
    maps\_utility::ent_flag_set( "boost_end" );
}

newhandlespawngroundimpact()
{
    var_0 = self.origin + ( 0, 0, 64 );
    var_1 = self.origin - ( 0, 0, 150 );
    var_2 = bullettrace( var_0, var_1, 0, undefined );
    var_3 = common_scripts\utility::getfx( "boost_dust_impact_ground" );
    var_0 = var_2["position"];
    var_4 = vectortoangles( var_2["normal"] );
    var_4 += ( 90, 0, 0 );
    var_5 = anglestoforward( var_4 );
    var_6 = anglestoup( var_4 );
    playfx( var_3, var_0, var_6, var_5 );
}

land_assist_thrusters( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "landass_exhaust_smk_lf_npc" ), var_0, "J_MainRoot" );
    playfxontag( common_scripts\utility::getfx( "landass_exhaust_smk_rt_npc" ), var_0, "J_MainRoot" );
    var_0 soundscripts\_snd::snd_message( "boost_land_assist_npc" );
}

land_assist_thrusters_with_land( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "landass_exhaust_smk_lf_npc" ), var_0, "J_MainRoot" );
    playfxontag( common_scripts\utility::getfx( "landass_exhaust_smk_rt_npc" ), var_0, "J_MainRoot" );
    var_0 soundscripts\_snd::snd_message( "boost_land_assist_npc" );
    wait 0.05;
    var_1 = physicstrace( var_0.origin, var_0.origin + ( 0, 0, -5120 ) );
    var_2 = anglestoforward( var_0.angles );
    playfx( common_scripts\utility::getfx( "landass_impact_smk_rnr" ), var_1, var_2 );
    wait 0.35;
    var_1 = physicstrace( var_0.origin, var_0.origin + ( 0, 0, -5120 ) );
    playfx( common_scripts\utility::getfx( "landass_impact_smk_rnr" ), var_1, var_2 );
    var_0 soundscripts\_snd::snd_message( "boost_land_assist_npc_ground" );
}

handletraversenotetrackslandassist( var_0 )
{
    if ( var_0 == "assist_thrusters" )
        land_assist_thrusters( self );
    else if ( var_0 == "assist_thrusters_2" )
        land_assist_thrusters( self );
    else if ( var_0 == "fx_start" )
        land_assist_thrusters( self );
    else
        animscripts\traverse\shared::handletraversenotetracks( var_0 );
}
