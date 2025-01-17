// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

onforfeit( var_0 )
{
    if ( isdefined( level.forfeitinprogress ) )
        return;

    level endon( "abort_forfeit" );
    level thread forfeitwaitforabort();
    level.forfeitinprogress = 1;

    if ( !level.teambased && level.players.size > 1 )
        wait 10;
    else
        wait 1.05;

    level.forfeit_aborted = 0;
    var_1 = 20.0;
    matchforfeittimer( var_1 );
    var_2 = &"";

    if ( !isdefined( var_0 ) )
    {
        level.finalkillcam_winner = "none";
        var_2 = game["end_reason"]["players_forfeited"];
        var_3 = level.players[0];
    }
    else if ( var_0 == "axis" )
    {
        level.finalkillcam_winner = "axis";
        var_2 = game["end_reason"]["allies_forfeited"];

        if ( level.gametype == "infect" )
            var_2 = game["end_reason"]["survivors_forfeited"];

        var_3 = "axis";
    }
    else if ( var_0 == "allies" )
    {
        level.finalkillcam_winner = "allies";
        var_2 = game["end_reason"]["axis_forfeited"];

        if ( level.gametype == "infect" )
            var_2 = game["end_reason"]["infected_forfeited"];

        var_3 = "allies";
    }
    else if ( level.multiteambased && issubstr( var_0, "team_" ) )
        var_3 = var_0;
    else
    {
        level.finalkillcam_winner = "none";
        var_3 = "tie";
    }

    level.forcedend = 1;

    if ( isplayer( var_3 ) )
        logstring( "forfeit, win: " + var_3 _meth_8297() + "(" + var_3.name + ")" );
    else
        logstring( "forfeit, win: " + var_3 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );

    thread endgame( var_3, var_2 );
}

forfeitwaitforabort()
{
    level endon( "game_ended" );
    level waittill( "abort_forfeit" );
    level.forfeit_aborted = 1;
    setomnvar( "ui_match_countdown", 0 );
    setomnvar( "ui_match_countdown_title", 0 );
    setomnvar( "ui_match_countdown_toggle", 0 );
}

matchforfeittimer_internal( var_0 )
{
    waittillframeend;
    level endon( "match_forfeit_timer_beginning" );
    setomnvar( "ui_match_countdown_title", 3 );
    setomnvar( "ui_match_countdown_toggle", 1 );

    while ( var_0 > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod )
    {
        setomnvar( "ui_match_countdown", var_0 );
        wait 1;
        var_0--;
    }
}

matchforfeittimer( var_0 )
{
    level notify( "match_forfeit_timer_beginning" );
    var_1 = int( var_0 );
    matchforfeittimer_internal( var_1 );
    setomnvar( "ui_match_countdown", 0 );
    setomnvar( "ui_match_countdown_title", 0 );
    setomnvar( "ui_match_countdown_toggle", 0 );
}

