// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    _func_080();
    thread onplayerconnect();
    precachestring( &"MP_EMP_REBOOTING" );
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );
        thread _id_5E4F();
    }
}

_id_5E4F()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self.empendtime = 0;

    for (;;)
    {
        self waittill( "emp_grenaded", var_0 );

        if ( !isalive( self ) )
            continue;

        if ( isdefined( self.usingremote ) )
            continue;

        if ( maps\mp\_utility::_hasperk( "specialty_empimmune" ) )
            continue;

        var_1 = 1;
        var_2 = 0;

        if ( level.teambased && isdefined( var_0 ) && isdefined( var_0.pers["team"] ) && var_0.pers["team"] == self.pers["team"] && var_0 != self )
        {
            if ( level.friendlyfire == 0 )
                continue;
            else if ( level.friendlyfire == 1 )
            {
                var_2 = 0;
                var_1 = 1;
            }
            else if ( level.friendlyfire == 2 )
            {
                var_1 = 0;
                var_2 = 1;
            }
            else if ( level.friendlyfire == 3 )
            {
                var_2 = 1;
                var_1 = 1;
            }
        }
        else if ( isdefined( var_0 ) )
        {
            var_0 notify( "emp_hit" );

            if ( var_0 != self )
                var_0 maps\mp\gametypes\_missions::processchallenge( "ch_onthepulse" );
        }

        if ( var_1 && isdefined( self ) )
            thread _id_0CAB();

        if ( var_2 && isdefined( var_0 ) )
            var_0 thread _id_0CAB();
    }
}

_id_306D( var_0 )
{
    maps\mp\gametypes\_scrambler::playersethudempscrambledoff( var_0 );
}

_id_0CAB()
{
    self notify( "applyEmp" );
    self endon( "applyEmp" );
    self endon( "death" );
    self endon( "disconnect" );
    wait 0.05;
    self._id_307C = 3;
    var_0 = 2;

    if ( maps\mp\_utility::isaugmentedgamemode() )
    {
        var_0 = 1;
        maps\mp\_utility::playerallowhighjump( 0, "empgrenade" );
        maps\mp\_utility::playerallowhighjumpdrop( 0, "empgrenade" );
        maps\mp\_utility::playerallowboostjump( 0, "empgrenade" );
        maps\mp\_utility::playerallowpowerslide( 0, "empgrenade" );
        maps\mp\_utility::playerallowdodge( 0, "empgrenade" );
    }

    self.empgrenaded = 1;
    self.empendtime = gettime() + self._id_307C * 1000;
    var_1 = maps\mp\gametypes\_scrambler::playersethudempscrambled( self.empendtime, var_0, "emp" );
    thread _id_2A63( self._id_307C, var_1 );
    thread _id_308D( 0.75 );
    self setempjammed( 1 );
    thread _id_3087( var_1 );
    wait(self._id_307C);
    self notify( "empGrenadeTimedOut" );
    _id_1D21( var_1 );
}

_id_2A63( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );
    self _meth_84BE( "digital_distort_mp" );
    self _meth_8064( 1.0, 1.0 );
    thread _id_A209( var_1 );
    wait 0.1;
    var_2 = var_0;
    var_3 = 0.95;
    var_4 = 0.2;
    var_5 = var_3 - var_4;
    var_6 = 0.1;
    var_7 = var_3;

    while ( var_2 > 0 )
    {
        var_7 = var_5 * var_2 / var_0 + var_4;
        self _meth_8064( var_7, 1.0 );
        var_2 -= var_6;
        wait(var_6);
    }

    self _meth_8064( 0.0, 0.0 );
}

_id_A209( var_0 )
{
    common_scripts\utility::waittill_any( "death", "disconnect", "faux_spawn", "joined_team" );

    if ( isdefined( self ) )
    {
        self _meth_8064( 0.0, 0.0 );
        _id_306D( var_0 );
    }
}

_id_3087( var_0 )
{
    self notify( "empGrenadeDeathWaiter" );
    self endon( "empGrenadeDeathWaiter" );
    self endon( "empGrenadeTimedOut" );
    self waittill( "death" );
    _id_1D21( var_0 );
}

_id_1D21( var_0 )
{
    self.empgrenaded = 0;
    self setempjammed( 0 );

    if ( maps\mp\_utility::isaugmentedgamemode() )
    {
        maps\mp\_utility::playerallowhighjump( 1, "empgrenade" );
        maps\mp\_utility::playerallowhighjumpdrop( 1, "empgrenade" );
        maps\mp\_utility::playerallowboostjump( 1, "empgrenade" );
        maps\mp\_utility::playerallowpowerslide( 1, "empgrenade" );
        maps\mp\_utility::playerallowdodge( 1, "empgrenade" );
    }

    self _meth_8064( 0.0, 0.0 );
    _id_306D( var_0 );
}

_id_308D( var_0 )
{
    self endon( "emp_rumble_loop" );
    self notify( "emp_rumble_loop" );
    var_1 = gettime() + var_0 * 1000;

    while ( gettime() < var_1 )
    {
        self playrumbleonentity( "damage_heavy" );
        wait 0.05;
    }
}

_id_50F8()
{
    return isdefined( self.empendtime ) && gettime() < self.empendtime;
}