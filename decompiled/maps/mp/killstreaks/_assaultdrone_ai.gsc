// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_0D47()
{
    thread maps\mp\_aerial_pathnodes::_id_19C5();
}

_id_09A1( var_0 )
{
    thread _id_0D3E( var_0 );
    wait 2.0;
    maps\mp\_aerial_pathnodes::_id_A05C();

    if ( isdefined( var_0 ) )
    {
        var_0._id_3287 = 0;
        var_0._id_3288 = 0;
        var_0 thread _id_0D39();
        var_0 thread _id_0D4B();
        var_0 thread _id_0D4C( !var_0._id_474A );

        if ( isdefined( level.ishorde ) && level.ishorde )
        {
            self.aerialassaultdrone = var_0;
            var_0.isaerialassaultdrone = 1;
            var_0 thread assault_vehicle_horde_monitor_death( self );
        }
    }
}

assault_vehicle_horde_monitor_death( var_0 )
{
    self waittill( "death" );
    self.aerialassaultdrone = undefined;
}

_id_0D3E( var_0 )
{
    var_0 endon( "death" );
    self waittill( "disconnect" );
    var_0 notify( "death" );
}

_id_0D39()
{
    self notify( "assault_vehicle_ai_aerial_movement" );
    self endon( "assault_vehicle_ai_aerial_movement" );
    self endon( "death" );
    var_0 = self _meth_84AD();
    self _meth_8283( var_0, 8, 60 );
    self _meth_8253( 0, 0, 0 );
    var_1 = undefined;
    var_2 = _id_0D44();

    if ( !isdefined( var_2 ) )
        return;

    var_3 = var_2;

    if ( !maps\mp\_aerial_pathnodes::_id_6121( var_3 ) )
    {
        var_4 = maps\mp\_aerial_pathnodes::_id_3D52( 64, 0 );

        if ( isdefined( var_4 ) )
            var_3 = var_4;
    }

    if ( maps\mp\_aerial_pathnodes::_id_6121( var_3 ) )
        var_1 = _func_200( self.origin, var_3.origin, 1, var_2 );

    if ( !isdefined( var_1 ) )
    {
        var_5 = 1500;
        var_6 = 0;

        while ( !isdefined( var_1 ) && var_6 < var_5 )
        {
            var_7 = maps\mp\_aerial_pathnodes::_id_3D52( var_5, var_6 );

            if ( isdefined( var_7 ) )
            {
                var_1 = _func_200( self.origin, var_7.origin, 1, var_2 );

                if ( !isdefined( var_1 ) )
                    var_6 = distance( self.origin, var_7.origin ) + 1;

                continue;
            }

            var_6 = var_5 + 1;
        }

        if ( var_6 > var_5 )
            return;
    }

    var_8 = _id_0D38( var_1 );
    _id_0D48( var_8 );
    wait 0.85;
    var_9 = 1;

    if ( var_9 )
    {
        self notify( "in_air" );
        _id_0D3B( var_8 );
    }
}

_id_0D38( var_0 )
{
    var_1 = ( 0.0, 0.0, 40.0 );
    var_2 = undefined;

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_0[var_3];

        if ( isdefined( var_2 ) && isdefined( var_2.targetname ) && var_2.targetname == "traverse" )
            assault_vehicle_ai_air_traverse( var_2, var_4, var_1 );

        _id_0D3C( var_4.origin + var_1 );
        var_5 = 0;

        while ( _func_220( var_4.origin, self.origin ) > squared( 24.0 ) )
        {
            var_5 += 0.05;

            if ( var_5 > _id_0D49() )
                return;

            wait 0.05;
        }

        if ( maps\mp\_aerial_pathnodes::_id_6121( var_4 ) )
            return var_4;

        var_2 = var_4;
    }

    return var_0[var_0.size - 1];
}

_id_0D48( var_0 )
{
    var_1 = var_0.origin + maps\mp\_aerial_pathnodes::_id_3CB0();
    _id_0D3C( var_1 );

    while ( distancesquared( self.origin, var_1 ) > 576.0 )
        wait 0.05;
}

