// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( getdvar( "mapname" ) == "mp_background" )
        return;

    maps\mp\gametypes\_globallogic::init();
    maps\mp\gametypes\_callbacksetup::setupcallbacks();
    maps\mp\gametypes\_globallogic::setupcallbacks();

    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = ::initializematchrules;
        [[ level.initializematchrules ]]();
        level thread maps\mp\_utility::reinitializematchrulesonmigration();
    }
    else
    {
        maps\mp\_utility::registerroundswitchdvar( level.gametype, 3, 0, 9 );
        maps\mp\_utility::registertimelimitdvar( level.gametype, 2.5 );
        maps\mp\_utility::registerscorelimitdvar( level.gametype, 1 );
        maps\mp\_utility::registerroundlimitdvar( level.gametype, 0 );
        maps\mp\_utility::registerwinlimitdvar( level.gametype, 4 );
        maps\mp\_utility::registernumlivesdvar( level.gametype, 1 );
        maps\mp\_utility::registerhalftimedvar( level.gametype, 0 );
        level.matchrules_damagemultiplier = 0;
        level.matchrules_vampirism = 0;
    }

    level.assists_disabled = 1;
    level.objectivebased = 1;
    level.teambased = 1;
    level.nobuddyspawns = 1;
    level.onprecachegametype = maps\mp\gametypes\common_sd_sr::onprecachegametype;
    level.onstartgametype = ::onstartgametype;
    level.getspawnpoint = ::getspawnpoint;
    level.onspawnplayer = ::onspawnplayer;
    level.onplayerkilled = ::onplayerkilled;
    level.ondeadevent = maps\mp\gametypes\common_sd_sr::ondeadevent;
    level.ononeleftevent = maps\mp\gametypes\common_sd_sr::ononeleftevent;
    level.ontimelimit = maps\mp\gametypes\common_sd_sr::ontimelimit;
    level.onnormaldeath = maps\mp\gametypes\common_sd_sr::onnormaldeath;
    level.gamemodemaydropweapon = maps\mp\gametypes\common_sd_sr::isplayeroutsideofanybombsite;
    level.allowlatecomers = 0;

    if ( level.matchrules_damagemultiplier || level.matchrules_vampirism )
        level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "sr_intro";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

    game["dialog"]["offense_obj"] = "obj_destroy";
    game["dialog"]["defense_obj"] = "obj_defend";
    game["dialog"]["lead_lost"] = "null";
    game["dialog"]["lead_tied"] = "null";
    game["dialog"]["lead_taken"] = "null";
    game["dialog"]["kill_confirmed"] = "kc_killconfirmed";
    game["dialog"]["revived"] = "sr_rev";

    if ( maps\mp\_utility::isgrapplinghookgamemode() )
        game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];

    setomnvar( "ui_bomb_timer_endtime", 0 );
    level.conf_fx["vanish"] = loadfx( "fx/impacts/small_snowhit" );
}

initializematchrules()
{
    maps\mp\_utility::setcommonrulesfrommatchrulesdata();
    var_0 = getmatchrulesdata( "srData", "roundLength" );
    setdynamicdvar( "scr_sr_timelimit", var_0 );
    maps\mp\_utility::registertimelimitdvar( "sr", var_0 );
    var_1 = getmatchrulesdata( "srData", "roundSwitch" );
    setdynamicdvar( "scr_sr_roundswitch", var_1 );
    maps\mp\_utility::registerroundswitchdvar( "sr", var_1, 0, 9 );
    var_2 = getmatchrulesdata( "commonOption", "scoreLimit" );
    setdynamicdvar( "scr_sr_winlimit", var_2 );
    maps\mp\_utility::registerwinlimitdvar( "sr", var_2 );
    setdynamicdvar( "scr_sr_bombtimer", getmatchrulesdata( "srData", "bombTimer" ) );
    setdynamicdvar( "scr_sr_planttime", getmatchrulesdata( "srData", "plantTime" ) );
    setdynamicdvar( "scr_sr_defusetime", getmatchrulesdata( "srData", "defuseTime" ) );
    setdynamicdvar( "scr_sr_multibomb", getmatchrulesdata( "srData", "multiBomb" ) );
    setdynamicdvar( "scr_sr_silentplant", getmatchrulesdata( "srData", "silentPlant" ) );
    setdynamicdvar( "scr_sr_roundlimit", 0 );
    maps\mp\_utility::registerroundlimitdvar( "sr", 0 );
    setdynamicdvar( "scr_sr_scorelimit", 1 );
    maps\mp\_utility::registerscorelimitdvar( "sr", 1 );
    setdynamicdvar( "scr_sr_halftime", 0 );
    maps\mp\_utility::registerhalftimedvar( "sr", 0 );
}

