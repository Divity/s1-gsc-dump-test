// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_0897["civ_generic"] = level._id_0897["civilian"];
    level._id_0897["civ_generic"]["think"] = ::civilian_generic_think;
    var_0[0] = [ "zombies_body_civ_cau_a" ];
    var_1[0] = [ "zombies_head_cau_a" ];
    var_2 = spawnstruct();
    var_2.agent_type = "civ_generic";
    var_2.animclass = "zombie_animclass";
    var_2.model_bodies = var_0;
    var_2.model_heads = var_1;
    var_2._id_4780 = 1.0;
    maps\mp\zombies\_util::agentclassregister( var_2, var_2.agent_type );
}

civilian_generic_think()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );
    maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
    thread maps\mp\zombies\_util::_id_A008();

    for (;;)
    {
        if ( civilian_evacuate() )
        {
            wait 0.05;
            continue;
        }

        if ( isalive( self.foundby ) && maps\mp\zombies\_behavior::humanoid_follow( self.foundby ) )
        {
            wait 0.05;
            continue;
        }

        if ( civilian_wait_used( &"ZOMBIES_CIV_FOLLOW" ) )
        {
            wait 0.05;
            continue;
        }

        wait 0.05;
    }
}

civilian_wait_used( var_0 )
{
    if ( isalive( self.foundby ) )
        return 0;

    self.foundby = undefined;

    if ( !self.ignoreme )
    {
        self takeallweapons();
        self _meth_8119( 0 );
        self.ignoreme = 1;
        thread maps\mp\zombies\_util::zombies_make_usable( var_0 );
        thread civilian_use_waiter();
        self _meth_8390( self.origin );
    }

    return 1;
}

civilian_use_waiter()
{
    self waittill( "player_used", var_0 );
    self.foundby = var_0;
    self.ignoreme = 0;
    self _meth_8119( 1 );
    thread maps\mp\zombies\_util::zombies_make_unusable();
}

civilian_evacuate()
{
    if ( !isdefined( self.evac_point ) && isdefined( level.evac_points ) )
    {
        var_0 = sortbydistance( level.evac_points, self.origin, 500 );

        if ( isdefined( var_0 ) && var_0.size > 0 )
            self.evac_point = var_0[0];
    }

    if ( !isdefined( self.evac_point ) )
    {
        self.evac_goal = undefined;
        self notify( "civilian_evac_waiter" );
        return 0;
    }

    if ( !isdefined( self.evac_goal ) )
    {
        self _meth_8390( self.evac_point.origin );
        self.evac_goal = self.evac_point;
        thread civilian_evac_waiter();
    }

    return 1;
}

civilian_evac_waiter()
{
    self notify( "civilian_evac_waiter" );
    self endon( "civilian_evac_waiter" );
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = common_scripts\utility::waittill_any_return( "goal", "goal_reached", "bad_path" );
    self.evac_point = undefined;

    if ( var_0 == "goal" || var_0 == "goal_reached" )
    {
        self notify( "rescued" );
        iprintlnbold( "Civilian Rescued!" );
        maps\mp\zombies\_util::zombies_make_nonobjective();

        if ( maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() )
            wait 0.05;

        self suicide();
    }
}