_id_0D3B( var_0 )
{
    var_1 = var_0;
    var_2 = [];
    var_2[var_1 _meth_8381()] = 1;

    for (;;)
    {
        var_1 = _id_0D4A( var_1, var_2 );
        _id_0D48( var_1 );
        var_3 = var_1 _meth_8381();

        if ( !isdefined( var_2[var_3] ) )
            var_2[var_3] = 0;

        var_2[var_3]++;
        wait(randomfloatrange( 0.05, 2.0 ));
    }
}

_id_0D3A()
{
    for (;;)
    {
        var_0 = undefined;

        if ( _id_0D3F() )
            var_0 = self._id_3286 maps\mp\_aerial_pathnodes::_id_3D52();

        if ( !isdefined( var_0 ) )
            var_0 = common_scripts\utility::random( level._id_088C );

        var_1 = maps\mp\_aerial_pathnodes::_id_3D52();
        var_2 = maps\mp\_aerial_pathnodes::_id_376A( var_1, var_0 );

        if ( isdefined( var_2 ) )
            _id_0D42( var_2, ::_id_0D3C, ::_id_0D40, maps\mp\_aerial_pathnodes::_id_3CB0()[2] );

        if ( _id_0D3F() )
        {
            if ( !_id_0D40( var_0 ) || _func_220( self.origin, self._id_3286.origin ) < squared( 200 ) )
            {
                var_3 = self._id_3286.origin + ( 0.0, 0.0, 40.0 );
                self _meth_825B( var_3, 1 );

                while ( _id_0D3F() && distancesquared( var_3, self.origin ) > squared( 24.0 ) )
                    wait 0.05;

                wait 0.8;
                _id_0D45( ::_id_0D3C, ::_id_0D41 );
            }
        }

        wait 0.05;
    }
}

_id_0D4A( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = 9999;
    var_4 = common_scripts\utility::array_randomize( var_0._id_0889 );

    foreach ( var_6 in var_4 )
    {
        var_7 = var_6 _meth_8381();
        var_8 = var_1[var_7];

        if ( !isdefined( var_8 ) )
            return var_6;

        if ( var_8 < var_3 )
        {
            var_2 = var_6;
            var_3 = var_8;
        }
    }

    return var_2;
}

_id_0D44()
{
    var_0 = getclosestnodeinsight( self.origin, 1 );

    if ( !isdefined( var_0 ) )
    {
        var_1 = getnodesinradiussorted( self.origin, 1000, 0 );

        if ( var_1.size > 0 )
            var_0 = var_1[0];
    }

    return var_0;
}

_id_0D45( var_0, var_1 )
{
    self endon( "death" );
    var_2 = _id_0D44();

    if ( !isdefined( var_2 ) )
        return;

    for (;;)
    {
        childthread _id_0D46( var_0, var_1 );
        common_scripts\utility::waittill_any( "enemy" );
    }
}

_id_0D46( var_0, var_1 )
{
    self notify( "assault_vehicle_ai_ground_movement_loop" );
    self endon( "assault_vehicle_ai_ground_movement_loop" );
    var_2 = [];

    for (;;)
    {
        var_3 = undefined;
        var_4 = undefined;

        if ( _id_0D3F() )
            var_4 = self._id_3286.origin;
        else
        {
            var_5 = 0;

            while ( !isdefined( var_3 ) && var_5 < 20 )
            {
                var_3 = istestclient( self.origin, self.angles );

                if ( isdefined( var_3 ) )
                {
                    if ( common_scripts\utility::array_contains( var_2, var_3 ) )
                        var_3 = undefined;
                    else
                        var_4 = var_3.origin;
                }

                var_5++;
                wait 0.05;
            }
        }

        if ( isdefined( var_4 ) )
        {
            var_6 = _id_0D44();

            if ( !isdefined( var_6 ) )
                return;

            var_7 = _func_200( self.origin, var_4, 0, var_6 );

            if ( isdefined( var_7 ) )
                _id_0D42( var_7, var_0, var_1 );
            else
                var_2[var_2.size] = var_3;
        }

        wait 0.05;
    }
}

_id_0D43()
{
    var_0 = self _meth_84F9();
    var_1 = self.origin + rotatevector( var_0, self.angles );
    return var_1;
}