default_ondeadevent( var_0 )
{
    level.finalkillcam_winner = "none";

    if ( var_0 == "allies" )
    {
        logstring( "team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
        level.finalkillcam_winner = "axis";
        thread endgame( "axis", game["end_reason"]["allies_eliminated"] );
    }
    else if ( var_0 == "axis" )
    {
        logstring( "team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
        level.finalkillcam_winner = "allies";
        thread endgame( "allies", game["end_reason"]["axis_eliminated"] );
    }
    else
    {
        logstring( "tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
        level.finalkillcam_winner = "none";

        if ( level.teambased )
            thread endgame( "tie", game["end_reason"]["tie"] );
        else
            thread endgame( undefined, game["end_reason"]["tie"] );
    }
}

default_ononeleftevent( var_0 )
{
    if ( level.teambased )
    {
        var_1 = maps\mp\_utility::getlastlivingplayer( var_0 );
        var_1 thread givelastonteamwarning();
    }
    else
    {
        var_1 = maps\mp\_utility::getlastlivingplayer();
        logstring( "last one alive, win: " + var_1.name );
        level.finalkillcam_winner = "none";
        thread endgame( var_1, game["end_reason"]["enemies_eliminated"] );
    }

    return 1;
}

default_ontimelimit()
{
    var_0 = undefined;
    level.finalkillcam_winner = "none";

    if ( level.teambased )
    {
        if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
            var_0 = "tie";
        else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
        {
            level.finalkillcam_winner = "axis";
            var_0 = "axis";
        }
        else
        {
            level.finalkillcam_winner = "allies";
            var_0 = "allies";
        }

        if ( maps\mp\_utility::practiceroundgame() )
            var_0 = "none";

        logstring( "time limit, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
    }
    else
    {
        var_0 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();

        if ( isdefined( var_0 ) )
            logstring( "time limit, win: " + var_0.name );
        else
            logstring( "time limit, tie" );
    }

    thread endgame( var_0, game["end_reason"]["time_limit_reached"] );
}

default_onhalftime( var_0 )
{
    var_1 = undefined;
    level.finalkillcam_winner = "none";
    thread endgame( "halftime", game["end_reason"][var_0] );
}

forceend()
{
    if ( level.hostforcedend || level.forcedend )
        return;

    var_0 = undefined;
    level.finalkillcam_winner = "none";

    if ( level.teambased )
    {
        if ( isdefined( level.ishorde ) )
            var_0 = "axis";
        else if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
            var_0 = "tie";
        else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
        {
            level.finalkillcam_winner = "axis";
            var_0 = "axis";
        }
        else
        {
            level.finalkillcam_winner = "allies";
            var_0 = "allies";
        }

        logstring( "host ended game, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
    }
    else
    {
        var_0 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();

        if ( isdefined( var_0 ) )
            logstring( "host ended game, win: " + var_0.name );
        else
            logstring( "host ended game, tie" );
    }

    level.forcedend = 1;
    level.hostforcedend = 1;

    if ( level.splitscreen )
        var_1 = game["end_reason"]["ended_game"];
    else
        var_1 = game["end_reason"]["host_ended_game"];

    thread endgame( var_0, var_1 );
}

onscorelimit()
{
    var_0 = game["end_reason"]["score_limit_reached"];
    var_1 = undefined;
    level.finalkillcam_winner = "none";

    if ( level.multiteambased )
    {
        var_1 = maps\mp\gametypes\_gamescore::getwinningteam();

        if ( var_1 == "none" )
            var_1 = "tie";
    }
    else if ( level.teambased )
    {
        if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
            var_1 = "tie";
        else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
        {
            var_1 = "axis";
            level.finalkillcam_winner = "axis";
        }
        else
        {
            var_1 = "allies";
            level.finalkillcam_winner = "allies";
        }

        logstring( "scorelimit, win: " + var_1 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
    }
    else
    {
        var_1 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();

        if ( isdefined( var_1 ) )
            logstring( "scorelimit, win: " + var_1.name );
        else
            logstring( "scorelimit, tie" );
    }

    thread endgame( var_1, var_0 );
    return 1;
}

updategameevents()
{
    if ( maps\mp\_utility::matchmakinggame() && !level.ingraceperiod && !getdvarint( "force_ranking" ) && ( !isdefined( level.disableforfeit ) || !level.disableforfeit ) )
    {
        if ( level.multiteambased )
        {
            var_0 = 0;
            var_1 = 0;

            for ( var_2 = 0; var_2 < level.teamnamelist.size; var_2++ )
            {
                var_0 += level.teamcount[level.teamnamelist[var_2]];

                if ( level.teamcount[level.teamnamelist[var_2]] )
                    var_1 += 1;
            }

            for ( var_2 = 0; var_2 < level.teamnamelist.size; var_2++ )
            {
                if ( var_0 == level.teamcount[level.teamnamelist[var_2]] && game["state"] == "playing" )
                {
                    thread onforfeit( level.teamnamelist[var_2] );
                    return;
                }
            }

            if ( var_1 > 1 )
            {
                level.forfeitinprogress = undefined;
                level notify( "abort_forfeit" );
            }
        }
        else if ( level.teambased )
        {
            if ( level.teamcount["allies"] < 1 && level.teamcount["axis"] > 0 && game["state"] == "playing" )
            {
                thread onforfeit( "axis" );
                return;
            }

            if ( level.teamcount["axis"] < 1 && level.teamcount["allies"] > 0 && game["state"] == "playing" )
            {
                thread onforfeit( "allies" );
                return;
            }

            if ( level.teamcount["axis"] > 0 && level.teamcount["allies"] > 0 )
            {
                level.forfeitinprogress = undefined;
                level notify( "abort_forfeit" );
            }
        }
        else
        {
            if ( level.teamcount["allies"] + level.teamcount["axis"] == 1 && level.maxplayercount >= 1 && !getdvarint( "virtualLobbyActive", 0 ) )
            {
                thread onforfeit();
                return;
            }

            if ( level.teamcount["axis"] + level.teamcount["allies"] > 1 )
            {
                level.forfeitinprogress = undefined;
                level notify( "abort_forfeit" );
            }
        }
    }

    if ( !maps\mp\_utility::getgametypenumlives() && ( !isdefined( level.disablespawning ) || !level.disablespawning ) )
        return;

    if ( !maps\mp\_utility::gamehasstarted() )
        return;

    if ( level.ingraceperiod )
        return;

    if ( level.multiteambased )
        return;

    if ( level.teambased )
    {
        var_3["allies"] = level.livescount["allies"];
        var_3["axis"] = level.livescount["axis"];

        if ( isdefined( level.disablespawning ) && level.disablespawning )
        {
            var_3["allies"] = 0;
            var_3["axis"] = 0;
        }

        if ( !level.alivecount["allies"] && !level.alivecount["axis"] && !var_3["allies"] && !var_3["axis"] )
            return [[ level.ondeadevent ]]( "all" );

        if ( !level.alivecount["allies"] && !var_3["allies"] )
            return [[ level.ondeadevent ]]( "allies" );

        if ( !level.alivecount["axis"] && !var_3["axis"] )
            return [[ level.ondeadevent ]]( "axis" );

        var_4 = level.alivecount["allies"] == 1 && !var_3["allies"];
        var_5 = level.alivecount["axis"] == 1 && !var_3["axis"];

        if ( ( var_4 || var_5 ) && !isdefined( level.bot_spawn_from_devgui_in_progress ) )
        {
            var_6 = undefined;

            if ( var_4 && !isdefined( level.onelefttime["allies"] ) )
            {
                level.onelefttime["allies"] = gettime();
                var_7 = [[ level.ononeleftevent ]]( "allies" );

                if ( isdefined( var_7 ) )
                {
                    if ( !isdefined( var_6 ) )
                        var_6 = var_7;

                    var_6 = var_6 || var_7;
                }
            }

            if ( var_5 && !isdefined( level.onelefttime["axis"] ) )
            {
                level.onelefttime["axis"] = gettime();
                var_8 = [[ level.ononeleftevent ]]( "axis" );

                if ( isdefined( var_8 ) )
                {
                    if ( !isdefined( var_6 ) )
                        var_6 = var_8;

                    var_6 = var_6 || var_8;
                }
            }

            return var_6;
            return;
        }
    }
    else
    {
        if ( !level.alivecount["allies"] && !level.alivecount["axis"] && ( !level.livescount["allies"] && !level.livescount["axis"] ) )
            return [[ level.ondeadevent ]]( "all" );

        var_9 = maps\mp\_utility::getpotentiallivingplayers();

        if ( var_9.size == 1 )
            return [[ level.ononeleftevent ]]( "all" );
    }
}

waittillfinalkillcamdone()
{
    if ( !isdefined( level.finalkillcam_winner ) )
        return 0;

    level waittill( "final_killcam_done" );
    return 1;
}

timelimitclock_intermission( var_0 )
{
    setgameendtime( gettime() + int( var_0 * 1000 ) );
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_1 hide();

    if ( var_0 >= 10.0 )
        wait(var_0 - 10.0);

    for (;;)
    {
        var_1 playsound( "ui_mp_timer_countdown" );
        wait 1.0;
    }
}

waitforplayers( var_0 )
{
    var_1 = gettime();
    var_2 = var_1 + var_0 * 1000 - 200;

    if ( var_0 > 5 )
        var_3 = gettime() + getdvarint( "min_wait_for_players" ) * 1000;
    else
        var_3 = 0;

    if ( isdefined( level.iszombiegame ) && level.iszombiegame )
        var_4 = level.connectingplayers;
    else
        var_4 = level.connectingplayers / 3;

    var_5 = 0;

    for (;;)
    {
        if ( isdefined( game["roundsPlayed"] ) && game["roundsPlayed"] )
            break;

        var_6 = level.maxplayercount;
        var_7 = gettime();

        if ( var_6 >= var_4 && var_7 > var_3 || var_7 > var_2 )
            break;

        wait 0.05;
    }
}

prematchperiod()
{
    level endon( "game_ended" );
    level.connectingplayers = getdvarint( "party_partyPlayerCountNum" );

    if ( level.prematchperiod > 0 )
    {
        level.waitingforplayers = 1;
        matchstarttimerwaitforplayers();
        level.waitingforplayers = 0;
    }
    else
        matchstarttimerskip();

    for ( var_0 = 0; var_0 < level.players.size; var_0++ )
    {
        level.players[var_0] maps\mp\_utility::freezecontrolswrapper( 0 );
        level.players[var_0] _meth_831E();
        level.players[var_0] enableammogeneration();
        var_1 = maps\mp\_utility::getobjectivehinttext( level.players[var_0].pers["team"] );

        if ( !isdefined( var_1 ) || !level.players[var_0].hasspawned )
            continue;

        level.players[var_0] thread maps\mp\gametypes\_hud_message::hintmessage( var_1 );
    }

    if ( game["state"] != "playing" )
        return;
}

graceperiod()
{
    level endon( "game_ended" );

    if ( !isdefined( game["clientActive"] ) )
    {
        while ( _func_27D() == 0 )
            wait 0.05;

        game["clientActive"] = 1;
    }

    while ( level.ingraceperiod > 0 )
    {
        wait 1.0;
        level.ingraceperiod--;
    }

    level notify( "grace_period_ending" );
    wait 0.05;
    maps\mp\_utility::gameflagset( "graceperiod_done" );
    level.ingraceperiod = 0;

    if ( game["state"] != "playing" )
        return;

    level thread updategameevents();
}

sethasdonecombat( var_0, var_1 )
{
    var_0.hasdonecombat = var_1;
    var_0 notify( "hasDoneCombat" );
    var_2 = !isdefined( var_0.hasdoneanycombat ) || !var_0.hasdoneanycombat;

    if ( var_2 && var_1 )
    {
        var_0.hasdoneanycombat = 1;
        var_0.pers["participation"] = 1;

        if ( isdefined( var_0.pers["hasMatchLoss"] ) && var_0.pers["hasMatchLoss"] )
            return;

        updatelossstats( var_0 );
    }
}

updatewinstats( var_0 )
{
    if ( !var_0 maps\mp\_utility::rankingenabled() )
        return;

    if ( ( !isdefined( var_0.hasdoneanycombat ) || !var_0.hasdoneanycombat ) && !( level.gametype == "infect" ) )
        return;

    var_0 maps\mp\gametypes\_persistence::statadd( "losses", -1 );
    var_0 maps\mp\gametypes\_persistence::statadd( "wins", 1 );
    var_0 maps\mp\_utility::updatepersratio( "winLossRatio", "wins", "losses" );
    var_0 maps\mp\gametypes\_persistence::statadd( "currentWinStreak", 1 );
    var_1 = var_0 maps\mp\gametypes\_persistence::statget( "currentWinStreak" );

    if ( var_1 > var_0 maps\mp\gametypes\_persistence::statget( "winStreak" ) )
        var_0 maps\mp\gametypes\_persistence::statset( "winStreak", var_1 );

    var_0 maps\mp\gametypes\_persistence::statsetchild( "round", "win", 1 );
    var_0 maps\mp\gametypes\_persistence::statsetchild( "round", "loss", 0 );
    var_0 maps\mp\gametypes\_missions::processchallenge( "ch_" + level.gametype + "_wins" );
    var_0.combatrecordwin = 1;
    var_0 maps\mp\gametypes\_missions::processchallengedaily( 25, undefined, undefined );
    var_0 maps\mp\gametypes\_missions::processchallengedaily( 26, undefined, undefined );
    var_0 maps\mp\gametypes\_missions::processchallengedaily( 27, undefined, undefined );
    var_0 maps\mp\gametypes\_missions::processchallengedaily( 28, undefined, undefined );
    var_0 maps\mp\gametypes\_missions::processchallengedaily( 29, undefined, undefined );
    var_0 maps\mp\gametypes\_missions::processchallengedaily( 30, undefined, undefined );
    var_0 maps\mp\gametypes\_missions::processchallengedaily( 36, undefined, undefined );
    var_0 maps\mp\gametypes\_missions::processchallengedaily( 37, undefined, undefined );

    if ( maps\mp\_utility::isgrapplinghookgamemode() )
        var_0 maps\mp\gametypes\_missions::processchallenge( "ch_tier2_4_iw5_dlcgun12" );

    if ( level.players.size > 5 )
    {
        superstarchallenge( var_0 );

        switch ( level.gametype )
        {
            case "war":
                if ( game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam( var_0.team )] + 20 )
                    var_0 maps\mp\gametypes\_missions::processchallenge( "ch_war_crushing" );

                break;
            case "hp":
                if ( game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam( var_0.team )] + 70 )
                    var_0 maps\mp\gametypes\_missions::processchallenge( "ch_hp_crushing" );

                break;
            case "conf":
                if ( game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam( var_0.team )] + 15 )
                    var_0 maps\mp\gametypes\_missions::processchallenge( "ch_conf_crushing" );

                break;
            case "ball":
                if ( game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam( var_0.team )] + 7 )
                    var_0 maps\mp\gametypes\_missions::processchallenge( "ch_ball_crushing" );

                break;
            case "infect":
                if ( var_0.team == "allies" )
                {
                    if ( game["teamScores"][var_0.team] >= 4 )
                        var_0 maps\mp\gametypes\_missions::processchallenge( "ch_infect_crushing" );

                    if ( game["teamScores"][maps\mp\_utility::getotherteam( var_0.team )] == 1 )
                        var_0 maps\mp\gametypes\_missions::processchallenge( "ch_infect_cleanup" );
                }

                break;
            case "dm":
                if ( isdefined( level.placement["all"][0] ) )
                {
                    var_2 = level.placement["all"][0];
                    var_3 = 9999;

                    if ( var_0 == var_2 )
                    {
                        foreach ( var_5 in level.players )
                        {
                            if ( var_0 == var_5 )
                                continue;

                            var_6 = var_0.score - var_5.score;

                            if ( var_6 < var_3 )
                                var_3 = var_6;
                        }

                        if ( var_3 >= 7 )
                            var_0 maps\mp\gametypes\_missions::processchallenge( "ch_dm_crushing" );
                    }
                }

                break;
            case "gun":
                foreach ( var_9 in level.players )
                {
                    if ( var_0 == var_9 )
                        continue;

                    if ( var_0.score < var_9.score + 5 )
                        break;
                }

                var_0 maps\mp\gametypes\_missions::processchallenge( "ch_gun_crushing" );
                break;
            case "twar":
            case "ctf":
                if ( game["shut_out"][var_0.team] )
                    var_0 maps\mp\gametypes\_missions::processchallenge( "ch_" + level.gametype + "_crushing" );

                break;
        }
    }
}

superstarchallenge( var_0 )
{
    var_1 = 0;
    var_2 = 9999;

    foreach ( var_4 in level.players )
    {
        if ( var_4.kills > var_1 )
            var_1 = var_4.kills;

        if ( var_4.deaths < var_2 )
            var_2 = var_4.deaths;
    }

    if ( var_0.kills >= var_1 && var_0.deaths <= var_2 && var_0.kills > 0 && !isai( var_0 ) )
        var_0 maps\mp\gametypes\_missions::processchallenge( "ch_" + level.gametype + "_star" );
}

checkgameendchallenges()
{
    if ( level.gametype == "dom" )
    {
        foreach ( var_1 in level.domflags )
        {
            if ( !isdefined( var_1.ownedtheentireround ) || !var_1.ownedtheentireround )
                continue;

            var_2 = var_1 maps\mp\gametypes\_gameobjects::getownerteam();

            foreach ( var_4 in level.players )
            {
                if ( var_4.team != var_2 )
                    continue;

                switch ( var_1.label )
                {
                    case "_a":
                        var_4 maps\mp\gametypes\_missions::processchallenge( "ch_dom_alphalock" );
                        break;
                    case "_b":
                        var_4 maps\mp\gametypes\_missions::processchallenge( "ch_dom_bravolock" );
                        break;
                    case "_c":
                        var_4 maps\mp\gametypes\_missions::processchallenge( "ch_dom_charlielock" );
                        break;
                }
            }
        }
    }
}

updatelossstats( var_0 )
{
    if ( !var_0 maps\mp\_utility::rankingenabled() )
        return;

    if ( !isdefined( var_0.hasdoneanycombat ) || !var_0.hasdoneanycombat )
        return;

    var_0.pers["hasMatchLoss"] = 1;
    var_0 maps\mp\gametypes\_persistence::statadd( "losses", 1 );
    var_0 maps\mp\_utility::updatepersratio( "winLossRatio", "wins", "losses" );
    var_0 maps\mp\gametypes\_persistence::statsetchild( "round", "loss", 1 );
}

updatetiestats( var_0 )
{
    if ( !var_0 maps\mp\_utility::rankingenabled() )
        return;

    if ( !isdefined( var_0.hasdoneanycombat ) || !var_0.hasdoneanycombat )
        return;

    var_0 maps\mp\gametypes\_persistence::statadd( "losses", -1 );
    var_0 maps\mp\gametypes\_persistence::statadd( "ties", 1 );
    var_0 maps\mp\_utility::updatepersratio( "winLossRatio", "wins", "losses" );
    var_0 maps\mp\gametypes\_persistence::statset( "currentWinStreak", 0 );
    var_0.combatrecordtie = 1;
}

updatewinlossstats( var_0 )
{
    if ( maps\mp\_utility::privatematch() )
        return;

    if ( maps\mp\_utility::practiceroundgame() )
        return;

    if ( !isdefined( var_0 ) || isdefined( var_0 ) && isstring( var_0 ) && var_0 == "tie" )
    {
        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2.connectedpostgame ) )
                continue;

            if ( level.hostforcedend && var_2 _meth_829C() )
            {
                var_2 maps\mp\gametypes\_persistence::statset( "currentWinStreak", 0 );
                continue;
            }

            updatetiestats( var_2 );
        }
    }
    else if ( isplayer( var_0 ) )
    {
        var_4[0] = var_0;

        if ( level.players.size > 5 )
            var_4 = maps\mp\gametypes\_gamescore::gethighestscoringplayersarray( 3 );

        foreach ( var_2 in var_4 )
        {
            if ( isdefined( var_2.connectedpostgame ) )
                continue;

            if ( level.hostforcedend && var_2 _meth_829C() )
            {
                var_2 maps\mp\gametypes\_persistence::statset( "currentWinStreak", 0 );
                continue;
            }

            updatewinstats( var_2 );
        }
    }
    else if ( isstring( var_0 ) )
    {
        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2.connectedpostgame ) )
                continue;

            if ( level.hostforcedend && var_2 _meth_829C() )
            {
                var_2 maps\mp\gametypes\_persistence::statset( "currentWinStreak", 0 );
                continue;
            }

            if ( var_0 == "tie" )
            {
                updatetiestats( var_2 );
                continue;
            }

            if ( var_2.pers["team"] == var_0 )
            {
                updatewinstats( var_2 );
                continue;
            }

            var_2 maps\mp\gametypes\_persistence::statset( "currentWinStreak", 0 );
        }
    }

    if ( level.players.size > 5 )
    {
        var_4 = maps\mp\gametypes\_gamescore::gethighestscoringplayersarray( 3 );

        for ( var_9 = 0; var_9 < var_4.size; var_9++ )
        {
            if ( var_9 == 0 )
                var_4[var_9] maps\mp\gametypes\_missions::processchallenge( "ch_" + level.gametype + "_mvp" );

            var_4[var_9] maps\mp\gametypes\_missions::processchallenge( "ch_" + level.gametype + "_superior" );
        }
    }
}

freezeplayerforroundend( var_0 )
{
    self endon( "disconnect" );
    maps\mp\_utility::clearlowermessages();

    if ( !isdefined( var_0 ) )
        var_0 = 0.05;

    self _meth_8325();
    self _meth_826C();
    wait(var_0);
    maps\mp\_utility::freezecontrolswrapper( 1 );
}

updatematchbonusscores( var_0 )
{
    if ( !game["timePassed"] )
        return;

    if ( !maps\mp\_utility::matchmakinggame() )
        return;

    if ( maps\mp\_utility::practiceroundgame() )
        return;

    if ( level.teambased )
    {
        if ( var_0 == "allies" )
        {
            var_1 = "allies";
            var_2 = "axis";
        }
        else if ( var_0 == "axis" )
        {
            var_1 = "axis";
            var_2 = "allies";
        }
        else
        {
            var_1 = "tie";
            var_2 = "tie";
        }

        if ( var_1 != "tie" )
            clientannouncement( var_1 );

        foreach ( var_4 in level.players )
        {
            if ( isdefined( var_4.connectedpostgame ) )
                continue;

            if ( !var_4 maps\mp\_utility::rankingenabled() )
                continue;

            if ( var_4.timeplayed["total"] < 1 || var_4.pers["participation"] < 1 )
                continue;

            if ( level.hostforcedend && var_4 _meth_829C() )
                continue;

            var_5 = 0;

            if ( var_1 == "tie" )
            {
                var_5 = maps\mp\gametypes\_rank::getscoreinfovalue( "tie" );
                var_4.didtie = 1;
                var_4.iswinner = 0;
            }
            else if ( isdefined( var_4.pers["team"] ) && var_4.pers["team"] == var_1 )
            {
                var_5 = maps\mp\gametypes\_rank::getscoreinfovalue( "win" );
                var_4.iswinner = 1;
            }
            else if ( isdefined( var_4.pers["team"] ) && var_4.pers["team"] == var_2 )
            {
                var_5 = maps\mp\gametypes\_rank::getscoreinfovalue( "loss" );
                var_4.iswinner = 0;
            }

            var_4.matchbonus = int( var_5 );
        }
    }
    else
    {
        foreach ( var_4 in level.players )
        {
            if ( isdefined( var_4.connectedpostgame ) )
                continue;

            if ( !var_4 maps\mp\_utility::rankingenabled() )
                continue;

            if ( var_4.timeplayed["total"] < 1 || var_4.pers["participation"] < 1 )
                continue;

            if ( level.hostforcedend && var_4 _meth_829C() )
                continue;

            var_4.iswinner = 0;

            for ( var_8 = 0; var_8 < min( level.placement["all"].size, 3 ); var_8++ )
            {
                if ( level.placement["all"][var_8] != var_4 )
                    continue;

                var_4.iswinner = 1;
            }

            var_5 = 0;

            if ( var_4.iswinner )
                var_5 = maps\mp\gametypes\_rank::getscoreinfovalue( "win" );
            else
                var_5 = maps\mp\gametypes\_rank::getscoreinfovalue( "loss" );

            var_4.matchbonus = int( var_5 );
        }
    }

    foreach ( var_4 in level.players )
    {
        if ( !isdefined( var_4 ) )
            continue;

        if ( !isdefined( var_4.iswinner ) )
            continue;

        var_11 = "loss";

        if ( var_4.iswinner )
            var_11 = "win";

        if ( isdefined( var_4.didtie ) && var_4.didtie )
            var_11 = "tie";

        var_4 thread givematchbonus( var_11, var_4.matchbonus );
    }
}

