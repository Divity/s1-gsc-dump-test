// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

playanimnatrateuntilnotetrack_safe( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "disconnect" );
    self endon( "death" );

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( var_1 ) )
            var_6 = getanimlength( self _meth_83D3( var_0, var_1 ) );
        else
            var_6 = getanimlength( self _meth_83D3( var_0, 0 ) );

        childthread notetrack_timeout( var_3, var_6 * 1.0 / var_2, var_4 );
    }

    _id_6A25( var_0, var_1, var_2, var_3, var_4, var_5 );
    self notify( "Notetrack_Timeout" );
}

playanimnuntilnotetrack_safe( var_0, var_1, var_2, var_3, var_4 )
{
    playanimnatrateuntilnotetrack_safe( var_0, var_1, 1.0, var_2, var_3, var_4 );
}

_id_6A25( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    set_anim_state( var_0, var_1, var_2 );

    if ( !isdefined( var_4 ) )
        var_4 = "end";

    _id_A0F7( var_3, var_4, var_0, var_1, var_5 );
}

waituntilnotetrack_safe( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    self endon( "death" );

    if ( isdefined( var_2 ) )
        childthread notetrack_timeout( var_0, var_2, var_1 );

    _id_A0F7( var_0, var_1 );
    self notify( "Notetrack_Timeout" );
}

_id_A0F7( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = gettime();
    var_6 = undefined;
    var_7 = undefined;

    if ( isdefined( var_2 ) && isdefined( var_3 ) )
        var_7 = getanimlength( self _meth_83D3( var_2, var_3 ) );

    for (;;)
    {
        self waittill( var_0, var_8 );

        if ( isdefined( var_7 ) )
            var_6 = ( gettime() - var_5 ) * 0.001 / var_7;

        if ( !isdefined( var_7 ) || var_6 > 0 )
        {
            if ( var_8 == var_1 || var_8 == "end" || var_8 == "anim_will_finish" || var_8 == "finish" )
                break;
        }

        if ( isdefined( var_4 ) )
            [[ var_4 ]]( var_8, var_2, var_3, var_6 );
    }
}

notetrack_timeout( var_0, var_1, var_2 )
{
    self notify( "Notetrack_Timeout" );
    self endon( "Notetrack_Timeout" );
    var_1 = max( 0.05, var_1 );
    wait(var_1);

    if ( isdefined( var_2 ) )
        self notify( var_0, var_2 );
    else
        self notify( var_0, "end" );
}

_id_6A24( var_0, var_1, var_2, var_3 )
{
    set_anim_state( var_0, var_1, var_2 );
    wait(var_3);
}

loop_anim_state_randomize( var_0, var_1, var_2 )
{
    for (;;)
    {
        var_3 = randomint( self _meth_83D6( var_0 ) );
        set_anim_state( var_0, var_3, var_1 );
        var_4 = getanimlength( self _meth_83D3( var_0, var_3 ) ) * 1.0 / var_1;
        waituntilnotetrack_safe( var_2, "end", var_4 );
    }
}

set_anim_state( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
        self _meth_83D2( var_0, var_1, var_2 );
    else if ( isdefined( var_1 ) )
        self _meth_83D2( var_0, var_1 );
    else
        self _meth_83D2( var_0 );
}

getangleindexvariable( var_0, var_1 )
{
    if ( var_1 <= 1 )
        return 0;

    var_2 = 360.0 / ( var_1 - 1 );
    var_3 = var_2 * 0.222222;

    if ( var_0 < 0 )
        return int( ceil( ( 180 + var_0 - var_3 ) / var_2 ) );
    else
        return int( floor( ( 180 + var_0 + var_3 ) / var_2 ) );
}

_id_3EFB( var_0, var_1, var_2 )
{
    var_3 = length2d( var_0 );
    var_4 = var_0[2];
    var_5 = length2d( var_1 );
    var_6 = var_1[2];
    var_7 = 1;
    var_8 = 1;

    if ( isdefined( var_2 ) && var_2 )
    {
        var_9 = ( var_1[0], var_1[1], 0 );
        var_10 = vectornormalize( var_9 );

        if ( vectordot( var_10, var_0 ) < 0 )
            var_7 = 0;
        else if ( var_5 > 0 )
            var_7 = var_3 / var_5;
    }
    else if ( var_5 > 0 )
        var_7 = var_3 / var_5;

    if ( abs( var_6 ) > 0.001 && var_6 * var_4 >= 0 )
        var_8 = var_4 / var_6;

    var_11 = spawnstruct();
    var_11._id_A3A8 = var_7;
    var_11.z = var_8;
    return var_11;
}

_id_648D( var_0, var_1 )
{
    self notify( "killanimscript" );

    if ( isdefined( self._id_0C69._id_64A2[var_0] ) )
        self [[ self._id_0C69._id_64A2[var_0] ]]();

    _id_343E( var_0 );

    if ( !isdefined( self._id_0C69._id_648C[var_1] ) )
        return;

    if ( var_0 == var_1 && var_1 != "traverse" )
        return;

    self._id_09A3 = var_1;
    _id_3304( var_1 );
    self [[ self._id_0C69._id_648C[var_1] ]]();
}

_id_3304( var_0 )
{
    self._id_09A3 = var_0;

    switch ( var_0 )
    {
        case "idle":
            self._id_1432 = 0;
            break;
        default:
            break;
    }
}

_id_343E( var_0 )
{
    switch ( var_0 )
    {
        default:
            break;
    }
}

isstatelocked()
{
    return self._id_03FC;
}

setstatelocked( var_0, var_1 )
{
    self._id_03FC = var_0;
}