_id_0D4B()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = [];
        var_1 = 0;

        if ( isdefined( self._id_3286 ) && !isalive( self._id_3286 ) )
        {
            var_2 = self._id_3286.lastinflictor;

            if ( isdefined( var_2 ) )
            {
                if ( var_2 == self || isdefined( var_2._id_9130 ) && var_2._id_9130 == self )
                {
                    self._id_379E = gettime() + 1000;
                    wait 1.0;
                }
            }
        }

        foreach ( var_4 in level.characters )
        {
            if ( isalive( var_4 ) && !_func_285( self, var_4 ) && self.owner != var_4 )
            {
                if ( var_4 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
                    continue;

                var_5 = 0;
                var_6 = _id_0D43();
                var_7 = var_4.origin + ( 0.0, 0.0, 40.0 );

                if ( self._id_4716 )
                    var_5 = 1;

                if ( isdefined( var_4.lastshotfiredtime ) && gettime() - var_4.lastshotfiredtime < 3.0 )
                    var_5 = 1;
                else if ( setteamradarstrength( self.team ) > getuavstrengthlevelneutral() )
                    var_5 = 1;
                else if ( sighttracepassed( var_6, var_7, 0, self, var_4 ) )
                    var_5 = 1;

                if ( var_5 && self._id_474A )
                {
                    var_8 = self _meth_84FA();
                    var_9 = var_7 - var_6;
                    var_10 = vectortoangles( var_9 );
                    var_11 = angleclamp180( var_10[0] );

                    if ( var_11 > var_8 || var_11 < -1 * var_8 )
                        var_5 = 0;
                }

                if ( var_5 )
                    var_0[var_0.size] = var_4;

                if ( var_1 )
                    wait 0.05;

                var_1 = !var_1;
            }
        }

        if ( isdefined( level.ishorde ) && level.ishorde )
        {
            var_13 = [];

            foreach ( var_15 in level._id_89A1 )
            {
                if ( isdefined( var_15.team ) && var_15.team == "axis" )
                    var_13[var_13.size] = var_15;
            }

            var_17 = common_scripts\utility::array_combine( level.flying_attack_drones, var_13 );

            foreach ( var_19 in var_17 )
            {
                var_5 = 0;
                var_6 = _id_0D43();
                var_7 = ( 0.0, 0.0, 0.0 );

                if ( isdefined( var_19.origin ) )
                {
                    var_7 = var_19.origin;

                    if ( sighttracepassed( var_6, var_7, 0, self, var_19 ) )
                        var_5 = 1;
                }

                if ( var_5 )
                {
                    var_8 = self _meth_84FA();
                    var_9 = var_7 - var_6;
                    var_10 = vectortoangles( var_9 );
                    var_11 = angleclamp180( var_10[0] );

                    if ( var_11 > var_8 || var_11 < -1 * var_8 )
                        var_5 = 0;
                }

                if ( var_5 )
                    var_0[var_0.size] = var_19;

                if ( var_1 )
                    waitframe();

                var_1 = !var_1;
            }

            foreach ( var_22 in level._id_49C1 )
            {
                var_5 = 0;
                var_6 = _id_0D43();
                var_7 = ( 0.0, 0.0, 0.0 );

                if ( isdefined( var_22.origin ) )
                {
                    var_7 = var_22.origin + ( 0.0, 0.0, 40.0 );

                    if ( sighttracepassed( var_6, var_7, 0, self, var_22 ) )
                        var_5 = 1;
                }

                if ( var_5 )
                {
                    var_8 = self _meth_84FA();
                    var_9 = var_7 - var_6;
                    var_10 = vectortoangles( var_9 );
                    var_11 = angleclamp180( var_10[0] );

                    if ( var_11 > var_8 || var_11 < -1 * var_8 )
                        var_5 = 0;
                }

                if ( var_5 )
                    var_0[var_0.size] = var_22;

                if ( var_1 )
                    waitframe();

                var_1 = !var_1;
            }

            var_24 = [];

            foreach ( var_26 in var_0 )
            {
                if ( !isdefined( var_26 ) )
                {
                    var_24[var_24.size] = var_26;
                    continue;
                }

                if ( isdefined( var_26._id_511B ) && var_26._id_511B )
                {
                    if ( !isdefined( var_26.damagetaken ) || !isdefined( var_26.maxhealth ) || var_26.damagetaken > var_26.maxhealth )
                        var_24[var_24.size] = var_26;

                    continue;
                }

                if ( isdefined( var_26._id_511C ) && var_26._id_511C )
                {
                    if ( !var_26.isalive )
                        var_24[var_24.size] = var_26;
                }
            }

            foreach ( var_26 in var_24 )
                var_0 = common_scripts\utility::array_remove( var_0, var_26 );
        }

        if ( var_0.size > 0 )
        {
            var_30 = common_scripts\utility::get_array_of_closest( self.origin, var_0 );
            var_31 = self._id_3286;
            self._id_3286 = var_30[0];

            if ( !isdefined( var_31 ) || var_31 != self._id_3286 )
                self notify( "enemy" );
        }
        else if ( isdefined( self._id_3286 ) )
            self._id_3286 = undefined;

        wait 0.05;
    }
}