givematchbonus( var_0, var_1 )
{
    self endon( "disconnect" );
    level waittill( "give_match_bonus" );
    maps\mp\gametypes\_rank::giverankxp( var_0, var_1 );
    maps\mp\_utility::logxpgains();
}

setxenonranks( var_0 )
{
    var_1 = level.players;

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = var_1[var_2];

        if ( !isdefined( var_3.score ) || !isdefined( var_3.pers["team"] ) )
            continue;
    }

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = var_1[var_2];

        if ( !isdefined( var_3.score ) || !isdefined( var_3.pers["team"] ) )
            continue;

        var_4 = var_3.score;

        if ( maps\mp\_utility::getminutespassed() )
            var_4 = var_3.score / maps\mp\_utility::getminutespassed();

        _func_173( var_3, var_3.clientid, int( var_4 ) );
    }
}

checktimelimit( var_0 )
{
    if ( isdefined( level.timelimitoverride ) && level.timelimitoverride )
        return;

    if ( game["state"] != "playing" )
    {
        setgameendtime( 0 );
        return;
    }

    if ( maps\mp\_utility::gettimelimit() <= 0 )
    {
        if ( isdefined( level.starttime ) )
            setgameendtime( level.starttime );
        else
            setgameendtime( 0 );

        return;
    }

    if ( !maps\mp\_utility::gameflag( "prematch_done" ) )
    {
        setgameendtime( 0 );
        return;
    }

    if ( !isdefined( level.starttime ) )
        return;

    if ( maps\mp\_utility::gettimepassedpercentage() > level.timepercentagecutoff )
        _func_260( 1 );

    var_1 = gettimeremaining();

    if ( maps\mp\_utility::gethalftime() && game["status"] != "halftime" )
        setgameendtime( gettime() + int( var_1 ) - int( maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5 ) );
    else
        setgameendtime( gettime() + int( var_1 ) );

    if ( var_1 > 0 )
    {
        if ( maps\mp\_utility::gethalftime() && checkhalftime( var_0 ) )
            [[ level.onhalftime ]]( "time_limit_reached" );

        return;
    }

    [[ level.ontimelimit ]]();
}

checkhalftimescore()
{
    if ( !level.halftimeonscorelimit )
        return 0;

    if ( !level.teambased )
        return 0;

    if ( game["status"] != "normal" )
        return 0;

    var_0 = maps\mp\_utility::getwatcheddvar( "scorelimit" );

    if ( var_0 )
    {
        if ( game["teamScores"]["allies"] >= var_0 || game["teamScores"]["axis"] >= var_0 )
            return 0;

        var_1 = int( var_0 / 2 + 0.5 );

        if ( game["teamScores"]["allies"] >= var_1 || game["teamScores"]["axis"] >= var_1 )
        {
            game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
            game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
            return 1;
        }
    }

    return 0;
}

checkhalftime( var_0 )
{
    if ( !level.teambased )
        return 0;

    if ( game["status"] != "normal" )
        return 0;

    if ( maps\mp\_utility::gettimelimit() )
    {
        var_1 = maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5;

        if ( maps\mp\_utility::gettimepassed() >= var_1 && var_0 < var_1 && var_0 > 0 )
        {
            game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
            return 1;
        }
    }

    return 0;
}

gettimeremaining()
{
    var_0 = maps\mp\_utility::gettimepassed();
    var_1 = maps\mp\_utility::gettimelimit() * 60 * 1000;

    if ( maps\mp\_utility::gethalftime() && game["status"] == "halftime" && isdefined( level.firsthalftimepassed ) )
    {
        var_2 = var_1 * 0.5;

        if ( level.firsthalftimepassed < var_2 )
        {
            if ( level.halftimeonscorelimit )
                var_0 = var_1 - level.firsthalftimepassed + var_0 - level.firsthalftimepassed;
            else
                var_0 += var_2 - level.firsthalftimepassed;
        }
    }

    return var_1 - var_0;
}

checkteamscorelimitsoon( var_0 )
{
    if ( maps\mp\_utility::getwatcheddvar( "scorelimit" ) <= 0 || maps\mp\_utility::isobjectivebased() )
        return;

    if ( isdefined( level.scorelimitoverride ) && level.scorelimitoverride )
        return;

    if ( level.gametype == "conf" )
        return;

    if ( !level.teambased )
        return;

    if ( maps\mp\_utility::gettimepassed() < 60000 )
        return;

    var_1 = estimatedtimetillscorelimit( var_0 );

    if ( var_1 < 2 )
        level notify( "match_ending_soon", "score" );
}

checkplayerscorelimitsoon()
{
    if ( maps\mp\_utility::getwatcheddvar( "scorelimit" ) <= 0 || maps\mp\_utility::isobjectivebased() )
        return;

    if ( level.teambased )
        return;

    if ( maps\mp\_utility::gettimepassed() < 60000 )
        return;

    var_0 = estimatedtimetillscorelimit();

    if ( var_0 < 2 )
        level notify( "match_ending_soon", "score" );
}

checkscorelimit()
{
    if ( maps\mp\_utility::isobjectivebased() )
        return 0;

    if ( isdefined( level.scorelimitoverride ) && level.scorelimitoverride )
        return 0;

    if ( game["state"] != "playing" )
        return 0;

    if ( maps\mp\_utility::getwatcheddvar( "scorelimit" ) <= 0 )
        return 0;

    if ( maps\mp\_utility::gethalftime() && checkhalftimescore() )
        return [[ level.onhalftime ]]( "score_limit_reached" );
    else if ( level.multiteambased )
    {
        var_0 = 0;

        for ( var_1 = 0; var_1 < level.teamnamelist.size; var_1++ )
        {
            if ( game["teamScores"][level.teamnamelist[var_1]] >= maps\mp\_utility::getwatcheddvar( "scorelimit" ) )
                var_0 = 1;
        }

        if ( !var_0 )
            return 0;
    }
    else if ( level.teambased )
    {
        if ( game["teamScores"]["allies"] < maps\mp\_utility::getwatcheddvar( "scorelimit" ) && game["teamScores"]["axis"] < maps\mp\_utility::getwatcheddvar( "scorelimit" ) )
            return 0;
    }
    else
    {
        if ( !isplayer( self ) )
            return 0;

        if ( self.score < maps\mp\_utility::getwatcheddvar( "scorelimit" ) )
            return 0;
    }

    return onscorelimit();
}

updategametypedvars()
{
    level endon( "game_ended" );

    while ( game["state"] == "playing" )
    {
        if ( isdefined( level.starttime ) )
        {
            if ( gettimeremaining() < 3000 )
            {
                wait 0.1;
                continue;
            }
        }

        wait 1;
    }
}

matchstarttimerwaitforplayers()
{
    setomnvar( "ui_match_countdown_title", 6 );
    setomnvar( "ui_match_countdown_toggle", 0 );

    if ( level.currentgen )
        setomnvar( "ui_cg_world_blur", 1 );

    waitforplayers( level.prematchperiod );

    if ( level.prematchperiodend > 0 && !isdefined( level.hostmigrationtimer ) )
        matchstarttimer( level.prematchperiodend );
}

matchstarttimer_internal( var_0 )
{
    waittillframeend;
    level endon( "match_start_timer_beginning" );
    setomnvar( "ui_match_countdown_title", 1 );
    setomnvar( "ui_match_countdown_toggle", 1 );

    while ( var_0 > 0 && !level.gameended )
    {
        setomnvar( "ui_match_countdown", var_0 );
        var_0--;

        if ( level.currentgen )
            setomnvar( "ui_cg_world_blur", 1 );

        wait 1;
    }

    if ( level.currentgen )
        setomnvar( "ui_cg_world_blur_fade_out", 1 );

    if ( level.xpscale > 1 && !( isdefined( level.ishorde ) && level.ishorde ) && !maps\mp\_utility::privatematch() && !maps\mp\_utility::practiceroundgame() && !( isdefined( level.iszombiegame ) && level.iszombiegame ) )
    {
        foreach ( var_2 in level.players )
            var_2 thread maps\mp\gametypes\_hud_message::splashnotify( "double_xp" );
    }

    setomnvar( "ui_match_countdown_toggle", 0 );
    setomnvar( "ui_match_countdown", 0 );
    setomnvar( "ui_match_countdown_title", 2 );
    level endon( "match_forfeit_timer_beginning" );
    wait 1.5;
    setomnvar( "ui_match_countdown_title", 0 );
}

matchstarttimer( var_0 )
{
    self notify( "matchStartTimer" );
    self endon( "matchStartTimer" );
    level notify( "match_start_timer_beginning" );
    var_1 = int( var_0 );

    if ( var_1 >= 2 )
    {
        matchstarttimer_internal( var_1 );
        visionsetnaked( "", 3.0 );
    }
    else
    {
        if ( level.currentgen )
            setomnvar( "ui_cg_world_blur_fade_out", 1 );

        if ( level.xpscale > 1 && !( isdefined( level.ishorde ) && level.ishorde ) && !maps\mp\_utility::privatematch() && !maps\mp\_utility::practiceroundgame() && !( isdefined( level.iszombiegame ) && level.iszombiegame ) )
        {
            foreach ( var_3 in level.players )
                var_3 thread maps\mp\gametypes\_hud_message::splashnotify( "double_xp" );
        }

        visionsetnaked( "", 1.0 );
    }
}

matchstarttimerskip()
{
    visionsetnaked( "", 0 );
}

onroundswitch()
{
    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    if ( game["roundsWon"]["allies"] == maps\mp\_utility::getwatcheddvar( "winlimit" ) - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::getwatcheddvar( "winlimit" ) - 1 )
    {
        var_0 = getbetterteam();

        if ( var_0 != game["defenders"] )
            game["switchedsides"] = !game["switchedsides"];

        level.halftimetype = "overtime";
        game["dynamicEvent_Overtime"] = 1;
    }
    else
    {
        level.halftimetype = "halftime";
        game["switchedsides"] = !game["switchedsides"];
    }
}

checkroundswitch()
{
    if ( !level.teambased )
        return 0;

    if ( !isdefined( level.roundswitch ) || !level.roundswitch )
        return 0;

    if ( game["roundsPlayed"] % level.roundswitch == 0 )
    {
        onroundswitch();
        return 1;
    }

    return 0;
}

timeuntilroundend()
{
    if ( level.gameended )
    {
        var_0 = ( gettime() - level.gameendtime ) / 1000;
        var_1 = level.postroundtime - var_0;

        if ( var_1 < 0 )
            return 0;

        return var_1;
    }

    if ( maps\mp\_utility::gettimelimit() <= 0 )
        return undefined;

    if ( !isdefined( level.starttime ) )
        return undefined;

    var_2 = maps\mp\_utility::gettimelimit();
    var_0 = ( gettime() - level.starttime ) / 1000;
    var_1 = maps\mp\_utility::gettimelimit() * 60 - var_0;

    if ( isdefined( level.timepaused ) )
        var_1 += level.timepaused;

    return var_1 + level.postroundtime;
}

freegameplayhudelems()
{
    if ( isdefined( self.perkicon ) )
    {
        if ( isdefined( self.perkicon[0] ) )
        {
            self.perkicon[0] maps\mp\gametypes\_hud_util::destroyelem();
            self.perkname[0] maps\mp\gametypes\_hud_util::destroyelem();
        }

        if ( isdefined( self.perkicon[1] ) )
        {
            self.perkicon[1] maps\mp\gametypes\_hud_util::destroyelem();
            self.perkname[1] maps\mp\gametypes\_hud_util::destroyelem();
        }

        if ( isdefined( self.perkicon[2] ) )
        {
            self.perkicon[2] maps\mp\gametypes\_hud_util::destroyelem();
            self.perkname[2] maps\mp\gametypes\_hud_util::destroyelem();
        }
    }

    self notify( "perks_hidden" );
    self.lowermessage maps\mp\gametypes\_hud_util::destroyelem();
    self.lowertimer maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( self.proxbar ) )
        self.proxbar maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( self.proxbartext ) )
        self.proxbartext maps\mp\gametypes\_hud_util::destroyelem();
}

