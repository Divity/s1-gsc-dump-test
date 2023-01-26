// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakfuncs["mp_torqued"] = ::tryusemptorqued;
    level.mapkillstreak = "mp_torqued";
    level._id_598A = &"MP_TORQUED_MAP_KILLSTREAK_PICKUP";
    level.killstreakwieldweapons["mp_torqued_beam"] = "mp_torqued";
    level._id_5984 = ::_id_82FA;
    level.torquedkillstreakactive = 0;
    thread fusioncoresetup();
}

_id_82FA()
{
    level thread maps\mp\bots\_bots_ks::_id_16CC( "mp_torqued", maps\mp\bots\_bots_ks::_id_167B );
}

fusioncoresetup()
{
    if ( !isdefined( level.fusioncore ) )
        level.fusioncore = spawnstruct();

    level.fusioncore.particle01 = loadfx( "vfx/map/mp_torqued/reactor_core" );
    level.fusioncore.particleexplosion = loadfx( "vfx/map/mp_torqued/mp_torqued_shock_impact" );
    level.fusioncore.particleexplosion2 = loadfx( "fx/explosions/generic_explosion_distortion" );
    level.fusioncore.particlezap = loadfx( "vfx/map/mp_torqued/mp_torqued_energy_impact" );
    level.fusioncore.particlezaptrail = loadfx( "vfx/trail/charged_shot_2_trail_blue" );
    level.fusioncore.particlezaptrail2 = loadfx( "vfx/map/mp_torqued/mp_torqued_energy_trail" );
    level.fusioncore.particlefinger01 = loadfx( "vfx/map/mp_torqued/mp_torqued_electric_trail" );
    level.fusioncore.camspawnarray = getentarray( "core_killcam", "targetname" );
    fusioncoresetuppos( 1 );
    level.fusioncore.minimapenemyicon = "compassping_torqued_streak_enemy";
    level.fusioncore.minimapfriendlyicon = "compassping_torqued_streak_friendly";
    level thread _id_64C9();

    foreach ( var_1 in level.fusioncore.camspawnarray )
        var_1 fusioncorekillcam();
}

fusioncoresetuppos( var_0 )
{
    if ( !isdefined( level.fusioncore ) )
        return;

    level.fusioncore.icon = getent( "fusion_world_icon_" + var_0, "targetname" );
    level.fusioncore.icon_fake = level.fusioncore.icon;
    level.fusioncore.center = common_scripts\utility::getstruct( "fusion_origin_" + var_0, "targetname" );
    level.fusioncore.laserarray = common_scripts\utility::getstructarray( "laser_origin_" + var_0, "targetname" );
}

_id_64C9()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 createtorquedfusiontrackingoverlay();
    }
}

tryusemptorqued( var_0, var_1 )
{
    if ( !maps\mp\_utility::validateusestreak() )
        return 0;

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( level.torquedkillstreakactive == 1 )
    {
        self iclientprintlnbold( &"MP_TORQUED_IN_USE" );
        return 0;
    }

    level thread killstreaktorqued( self );
    return 1;
}

killstreaktorqued( var_0 )
{
    level endon( "killstreak_over" );
    level.torquedkillstreakactive = 1;
    var_1 = var_0.team;

    while ( level.torqued_rockfall_active )
        waitframe();

    level.fusioncore.kill_list = [];
    fusioncorespinup( var_0 );
    fusioncoretrackpeople( var_1, var_0 );
    fusioncorekillpeople( var_1, var_0 );
    fusioncorecooldown();
    fusioncoretrackpeople( var_1, var_0 );
    fusioncorekillpeople( var_1, var_0 );
    fusioncorecooldown();
    fusioncorecleanup( var_0 );
    thread killstreakend();
}

fusioncorecleanup( var_0 )
{
    level notify( "shutdown_streak_particles" );
    level.fusioncore.icon_fake minimapremoveteamicon();
    destroyfriendlyplayericons( var_0 );

    foreach ( var_2 in level.players )
        var_2 endtorquedtrackingoverlay();
}

