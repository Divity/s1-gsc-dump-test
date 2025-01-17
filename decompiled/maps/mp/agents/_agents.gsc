// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( isdefined( level.createfx_enabled ) && level.createfx_enabled )
        return;

    setup_callbacks();
    level.badplace_cylinder_func = ::badplace_cylinder;
    level.badplace_delete_func = ::badplace_delete;
    level thread maps\mp\agents\_agent_common::init();

    if ( !maps\mp\_utility::invirtuallobby() && !( isdefined( level.iszombiegame ) && level.iszombiegame ) )
    {
        level thread maps\mp\killstreaks\_agent_killstreak::init();
        level thread maps\mp\killstreaks\_dog_killstreak::init();
    }
}

setup_callbacks()
{
    if ( !isdefined( level.agent_funcs ) )
        level.agent_funcs = [];

    if ( !( isdefined( level.iszombiegame ) && level.iszombiegame ) )
    {
        level.agent_funcs["player"] = [];
        level.agent_funcs["player"]["spawn"] = ::spawn_agent_player;
        level.agent_funcs["player"]["think"] = maps\mp\bots\_bots_gametype_war::bot_war_think;
        level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
        level.agent_funcs["player"]["on_damaged"] = ::on_agent_player_damaged;
        level.agent_funcs["player"]["on_damaged_finished"] = ::agent_damage_finished;
        maps\mp\killstreaks\_agent_killstreak::setup_callbacks();
        maps\mp\killstreaks\_dog_killstreak::setup_callbacks();
    }
}

wait_till_agent_funcs_defined()
{
    while ( !isdefined( level.agent_funcs ) )
        wait 0.05;
}

add_humanoid_agent( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = maps\mp\agents\_agent_common::connectnewagent( var_0, var_1, var_2 );

    if ( isdefined( var_9 ) )
        var_9 thread [[ var_9 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]( var_3, var_4, var_5, var_6, var_7, var_8 );

    return var_9;
}

spawn_agent_player( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "disconnect" );

    while ( !isdefined( level.getspawnpoint ) )
        waitframe();

    if ( self.hasdied )
        wait(randomintrange( 6, 10 ));

    maps\mp\agents\_agent_utility::initplayerscriptvariables( 1 );

    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_6 = var_0;
        var_7 = var_1;
        self.lastspawnpoint = spawnstruct();
        self.lastspawnpoint.origin = var_6;
        self.lastspawnpoint.angles = var_7;
    }
    else
    {
        var_8 = self [[ level.getspawnpoint ]]();
        var_6 = var_8.origin;
        var_7 = var_8.angles;
        self.lastspawnpoint = var_8;
    }

    maps\mp\agents\_agent_utility::activateagent();
    self.lastspawntime = gettime();
    self.spawntime = gettime();
    var_9 = var_6 + ( 0, 0, 25 );
    var_10 = var_6;
    var_11 = playerphysicstrace( var_9, var_10 );

    if ( distancesquared( var_11, var_9 ) > 1 )
        var_6 = var_11;

    self _meth_838A( var_6, var_7 );

    if ( isdefined( var_5 ) )
        self.agent_override_difficulty = var_5;

    if ( isdefined( self.agent_override_difficulty ) )
    {
        if ( self.agent_override_difficulty == "follow_code_and_dev_dvar" )
            maps\mp\bots\_bots_util::bot_set_difficulty( self _meth_836B(), 1 );
        else
            maps\mp\bots\_bots_util::bot_set_difficulty( var_5 );
    }
    else
        maps\mp\bots\_bots_util::bot_set_difficulty( self _meth_836B() );

    if ( isdefined( var_3 ) && var_3 )
        self.use_randomized_personality = 1;

    if ( isdefined( self.use_randomized_personality ) && self.use_randomized_personality )
    {
        if ( !self.hasdied )
        {
            var_12 = self _meth_837B( "advancedPersonality" );

            if ( isdefined( var_12 ) && var_12 != 0 )
                maps\mp\bots\_bots_personality::bot_balance_personality();
        }

        maps\mp\bots\_bots_personality::bot_assign_personality_functions();
    }
    else
        maps\mp\bots\_bots_util::bot_set_personality( "default" );

    initplayerclass();
    maps\mp\agents\_agent_common::set_agent_health( 100 );

    if ( isdefined( var_4 ) && var_4 )
        self.respawn_on_death = 1;

    if ( isdefined( var_2 ) )
        maps\mp\agents\_agent_utility::set_agent_team( var_2.team, var_2 );

    if ( isdefined( self.owner ) )
        thread destroyonownerdisconnect( self.owner );

    thread maps\mp\_flashgrenades::monitorflash();
    self _meth_83D1( 0 );
    self [[ level.onspawnplayer ]]();
    maps\mp\gametypes\_class::giveandapplyloadout( self.team, self.class, 1 );
    thread maps\mp\bots\_bots::bot_think_watch_enemy( 1 );
    thread maps\mp\bots\_bots::bot_think_crate();

    if ( self.agent_type == "player" )
        thread maps\mp\bots\_bots::bot_think_level_actions();
    else if ( self.agent_type == "odin_juggernaut" )
        thread maps\mp\bots\_bots::bot_think_level_actions( 128 );

    thread maps\mp\bots\_bots_strategy::bot_think_tactical_goals();
    self thread [[ maps\mp\agents\_agent_utility::agentfunc( "think" ) ]]();

    if ( !self.hasdied )
        maps\mp\gametypes\_spawnlogic::addtoparticipantsarray();

    if ( !self.hasdied )
    {
        thread maps\mp\gametypes\_weapons::onplayerspawned();
        thread maps\mp\gametypes\_battlechatter_mp::onplayerspawned();
    }

    self.hasdied = 0;
    thread maps\mp\gametypes\_healthoverlay::playerhealthregen();

    if ( isdefined( self.use_randomized_personality ) && self.use_randomized_personality && isdefined( self.respawn_on_death ) && self.respawn_on_death )
        self _meth_852D( 1 );

    level notify( "spawned_agent_player", self );
    level notify( "spawned_agent", self );
    level notify( "player_spawned", self );
    self notify( "spawned_player" );
}