gethostplayer()
{
    var_0 = getentarray( "player", "classname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( var_0[var_1] _meth_829C() )
            return var_0[var_1];
    }
}

hostidledout()
{
    var_0 = gethostplayer();

    if ( isdefined( var_0 ) && !var_0.hasspawned && !isdefined( var_0.selectedclass ) )
        return 1;

    return 0;
}

roundendwait( var_0, var_1 )
{
    foreach ( var_3 in level.players )
        var_3 maps\mp\gametypes\_damage::streamfinalkillcam();

    var_5 = 0;

    while ( !var_5 )
    {
        var_6 = level.players;
        var_5 = 1;

        foreach ( var_3 in var_6 )
        {
            if ( !isdefined( var_3.doingsplash ) )
                continue;

            if ( !var_3 maps\mp\gametypes\_hud_message::isdoingsplash() )
                continue;

            var_5 = 0;
        }

        wait 0.5;
    }

    if ( !var_1 )
    {
        wait(var_0);
        var_6 = level.players;

        foreach ( var_3 in var_6 )
            var_3 _meth_82FB( "ui_round_end", 0 );

        level notify( "round_end_finished" );
        return;
    }

    wait(var_0 / 2);
    level notify( "give_match_bonus" );
    wait(var_0 / 2);
    var_5 = 0;

    while ( !var_5 )
    {
        var_6 = level.players;
        var_5 = 1;

        foreach ( var_3 in var_6 )
        {
            if ( !isdefined( var_3.doingsplash ) )
                continue;

            if ( !var_3 maps\mp\gametypes\_hud_message::isdoingsplash() )
                continue;

            var_5 = 0;
        }

        wait 0.5;
    }

    var_6 = level.players;

    foreach ( var_3 in var_6 )
        var_3 _meth_82FB( "ui_round_end", 0 );

    level notify( "round_end_finished" );
}

roundenddof( var_0 )
{
    self _meth_8186( 0, 128, 512, 4000, 6, 1.8 );
}

callback_startgametype()
{
    maps\mp\_load::main();
    maps\mp\_utility::levelflaginit( "round_over", 0 );
    maps\mp\_utility::levelflaginit( "game_over", 0 );
    maps\mp\_utility::levelflaginit( "block_notifies", 0 );
    level.prematchperiod = 0;
    level.prematchperiodend = 0;
    level.postgamenotifies = 0;
    level.intermission = 0;
    setdvar( "bg_compassShowEnemies", getdvar( "scr_game_forceuav" ) );

    if ( !isdefined( game["gamestarted"] ) )
    {
        game["clientid"] = 0;
        var_0 = getmapcustom( "allieschar" );

        if ( !isdefined( var_0 ) || var_0 == "" )
        {
            if ( !isdefined( game["allies"] ) )
                var_0 = "sentinel";
            else
                var_0 = game["allies"];
        }

        var_1 = getmapcustom( "axischar" );

        if ( !isdefined( var_1 ) || var_1 == "" )
        {
            if ( !isdefined( game["axis"] ) )
                var_1 = "atlas";
            else
                var_1 = game["axis"];
        }

        if ( level.multiteambased )
        {
            var_2 = getmapcustom( "allieschar" );

            if ( !isdefined( var_2 ) || var_2 == "" )
                var_2 = "delta_multicam";

            for ( var_3 = 0; var_3 < level.teamnamelist.size; var_3++ )
                game[level.teamnamelist[var_3]] = var_2;
        }

        game["allies"] = var_0;
        game["axis"] = var_1;

        if ( !isdefined( game["attackers"] ) || !isdefined( game["defenders"] ) )
            thread common_scripts\utility::error( "No attackers or defenders team defined in level .gsc." );

        if ( !isdefined( game["attackers"] ) )
            game["attackers"] = "allies";

        if ( !isdefined( game["defenders"] ) )
            game["defenders"] = "axis";

        if ( !isdefined( game["state"] ) )
            game["state"] = "playing";

        if ( level.teambased )
        {
            game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_TEAMS";
            game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
        }
        else
        {
            game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_MORE_PLAYERS";
            game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
        }

        game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
        game["strings"]["match_starting_in"] = &"MP_MATCH_STARTING_IN";
        game["strings"]["match_resuming_in"] = &"MP_MATCH_RESUMING_IN";
        game["strings"]["waiting_for_players"] = &"MP_WAITING_FOR_PLAYERS";
        game["strings"]["spawn_tag_wait"] = &"MP_SPAWN_TAG_WAIT";
        game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
        game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
        game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
        game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
        game["strings"]["change_class_cancel"] = &"MP_CHANGE_CLASS_CANCEL";
        game["strings"]["change_class_wait"] = &"MP_CHANGE_CLASS_WAIT";
        game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
        game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
        game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
        game["colors"]["blue"] = ( 0.25, 0.25, 0.75 );
        game["colors"]["red"] = ( 0.75, 0.25, 0.25 );
        game["colors"]["white"] = ( 1, 1, 1 );
        game["colors"]["black"] = ( 0, 0, 0 );
        game["colors"]["grey"] = ( 0.5, 0.5, 0.5 );
        game["colors"]["green"] = ( 0.25, 0.75, 0.25 );
        game["colors"]["yellow"] = ( 0.65, 0.65, 0 );
        game["colors"]["orange"] = ( 1, 0.45, 0 );
        game["colors"]["cyan"] = ( 0.35, 0.7, 0.9 );
        game["strings"]["allies_name"] = maps\mp\gametypes\_teams::getteamname( "allies" );
        game["icons"]["allies"] = maps\mp\gametypes\_teams::getteamicon( "allies" );
        game["colors"]["allies"] = maps\mp\gametypes\_teams::getteamcolor( "allies" );
        game["strings"]["axis_name"] = maps\mp\gametypes\_teams::getteamname( "axis" );
        game["icons"]["axis"] = maps\mp\gametypes\_teams::getteamicon( "axis" );
        game["colors"]["axis"] = maps\mp\gametypes\_teams::getteamcolor( "axis" );

        if ( game["colors"]["allies"] == ( 0, 0, 0 ) )
            game["colors"]["allies"] = ( 0.5, 0.5, 0.5 );

        if ( game["colors"]["axis"] == ( 0, 0, 0 ) )
            game["colors"]["axis"] = ( 0.5, 0.5, 0.5 );

        [[ level.onprecachegametype ]]();
        setdvarifuninitialized( "min_wait_for_players", 5 );

        if ( level.console )
        {
            if ( !level.splitscreen )
            {
                if ( _func_27A() )
                    level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "graceperiod_ds" );
                else
                    level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "graceperiod" );

                level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "matchstarttime" );
            }
        }
        else
        {
            if ( _func_27A() )
                level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "playerwaittime_ds" );
            else
                level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "playerwaittime" );

            level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "matchstarttime" );
        }
    }
    else
    {
        setdvarifuninitialized( "min_wait_for_players", 5 );

        if ( level.console )
        {
            if ( !level.splitscreen )
            {
                level.prematchperiod = 5;
                level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "roundstarttime" );
            }
        }
        else
        {
            level.prematchperiod = 5;
            level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "roundstarttime" );
        }
    }

    if ( !isdefined( game["status"] ) )
        game["status"] = "normal";

    if ( game["status"] != "overtime" && game["status"] != "halftime" && game["status"] != "overtime_halftime" )
    {
        game["teamScores"]["allies"] = 0;
        game["teamScores"]["axis"] = 0;

        if ( level.multiteambased )
        {
            for ( var_3 = 0; var_3 < level.teamnamelist.size; var_3++ )
                game["teamScores"][level.teamnamelist[var_3]] = 0;
        }
    }

    if ( !isdefined( game["timePassed"] ) )
        game["timePassed"] = 0;

    if ( !isdefined( game["roundsPlayed"] ) )
        game["roundsPlayed"] = 0;

    setomnvar( "ui_current_round", game["roundsPlayed"] + 1 );

    if ( !isdefined( game["roundsWon"] ) )
        game["roundsWon"] = [];

    if ( level.teambased )
    {
        if ( !isdefined( game["roundsWon"]["axis"] ) )
            game["roundsWon"]["axis"] = 0;

        if ( !isdefined( game["roundsWon"]["allies"] ) )
            game["roundsWon"]["allies"] = 0;

        if ( level.multiteambased )
        {
            for ( var_3 = 0; var_3 < level.teamnamelist.size; var_3++ )
            {
                if ( !isdefined( game["roundsWon"][level.teamnamelist[var_3]] ) )
                    game["roundsWon"][level.teamnamelist[var_3]] = 0;
            }
        }
    }

    level.gameended = 0;
    level.forcedend = 0;
    level.hostforcedend = 0;
    level.hardcoremode = getdvarint( "g_hardcore" );

    if ( level.hardcoremode )
        logstring( "game mode: hardcore" );

    level.diehardmode = getdvarint( "scr_diehard" );

    if ( !level.teambased )
        level.diehardmode = 0;

    if ( level.diehardmode )
        logstring( "game mode: diehard" );

    level.killstreakrewards = getdvarint( "scr_game_hardpoints" );

    if ( !isdefined( level.iszombiegame ) )
        level.iszombiegame = 0;

    level.usestartspawns = 1;
    level.objectivepointsmod = 1;
    level.baseplayermovescale = 1;
    level.maxallowedteamkills = 2;
    thread maps\mp\_teleport::main();
    thread maps\mp\gametypes\_persistence::init();
    thread maps\mp\gametypes\_menus::init();
    thread maps\mp\gametypes\_hud::init();
    thread maps\mp\gametypes\_serversettings::init();
    thread maps\mp\gametypes\_teams::init();
    thread maps\mp\gametypes\_weapons::init();
    thread maps\mp\gametypes\_killcam::init();
    thread maps\mp\gametypes\_shellshock::init();
    thread maps\mp\gametypes\_deathicons::init();
    thread maps\mp\gametypes\_damagefeedback::init();
    thread maps\mp\gametypes\_healthoverlay::init();
    thread maps\mp\gametypes\_spectating::init();
    thread maps\mp\gametypes\_objpoints::init();
    thread maps\mp\gametypes\_gameobjects::init();
    thread maps\mp\gametypes\_spawnlogic::init();
    thread maps\mp\gametypes\_battlechatter_mp::init();
    thread maps\mp\gametypes\_music_and_dialog::init();
    thread maps\mp\gametypes\_high_jump_mp::init();
    thread maps\mp\_grappling_hook::init();
    thread maps\mp\_matchdata::init();
    thread maps\mp\_awards::init();
    thread maps\mp\_areas::init();

    if ( !maps\mp\_utility::invirtuallobby() )
        thread maps\mp\killstreaks\_killstreaks_init::init();

    thread maps\mp\perks\_perks::init();
    thread maps\mp\_events::init();
    thread maps\mp\gametypes\_damage::initfinalkillcam();
    thread maps\mp\_threatdetection::init();
    thread maps\mp\_exo_suit::init();
    thread maps\mp\_reinforcements::init();
    thread maps\mp\_snd_common_mp::init();
    thread maps\mp\_utility::buildattachmentmaps();

    if ( level.teambased )
        thread maps\mp\gametypes\_friendicons::init();

    thread maps\mp\gametypes\_hud_message::init();
    thread maps\mp\gametypes\_divisions::init();

    foreach ( var_5 in game["strings"] )
        precachestring( var_5 );

    foreach ( var_8 in game["icons"] )
        precacheshader( var_8 );

    game["gamestarted"] = 1;
    level.maxplayercount = 0;
    level.wavedelay["allies"] = 0;
    level.wavedelay["axis"] = 0;
    level.lastwave["allies"] = 0;
    level.lastwave["axis"] = 0;
    level.waveplayerspawnindex["allies"] = 0;
    level.waveplayerspawnindex["axis"] = 0;
    level.aliveplayers["allies"] = [];
    level.aliveplayers["axis"] = [];
    level.activeplayers = [];

    if ( level.multiteambased )
    {
        for ( var_3 = 0; var_3 < level.teamnamelist.size; var_3++ )
        {
            level._wavedelay[level.teamnamelist[var_3]] = 0;
            level._lastwave[level.teamnamelist[var_3]] = 0;
            level._waveplayerspawnindex[level.teamnamelist[var_3]] = 0;
            level._aliveplayers[level.teamnamelist[var_3]] = [];
        }
    }

    setdvar( "ui_scorelimit", 0 );
    setdvar( "ui_allow_teamchange", 1 );

    if ( maps\mp\_utility::getgametypenumlives() )
        setdvar( "g_deadChat", 0 );
    else
        setdvar( "g_deadChat", 1 );

    var_10 = getdvarfloat( "scr_" + level.gametype + "_waverespawndelay" );

    if ( var_10 > 0 )
    {
        level.wavedelay["allies"] = var_10;
        level.wavedelay["axis"] = var_10;
        level.lastwave["allies"] = 0;
        level.lastwave["axis"] = 0;

        if ( level.multiteambased )
        {
            for ( var_3 = 0; var_3 < level.teamnamelist.size; var_3++ )
            {
                level._wavedelay[level.teamnamelist[var_3]] = var_10;
                level._lastwave[level.teamnamelist[var_3]] = 0;
            }
        }

        level thread wavespawntimer();
    }

    maps\mp\_utility::gameflaginit( "prematch_done", 0 );
    level.graceperiod = 15;
    level.ingraceperiod = level.graceperiod;
    maps\mp\_utility::gameflaginit( "graceperiod_done", 0 );
    level.roundenddelay = 4;
    level.halftimeroundenddelay = 4;
    level.noragdollents = getentarray( "noragdoll", "targetname" );

    if ( level.teambased )
    {
        maps\mp\gametypes\_gamescore::updateteamscore( "axis" );
        maps\mp\gametypes\_gamescore::updateteamscore( "allies" );

        if ( level.multiteambased )
        {
            for ( var_3 = 0; var_3 < level.teamnamelist.size; var_3++ )
                maps\mp\gametypes\_gamescore::updateteamscore( level.teamnamelist[var_3] );
        }
    }
    else
        thread maps\mp\gametypes\_gamescore::initialdmscoreupdate();

    thread updateuiscorelimit();
    level notify( "update_scorelimit" );
    [[ level.onstartgametype ]]();
    level.scorepercentagecutoff = getdvarint( "scr_" + level.gametype + "_score_percentage_cut_off", 80 );
    level.timepercentagecutoff = getdvarint( "scr_" + level.gametype + "_time_percentage_cut_off", 80 );

    if ( !level.console && ( getdvar( "dedicated" ) == "dedicated LAN server" || getdvar( "dedicated" ) == "dedicated internet server" ) )
        thread verifydedicatedconfiguration();

    setattackingteam();
    thread startgame();
    level thread maps\mp\_utility::updatewatcheddvars();
    level thread timelimitthread();
    level thread maps\mp\gametypes\_damage::dofinalkillcam();
}