fusioncorespinup( var_0 )
{
    var_1 = 768;
    var_2 = 0.25;
    var_3 = "steady_rumble";
    var_4 = spawn( "script_origin", level.fusioncore.center.origin );
    var_4 thread fusionspinupsound();
    playrumblelooponposition( var_3, level.fusioncore.center.origin );
    thread quakethink( var_2, var_1, level.fusioncore.center );
}

destroyfriendlyplayericons( var_0 )
{
    if ( isdefined( level.fusioncore.icon.entityheadicons ) )
    {
        if ( isdefined( level.fusioncore.icon.entityheadicons[var_0.team] ) )
        {
            level.fusioncore.icon.entityheadicons[var_0.team] destroy();
            level.fusioncore.icon.entityheadicons[var_0.team] = undefined;
        }
        else if ( isdefined( level.fusioncore.icon.entityheadicons[var_0.guid] ) )
        {
            level.fusioncore.icon.entityheadicons[var_0.guid] destroy();
            level.fusioncore.icon.entityheadicons[var_0.guid] = undefined;
        }
    }
}

fusionspinupsound()
{
    thread maps\mp\_utility::playsoundinspace( "mp_torqued_reactor_engine", level.fusioncore.center.origin );
}

fusioncoretrackpeople( var_0, var_1 )
{
    var_2 = 3;
    var_3 = "tank_rumble";
    level.fusioncore.center thread particlethink( level.fusioncore.particle01 );
    playrumblelooponposition( var_3, level.fusioncore.center.origin );
    thread maps\mp\_utility::playsoundinspace( "mp_torqued_reactor_ramp_up", level.fusioncore.center.origin );
    thread startlasertest( var_0, var_1 );
    wait(var_2);
}

fusioncorekillpeople( var_0, var_1 )
{
    level.fusioncore.center thread particlethink( level.fusioncore.particleexplosion, 2 );
    level.fusioncore.center thread particlethink( level.fusioncore.particleexplosion2, 2 );
    thread maps\mp\_utility::playsoundinspace( "mp_torqued_reactor_blast", level.fusioncore.center.origin );
    thread empenemyteam( var_0, var_1 );

    foreach ( var_3 in level.fusioncore.kill_list )
    {
        if ( isdefined( var_3 ) && maps\mp\_utility::isreallyalive( var_3 ) )
            var_3 thread deathtouchzap( var_1 );
    }

    level notify( "zap_players" );
}

empenemyteam( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < level.teamnamelist.size; var_2++ )
    {
        if ( var_0 != level.teamnamelist[var_2] )
            thread destroyactivesmallvehicles( var_1, level.teamnamelist[var_2] );
    }

    foreach ( var_4 in level.players )
    {
        if ( var_4.team != var_0 )
        {
            if ( maps\mp\_utility::isreallyalive( var_4 ) )
                var_4 notify( "emp_grenaded", var_1 );
        }
    }
}

destroyactivesmallvehicles( var_0, var_1 )
{
    thread maps\mp\killstreaks\_emp::_id_28DD( var_0, var_1 );
    thread maps\mp\killstreaks\_emp::_id_28DB( var_0, var_1 );
    thread maps\mp\killstreaks\_emp::_id_28DF( var_0, var_1 );
}

fusioncorecooldown()
{
    level notify( "shutdown_streak_particles" );
    var_0 = 3;
    level notify( "Reactor_Cooldown" );
    stopallrumbles();
    level.fusioncore.kill_list = [];

    foreach ( var_2 in level.players )
        var_2 endtorquedtrackingoverlay();

    wait(var_0);
}

particlelaserthink( var_0 )
{
    var_1 = 15;

    for ( var_2 = 0; var_2 < var_1; var_2++ )
        thread particlelaserspawn( var_0 );
}

particlelaserspawn( var_0 )
{
    level endon( "Reactor_Cooldown" );
    var_1 = spawnfx( var_0, self.origin );
    var_2 = randomintrange( -180, 180 );
    var_3 = randomintrange( -180, 180 );
    var_4 = randomintrange( -180, 180 );
    var_5 = ( var_2, var_3, var_4 );
    var_1.angles = var_5;
    var_1 thread particlelasercleanup();

    for (;;)
    {
        triggerfx( var_1 );
        wait 0.05;
    }
}