destroyonownerdisconnect( var_0 )
{
    self endon( "death" );
    var_0 waittill( "killstreak_disowned" );
    self notify( "owner_disconnect" );

    if ( maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() )
        wait 0.05;

    self _meth_826B();
}

agent_damage_finished( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( var_0 ) || isdefined( var_1 ) )
    {
        if ( !isdefined( var_0 ) )
            var_0 = var_1;

        if ( isdefined( self.allowvehicledamage ) && !self.allowvehicledamage )
        {
            if ( isdefined( var_0.classname ) && var_0.classname == "script_vehicle" )
                return 0;
        }

        if ( isdefined( var_0.classname ) && var_0.classname == "auto_turret" )
            var_1 = var_0;

        if ( isdefined( var_1 ) && var_4 != "MOD_FALLING" && var_4 != "MOD_SUICIDE" )
        {
            if ( level.teambased )
            {
                if ( isdefined( var_1.team ) && var_1.team != self.team )
                    self _meth_838C( var_1 );
            }
            else
                self _meth_838C( var_1 );
        }
    }

    var_10 = maps\mp\gametypes\_damage::shouldplayblastimpact( var_3, var_4, var_5 );
    var_11 = self _meth_838B( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10 );

    if ( isdefined( var_11 ) )
        thread finishagentdamage_impactfxwrapper( var_11[0], var_11[1], var_11[2], var_11[3], var_11[4], var_11[5], var_11[6] );

    if ( !isdefined( self.isactive ) )
        self.waitingtodeactivate = 1;

    return 1;
}