setattackingteam()
{
    if ( game["attackers"] == "axis" )
        var_0 = 1;
    else if ( game["attackers"] == "allies" )
        var_0 = 2;
    else
        var_0 = 0;

    setomnvar( "ui_attacking_team", var_0 );
}

callback_codeendgame()
{
    _func_174();

    if ( !level.gameended )
        level thread forceend();
}

verifydedicatedconfiguration()
{
    for (;;)
    {
        if ( level.rankedmatch )
            exitlevel( 0 );

        if ( !getdvarint( "xblive_privatematch" ) )
            exitlevel( 0 );

        if ( getdvar( "dedicated" ) != "dedicated LAN server" && getdvar( "dedicated" ) != "dedicated internet server" )
            exitlevel( 0 );

        wait 5;
    }
}

timelimitthread()
{
    level endon( "game_ended" );
    var_0 = maps\mp\_utility::gettimepassed();

    while ( game["state"] == "playing" )
    {
        thread checktimelimit( var_0 );
        var_0 = maps\mp\_utility::gettimepassed();

        if ( isdefined( level.starttime ) )
        {
            if ( gettimeremaining() < 3000 )
            {
                wait 0.1;
                continue;
            }
        }

        wait 1;
    }
}

updateuiscorelimit()
{
    for (;;)
    {
        level common_scripts\utility::waittill_either( "update_scorelimit", "update_winlimit" );

        if ( !maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased() )
        {
            setdvar( "ui_scorelimit", maps\mp\_utility::getwatcheddvar( "scorelimit" ) );
            thread checkscorelimit();
            continue;
        }

        setdvar( "ui_scorelimit", maps\mp\_utility::getwatcheddvar( "winlimit" ) );
    }
}

playtickingsound()
{
    self endon( "death" );
    self endon( "stop_ticking" );
    level endon( "game_ended" );
    var_0 = level.bombtimer;

    for (;;)
    {
        self playsound( "ui_mp_suitcasebomb_timer" );

        if ( var_0 > 10 )
        {
            var_0 -= 1;
            wait 1;
        }
        else if ( var_0 > 4 )
        {
            var_0 -= 0.5;
            wait 0.5;
        }
        else if ( var_0 > 1 )
        {
            var_0 -= 0.4;
            wait 0.4;
        }
        else
        {
            var_0 -= 0.3;
            wait 0.3;
        }

        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    }
}

stoptickingsound()
{
    self notify( "stop_ticking" );
}

timelimitclock()
{
    level endon( "game_ended" );
    wait 0.05;
    var_0 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_0 hide();

    while ( game["state"] == "playing" )
    {
        if ( !level.timerstopped && maps\mp\_utility::gettimelimit() )
        {
            var_1 = gettimeremaining() / 1000;
            var_2 = int( var_1 + 0.5 );
            var_3 = int( maps\mp\_utility::gettimelimit() * 60 * 0.5 );

            if ( maps\mp\_utility::gethalftime() && var_2 > var_3 )
                var_2 -= var_3;

            if ( var_2 >= 30 && var_2 <= 60 )
                level notify( "match_ending_soon", "time" );

            if ( var_2 <= 10 || var_2 <= 30 && var_2 % 2 == 0 )
            {
                level notify( "match_ending_very_soon" );

                if ( var_2 == 0 )
                    break;

                var_0 playsound( "ui_mp_timer_countdown" );
            }

            if ( var_1 - floor( var_1 ) >= 0.05 )
                wait(var_1 - floor( var_1 ));
        }

        wait 1.0;
    }
}

gametimer()
{
    level endon( "game_ended" );
    level waittill( "prematch_over" );
    level.starttime = gettime();
    level.discardtime = 0;
    level.matchdurationstarttime = gettime();

    if ( isdefined( game["roundMillisecondsAlreadyPassed"] ) )
    {
        level.starttime -= game["roundMillisecondsAlreadyPassed"];
        level.firsthalftimepassed = game["roundMillisecondsAlreadyPassed"];
        game["roundMillisecondsAlreadyPassed"] = undefined;
    }

    var_0 = gettime();

    while ( game["state"] == "playing" )
    {
        if ( !level.timerstopped )
            game["timePassed"] += gettime() - var_0;

        var_0 = gettime();
        wait 1.0;
    }
}

updatetimerpausedness()
{
    var_0 = level.timerstoppedforgamemode || isdefined( level.hostmigrationtimer );

    if ( !maps\mp\_utility::gameflag( "prematch_done" ) )
        var_0 = 0;

    if ( !level.timerstopped && var_0 )
    {
        level.timerstopped = 1;
        level.timerpausetime = gettime();
    }
    else if ( level.timerstopped && !var_0 )
    {
        level.timerstopped = 0;
        level.discardtime += gettime() - level.timerpausetime;
    }
}

pausetimer()
{
    level.timerstoppedforgamemode = 1;
    updatetimerpausedness();
}

resumetimer()
{
    level.timerstoppedforgamemode = 0;
    updatetimerpausedness();
}

startgame()
{
    thread gametimer();
    level.timerstopped = 0;
    level.timerstoppedforgamemode = 0;
    setdvar( "ui_inprematch", 1 );
    prematchperiod();
    maps\mp\_utility::gameflagset( "prematch_done" );
    level notify( "prematch_over" );
    setdvar( "ui_inprematch", 0 );
    level.prematch_done_time = gettime();
    updatetimerpausedness();
    thread timelimitclock();
    thread graceperiod();
    thread maps\mp\gametypes\_missions::roundbegin();
    thread maps\mp\_matchdata::matchstarted();
    var_0 = isdefined( level.ishorde ) && level.ishorde;
    var_1 = isdefined( level.iszombiegame ) && level.iszombiegame;

    if ( var_0 || var_1 )
        thread updategameduration();

    _func_240();
}

wavespawntimer()
{
    level endon( "game_ended" );

    while ( game["state"] == "playing" )
    {
        var_0 = gettime();

        if ( var_0 - level.lastwave["allies"] > level.wavedelay["allies"] * 1000 )
        {
            level notify( "wave_respawn_allies" );
            level.lastwave["allies"] = var_0;
            level.waveplayerspawnindex["allies"] = 0;
        }

        if ( var_0 - level.lastwave["axis"] > level.wavedelay["axis"] * 1000 )
        {
            level notify( "wave_respawn_axis" );
            level.lastwave["axis"] = var_0;
            level.waveplayerspawnindex["axis"] = 0;
        }

        if ( level.multiteambased )
        {
            for ( var_1 = 0; var_1 < level.teamnamelist.size; var_1++ )
            {
                if ( var_0 - level.lastwave[level.teamnamelist[var_1]] > level._wavedelay[level.teamnamelist[var_1]] * 1000 )
                {
                    var_2 = "wave_rewpawn_" + level.teamnamelist[var_1];
                    level notify( var_2 );
                    level.lastwave[level.teamnamelist[var_1]] = var_0;
                    level.waveplayerspawnindex[level.teamnamelist[var_1]] = 0;
                }
            }
        }

        wait 0.05;
    }
}

getbetterteam()
{
    var_0["allies"] = 0;
    var_0["axis"] = 0;
    var_1["allies"] = 0;
    var_1["axis"] = 0;
    var_2["allies"] = 0;
    var_2["axis"] = 0;

    foreach ( var_4 in level.players )
    {
        var_5 = var_4.pers["team"];

        if ( isdefined( var_5 ) && ( var_5 == "allies" || var_5 == "axis" ) )
        {
            var_0[var_5] += var_4.score;
            var_1[var_5] += var_4.kills;
            var_2[var_5] += var_4.deaths;
        }
    }

    if ( var_0["allies"] > var_0["axis"] )
        return "allies";
    else if ( var_0["axis"] > var_0["allies"] )
        return "axis";

    if ( var_1["allies"] > var_1["axis"] )
        return "allies";
    else if ( var_1["axis"] > var_1["allies"] )
        return "axis";

    if ( var_2["allies"] < var_2["axis"] )
        return "allies";
    else if ( var_2["axis"] < var_2["allies"] )
        return "axis";

    if ( randomint( 2 ) == 0 )
        return "allies";

    return "axis";
}

rankedmatchupdates( var_0 )
{
    if ( !maps\mp\_utility::waslastround() )
        return;

    var_0 = getgamewinner( var_0, 0 );

    if ( maps\mp\_utility::matchmakinggame() )
    {
        setxenonranks();

        if ( hostidledout() )
        {
            level.hostforcedend = 1;
            logstring( "host idled out" );
            endlobby();
        }

        updatematchbonusscores( var_0 );
    }

    updatewinlossstats( var_0 );
}

displayroundend( var_0, var_1 )
{
    if ( !maps\mp\_utility::practiceroundgame() )
    {
        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_3.connectedpostgame ) || var_3.pers["team"] == "spectator" && !var_3 _meth_8432() )
                continue;

            if ( level.teambased )
            {
                var_3 thread maps\mp\gametypes\_hud_message::teamoutcomenotify( var_0, 1, var_1 );
                continue;
            }

            var_3 thread maps\mp\gametypes\_hud_message::outcomenotify( var_0, var_1 );
        }
    }

    if ( !maps\mp\_utility::waslastround() )
        level notify( "round_win", var_0 );

    if ( maps\mp\_utility::waslastround() )
        roundendwait( level.roundenddelay, 0 );
    else
        roundendwait( level.roundenddelay, 1 );
}

displaygameend( var_0, var_1 )
{
    if ( !maps\mp\_utility::practiceroundgame() )
    {
        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_3.connectedpostgame ) || var_3.pers["team"] == "spectator" && !var_3 _meth_8432() )
                continue;

            if ( level.teambased )
            {
                var_3 thread maps\mp\gametypes\_hud_message::teamoutcomenotify( var_0, 0, var_1, 1 );
                continue;
            }

            var_3 thread maps\mp\gametypes\_hud_message::outcomenotify( var_0, var_1 );
        }
    }

    level notify( "game_win", var_0 );
    roundendwait( level.postroundtime, 1 );
}

displayroundswitch()
{
    var_0 = level.halftimetype;

    if ( var_0 == "halftime" )
    {
        if ( maps\mp\_utility::getwatcheddvar( "roundlimit" ) )
        {
            if ( game["roundsPlayed"] * 2 == maps\mp\_utility::getwatcheddvar( "roundlimit" ) )
                var_0 = "halftime";
            else
                var_0 = "intermission";
        }
        else if ( maps\mp\_utility::getwatcheddvar( "winlimit" ) )
        {
            if ( game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar( "winlimit" ) - 1 )
                var_0 = "halftime";
            else
                var_0 = "intermission";
        }
        else
            var_0 = "intermission";
    }

    level notify( "round_switch", var_0 );

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2.connectedpostgame ) || var_2.pers["team"] == "spectator" && !var_2 _meth_8432() )
            continue;

        var_2 thread maps\mp\gametypes\_hud_message::teamoutcomenotify( var_0, 1, game["end_reason"]["switching_sides"] );
    }

    roundendwait( level.halftimeroundenddelay, 0 );
}

freezeallplayers( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    foreach ( var_3 in level.players )
    {
        var_3 disableammogeneration();
        var_3 thread freezeplayerforroundend( var_0 );
        var_3 thread roundenddof( 4.0 );
        var_3 freegameplayhudelems();

        if ( isdefined( var_1 ) && var_1 )
        {
            var_3 _meth_82FD( "cg_everyoneHearsEveryone", 1, "cg_fovScale", 1 );
            var_3 _meth_82FB( "fov_scale", 1 );
            continue;
        }

        var_3 _meth_82FD( "cg_everyoneHearsEveryone", 1 );
    }

    if ( isdefined( level.agentarray ) )
    {
        foreach ( var_6 in level.agentarray )
            var_6 maps\mp\_utility::freezecontrolswrapper( 1 );
    }
}

