// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakwieldweapons["detroit_tram_turret_mp"] = "mp_detroit";
    level.killstreakfuncs["mp_detroit"] = ::tryusekillstreak;
    level.mapkillstreak = "mp_detroit";
    level.mapkillstreakpickupstring = &"MP_DETROIT_MAP_KILLSTREAK_PICKUP";
    level.getaerialkillstreakarray = ::tramlockonentsforteam;
    level.streak_trams = getentarray( "streak_tram", "targetname" );
    common_scripts\utility::array_thread( level.streak_trams, maps\mp\mp_detroit_events::tram_init );
    common_scripts\utility::array_thread( level.streak_trams, ::tram_killstreak_init );
    level.detroittramobjids = [];
    var_0 = [ "allies", "axis" ];

    foreach ( var_2 in var_0 )
    {
        level.detroittramobjids[var_2] = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( level.detroittramobjids[var_2], "invisible", ( 0, 0, 0 ) );
        objective_icon( level.detroittramobjids[var_2], common_scripts\utility::ter_op( var_2 == "allies", "compass_objpoint_tram_turret_friendly", "compass_objpoint_tram_turret_enemy" ) );
    }
}

setupbotsformapkillstreak()
{
    level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func( "mp_detroit", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

tram_killstreak_init()
{
    self.getstingertargetposfunc = ::tram_stinger_target_pos;
}

tram_stinger_target_pos()
{
    return self gettagorigin( "tag_turret" );
}

tramlockonentsforteam( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.streak_trams )
    {
        if ( var_3.active && isdefined( var_3.owner ) && ( !level.teambased || var_3.owner.team == var_0 ) )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

tryusekillstreak( var_0, var_1 )
{
    if ( level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iclientprintlnbold( &"MP_TOO_MANY_VEHICLES" );
        return 0;
    }

    var_2 = 0;

    foreach ( var_4 in level.streak_trams )
    {
        if ( var_4.active )
        {
            var_2 = 1;
            break;
        }
        else
            var_4 maps\mp\mp_detroit_events::tram_reset();
    }

    var_6 = undefined;

    if ( !var_2 )
    {
        level.streak_trams = sortbydistance( level.streak_trams, self.origin );
        var_6 = level.streak_trams[0];
    }

    if ( isdefined( var_6 ) )
    {
        var_7 = maps\mp\killstreaks\_killstreaks::initridekillstreak( "mp_detroit_tram" );

        if ( var_7 != "success" )
            return 0;

        maps\mp\_utility::incrementfauxvehiclecount();
        thread run_tram_killstreak( var_6 );
        return 1;
    }
    else
    {
        self iclientprintlnbold( &"MP_DETROIT_MAP_KILLSTREAK_NOT_AVAILABLE" );
        return 0;
    }
}

run_tram_killstreak( var_0 )
{
    var_1 = 35;
    var_0 maps\mp\mp_detroit_events::tram_reset();
    var_0.owner = self;
    var_0.team = self.team;
    var_0.turret = var_0 spawn_tram_turret();
    var_0.isleaving = 0;
    var_0.stopdamagefunc = 0;
    var_0 tram_show_icon();
    var_0 thread maps\mp\gametypes\_damage::setentitydamagecallback( 1000, undefined, ::tramondeath, undefined, 1 );
    self _meth_82DD( "CancelTramStart", "+usereload" );
    self _meth_82DD( "CancelTramEnd", "-usereload" );
    maps\mp\_utility::setusingremote( "mp_detroit_tram" );
    self _meth_80E8( var_0.turret, 30, var_0.angles[1] - 90 );
    var_0 thread tram_update_shooting_location();
    var_0 common_scripts\utility::make_entity_sentient_mp( var_0.team );
    self _meth_807E( var_0, "tag_player", 0, 180, 180, 0, 90, 0 );
    self _meth_80A0( 0 );
    self thermalvisionfofoverlayon();
    self _meth_82FB( "ui_detroit_tram_turret", 1 );
    var_0 thread tram_killstreak_team_change_watch();
    var_0 thread tram_killstreak_cancel_watch();
    var_0 thread tram_killstreak_exit_watch();
    var_0 thread tram_killstreak_move( var_1 );
    var_0 thread tram_killstreak_match_ended();
    var_0 thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
}

tram_update_shooting_location()
{
    var_0 = self.owner;
    self endon( "player_exit" );
    var_0 endon( "disconnect" );
    self.turret endon( "death" );
    self.target_ent = spawn( "script_model", ( 0, 0, 0 ) );
    self.target_ent _meth_80B1( "tag_origin" );
    self.turret _meth_8508( self.target_ent );

    for (;;)
    {
        var_1 = self.turret gettagorigin( "tag_player" );
        var_2 = self.turret gettagorigin( "tag_player" ) + anglestoforward( self.turret gettagangles( "tag_player" ) ) * 20000;
        var_3 = bullettrace( var_1, var_2, 0, self.turret );
        var_4 = var_3["position"];
        self.target_ent.origin = var_4;
        waitframe();
    }
}

tram_killstreak_match_ended()
{
    self endon( "player_exit" );
    level waittill( "game_ended" );
    self notify( "player_exit" );
}

tram_show_icon()
{
    foreach ( var_2, var_1 in level.detroittramobjids )
    {
        objective_state( var_1, "active" );

        if ( var_2 == "allies" )
            objective_playerteam( var_1, self.owner _meth_81B1() );
        else
            objective_playerenemyteam( var_1, self.owner _meth_81B1() );

        objective_onentitywithrotation( var_1, self.turret.obj_ent );
    }
}

tram_hide_icon()
{
    foreach ( var_2, var_1 in level.detroittramobjids )
        objective_state( var_1, "invisible" );
}

tramondeath( var_0, var_1, var_2, var_3 )
{
    self notify( "player_exit" );
    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "map_killstreak_destroyed", undefined, "callout_destroyed_tram_turet", 1 );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "vehicle_pdrone_explosion" ), self, "tag_turret" );

    if ( isdefined( self.turret ) )
        self.turret delete();

    if ( isdefined( self.target_ent ) )
        self.target_ent delete();
}