particlelasercleanup()
{
    level waittill( "Reactor_Cooldown" );
    self delete();
}

particlethink( var_0, var_1 )
{
    var_2 = spawnfx( var_0, self.origin );
    var_2.angles = self.angles;
    triggerfx( var_2 );

    if ( !isdefined( var_1 ) )
    {
        level waittill( "shutdown_streak_particles" );

        if ( isdefined( var_2 ) )
            var_2 delete();
    }
    else if ( isdefined( var_1 ) )
    {
        wait(var_1);

        if ( isdefined( var_2 ) )
            var_2 delete();
    }
}

particletrailthink( var_0, var_1 )
{
    var_2 = level.fusioncore.center.origin;

    if ( isdefined( self.lasernode ) )
        var_2 = self.lasernode.origin;

    var_3 = self geteye() + ( 0.0, 0.0, -3.0 );
    var_4 = var_2;
    var_5 = vectortoangles( var_3 - var_2 );
    var_4 += anglestoforward( var_5 ) * 32;
    var_6 = spawnfx( var_0, var_4 );
    var_6.angles = var_5;
    triggerfx( var_6 );
    var_7 = 3;

    for ( var_8 = 0; var_8 < var_7; var_8++ )
    {
        thread particlevolley( var_1, var_4, var_3, var_5 );
        wait 0.05;
    }

    var_6 delete();
}

particlevolley( var_0, var_1, var_2, var_3 )
{
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4.origin = var_1;
    var_4.angles = var_3;
    var_4 show();
    wait 0.05;
    var_4 show();
    var_4 moveto( var_2, 0.25 );
    playfxontag( var_0, var_4, "tag_origin" );
    wait 0.05;
    var_4 show();
    playfxontag( var_0, var_4, "tag_origin" );
    wait 0.05;
    var_4 show();
    playfxontag( var_0, var_4, "tag_origin" );
    var_4 waittill( "movedone" );
    stopfxontag( var_0, var_4, "tag_origin" );
    var_4 delete();
}

zapplayers( var_0 )
{

}

quakethink( var_0, var_1, var_2 )
{
    level endon( "killstreak_over" );

    for (;;)
    {
        var_3 = randomfloatrange( 1.0, 1.7 );
        earthquake( var_0, var_3, var_2.origin, var_1 );
        wait(var_3 - 0.2);
    }
}

deathtouchzap( var_0 )
{
    particletrailthink( level.fusioncore.particlezaptrail, level.fusioncore.particlezaptrail2 );
    thread particlethink( level.fusioncore.particlezap, 1 );
    var_1 = findfarthestkillcam();

    if ( self.fuisioncorekillrange )
    {
        setplayerprekilledfunc();
        self thread [[ level.callbackplayerdamage ]]( var_1, var_0, self.health + 9999, 0, "MOD_HEAD_SHOT", "mp_torqued_beam", self.origin, ( 0.0, 0.0, 0.0 ) - self.origin, "none", 0 );
        clearplayerprekilledfunc();
    }
    else
        thread maps\mp\_flashgrenades::applyflash( 5.0, 2.5 );
}

setplayerprekilledfunc()
{
    self.prekilledfunc = ::_id_6D26;
}

clearplayerprekilledfunc()
{
    self.prekilledfunc = undefined;
    self.hideondeath = 0;
}

_id_6D26( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( var_5 == "mp_torqued_beam" )
        _id_6D25();
}

_id_6D25()
{
    self.hideondeath = 1;
    var_0 = ( 0.0, 0.0, 30.0 );
    var_1 = self getstance();

    if ( var_1 == "crouch" )
        var_0 = ( 0.0, 0.0, 20.0 );
    else if ( var_1 == "prone" )
        var_0 = ( 0.0, 0.0, 10.0 );

    playfx( common_scripts\utility::getfx( "torqued_killstreak_death" ), self.origin + var_0 );
}