endgameovertime( var_0, var_1 )
{
    setdvar( "bg_compassShowEnemies", 0 );
    freezeallplayers( 1.0, 1 );

    foreach ( var_3 in level.players )
    {
        var_3.pers["stats"] = var_3.stats;
        var_3.pers["segments"] = var_3.segments;
    }

    level notify( "round_switch", "overtime" );
    var_5 = 0;
    var_6 = var_0 == "overtime";

    if ( level.gametype == "ctf" )
    {
        var_0 = "tie";
        var_5 = 1;

        if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
            var_0 = "axis";

        if ( game["teamScores"]["allies"] > game["teamScores"]["axis"] )
            var_0 = "allies";
    }

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3.connectedpostgame ) || var_3.pers["team"] == "spectator" && !var_3 _meth_8432() )
            continue;

        if ( level.teambased )
        {
            var_3 thread maps\mp\gametypes\_hud_message::teamoutcomenotify( var_0, var_5, var_1 );
            continue;
        }

        var_3 thread maps\mp\gametypes\_hud_message::outcomenotify( var_0, var_1 );
    }

    roundendwait( level.roundenddelay, 0 );

    if ( level.gametype == "ctf" )
        var_0 = "overtime_halftime";

    if ( isdefined( level.finalkillcam_winner ) && var_6 )
    {
        level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();

        foreach ( var_3 in level.players )
            var_3 notify( "reset_outcome" );

        level notify( "game_cleanup" );
        waittillfinalkillcamdone();

        if ( level.gametype == "ctf" )
        {
            var_0 = "overtime";
            var_1 = game["end_reason"]["tie"];
        }

        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_3.connectedpostgame ) || var_3.pers["team"] == "spectator" && !var_3 _meth_8432() )
                continue;

            if ( level.teambased )
            {
                var_3 thread maps\mp\gametypes\_hud_message::teamoutcomenotify( var_0, 0, var_1 );
                continue;
            }

            var_3 thread maps\mp\gametypes\_hud_message::outcomenotify( var_0, var_1 );
        }

        roundendwait( level.halftimeroundenddelay, 0 );
    }

    game["status"] = var_0;
    level notify( "restarting" );
    game["state"] = "playing";
    setdvar( "ui_game_state", game["state"] );
    _func_169( 1 );
}

endgamehalftime( var_0 )
{
    setdvar( "bg_compassShowEnemies", 0 );
    var_1 = "halftime";
    var_2 = 1;

    if ( isdefined( level.halftime_switch_sides ) && !level.halftime_switch_sides )
        var_2 = 0;

    if ( var_2 )
    {
        game["switchedsides"] = !game["switchedsides"];
        var_3 = game["end_reason"]["switching_sides"];
    }
    else
        var_3 = var_0;

    freezeallplayers( 1.0, 1 );

    if ( level.gametype == "ctf" )
    {
        var_3 = var_0;
        var_1 = "tie";

        if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
            var_1 = "axis";

        if ( game["teamScores"]["allies"] > game["teamScores"]["axis"] )
            var_1 = "allies";
    }

    foreach ( var_5 in level.players )
    {
        var_5.pers["stats"] = var_5.stats;
        var_5.pers["segments"] = var_5.segments;
    }

    level notify( "round_switch", "halftime" );

    foreach ( var_5 in level.players )
    {
        if ( isdefined( var_5.connectedpostgame ) || var_5.pers["team"] == "spectator" && !var_5 _meth_8432() )
            continue;

        var_5 thread maps\mp\gametypes\_hud_message::teamoutcomenotify( var_1, 1, var_3 );
    }

    roundendwait( level.roundenddelay, 0 );

    if ( isdefined( level.finalkillcam_winner ) )
    {
        level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();

        foreach ( var_5 in level.players )
            var_5 notify( "reset_outcome" );

        level notify( "game_cleanup" );
        waittillfinalkillcamdone();
        var_11 = game["end_reason"]["switching_sides"];

        if ( !var_2 )
            var_11 = var_3;

        foreach ( var_5 in level.players )
        {
            if ( isdefined( var_5.connectedpostgame ) || var_5.pers["team"] == "spectator" && !var_5 _meth_8432() )
                continue;

            var_5 thread maps\mp\gametypes\_hud_message::teamoutcomenotify( "halftime", 1, var_11 );
        }

        roundendwait( level.halftimeroundenddelay, 0 );
    }

    game["status"] = "halftime";
    level notify( "restarting" );
    game["state"] = "playing";
    setdvar( "ui_game_state", game["state"] );
    _func_169( 1 );
}

updategameduration()
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = getgameduration();
        setomnvar( "ui_game_duration", var_0 * 1000 );
        wait 1.0;
    }
}

getgameduration()
{
    var_0 = maps\mp\_utility::getgametimepassedseconds();

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_0 = gamedurationclamp( var_0 );

    return var_0;
}

gamedurationclamp( var_0 )
{
    if ( var_0 > 86399 )
        return 86399;

    return var_0;
}

endgame( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( game["state"] == "postgame" || level.gameended )
        return;

    game["state"] = "postgame";
    setdvar( "ui_game_state", "postgame" );
    level.gameendtime = gettime();
    level.gameended = 1;
    level.ingraceperiod = 0;
    level notify( "game_ended", var_0 );
    maps\mp\_utility::levelflagset( "game_over" );
    maps\mp\_utility::levelflagset( "block_notifies" );
    var_3 = getgameduration();
    setomnvar( "ui_game_duration", var_3 * 1000 );
    waitframe();
    setgameendtime( 0 );
    setmatchdata( "gameLengthSeconds", var_3 );
    setmatchdata( "endTimeUTC", getsystemtime() );
    checkgameendchallenges();

    if ( isdefined( var_0 ) && isstring( var_0 ) && maps\mp\_utility::isovertimetext( var_0 ) )
    {
        level.finalkillcam_winner = "none";
        endgameovertime( var_0, var_1 );
        return;
    }

    if ( isdefined( var_0 ) && isstring( var_0 ) && var_0 == "halftime" )
    {
        level.finalkillcam_winner = "none";
        endgamehalftime( var_1 );
        return;
    }

    if ( isdefined( level.finalkillcam_winner ) )
        level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();

    game["roundsPlayed"]++;
    setomnvar( "ui_current_round", game["roundsPlayed"] );

    if ( level.teambased )
    {
        if ( ( var_0 == "axis" || var_0 == "allies" ) && level.gametype != "ctf" )
            game["roundsWon"][var_0]++;

        maps\mp\gametypes\_gamescore::updateteamscore( "axis" );
        maps\mp\gametypes\_gamescore::updateteamscore( "allies" );
    }
    else if ( isdefined( var_0 ) && isplayer( var_0 ) )
        game["roundsWon"][var_0.guid]++;

    maps\mp\gametypes\_gamescore::updateplacement();
    rankedmatchupdates( var_0 );

    foreach ( var_5 in level.players )
    {
        var_5 _meth_82FC( "ui_opensummary", 1 );

        if ( maps\mp\_utility::wasonlyround() || maps\mp\_utility::waslastround() )
            var_5 maps\mp\killstreaks\_killstreaks::clearkillstreaks( 1 );
    }

    setdvar( "g_deadChat", 1 );
    setdvar( "ui_allow_teamchange", 0 );
    setdvar( "bg_compassShowEnemies", 0 );
    freezeallplayers( 1.0, 1 );

    if ( !maps\mp\_utility::wasonlyround() && !var_2 )
    {
        displayroundend( var_0, var_1 );

        if ( isdefined( level.finalkillcam_winner ) )
        {
            foreach ( var_5 in level.players )
                var_5 notify( "reset_outcome" );

            level notify( "game_cleanup" );
            waittillfinalkillcamdone();
        }

        if ( !maps\mp\_utility::waslastround() )
        {
            maps\mp\_utility::levelflagclear( "block_notifies" );

            if ( checkroundswitch() )
                displayroundswitch();

            foreach ( var_5 in level.players )
            {
                var_5.pers["stats"] = var_5.stats;
                var_5.pers["segments"] = var_5.segments;
            }

            level notify( "restarting" );
            game["state"] = "playing";
            setdvar( "ui_game_state", "playing" );
            _func_169( 1 );
            return;
        }

        if ( !level.forcedend )
            var_1 = updateendreasontext( var_0 );
    }

    if ( !isdefined( game["clientMatchDataDef"] ) )
    {
        game["clientMatchDataDef"] = "mp/clientmatchdata.def";
        setclientmatchdatadef( game["clientMatchDataDef"] );
    }

    maps\mp\gametypes\_missions::roundend( var_0 );
    var_0 = getgamewinner( var_0, 1 );

    if ( level.teambased )
    {
        setomnvar( "ui_game_victor", 0 );

        if ( var_0 == "allies" )
            setomnvar( "ui_game_victor", 2 );
        else if ( var_0 == "axis" )
            setomnvar( "ui_game_victor", 1 );
    }

    displaygameend( var_0, var_1 );
    var_11 = gettime();

    if ( isdefined( level.finalkillcam_winner ) && maps\mp\_utility::wasonlyround() )
    {
        foreach ( var_5 in level.players )
            var_5 notify( "reset_outcome" );

        level notify( "game_cleanup" );
        waittillfinalkillcamdone();
    }

    maps\mp\_utility::levelflagclear( "block_notifies" );
    level.intermission = 1;
    level notify( "spawning_intermission" );

    foreach ( var_5 in level.players )
    {
        var_5 _meth_8325();
        var_5 _meth_826C();
        var_5 notify( "reset_outcome" );
        var_5 thread maps\mp\gametypes\_playerlogic::spawnintermission();
    }

    processlobbydata();
    wait 1.0;
    checkforpersonalbests();
    updatecombatrecord();

    if ( level.teambased )
    {
        if ( var_0 == "axis" || var_0 == "allies" )
            setmatchdata( "victor", var_0 );
        else
            setmatchdata( "victor", "none" );

        setmatchdata( "alliesScore", game["teamScores"]["allies"] );
        setmatchdata( "axisScore", game["teamScores"]["axis"] );
        _func_242( var_0 );
    }
    else
        setmatchdata( "victor", "none" );

    level maps\mp\_matchdata::endofgamesummarylogger();

    foreach ( var_5 in level.players )
    {
        if ( var_5 maps\mp\_utility::rankingenabled() )
            var_5 maps\mp\_matchdata::logfinalstats();

        var_5 maps\mp\gametypes\_playerlogic::logplayerstats();
    }

    setmatchdata( "host", maps\mp\gametypes\_playerlogic::truncateplayername( level.hostname ) );

    if ( maps\mp\_utility::matchmakinggame() )
    {
        setmatchdata( "playlistVersion", _func_27B() );
        setmatchdata( "playlistID", _func_27C() );
        setmatchdata( "isDedicated", _func_27A() );
    }

    setmatchdata( "levelMaxClients", level.maxclients );
    sendmatchdata();

    foreach ( var_5 in level.players )
    {
        var_5.pers["stats"] = var_5.stats;
        var_5.pers["segments"] = var_5.segments;
    }

    _func_243();
    var_20 = 0;

    if ( maps\mp\_utility::practiceroundgame() )
        var_20 = 5.0;

    if ( isdefined( level.endgamewaitfunc ) )
        [[ level.endgamewaitfunc ]]( var_2, level.postgamenotifies, var_20, var_0 );
    else if ( !var_2 && !level.postgamenotifies )
    {
        if ( !maps\mp\_utility::wasonlyround() )
            wait(6.0 + var_20);
        else
            wait(min( 10.0, 4.0 + var_20 + level.postgamenotifies ));
    }
    else
        wait(min( 10.0, 4.0 + var_20 + level.postgamenotifies ));

    var_21 = "_gamelogic.gsc";
    var_22 = "all";

    if ( level.teambased && isdefined( var_0 ) )
        var_22 = var_0;

    var_23 = "undefined";

    if ( isdefined( var_1 ) )
    {
        switch ( var_1 )
        {
            case 1:
                var_23 = "MP_SCORE_LIMIT_REACHED";
                break;
            case 2:
                var_23 = "MP_TIME_LIMIT_REACHED";
                break;
            case 3:
                var_23 = "MP_PLAYERS_FORFEITED";
                break;
            case 4:
                var_23 = "MP_TARGET_DESTROYED";
                break;
            case 5:
                var_23 = "MP_BOMB_DEFUSED";
                break;
            case 6:
                var_23 = "MP_GHOSTS_ELIMINATED";
                break;
            case 7:
                var_23 = "MP_FEDERATION_ELIMINATED";
                break;
            case 8:
                var_23 = "MP_GHOSTS_FORFEITED";
                break;
            case 9:
                var_23 = "MP_FEDERATION_FORFEITED";
                break;
            case 10:
                var_23 = "MP_ENEMIES_ELIMINATED";
                break;
            case 11:
                var_23 = "MP_MATCH_TIE";
                break;
            case 12:
                var_23 = "GAME_OBJECTIVECOMPLETED";
                break;
            case 13:
                var_23 = "GAME_OBJECTIVEFAILED";
                break;
            case 14:
                var_23 = "MP_SWITCHING_SIDES";
                break;
            case 15:
                var_23 = "MP_ROUND_LIMIT_REACHED";
                break;
            case 16:
                var_23 = "MP_ENDED_GAME";
                break;
            case 17:
                var_23 = "MP_HOST_ENDED_GAME";
                break;
            default:
                break;
        }
    }

    if ( !isdefined( var_11 ) )
        var_11 = -1;

    var_24 = 15;
    var_25 = var_24;
    var_26 = getmatchdata( "playerCount" );
    var_27 = getmatchdata( "lifeCount" );

    if ( !isdefined( level.matchdata ) )
    {
        var_28 = 0;
        var_29 = 0;
        var_30 = 0;
        var_31 = 0;
        var_32 = 0;
        var_33 = 0;
        var_34 = 0;
    }
    else
    {
        if ( isdefined( level.matchdata["botJoinCount"] ) )
            var_28 = level.matchdata["botJoinCount"];
        else
            var_28 = 0;

        if ( isdefined( level.matchdata["deathCount"] ) )
            var_29 = level.matchdata["deathCount"];
        else
            var_29 = 0;

        if ( isdefined( level.matchdata["badSpawnDiedTooFastCount"] ) )
            var_30 = level.matchdata["badSpawnDiedTooFastCount"];
        else
            var_30 = 0;

        if ( isdefined( level.matchdata["badSpawnKilledTooFastCount"] ) )
            var_31 = level.matchdata["badSpawnKilledTooFastCount"];
        else
            var_31 = 0;

        if ( isdefined( level.matchdata["badSpawnDmgDealtCount"] ) )
            var_32 = level.matchdata["badSpawnDmgDealtCount"];
        else
            var_32 = 0;

        if ( isdefined( level.matchdata["badSpawnDmgReceivedCount"] ) )
            var_33 = level.matchdata["badSpawnDmgReceivedCount"];
        else
            var_33 = 0;

        if ( isdefined( level.matchdata["badSpawnByAnyMeansCount"] ) )
            var_34 = level.matchdata["badSpawnByAnyMeansCount"];
        else
            var_34 = 0;
    }

    var_35 = 0;

    if ( isdefined( level.spawnsighttracesused_pres1tu ) )
        var_35 += 1;

    if ( isdefined( level.spawnsighttracesused_posts1tu ) )
        var_35 += 2;

    reconevent( "script_mp_match_end: script_file %s, gameTime %d, match_winner %s, win_reason %s, version %d, joinCount %d, botJoinCount %d, spawnCount %d, deathCount %d, badSpawnDiedTooFastCount %d, badSpawnKilledTooFastCount %d, badSpawnDmgDealtCount %d, badSpawnDmgReceivedCount %d, badSpawnByAnyMeansCount %d, sightTraceMethodsUsed %d", var_21, var_11, var_22, var_23, var_25, var_26, var_28, var_27, var_29, var_30, var_31, var_32, var_33, var_34, var_35 );

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        if ( isdefined( level.zombiescompleted ) && level.zombiescompleted )
            setdvar( "cg_drawCrosshair", 1 );
    }

    level notify( "exitLevel_called" );
    exitlevel( 0 );
}