finishagentdamage_impactfxwrapper( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    waittillframeend;

    if ( !isdefined( self ) || !isdefined( var_0 ) )
        return;

    self _meth_8540( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
}

on_agent_generic_damaged( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = isdefined( var_1 ) && isdefined( self.owner ) && self.owner == var_1;
    var_11 = maps\mp\_utility::attackerishittingteam( self.owner, var_1 ) || var_10;

    if ( level.teambased && var_11 && !level.friendlyfire )
        return 0;

    if ( !level.teambased && var_10 )
        return 0;

    if ( isdefined( var_4 ) && var_4 == "MOD_CRUSH" && isdefined( var_0 ) && isdefined( var_0.classname ) && var_0.classname == "script_vehicle" )
        return 0;

    if ( !isdefined( self ) || !maps\mp\_utility::isreallyalive( self ) )
        return 0;

    if ( isdefined( var_1 ) && var_1.classname == "script_origin" && isdefined( var_1.type ) && var_1.type == "soft_landing" )
        return 0;

    if ( var_5 == "killstreak_emp_mp" )
        return 0;

    if ( var_5 == "bouncingbetty_mp" && !maps\mp\gametypes\_weapons::minedamageheightpassed( var_0, self ) )
        return 0;

    if ( ( var_5 == "throwingknife_mp" || var_5 == "throwingknifejugg_mp" ) && var_4 == "MOD_IMPACT" )
        var_2 = self.health + 1;

    if ( isdefined( var_0 ) && isdefined( var_0.stuckenemyentity ) && var_0.stuckenemyentity == self )
        var_2 = self.health + 1;

    if ( var_2 <= 0 )
        return 0;

    if ( isdefined( level.modifyplayerdamage ) )
        var_2 = [[ level.modifyplayerdamage ]]( self, var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8 );

    if ( isdefined( var_1 ) && var_1 != self && var_2 > 0 && ( !isdefined( var_8 ) || var_8 != "shield" ) )
    {
        if ( var_3 & level.idflags_stun )
            var_12 = "stun";
        else if ( !maps\mp\gametypes\_damage::shouldweaponfeedback( var_5 ) )
            var_12 = "none";
        else
        {
            var_12 = "standard";

            if ( isdefined( level.iszombiegame ) && level.iszombiegame )
            {
                if ( var_5 == "trap_zm_mp" || var_5 == "zombie_vaporize_mp" || var_5 == "zombie_trap_turret_mp" || var_5 == "zombie_water_trap_mp" )
                    var_12 = "none";
                else
                {
                    if ( var_5 == "iw5_microwavezm_mp" )
                        var_12 = "nosound";

                    if ( var_2 < self.health )
                    {
                        switch ( var_8 )
                        {
                            case "neck":
                            case "helmet":
                            case "head":
                                var_12 = "headshot";
                                break;
                        }
                    }
                    else
                    {
                        switch ( var_8 )
                        {
                            case "neck":
                            case "helmet":
                            case "head":
                                var_12 = "killshot_headshot";
                                break;
                            default:
                                var_12 = "killshot";
                                break;
                        }
                    }
                }
            }
        }

        var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback( var_12 );
    }

    return self [[ maps\mp\agents\_agent_utility::agentfunc( "on_damaged_finished" ) ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

on_agent_player_damaged( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = isdefined( var_1 ) && isdefined( self.owner ) && self.owner == var_1;

    if ( !level.teambased && var_10 )
        return 0;

    maps\mp\gametypes\_damage::callback_playerdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

on_agent_player_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    on_humanoid_agent_killed_common( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1 );

    if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) && ( !isdefined( self.nonkillstreakagent ) || !self.nonkillstreakagent ) )
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2, "destroyed_squad_mate" );

    if ( isdefined( level.on_agent_player_killed ) )
        [[ level.on_agent_player_killed ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

    thread maps\mp\gametypes\_weapons::dropscavengerfordeath( var_1 );

    if ( self.isactive )
    {
        self.hasdied = 1;

        if ( maps\mp\_utility::getgametypenumlives() != 1 && ( isdefined( self.respawn_on_death ) && self.respawn_on_death ) )
            self thread [[ maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]();
        else
            maps\mp\agents\_agent_utility::deactivateagent();
    }
}

on_humanoid_agent_killed_common( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( maps\mp\_riotshield::hasriotshieldequipped() )
    {
        maps\mp\gametypes\_damage::launchshield( var_2, var_3 );

        if ( !var_9 )
        {
            var_10 = self _meth_8250( self _meth_8311() );

            if ( isdefined( var_10 ) )
            {
                var_10 thread maps\mp\gametypes\_weapons::deletepickupafterawhile();
                var_10.owner = self;
                var_10.ownersattacker = var_1;
                var_10 makeunusable();
            }
        }
    }

    if ( var_9 )
        self thread [[ level.weapondropfunction ]]( var_1, var_3 );

    if ( !isdefined( self.bypassagentcorpse ) || !self.bypassagentcorpse )
    {
        self.body = self _meth_838D( var_8 );

        if ( isdefined( level.agentshouldragdollimmediatelyfunc ) && [[ level.agentshouldragdollimmediatelyfunc ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 ) )
        {
            self.body _meth_8023();

            if ( !self.body _meth_81E0() )
                thread maps\mp\gametypes\_damage::delaystartragdoll( self.body, var_6, var_5, var_4, var_0, var_3 );
        }
        else
            thread maps\mp\gametypes\_damage::delaystartragdoll( self.body, var_6, var_5, var_4, var_0, var_3 );
    }

    maps\mp\_riotshield::riotshield_clear();
}

initplayerclass()
{
    if ( isdefined( self.class_override ) )
        self.class = self.class_override;
    else if ( maps\mp\bots\_bots_loadout::bot_setup_loadout_callback() )
        self.class = "callback";
    else
        self.class = "class1";
}