_id_0D4C( var_0 )
{
    self endon( "death" );

    if ( var_0 )
        self waittill( "in_air" );

    self._id_554C = 0;
    self._id_4DCA = 1;
    var_1 = squared( maps\mp\killstreaks\_drone_assault::_id_3F06() * 0.75 );

    for (;;)
    {
        if ( isdefined( self._id_91C2 ) )
        {
            if ( _id_0D3F() )
            {
                if ( _id_0D3D() )
                {
                    if ( isdefined( level.ishorde ) && level.ishorde )
                    {
                        if ( isdefined( self._id_3286._id_511B ) && self._id_3286._id_511B )
                            self._id_91C2.origin = self._id_3286.origin;
                        else
                            self._id_91C2.origin = self._id_3286.origin + ( 0.0, 0.0, 40.0 );
                    }
                    else if ( self._id_474A )
                        self._id_91C2.origin = self._id_3286.origin + ( 0.0, 0.0, 40.0 );
                    else
                        self._id_91C2.origin = self._id_3286.origin + anglestoforward( self._id_3286.angles ) * 100;

                    var_2 = vectortoangles( self._id_91C2.origin - self.origin );

                    for ( var_3 = var_2[1] - self.angles[1]; var_3 > 180; var_3 -= 360 )
                    {

                    }

                    while ( var_3 < -180 )
                        var_3 += 360;

                    var_4 = 10;

                    if ( abs( var_3 ) < var_4 )
                        var_5 = var_2[1];
                    else
                        var_5 = self.angles[1] + var_4 * var_3 / abs( var_3 );

                    self _meth_827C( self.origin, ( var_2[0], var_5, self.angles[2] ), 0, 1 );

                    if ( self._id_4DCA )
                    {
                        wait 0.1;
                        self._id_4DCA = 0;

                        if ( !_id_0D3D() )
                            continue;
                    }

                    var_6 = self._id_473F && self._id_7589 > 0;

                    if ( self._id_474A )
                        var_7 = self._id_5BD2 gettagorigin( "tag_flash" );
                    else
                        var_7 = self.origin;

                    if ( var_6 )
                        var_6 = distancesquared( var_7, self._id_3286.origin ) > 17424;

                    var_8 = self._id_91C2.origin - var_7;
                    var_9 = vectortoangles( var_8 );
                    var_10 = self _meth_84FA();
                    var_11 = angleclamp180( var_9[0] );
                    var_12 = var_11 < var_10 && var_11 > -1 * var_10;
                    var_13 = vectornormalize( anglestoforward( self.angles ) * ( 1.0, 1.0, 0.0 ) );
                    var_14 = vectornormalize( var_8 * ( 1.0, 1.0, 0.0 ) );
                    var_15 = vectordot( var_13, var_14 ) > 0.9;

                    if ( var_12 && var_15 )
                    {
                        if ( self._id_473F && var_6 )
                        {
                            if ( gettime() > self._id_554C + 1000 )
                            {
                                if ( self._id_4736 )
                                    self notify( "FireSecondaryWeapon" );
                                else
                                    self notify( "FirePrimaryWeapon" );

                                self._id_554C = gettime();
                            }
                        }
                        else if ( self._id_4736 )
                            self._id_5BD2 _meth_80EA();
                        else if ( !self._id_474A )
                        {
                            if ( sighttracepassed( var_7, self._id_91C2.origin, 0, self, self._id_3286 ) )
                                self notify( "FirePrimaryWeapon" );
                        }
                    }
                }
                else
                    self._id_4DCA = 1;
            }
            else if ( isdefined( self._id_3286 ) && !isalive( self._id_3286 ) )
            {
                if ( self._id_4736 )
                {
                    if ( isdefined( self._id_379E ) && gettime() < self._id_379E )
                        self._id_5BD2 _meth_80EA();
                }
            }
        }

        if ( self._id_4721 && !maps\mp\killstreaks\_drone_common::_id_2F10( self ) )
        {
            if ( !isdefined( self._id_1FBB ) || self._id_1FBB == 0 )
                self notify( "Cloak" );
        }

        wait 0.05;
    }
}