getgamewinner( var_0, var_1 )
{
    if ( !isstring( var_0 ) )
        return var_0;

    var_2 = var_0;

    if ( level.teambased && ( maps\mp\_utility::isroundbased() || level.gametype == "ctf" ) && level.gameended )
    {
        var_3 = "roundsWon";

        if ( isdefined( level.winbycaptures ) && level.winbycaptures )
            var_3 = "teamScores";

        if ( game[var_3]["allies"] == game[var_3]["axis"] )
            var_2 = "tie";
        else if ( game[var_3]["axis"] > game[var_3]["allies"] )
            var_2 = "axis";
        else
            var_2 = "allies";
    }

    if ( var_1 && ( var_2 == "allies" || var_2 == "axis" ) )
        level.finalkillcam_winner = var_2;

    return var_2;
}

updateendreasontext( var_0 )
{
    if ( !level.teambased )
        return 1;

    if ( maps\mp\_utility::hitroundlimit() )
        return game["end_reason"]["round_limit_reached"];

    if ( maps\mp\_utility::hitwinlimit() )
        return game["end_reason"]["score_limit_reached"];

    return game["end_reason"]["objective_completed"];
}

estimatedtimetillscorelimit( var_0 )
{
    var_1 = getscoreperminute( var_0 );
    var_2 = getscoreremaining( var_0 );
    var_3 = 999999;

    if ( var_1 )
        var_3 = var_2 / var_1;

    return var_3;
}

getscoreperminute( var_0 )
{
    var_1 = maps\mp\_utility::getwatcheddvar( "scorelimit" );
    var_2 = maps\mp\_utility::gettimelimit();
    var_3 = maps\mp\_utility::gettimepassed() / 60000 + 0.0001;

    if ( isplayer( self ) )
        var_4 = self.score / var_3;
    else
        var_4 = setclientnamemode( var_0 ) / var_3;

    return var_4;
}

getscoreremaining( var_0 )
{
    var_1 = maps\mp\_utility::getwatcheddvar( "scorelimit" );

    if ( isplayer( self ) )
        var_2 = var_1 - self.score;
    else
        var_2 = var_1 - setclientnamemode( var_0 );

    return var_2;
}

givelastonteamwarning()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    maps\mp\_utility::waittillrecoveredhealth( 3 );
    thread maps\mp\_utility::teamplayercardsplash( "callout_lastteammemberalive", self, self.pers["team"] );

    if ( level.multiteambased )
    {
        foreach ( var_1 in level.teamnamelist )
        {
            if ( self.pers["team"] != var_1 )
                thread maps\mp\_utility::teamplayercardsplash( "callout_lastenemyalive", self, var_1 );
        }
    }
    else
    {
        var_3 = maps\mp\_utility::getotherteam( self.pers["team"] );
        thread maps\mp\_utility::teamplayercardsplash( "callout_lastenemyalive", self, var_3 );
    }

    level notify( "last_alive", self );
}

processlobbydata()
{
    var_0 = 0;

    foreach ( var_2 in level.players )
    {
        if ( !isdefined( var_2 ) )
            continue;

        var_2.clientmatchdataid = var_0;
        var_0++;

        if ( isdefined( level.iszombiegame ) && level.iszombiegame )
            var_2.clientmatchdataid = var_2 _meth_81B1();

        setclientmatchdata( "players", var_2.clientmatchdataid, "name", maps\mp\gametypes\_playerlogic::truncateplayername( var_2.name ) );
        setclientmatchdata( "players", var_2.clientmatchdataid, "xuid", var_2.xuid );
    }

    maps\mp\_awards::assignawards();
    maps\mp\_scoreboard::processlobbyscoreboards();
    sendclientmatchdata();
    _func_23E();
}

trackleaderboarddeathstats( var_0, var_1 )
{
    thread threadedsetweaponstatbyname( var_0, 1, "deaths" );
}

trackattackerleaderboarddeathstats( var_0, var_1, var_2 )
{
    if ( isdefined( self ) && isplayer( self ) )
    {
        if ( var_1 != "MOD_FALLING" )
        {
            if ( maps\mp\_utility::ismeleemod( var_1 ) && issubstr( var_0, "tactical" ) )
                return;

            if ( maps\mp\_utility::ismeleemod( var_1 ) && !issubstr( var_0, "riotshield" ) && !issubstr( var_0, "combatknife" ) )
                return;

            thread threadedsetweaponstatbyname( var_0, 1, "kills" );
            var_3 = 0;

            if ( isdefined( var_2 ) && isdefined( var_2.firedads ) )
                var_3 = var_2.firedads;
            else
                var_3 = self _meth_8340();

            if ( var_3 < 0.2 )
                thread threadedsetweaponstatbyname( var_0, 1, "hipfirekills" );
        }

        if ( var_1 == "MOD_HEAD_SHOT" )
            thread threadedsetweaponstatbyname( var_0, 1, "headShots" );
    }
}

setweaponstat( var_0, var_1, var_2 )
{
    if ( !var_1 )
        return;

    var_3 = maps\mp\_utility::getweaponclass( var_0 );

    if ( var_3 == "killstreak" || var_3 == "other" )
        return;

    if ( maps\mp\_utility::isenvironmentweapon( var_0 ) )
        return;

    if ( maps\mp\_utility::isbombsiteweapon( var_0 ) )
        return;

    if ( var_0 == maps\mp\_grappling_hook::get_grappling_hook_weapon() )
        return;

    if ( var_3 == "weapon_grenade" || var_3 == "weapon_explosive" )
    {
        var_4 = maps\mp\_utility::strip_suffix( var_0, "_lefthand" );
        var_4 = maps\mp\_utility::strip_suffix( var_4, "_mp" );
        maps\mp\gametypes\_persistence::incrementweaponstat( var_4, var_2, var_1 );
        maps\mp\_matchdata::logweaponstat( var_4, var_2, var_1 );
        return;
    }

    var_5 = maps\mp\gametypes\_weapons::isprimaryorsecondaryprojectileweapon( var_0 );

    if ( var_2 != "timeInUse" && var_2 != "deaths" && !var_5 )
    {
        var_6 = var_0;
        var_0 = self _meth_8311();

        if ( var_0 != var_6 && maps\mp\_utility::iskillstreakweapon( var_0 ) )
            return;
    }

    if ( !isdefined( self.trackingweaponname ) )
        self.trackingweaponname = var_0;

    if ( var_0 != self.trackingweaponname )
    {
        maps\mp\gametypes\_persistence::updateweaponbufferedstats();
        self.trackingweaponname = var_0;
        self.currentfirefightshots = 0;
    }

    switch ( var_2 )
    {
        case "shots":
            self.trackingweaponshots++;
            self.currentfirefightshots++;
            break;
        case "hits":
            self.trackingweaponhits++;
            break;
        case "headShots":
            self.trackingweaponheadshots++;
            self.trackingweaponhits++;
            break;
        case "kills":
            self.trackingweaponkills++;
            break;
        case "hipfirekills":
            self.trackingweaponhipfirekills++;
            break;
        case "timeInUse":
            self.trackingweaponusetime += var_1;
            break;
    }

    if ( var_2 == "deaths" )
    {
        var_7 = maps\mp\_utility::getbaseweaponname( var_0 );

        if ( !maps\mp\_utility::iscacprimaryweapon( var_7 ) && !maps\mp\_utility::iscacsecondaryweapon( var_7 ) )
            return;

        var_8 = maps\mp\_utility::getweaponattachmentsbasenames( var_0 );
        maps\mp\gametypes\_persistence::incrementweaponstat( var_7, var_2, var_1 );
        maps\mp\_matchdata::logweaponstat( var_7, "deaths", var_1 );

        foreach ( var_10 in var_8 )
            maps\mp\gametypes\_persistence::incrementattachmentstat( var_10, var_2, var_1 );
    }
}

setinflictorstat( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        return;

    if ( !isdefined( var_0 ) )
    {
        var_1 setweaponstat( var_2, 1, "hits" );
        return;
    }

    if ( !isdefined( var_0.playeraffectedarray ) )
        var_0.playeraffectedarray = [];

    var_3 = 1;

    for ( var_4 = 0; var_4 < var_0.playeraffectedarray.size; var_4++ )
    {
        if ( var_0.playeraffectedarray[var_4] == self )
        {
            var_3 = 0;
            break;
        }
    }

    if ( var_3 )
    {
        var_0.playeraffectedarray[var_0.playeraffectedarray.size] = self;
        var_1 setweaponstat( var_2, 1, "hits" );
    }
}

threadedsetweaponstatbyname( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    waittillframeend;
    setweaponstat( var_0, var_1, var_2 );
}

checkforpersonalbests()
{
    foreach ( var_1 in level.players )
    {
        if ( !isdefined( var_1 ) )
            continue;

        if ( var_1 maps\mp\_utility::rankingenabled() )
        {
            var_2 = var_1 _meth_8226( "round", "kills" );
            var_3 = var_1 _meth_8226( "round", "deaths" );
            var_4 = var_1.pers["summary"]["xp"];
            var_5 = var_1.score;
            var_6 = getroundaccuracy( var_1 );
            var_7 = var_1 _meth_8223( "bestKills" );
            var_8 = var_1 _meth_8223( "mostDeaths" );
            var_9 = var_1 _meth_8223( "mostXp" );
            var_10 = var_1 _meth_8223( "bestScore" );
            var_11 = var_1 _meth_8223( "bestAccuracy" );

            if ( var_2 > var_7 )
                var_1 _meth_8244( "bestKills", var_2 );

            if ( var_4 > var_9 )
                var_1 _meth_8244( "mostXp", var_4 );

            if ( var_3 > var_8 )
                var_1 _meth_8244( "mostDeaths", var_3 );

            if ( var_5 > var_10 )
                var_1 _meth_8244( "bestScore", var_5 );

            if ( var_6 > var_11 )
                var_1 _meth_8244( "bestAccuracy", var_6 );

            var_1 checkforbestweapon();
            var_1 maps\mp\_matchdata::logplayerxp( var_4, "totalXp" );
            var_1 maps\mp\_matchdata::logplayerxp( var_1.pers["summary"]["score"], "scoreXp" );
            var_1 maps\mp\_matchdata::logplayerxp( var_1.pers["summary"]["challenge"], "challengeXp" );
            var_1 maps\mp\_matchdata::logplayerxp( var_1.pers["summary"]["match"], "matchXp" );
            var_1 maps\mp\_matchdata::logplayerxp( var_1.pers["summary"]["misc"], "miscXp" );
        }

        if ( isdefined( var_1.pers["confirmed"] ) )
            var_1 maps\mp\_matchdata::logkillsconfirmed();

        if ( isdefined( var_1.pers["denied"] ) )
            var_1 maps\mp\_matchdata::logkillsdenied();
    }
}