findfarthestkillcam()
{
    var_0 = sortbydistance( level.fusioncore.camspawnarray, self.origin );
    var_1 = var_0[var_0.size - 1];
    return var_1;
}

fusioncorekillcam( var_0 )
{
    var_1 = undefined;
    var_1 = spawn( "script_model", self.origin );
    var_1.angles = self.angles;
    self.killcament = var_1;
}

removekillcamentity()
{
    if ( isdefined( self.killcament ) )
        self.killcament delete();
}

startlasertest( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( level.teambased == 0 && var_3 != var_1 )
        {
            var_3 thread tracktargets();
            continue;
        }

        if ( var_3 == var_1 )
            continue;

        if ( var_3.team != var_0 )
        {
            var_3 thread tracktargets();
            continue;
        }

        var_3 thread onteamswitchdurringstreak( var_0 );
    }

    thread onplayerconnectdurringstreak( var_0 );
}

tracktargets()
{
    self endon( "disconnected" );
    level endon( "zap_players" );
    var_0 = 0.1;
    self.lasernode = undefined;
    var_1 = 500;
    var_2 = 1000;
    var_3 = var_1 * var_1;
    var_4 = var_2 * var_2;

    for (;;)
    {
        foreach ( var_6 in level.fusioncore.laserarray )
        {
            var_7 = 0;

            while ( var_7 == 0 )
            {
                if ( isdefined( self ) )
                {
                    var_8 = self geteye() + ( 0.0, 0.0, -3.0 );
                    var_9 = distancesquared( var_8, var_6.origin );

                    if ( var_9 <= var_4 )
                    {
                        var_10 = bullettrace( var_6.origin, var_8, 1, 0 );

                        if ( isdefined( var_10["entity"] ) && self == var_10["entity"] && isalive( self ) )
                        {
                            self.fuisioncorekillrange = var_9 <= var_3;

                            if ( !common_scripts\utility::array_contains( level.fusioncore.kill_list, self ) )
                            {
                                level.fusioncore.kill_list = common_scripts\utility::add_to_array( level.fusioncore.kill_list, self );
                                self.lasernode = var_6;
                                thread fadeinouttorquedtrackingoverlay();
                                thread _id_A206();
                            }

                            thread drawparticleline( var_6 );
                            wait(var_0);
                            continue;
                        }
                    }

                    level.fusioncore.kill_list = common_scripts\utility::array_remove( level.fusioncore.kill_list, self );
                    var_7 = 1;
                    self notify( "player_not_tracked" );
                    endtorquedtrackingoverlay();
                    wait(var_0);
                }
            }
        }

        wait(var_0);
    }
}

drawparticleline( var_0 )
{
    var_1 = 200;
    var_2 = 1;
    var_3 = 200;
    var_4 = self geteye();
    var_5 = var_0.origin;
    var_1 = distance( var_4, var_5 );

    if ( var_1 < 200 )
        var_1 = 200;

    var_2 = var_1 / var_3;
    var_2 += 0.5;
    var_2 = int( var_2 );
    var_6 = vectortoangles( var_4 - var_5 );

    for ( var_7 = 0; var_7 < var_2; var_7++ )
    {
        var_8 = spawnfx( level.fusioncore.particlefinger01, var_5 );
        var_8.angles = var_6;
        triggerfx( var_8 );
        var_8 thread deleteparticlefinger();
        var_5 += anglestoforward( var_6 ) * 200;
    }
}

deleteparticlefinger()
{
    wait 0.15;
    self delete();
}

_id_A206()
{
    level endon( "zap_players" );
    level endon( "killstreak_over" );
    self endon( "disconnected" );
    self waittill( "death" );
    level.fusioncore.kill_list = common_scripts\utility::array_remove( level.fusioncore.kill_list, self );
    endtorquedtrackingoverlay();
}

_id_A040( var_0 )
{
    level endon( "zap_players" );
    self waittill( "spawned_player" );
    level.fusioncore.kill_list = common_scripts\utility::array_remove( level.fusioncore.kill_list, self );

    if ( level.teambased == 0 )
        thread tracktargets();
    else if ( self.team != var_0 )
        thread tracktargets();
}

