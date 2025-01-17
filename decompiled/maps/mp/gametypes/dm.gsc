// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
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
        maps\mp\_utility::registertimelimitdvar( level.gametype, 10 );
        maps\mp\_utility::registerscorelimitdvar( level.gametype, 30 );
        maps\mp\_utility::registerwinlimitdvar( level.gametype, 1 );
        maps\mp\_utility::registerroundlimitdvar( level.gametype, 1 );
        maps\mp\_utility::registernumlivesdvar( level.gametype, 0 );
        maps\mp\_utility::registerhalftimedvar( level.gametype, 0 );
        maps\mp\_utility::registerscorelimitdvar( level.gametype, 30 );
        level.matchrules_damagemultiplier = 0;
        level.matchrules_vampirism = 0;
    }

    level.onstartgametype = ::onstartgametype;
    level.getspawnpoint = ::getspawnpoint;
    level.onnormaldeath = ::onnormaldeath;
    level.onplayerscore = ::onplayerscore;

    if ( level.matchrules_damagemultiplier || level.matchrules_vampirism )
        level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    setteamscore( "ffa" );
    game["dialog"]["gametype"] = "ffa_intro";
    game["dialog"]["defense_obj"] = "gbl_start";
    game["dialog"]["offense_obj"] = "gbl_start";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

    if ( maps\mp\_utility::isgrapplinghookgamemode() )
        game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
}

initializematchrules()
{
    maps\mp\_utility::setcommonrulesfrommatchrulesdata( 1 );
    setdynamicdvar( "scr_dm_winlimit", 1 );
    maps\mp\_utility::registerwinlimitdvar( "dm", 1 );
    setdynamicdvar( "scr_dm_roundlimit", 1 );
    maps\mp\_utility::registerroundlimitdvar( "dm", 1 );
    setdynamicdvar( "scr_dm_halftime", 0 );
    maps\mp\_utility::registerhalftimedvar( "dm", 0 );
}

onstartgametype()
{
    getteamplayersalive( "auto_change" );
    maps\mp\_utility::setobjectivetext( "allies", &"OBJECTIVES_DM" );
    maps\mp\_utility::setobjectivetext( "axis", &"OBJECTIVES_DM" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::setobjectivescoretext( "allies", &"OBJECTIVES_DM" );
        maps\mp\_utility::setobjectivescoretext( "axis", &"OBJECTIVES_DM" );
    }
    else
    {
        maps\mp\_utility::setobjectivescoretext( "allies", &"OBJECTIVES_DM_SCORE" );
        maps\mp\_utility::setobjectivescoretext( "axis", &"OBJECTIVES_DM_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_DM_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_DM_HINT" );
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    level.spawn_name = "mp_dm_spawn";
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", level.spawn_name );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", level.spawn_name );
    level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    var_0[0] = "dm";
    maps\mp\gametypes\_gameobjects::main( var_0 );
    level.quickmessagetoall = 1;
}

getstartspawnpoints( var_0 )
{
    if ( !isdefined( level.dmstartspawnpoints ) )
        level.dmstartspawnpoints = [];

    if ( !isdefined( level.dmstartspawnpoints[var_0] ) )
    {
        var_1 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( var_0 );
        level.dmstartspawnpoints[var_0] = [];

        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "start_spawn" )
                level.dmstartspawnpoints[var_0][level.dmstartspawnpoints[var_0].size] = var_3;
        }
    }

    if ( level.dmstartspawnpoints[var_0].size >= level.players.size )
        return level.dmstartspawnpoints[var_0];
    else
        return maps\mp\gametypes\_spawnlogic::getteamspawnpoints( var_0 );
}

getspawnpoint()
{
    if ( level.ingraceperiod )
    {
        var_0 = getstartspawnpoints( self.team );
        var_1 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random( var_0 );
    }
    else
    {
        var_0 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( self.team );
        var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_freeforall( var_0 );
    }

    maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint( var_1 );
    return var_1;
}

onnormaldeath( var_0, var_1, var_2 )
{
    var_3 = 0;

    foreach ( var_5 in level.players )
    {
        if ( isdefined( var_5.score ) && var_5.score > var_3 )
            var_3 = var_5.score;
    }

    if ( game["state"] == "postgame" && var_1.score >= var_3 )
        var_1.finalkill = 1;
}

onplayerscore( var_0, var_1, var_2 )
{
    if ( issoringevent( var_0 ) )
    {
        var_3 = maps\mp\gametypes\_rank::getscoreinfovalue( var_0 );
        var_1 maps\mp\_utility::setextrascore0( var_1.extrascore0 + var_3 );
        var_1 maps\mp\gametypes\_gamescore::updatescorestatsffa( var_1, var_3 );
        return 1;
    }

    return 0;
}

issoringevent( var_0 )
{
    switch ( var_0 )
    {
        case "map_killstreak_kill":
        case "airdrop_kill":
        case "airdrop_trap_kill":
        case "goliath_kill":
        case "assault_drone_kill":
        case "strafing_run_kill":
        case "sentry_gun_kill":
        case "missile_strike_kill":
        case "paladin_kill":
        case "warbird_kill":
        case "vulcan_kill":
        case "kill":
            return 1;
    }

    return 0;
}