_id_0D3F()
{
    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        if ( isdefined( self._id_3286 ) && isdefined( self._id_3286._id_511C ) && self._id_3286._id_511C )
            return self._id_3286.isalive;
        else
            return isdefined( self._id_3286 ) && isalive( self._id_3286 );
    }
    else
        return isdefined( self._id_3286 ) && isalive( self._id_3286 );
}

_id_0D3D()
{
    if ( !_id_0D3F() )
        return 0;

    if ( gettime() > self._id_3287 )
    {
        self._id_3287 = gettime();

        if ( isdefined( level.ishorde ) && level.ishorde )
        {
            if ( isdefined( self._id_3286._id_511B ) && self._id_3286._id_511B )
                self._id_3288 = sighttracepassed( _id_0D43(), self._id_3286.origin, 0, self, self._id_3286 );
            else
                self._id_3288 = sighttracepassed( _id_0D43(), self._id_3286.origin + ( 0.0, 0.0, 40.0 ), 0, self, self._id_3286 );
        }
        else
            self._id_3288 = sighttracepassed( _id_0D43(), self._id_3286.origin + ( 0.0, 0.0, 40.0 ), 0, self, self._id_3286 );
    }

    return self._id_3288;
}

_id_0D42( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_4 = ( 0, 0, var_3 );

    for ( var_5 = 0; var_5 < var_0.size; var_5++ )
    {
        var_6 = var_0[var_5];
        self [[ var_1 ]]( var_6.origin + var_4 );
        var_7 = 0;

        while ( _func_220( var_6.origin, self.origin ) > squared( 24.0 ) )
        {
            var_7 += 0.05;
            var_8 = var_7 > _id_0D49();

            if ( !var_8 && _id_0D3F() )
                var_8 = self [[ var_2 ]]( var_0[var_0.size - 1] );

            if ( var_8 )
                return;

            if ( self._id_474A && _id_0D3D() )
            {
                self [[ var_1 ]]( self.origin );

                while ( _id_0D3D() )
                    wait 0.05;

                self [[ var_1 ]]( var_6.origin );
            }

            wait 0.05;
        }
    }
}

_id_0D40( var_0 )
{
    var_1 = self._id_3286 maps\mp\_aerial_pathnodes::_id_3D52();
    return var_1 != var_0;
}

_id_0D41( var_0 )
{
    return distancesquared( var_0.origin, self._id_3286.origin ) > squared( 128.0 );
}

_id_0D49()
{
    return 7.5;
}

assault_vehicle_ai_air_traverse( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return;

    if ( !isdefined( var_0.targetname ) || var_0.targetname != "traverse" )
        return;

    if ( !isdefined( var_0.type ) || !isdefined( var_1.type ) || var_0.type != "Begin" || var_1.type != "End" )
        return;

    if ( !isdefined( var_0.target ) || !isdefined( var_1.targetname ) || var_0.target != var_1.targetname )
        return;

    if ( isdefined( var_0._id_0047 ) )
    {
        if ( var_0._id_0047 == "boost_jump_up" )
        {
            var_3 = 0.25 * ( var_1.origin - var_0.origin ) + var_0.origin;
            var_3 = ( var_3[0], var_3[1], var_1.origin[2] + 10 );
            _id_0D3C( var_3 + var_2 );
            var_4 = 0;

            while ( _func_220( var_3, self.origin ) > squared( 24.0 ) || self.origin[2] < var_3[2] )
            {
                var_4 += 0.05;

                if ( var_4 > _id_0D49() )
                    return;

                wait 0.05;
            }
        }
    }
}

_id_0D3C( var_0 )
{
    self _meth_825B( var_0, 1 );
}