onteamswitchdurringstreak( var_0 )
{
    level endon( "zap_players" );

    for (;;)
    {
        self waittill( "joined_team" );
        thread _id_A040( var_0 );
        return 1;
    }
}

onplayerconnectdurringstreak( var_0 )
{
    level endon( "zap_players" );

    for (;;)
    {
        level waittill( "connected", var_1 );
        var_1 thread _id_A040( var_0 );
        return 1;
    }
}

minimapdisplayteamicon( var_0, var_1, var_2 )
{
    if ( !level.teambased )
    {
        var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( var_3, "invisible", self.origin );
        objective_state( var_3, "active" );
        objective_player( var_3, var_0 getentitynumber() );
        objective_icon( var_3, var_1 );
        self.objid01 = var_3;
        var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( var_3, "invisible", self.origin );
        objective_state( var_3, "active" );
        objective_playerenemyteam( var_3, var_0 getentitynumber() );
        objective_icon( var_3, var_2 );
        self.objid02 = var_3;
    }
    else
    {
        var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( var_3, "invisible", self.origin );
        objective_state( var_3, "active" );
        objective_team( var_3, var_0.team );
        objective_icon( var_3, var_1 );
        self.objid03 = var_3;
        var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( var_3, "invisible", self.origin );
        objective_state( var_3, "active" );
        objective_team( var_3, level.otherteam[var_0.team] );
        objective_icon( var_3, var_2 );
        self.objid04 = var_3;
    }
}

minimapremoveteamicon()
{
    if ( isdefined( self.objid01 ) )
        maps\mp\_utility::_objective_delete( self.objid01 );

    if ( isdefined( self.objid02 ) )
        maps\mp\_utility::_objective_delete( self.objid02 );

    if ( isdefined( self.objid03 ) )
        maps\mp\_utility::_objective_delete( self.objid03 );

    if ( isdefined( self.objid04 ) )
        maps\mp\_utility::_objective_delete( self.objid04 );
}

createtorquedfusiontrackingoverlay()
{
    if ( !isdefined( self.torquedfusiontrackingoverlay ) )
    {
        self.torquedfusiontrackingoverlay = newclienthudelem( self );
        self.torquedfusiontrackingoverlay.x = 0;
        self.torquedfusiontrackingoverlay.y = 0;
        self.torquedfusiontrackingoverlay setshader( "torqued_reactor_tracking_overlay", 640, 480 );
        self.torquedfusiontrackingoverlay.alignx = "left";
        self.torquedfusiontrackingoverlay.aligny = "top";
        self.torquedfusiontrackingoverlay.horzalign = "fullscreen";
        self.torquedfusiontrackingoverlay.vertalign = "fullscreen";
        self.torquedfusiontrackingoverlay.alpha = 0;
    }
}

fadeinouttorquedtrackingoverlay()
{
    level endon( "zap_players" );
    level endon( "killstreak_over" );
    level endon( "game_ended" );
    self endon( "player_not_tracked" );

    if ( isdefined( self.torquedfusiontrackingoverlay ) )
    {
        for (;;)
        {
            self.torquedfusiontrackingoverlay fadeovertime( 0.2 );
            self.torquedfusiontrackingoverlay.alpha = 1;
            wait 0.3;
            self.torquedfusiontrackingoverlay fadeovertime( 0.2 );
            self.torquedfusiontrackingoverlay.alpha = 0.3;
            wait 0.3;
        }
    }
}

endtorquedtrackingoverlay()
{
    if ( isdefined( self.torquedfusiontrackingoverlay ) )
    {
        self.torquedfusiontrackingoverlay fadeovertime( 0.2 );
        self.torquedfusiontrackingoverlay.alpha = 0.0;
    }
}

killstreakend()
{
    var_0 = 3;
    level notify( "killstreak_over" );
    stopallrumbles();
    wait(var_0);
    level.torquedkillstreakactive = 0;
}
