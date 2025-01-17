// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    precachemodel( "animal_dobernan" );
    level.killstreakfuncs["guard_dog"] = ::tryusedog;
}

setup_callbacks()
{
    level.agent_funcs["dog"] = level.agent_funcs["player"];
    level.agent_funcs["dog"]["spawn"] = ::spawn_dog;
    level.agent_funcs["dog"]["on_killed"] = ::on_agent_dog_killed;
    level.agent_funcs["dog"]["on_damaged"] = maps\mp\agents\_agents::on_agent_generic_damaged;
    level.agent_funcs["dog"]["on_damaged_finished"] = ::on_damaged_finished;
    level.agent_funcs["dog"]["think"] = maps\mp\agents\dog\_dog_think::main;
    level.killstreakwieldweapons["agent_mp"] = "agent_mp";
}

tryusedog( var_0, var_1 )
{
    return usedog();
}

usedog()
{
    if ( maps\mp\agents\_agent_utility::getnumactiveagents( "dog" ) >= 5 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_TOO_MANY_DOGS" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::getnumownedactiveagentsbytype( self, "dog" ) >= 1 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_ALREADY_HAVE_DOG" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::getnumownedactiveagents( self ) >= 2 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_0 = _func_1FB();

    if ( maps\mp\agents\_agent_utility::getnumactiveagents() >= var_0 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_UNAVAILABLE" );
        return 0;
    }

    if ( !maps\mp\_utility::isreallyalive( self ) )
        return 0;

    var_1 = maps\mp\agents\_agent_utility::getvalidspawnpathnodenearplayer( 1 );

    if ( !isdefined( var_1 ) )
        return 0;

    var_2 = maps\mp\agents\_agent_common::connectnewagent( "dog", self.team );

    if ( !isdefined( var_2 ) )
        return 0;

    var_2 maps\mp\agents\_agent_utility::set_agent_team( self.team, self );
    var_3 = var_1.origin;
    var_4 = vectortoangles( self.origin - var_1.origin );
    var_2 thread [[ var_2 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]( var_3, var_4, self );
    var_2 maps\mp\_utility::_setnameplatematerial( "player_name_bg_green_dog", "player_name_bg_red_dog" );

    if ( isdefined( self.balldrone ) && self.balldrone.balldronetype == "ball_drone_backup" )
        maps\mp\gametypes\_missions::processchallenge( "ch_twiceasdeadly" );

    return 1;
}

on_agent_dog_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self.isactive = 0;
    self.hasdied = 0;
    var_1.lastkilldogtime = gettime();

    if ( isdefined( self.animcbs.onexit[self.aistate] ) )
        self [[ self.animcbs.onexit[self.aistate] ]]();

    if ( isplayer( var_1 ) && isdefined( self.owner ) && var_1 != self.owner )
    {
        self.owner maps\mp\_utility::leaderdialogonplayer( "dog_killed" );
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2, "destroyed_guard_dog" );

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_missions::processchallenge( "ch_notsobestfriend" );

            if ( !self _meth_8341() )
                var_1 maps\mp\gametypes\_missions::processchallenge( "ch_hoopla" );
        }
    }

    self _meth_83D2( "death" );
    var_9 = self _meth_83D3();
    var_10 = getanimlength( var_9 );
    var_8 = int( var_10 * 1000 );
    self.body = self _meth_838D( var_8 );
    self playsound( "anml_doberman_death" );
    maps\mp\agents\_agent_utility::deactivateagent();
    self notify( "killanimscript" );
}

on_damaged_finished( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( self.playing_pain_sound ) )
        thread play_pain_sound( 2.5 );

    var_10 = var_2;

    if ( isdefined( var_8 ) && var_8 == "head" && level.gametype != "horde" )
    {
        var_10 = int( var_10 * 0.6 );

        if ( var_2 > 0 && var_10 <= 0 )
            var_10 = 1;
    }

    if ( self.health - var_10 > 0 )
        maps\mp\agents\dog\_dog_think::ondamage( var_0, var_1, var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( isplayer( var_1 ) )
    {
        if ( isdefined( self.attackstate ) && self.attackstate != "attacking" )
        {
            if ( distancesquared( self.origin, var_1.origin ) <= self.dogdamagedradiussq )
            {
                self.favoriteenemy = var_1;
                self.forceattack = 1;
                thread maps\mp\agents\dog\_dog_think::watchfavoriteenemydeath();
            }
        }
    }

    maps\mp\agents\_agents::agent_damage_finished( var_0, var_1, var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

play_pain_sound( var_0 )
{
    self endon( "death" );
    self playsound( "anml_doberman_pain" );
    self.playing_pain_sound = 1;
    wait(var_0);
    self.playing_pain_sound = undefined;
}

spawn_dog( var_0, var_1, var_2 )
{
    if ( _func_282() )
        self _meth_80B1( "animal_dobernan" );
    else
        self _meth_80B1( "animal_dobernan" );

    self.species = "dog";
    self.onenteranimstate = maps\mp\agents\dog\_dog_think::onenteranimstate;

    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_3 = var_0;
        var_4 = var_1;
    }
    else
    {
        var_5 = self [[ level.getspawnpoint ]]();
        var_3 = var_5.origin;
        var_4 = var_5.angles;
    }

    maps\mp\agents\_agent_utility::activateagent();
    self.spawntime = gettime();
    self.lastspawntime = gettime();
    maps\mp\agents\dog\_dog_think::init();
    self _meth_838A( var_3, var_4, "dog_animclass", 15, 40, var_2 );
    level notify( "spawned_agent", self );
    maps\mp\agents\_agent_common::set_agent_health( 250 );

    if ( isdefined( var_2 ) )
        maps\mp\agents\_agent_utility::set_agent_team( var_2.team, var_2 );

    self _meth_8177( "Dogs" );
    self _meth_8310();

    if ( isdefined( self.owner ) )
    {
        self hide();
        wait 1.0;

        if ( !isalive( self ) )
            return;

        self show();
        wait 0.1;
    }

    self thread [[ maps\mp\agents\_agent_utility::agentfunc( "think" ) ]]();
    wait 0.1;

    if ( _func_282() )
        playfxontag( level.furfx, self, "tag_origin" );
}