getroundaccuracy( var_0 )
{
    var_1 = float( var_0 _meth_8223( "totalShots" ) - var_0.pers["previous_shots"] );

    if ( var_1 == 0 )
        return 0;

    var_2 = float( var_0 _meth_8223( "hits" ) - var_0.pers["previous_hits"] );
    var_3 = clamp( var_2 / var_1, 0.0, 1.0 ) * 10000.0;
    return int( var_3 );
}

checkforbestweapon()
{
    var_0 = maps\mp\_matchdata::buildbaseweaponlist();

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_2 = var_0[var_1];
        var_2 = maps\mp\_utility::getbaseweaponname( var_2 );
        var_3 = maps\mp\_utility::getweaponclass( var_2 );

        if ( !maps\mp\_utility::iskillstreakweapon( var_2 ) && var_3 != "killstreak" && var_3 != "other" )
        {
            var_4 = self _meth_8223( "bestWeapon", "kills" );
            var_5 = 0;

            if ( isdefined( self.pers["mpWeaponStats"][var_2] ) && isdefined( self.pers["mpWeaponStats"][var_2]["kills"] ) )
            {
                var_5 = self.pers["mpWeaponStats"][var_2]["kills"];

                if ( var_5 > var_4 )
                {
                    self _meth_8244( "bestWeapon", "kills", var_5 );
                    var_6 = 0;

                    if ( isdefined( self.pers["mpWeaponStats"][var_2]["shots"] ) )
                        var_6 = self.pers["mpWeaponStats"][var_2]["shots"];

                    var_7 = 0;

                    if ( isdefined( self.pers["mpWeaponStats"][var_2]["headShots"] ) )
                        var_7 = self.pers["mpWeaponStats"][var_2]["headShots"];

                    var_8 = 0;

                    if ( isdefined( self.pers["mpWeaponStats"][var_2]["hits"] ) )
                        var_8 = self.pers["mpWeaponStats"][var_2]["hits"];

                    var_9 = 0;

                    if ( isdefined( self.pers["mpWeaponStats"][var_2]["deaths"] ) )
                        var_9 = self.pers["mpWeaponStats"][var_2]["deaths"];

                    self _meth_8244( "bestWeapon", "shots", var_6 );
                    self _meth_8244( "bestWeapon", "headShots", var_7 );
                    self _meth_8244( "bestWeapon", "hits", var_8 );
                    self _meth_8244( "bestWeapon", "deaths", var_9 );
                    var_10 = int( tablelookup( "mp/statstable.csv", 4, var_2, 0 ) );
                    self _meth_8244( "bestWeaponIndex", var_10 );
                }
            }
        }
    }
}

updatecombatrecordforplayertrends()
{
    var_0 = 5;
    var_1 = self _meth_8223( "combatRecord", "numTrends" );
    var_1++;

    if ( var_1 > var_0 )
    {
        var_1 = var_0;

        if ( var_0 > 1 )
        {
            for ( var_2 = 0; var_2 < var_0 - 1; var_2++ )
            {
                var_3 = self _meth_8223( "combatRecord", "trend", var_2 + 1, "timestamp" );
                var_4 = self _meth_8223( "combatRecord", "trend", var_2 + 1, "kills" );
                var_5 = self _meth_8223( "combatRecord", "trend", var_2 + 1, "deaths" );
                self _meth_8244( "combatRecord", "trend", var_2, "timestamp", var_3 );
                self _meth_8244( "combatRecord", "trend", var_2, "kills", var_4 );
                self _meth_8244( "combatRecord", "trend", var_2, "deaths", var_5 );
            }
        }
    }

    var_3 = maps\mp\_utility::gettimeutc_for_stat_recording();
    var_4 = self.kills;
    var_5 = self.deaths;
    self _meth_8244( "combatRecord", "trend", var_1 - 1, "timestamp", var_3 );
    self _meth_8244( "combatRecord", "trend", var_1 - 1, "kills", var_4 );
    self _meth_8244( "combatRecord", "trend", var_1 - 1, "deaths", var_5 );
    self _meth_8244( "combatRecord", "numTrends", var_1 );
}

updatecombatrecordcommondata()
{
    var_0 = maps\mp\_utility::gettimeutc_for_stat_recording();
    setcombatrecordstat( "timeStampLastGame", var_0 );
    incrementcombatrecordstat( "numMatches", 1 );
    incrementcombatrecordstat( "timePlayed", self.timeplayed["total"] );
    incrementcombatrecordstat( "kills", self.kills );
    incrementcombatrecordstat( "deaths", self.deaths );
    incrementcombatrecordstat( "xpEarned", self.pers["summary"]["xp"] );

    if ( isdefined( self.combatrecordwin ) )
        incrementcombatrecordstat( "wins", 1 );

    if ( isdefined( self.combatrecordtie ) )
        incrementcombatrecordstat( "ties", 1 );

    var_1 = self _meth_8223( "combatRecord", level.gametype, "timeStampFirstGame" );

    if ( var_1 == 0 )
        setcombatrecordstat( "timeStampFirstGame", var_0 );
}

incrementcombatrecordstat( var_0, var_1 )
{
    var_2 = self _meth_8223( "combatRecord", level.gametype, var_0 );
    var_2 += var_1;
    self _meth_8244( "combatRecord", level.gametype, var_0, var_2 );
}

setcombatrecordstat( var_0, var_1 )
{
    self _meth_8244( "combatRecord", level.gametype, var_0, var_1 );
}

setcombatrecordstatifgreater( var_0, var_1 )
{
    var_2 = self _meth_8223( "combatRecord", level.gametype, var_0 );

    if ( var_1 > var_2 )
        setcombatrecordstat( var_0, var_1 );
}

updatecombatrecordforplayergamemodes()
{
    if ( level.gametype == "war" || level.gametype == "dm" )
    {
        updatecombatrecordcommondata();
        var_0 = self.deaths;

        if ( var_0 == 0 )
            var_0 = 1;

        var_1 = int( self.kills / var_0 ) * 1000;
        setcombatrecordstatifgreater( "mostkills", self.kills );
        setcombatrecordstatifgreater( "bestkdr", var_1 );
    }
    else if ( level.gametype == "ctf" )
    {
        updatecombatrecordcommondata();
        var_2 = maps\mp\_utility::getpersstat( "captures" );
        var_3 = maps\mp\_utility::getpersstat( "returns" );
        incrementcombatrecordstat( "captures", var_2 );
        incrementcombatrecordstat( "returns", var_3 );
        setcombatrecordstatifgreater( "mostcaptures", var_2 );
        setcombatrecordstatifgreater( "mostreturns", var_3 );
    }
    else if ( level.gametype == "dom" )
    {
        updatecombatrecordcommondata();
        var_2 = maps\mp\_utility::getpersstat( "captures" );
        var_4 = maps\mp\_utility::getpersstat( "defends" );
        incrementcombatrecordstat( "captures", var_2 );
        incrementcombatrecordstat( "defends", var_4 );
        setcombatrecordstatifgreater( "mostcaptures", var_2 );
        setcombatrecordstatifgreater( "mostdefends", var_4 );
    }
    else if ( level.gametype == "conf" )
    {
        updatecombatrecordcommondata();
        var_5 = maps\mp\_utility::getpersstat( "confirmed" );
        var_6 = maps\mp\_utility::getpersstat( "denied" );
        incrementcombatrecordstat( "confirms", var_5 );
        incrementcombatrecordstat( "denies", var_6 );
        setcombatrecordstatifgreater( "mostconfirms", var_5 );
        setcombatrecordstatifgreater( "mostdenies", var_6 );
    }
    else if ( level.gametype == "sd" )
    {
        updatecombatrecordcommondata();
        var_7 = maps\mp\_utility::getpersstat( "plants" );
        var_8 = maps\mp\_utility::getpersstat( "defuses" );
        var_9 = maps\mp\_utility::getpersstat( "destructions" );
        incrementcombatrecordstat( "plants", var_7 );
        incrementcombatrecordstat( "defuses", var_8 );
        incrementcombatrecordstat( "detonates", var_9 );
        setcombatrecordstatifgreater( "mostplants", var_7 );
        setcombatrecordstatifgreater( "mostdefuses", var_8 );
        setcombatrecordstatifgreater( "mostdetonates", var_9 );
    }
    else if ( level.gametype == "hp" )
    {
        updatecombatrecordcommondata();
        var_2 = maps\mp\_utility::getpersstat( "captures" );
        var_4 = maps\mp\_utility::getpersstat( "defends" );
        incrementcombatrecordstat( "captures", var_2 );
        incrementcombatrecordstat( "defends", var_4 );
        setcombatrecordstatifgreater( "mostcaptures", var_2 );
        setcombatrecordstatifgreater( "mostdefends", var_4 );
    }
    else if ( level.gametype == "sr" )
    {
        updatecombatrecordcommondata();
        var_7 = maps\mp\_utility::getpersstat( "plants" );
        var_8 = maps\mp\_utility::getpersstat( "defuses" );
        var_9 = maps\mp\_utility::getpersstat( "destructions" );
        var_5 = maps\mp\_utility::getpersstat( "confirmed" );
        var_6 = maps\mp\_utility::getpersstat( "denied" );
        incrementcombatrecordstat( "plants", var_7 );
        incrementcombatrecordstat( "defuses", var_8 );
        incrementcombatrecordstat( "detonates", var_9 );
        incrementcombatrecordstat( "confirms", var_5 );
        incrementcombatrecordstat( "denies", var_6 );
        setcombatrecordstatifgreater( "mostplants", var_7 );
        setcombatrecordstatifgreater( "mostdefuses", var_8 );
        setcombatrecordstatifgreater( "mostdetonates", var_9 );
        setcombatrecordstatifgreater( "mostconfirms", var_5 );
        setcombatrecordstatifgreater( "mostdenies", var_6 );
    }
    else if ( level.gametype == "infect" )
    {
        updatecombatrecordcommondata();
        var_10 = maps\mp\_utility::getplayerstat( "contagious" );
        var_11 = self.kills - var_10;
        incrementcombatrecordstat( "infectedKills", var_11 );
        incrementcombatrecordstat( "survivorKills", var_10 );
        setcombatrecordstatifgreater( "mostInfectedKills", var_11 );
        setcombatrecordstatifgreater( "mostSurvivorKills", var_10 );
    }
    else if ( level.gametype == "gun" )
    {
        updatecombatrecordcommondata();
        var_12 = maps\mp\_utility::getplayerstat( "levelup" );
        var_13 = maps\mp\_utility::getplayerstat( "humiliation" );
        incrementcombatrecordstat( "gunPromotions", var_12 );
        incrementcombatrecordstat( "stabs", var_13 );
        setcombatrecordstatifgreater( "mostGunPromotions", var_12 );
        setcombatrecordstatifgreater( "mostStabs", var_13 );
    }
    else if ( level.gametype == "ball" )
    {
        updatecombatrecordcommondata();
        var_14 = maps\mp\_utility::getplayerstat( "fieldgoal" ) + maps\mp\_utility::getplayerstat( "touchdown" ) * 2;
        var_15 = maps\mp\_utility::getplayerstat( "killedBallCarrier" );
        incrementcombatrecordstat( "pointsScored", var_14 );
        incrementcombatrecordstat( "killedBallCarrier", var_15 );
        setcombatrecordstatifgreater( "mostPointsScored", var_14 );
        setcombatrecordstatifgreater( "mostKilledBallCarrier", var_15 );
    }
    else if ( level.gametype == "twar" )
    {
        updatecombatrecordcommondata();
        var_2 = maps\mp\_utility::getpersstat( "captures" );
        var_16 = maps\mp\_utility::getplayerstat( "kill_while_capture" );
        incrementcombatrecordstat( "captures", var_2 );
        incrementcombatrecordstat( "killWhileCaptures", var_16 );
        setcombatrecordstatifgreater( "mostCaptures", var_2 );
        setcombatrecordstatifgreater( "mostKillWhileCaptures", var_16 );
    }
}

updatecombatrecordforplayer()
{
    updatecombatrecordforplayertrends();
    updatecombatrecordforplayergamemodes();
}

updatecombatrecord()
{
    foreach ( var_1 in level.players )
    {
        if ( !isdefined( var_1 ) )
            continue;

        if ( var_1 maps\mp\_utility::rankingenabled() )
            var_1 updatecombatrecordforplayer();

        level maps\mp\gametypes\_playerlogic::writesegmentdata( var_1 );

        if ( maps\mp\_utility::practiceroundgame() )
            level maps\mp\gametypes\_playerlogic::checkpracticeroundlockout( var_1 );
    }
}