tram_killstreak_cancel_watch()
{
    var_0 = self.owner;
    self endon( "player_exit" );
    var_0 endon( "disconnect" );

    for (;;)
    {
        var_0 waittill( "CancelTramStart" );
        var_1 = var_0 common_scripts\utility::waittill_any_timeout( 1, "CancelTramEnd" );

        if ( var_1 == "timeout" )
            self notify( "player_exit" );
    }
}

tram_killstreak_team_change_watch()
{
    var_0 = self.owner;
    self endon( "player_exit" );
    var_0 endon( "disconnect" );
    var_0 common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );
    self notify( "player_exit" );
}

tram_killstreak_move( var_0 )
{
    maps\mp\mp_detroit_events::tram_spline_move( var_0 );
    self notify( "player_exit" );
    self waittill( "trackEnd" );

    if ( isdefined( self.turret ) )
        self.turret delete();

    if ( isdefined( self.target_ent ) )
        self.target_ent delete();
}

tram_killstreak_exit_watch()
{
    self endon( "disconnect" );
    self waittill( "player_exit" );
    tram_hide_icon();
    self.owner _meth_82FB( "ui_detroit_tram_turret", 0 );
    self.owner thermalvisionfofoverlayoff();
    self.owner _meth_804F();
    self.owner _meth_80E9( self.turret );
    self _meth_813A();
    self.owner maps\mp\_utility::clearusingremote();
    self.owner = undefined;
    thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
    self notify( "leaving" );
    self.isleaving = 1;
}

spawn_tram_turret()
{
    var_0 = "tag_turret";
    var_1 = spawnturret( "misc_turret", self.origin, "detroit_tram_turret_mp", 0 );
    var_1.angles = ( 0, 0, 0 );
    var_1 _meth_80B1( "vehicle_xh9_warbird_turret_detroit_mp" );
    var_1 _meth_815A( 45.0 );
    var_1 _meth_804D( self, var_0, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1.owner = self.owner;
    var_1.health = 99999;
    var_1.maxhealth = 1000;
    var_1.damagetaken = 0;
    var_1.stunned = 0;
    var_1.stunnedtime = 0.0;
    var_1 _meth_82C0( 0 );
    var_1 _meth_82C1( 0 );
    var_1.team = self.team;
    var_1.pers["team"] = self.team;

    if ( level.teambased )
        var_1 _meth_8135( self.team );

    var_1 _meth_8065( "sentry_manual" );
    var_1 _meth_8103( self.owner );
    var_1 _meth_8105( 0 );
    var_1.chopper = self;
    var_2 = spawn( "script_model", self.origin );
    var_2 _meth_804D( var_1, "tag_aim_pivot", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_2 setcontents( 0 );
    var_1 thread common_scripts\utility::delete_on_death( var_2 );
    var_1.obj_ent = var_2;
    return var_1;
}