onstartgametype()
{
    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    if ( game["switchedsides"] )
    {
        var_0 = game["attackers"];
        var_1 = game["defenders"];
        game["attackers"] = var_1;
        game["defenders"] = var_0;
    }

    getteamplayersalive( "manual_change" );
    level._effect["bomb_explosion"] = loadfx( "vfx/explosion/mp_gametype_bomb" );
    level._effect["bomb_light_blinking"] = loadfx( "vfx/lights/light_sdbomb_blinking" );
    level._effect["bomb_light_planted"] = loadfx( "vfx/lights/light_beacon_sdbomb" );
    maps\mp\_utility::setobjectivetext( game["attackers"], &"OBJECTIVES_SD_ATTACKER" );
    maps\mp\_utility::setobjectivetext( game["defenders"], &"OBJECTIVES_SD_DEFENDER" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::setobjectivescoretext( game["attackers"], &"OBJECTIVES_SD_ATTACKER" );
        maps\mp\_utility::setobjectivescoretext( game["defenders"], &"OBJECTIVES_SD_DEFENDER" );
    }
    else
    {
        maps\mp\_utility::setobjectivescoretext( game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE" );
        maps\mp\_utility::setobjectivescoretext( game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT" );
    maps\mp\_utility::setobjectivehinttext( game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT" );
    initspawns();
    var_2[0] = "sd";
    var_2[1] = "bombzone";
    var_2[2] = "blocker";
    maps\mp\gametypes\_gameobjects::main( var_2 );
    maps\mp\gametypes\common_sd_sr::updategametypedvars();
    level.dogtags = [];
    maps\mp\gametypes\common_sd_sr::setspecialloadout();
    thread maps\mp\gametypes\common_sd_sr::bombs();
}

initspawns()
{
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_sd_spawn_attacker" );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_sd_spawn_defender" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "attacker", "mp_tdm_spawn" );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "defender", "mp_tdm_spawn" );
    level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

getspawnpoint()
{
    var_0 = "defender";

    if ( self.pers["team"] == game["attackers"] )
        var_0 = "attacker";

    if ( maps\mp\gametypes\_spawnlogic::shoulduseteamstartspawn() )
    {
        var_1 = maps\mp\gametypes\_spawnlogic::getspawnpointarray( "mp_sd_spawn_" + var_0 );
        var_2 = maps\mp\gametypes\_spawnlogic::getspawnpoint_startspawn( var_1 );
    }
    else
    {
        var_1 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( var_0 );
        var_2 = maps\mp\gametypes\_spawnscoring::getspawnpoint_searchandrescue( var_1 );
    }

    maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint( var_2 );
    return var_2;
}

onspawnplayer()
{
    var_0 = isdefined( self.isrespawningwithbombcarrierclass ) && self.isrespawningwithbombcarrierclass;
    self.isplanting = 0;
    self.isdefusing = 0;

    if ( !var_0 )
    {
        self.isbombcarrier = 0;
        self.objective = 0;
    }

    if ( isplayer( self ) && !var_0 )
    {
        if ( level.multibomb && self.pers["team"] == game["attackers"] )
            self _meth_82FB( "ui_carrying_bomb", 1 );
        else
            self _meth_82FB( "ui_carrying_bomb", 0 );
    }

    self.isrespawningwithbombcarrierclass = undefined;
    level notify( "spawned_player" );

    if ( self.sessionteam == "axis" || self.sessionteam == "allies" )
    {
        level notify( "sr_player_joined", self );
        maps\mp\_utility::setextrascore0( 0 );

        if ( isdefined( self.pers["plants"] ) )
            maps\mp\_utility::setextrascore0( self.pers["plants"] );

        maps\mp\_utility::setextrascore1( 0 );

        if ( isdefined( self.pers["defuses"] ) )
            maps\mp\_utility::setextrascore1( self.pers["defuses"] );

        self.assists = 0;

        if ( isdefined( self.pers["denied"] ) )
            self.assists = self.pers["denied"];
    }
}

shouldspawntags( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( self.switching_teams ) )
        return 0;

    if ( isdefined( self.wasswitchingteamsforonplayerkilled ) )
        return 0;

    if ( isdefined( var_1 ) && var_1 == self )
        return 0;

    if ( level.teambased && isdefined( var_1 ) && isdefined( var_1.team ) && var_1.team == self.team )
        return 0;

    if ( isdefined( var_1 ) && !isdefined( var_1.team ) && ( var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" ) )
        return 0;

    return 1;
}

onplayerkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isplayer( self ) )
        self _meth_82FB( "ui_carrying_bomb", 0 );

    if ( !maps\mp\_utility::gameflag( "prematch_done" ) )
        maps\mp\gametypes\_playerlogic::mayspawn();
    else
    {
        var_10 = shouldspawntags( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( var_10 )
            var_10 = var_10 && !maps\mp\_utility::isreallyalive( self );

        if ( var_10 )
            var_10 = var_10 && !maps\mp\gametypes\_playerlogic::mayspawn();

        if ( var_10 )
            level thread spawndogtags( self, var_1 );
    }

    thread maps\mp\gametypes\common_sd_sr::checkallowspectating();
}

spawndogtags( var_0, var_1 )
{
    if ( isagent( var_0 ) )
        return;

    if ( isagent( var_1 ) )
        var_1 = var_1.owner;

    var_2 = var_0.origin + ( 0, 0, 14 );

    if ( isdefined( level.dogtags[var_0.guid] ) )
    {
        playfx( level.conf_fx["vanish"], level.dogtags[var_0.guid].curorigin );
        level.dogtags[var_0.guid] notify( "reset" );
    }
    else
    {
        var_3[0] = spawn( "script_model", ( 0, 0, 0 ) );
        var_3[0] _meth_8382( var_0 );
        var_3[0] _meth_80B1( "prop_dogtags_future_enemy_animated" );
        var_3[0] _meth_856C( 1 );
        var_3[1] = spawn( "script_model", ( 0, 0, 0 ) );
        var_3[1] _meth_8382( var_0 );
        var_3[1] _meth_80B1( "prop_dogtags_future_friend_animated" );
        var_3[1] _meth_856C( 1 );
        var_4 = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
        level.dogtags[var_0.guid] = maps\mp\gametypes\_gameobjects::createuseobject( "any", var_4, var_3, ( 0, 0, 16 ) );
        maps\mp\gametypes\_objpoints::deleteobjpoint( level.dogtags[var_0.guid].objpoints["allies"] );
        maps\mp\gametypes\_objpoints::deleteobjpoint( level.dogtags[var_0.guid].objpoints["axis"] );
        maps\mp\gametypes\_objpoints::deleteobjpoint( level.dogtags[var_0.guid].objpoints["mlg"] );
        level.dogtags[var_0.guid] maps\mp\gametypes\_gameobjects::setusetime( 0 );
        level.dogtags[var_0.guid].onuse = ::onuse;
        level.dogtags[var_0.guid].victim = var_0;
        level.dogtags[var_0.guid].victimteam = var_0.team;
        level thread clearonvictimdisconnect( var_0 );
        var_0 thread tagteamupdater( level.dogtags[var_0.guid] );
    }

    level.dogtags[var_0.guid].curorigin = var_2;
    level.dogtags[var_0.guid].trigger.origin = var_2;
    level.dogtags[var_0.guid].visuals[0].origin = var_2;
    level.dogtags[var_0.guid].visuals[1].origin = var_2;
    level.dogtags[var_0.guid] maps\mp\gametypes\_gameobjects::initializetagpathvariables();
    level.dogtags[var_0.guid] maps\mp\gametypes\_gameobjects::allowuse( "any" );
    level.dogtags[var_0.guid].visuals[0] thread showtoteam( level.dogtags[var_0.guid], maps\mp\_utility::getotherteam( var_0.team ) );
    level.dogtags[var_0.guid].visuals[1] thread showtoteam( level.dogtags[var_0.guid], var_0.team );
    level.dogtags[var_0.guid].attacker = var_1;

    if ( var_0.team == "axis" )
    {
        objective_icon( level.dogtags[var_0.guid].objidaxis, "waypoint_dogtags_friendlys" );
        objective_team( level.dogtags[var_0.guid].objidaxis, "axis" );
        objective_icon( level.dogtags[var_0.guid].objidallies, "waypoint_dogtags" );
        objective_team( level.dogtags[var_0.guid].objidallies, "allies" );
    }
    else
    {
        objective_icon( level.dogtags[var_0.guid].objidallies, "waypoint_dogtags_friendlys" );
        objective_team( level.dogtags[var_0.guid].objidallies, "allies" );
        objective_icon( level.dogtags[var_0.guid].objidaxis, "waypoint_dogtags" );
        objective_team( level.dogtags[var_0.guid].objidaxis, "axis" );
    }

    objective_position( level.dogtags[var_0.guid].objidallies, var_2 );
    objective_position( level.dogtags[var_0.guid].objidaxis, var_2 );
    objective_state( level.dogtags[var_0.guid].objidallies, "active" );
    objective_state( level.dogtags[var_0.guid].objidaxis, "active" );
    playsoundatpos( var_2, "mp_killconfirm_tags_drop" );
    level notify( "sr_player_killed", var_0 );
    var_0.tagavailable = 1;
    var_0.objective = 3;
    level.dogtags[var_0.guid].visuals[0] _meth_8279( "mp_dogtag_spin" );
    level.dogtags[var_0.guid].visuals[1] _meth_8279( "mp_dogtag_spin" );
}

showtoteam( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "reset" );
    self hide();

    foreach ( var_3 in level.players )
    {
        if ( var_3.team == var_1 )
            self showtoplayer( var_3 );

        if ( var_3.team == "spectator" && var_1 == "allies" )
            self showtoplayer( var_3 );
    }

    for (;;)
    {
        level waittill( "joined_team" );
        self hide();

        foreach ( var_3 in level.players )
        {
            if ( var_3.team == var_1 )
                self showtoplayer( var_3 );

            if ( var_3.team == "spectator" && var_1 == "allies" )
                self showtoplayer( var_3 );
        }
    }
}

sr_respawn()
{
    maps\mp\gametypes\_playerlogic::incrementalivecount( self.team );
    self.alreadyaddedtoalivecount = 1;
    thread waitillcanspawnclient();
}

waitillcanspawnclient()
{
    self endon( "started_spawnPlayer" );

    for (;;)
    {
        wait 0.05;

        if ( isdefined( self ) && ( self.sessionstate == "spectator" || !maps\mp\_utility::isreallyalive( self ) ) )
        {
            self.pers["lives"] = 1;
            maps\mp\gametypes\_playerlogic::spawnclient();
            continue;
        }

        return;
    }
}

onuse( var_0 )
{
    if ( isdefined( var_0.owner ) )
        var_0 = var_0.owner;

    if ( var_0.pers["team"] == self.victimteam )
    {
        self.trigger playsound( "mp_snd_ally_revive" );
        var_0 thread maps\mp\_events::revivetagevent( self.victim );

        if ( isdefined( self.victim ) )
        {
            level notify( "sr_player_respawned", self.victim );
            self.victim maps\mp\_utility::leaderdialogonplayer( "revived" );
        }

        if ( isdefined( self.victim ) )
        {
            if ( !level.gameended )
                self.victim thread sr_respawn();
        }

        var_0 maps\mp\gametypes\_missions::processchallenge( "ch_rescuer" );

        if ( !isdefined( var_0.rescuedplayers ) )
            var_0.rescuedplayers = [];

        var_0.rescuedplayers[self.victim.guid] = 1;

        if ( var_0.rescuedplayers.size == 4 )
            var_0 maps\mp\gametypes\_missions::processchallenge( "ch_helpme" );
    }
    else
    {
        self.trigger playsound( "mp_killconfirm_tags_pickup" );
        var_0 thread maps\mp\_events::eliminatetagevent();

        if ( isdefined( self.victim ) )
        {
            if ( !level.gameended )
            {
                self.victim maps\mp\_utility::setlowermessage( "spawn_info", game["strings"]["spawn_next_round"] );
                self.victim thread maps\mp\gametypes\_playerlogic::removespawnmessageshortly( 3.0 );
            }

            self.victim.tagavailable = undefined;
        }

        var_0 maps\mp\_utility::leaderdialogonplayer( "kill_confirmed" );
        var_0 maps\mp\gametypes\_missions::processchallenge( "ch_hideandseek" );
    }

    self.victim.objective = 0;
    level thread maps\mp\_events::monitortagcollector( var_0 );
    resettags();
}

resettags()
{
    self.attacker = undefined;
    self notify( "reset" );
    self.visuals[0] hide();
    self.visuals[1] hide();
    self.curorigin = ( 0, 0, 1000 );
    self.trigger.origin = ( 0, 0, 1000 );
    self.visuals[0].origin = ( 0, 0, 1000 );
    self.visuals[1].origin = ( 0, 0, 1000 );
    maps\mp\gametypes\_gameobjects::allowuse( "none" );
    objective_state( self.objidallies, "invisible" );
    objective_state( self.objidaxis, "invisible" );
}

tagteamupdater( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "joined_team" );
        var_0.victimteam = self.pers["team"];
        var_0 resettags();
    }
}

clearonvictimdisconnect( var_0 )
{
    level endon( "game_ended" );
    var_1 = var_0.guid;
    var_0 waittill( "disconnect" );

    if ( isdefined( level.dogtags[var_1] ) )
    {
        level.dogtags[var_1] maps\mp\gametypes\_gameobjects::allowuse( "none" );
        playfx( level.conf_fx["vanish"], level.dogtags[var_1].curorigin );
        level.dogtags[var_1] notify( "reset" );
        wait 0.05;

        if ( isdefined( level.dogtags[var_1] ) )
        {
            objective_delete( level.dogtags[var_1].objidallies );
            objective_delete( level.dogtags[var_1].objidallies );
            level.dogtags[var_1].trigger delete();

            for ( var_2 = 0; var_2 < level.dogtags[var_1].visuals.size; var_2++ )
                level.dogtags[var_1].visuals[var_2] delete();

            level.dogtags[var_1] notify( "deleted" );
            level.dogtags[var_1] = undefined;
        }
    }
}
