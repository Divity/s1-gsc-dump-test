// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self endon( "killanimscript" );

    if ( !isdefined( level._id_2CDF ) )
        _id_4DAE();

    var_0 = self _meth_819D();
    var_1 = self _meth_819E();

    if ( var_0._id_0047 == "bot_walk_forward" )
    {
        var_2 = var_1.origin - var_0.origin;
        var_3 = length( var_2 ) / 256;
        var_4 = ( var_2[0], var_2[1], 0 );
        var_5 = vectortoangles( var_4 );
        self _meth_8396( "face angle abs", var_5 );
        self _meth_839F( var_0.origin, var_1.origin, var_3 );
        self _meth_8398( "noclip" );
        maps\mp\agents\_scriptedagents::_id_6A23( "run", var_3 );
    }
    else
    {
        var_6 = undefined;
        var_6 = level._id_2CDF[var_0._id_0047];

        if ( !isdefined( var_6 ) )
            return;

        self._id_14B3 = 1;
        var_2 = var_1.origin - var_0.origin;
        var_4 = ( var_2[0], var_2[1], 0 );
        var_5 = vectortoangles( var_4 );
        self _meth_8396( "face angle abs", var_5 );
        self _meth_8397( "anim deltas" );
        var_7 = self _meth_83D3( var_6, 0 );
        var_8 = getnotetracktimes( var_7, "code_move" );

        if ( var_8.size > 0 )
            var_9 = getmovedelta( var_7, 0, var_8[0] );
        else
            var_9 = getmovedelta( var_7, 0, 1 );

        var_10 = maps\mp\agents\_scriptedagents::_id_3EFB( var_2, var_9 );
        self _meth_8398( "noclip" );

        if ( var_2[2] > 0 )
        {
            if ( var_9[2] > 0 )
            {
                var_11 = getnotetracktimes( var_7, "traverse_jump_start" );

                if ( var_11.size > 0 )
                {
                    var_12 = 1;
                    var_13 = 1;

                    if ( length2dsquared( var_4 ) < 0.64 * length2dsquared( var_9 ) )
                        var_12 = 0.4;

                    if ( var_2[2] < 0.75 * var_9[2] )
                        var_13 = 0.5;

                    self _meth_8395( var_12, var_13 );
                    maps\mp\agents\_scriptedagents::_id_6A27( var_6, 0, "traverse", "traverse_jump_start" );
                    var_14 = getnotetracktimes( var_7, "traverse_jump_end" );
                    var_15 = getmovedelta( var_7, 0, var_11[0] );
                    var_16 = getmovedelta( var_7, 0, var_14[0] );
                    var_12 = 1;
                    var_13 = 1;
                    var_17 = var_1.origin - self.origin;
                    var_18 = var_9 - var_15;

                    if ( length2dsquared( var_17 ) < 0.5625 * length2dsquared( var_18 ) )
                        var_12 = 0.75;

                    if ( var_17[2] < 0.75 * var_18[2] )
                        var_13 = 0.75;

                    var_19 = var_9 - var_16;
                    var_20 = ( var_19[0] * var_12, var_19[1] * var_12, var_19[2] * var_13 );
                    var_21 = rotatevector( var_20, var_5 );
                    var_22 = var_1.origin - var_21;
                    var_23 = var_16 - var_15;
                    var_24 = rotatevector( var_23, var_5 );
                    var_25 = var_22 - self.origin;
                    var_10 = maps\mp\agents\_scriptedagents::_id_3EFB( var_25, var_24, 1 );
                    self _meth_8395( var_10._id_A3A8, var_10.z );
                    maps\mp\agents\_scriptedagents::_id_A0F7( "traverse", "traverse_jump_end" );
                    self _meth_8395( var_12, var_13 );
                    maps\mp\agents\_scriptedagents::_id_A0F7( "traverse", "code_move" );
                    return;
                }

                self _meth_8395( var_10._id_A3A8, var_10.z );
                maps\mp\agents\_scriptedagents::_id_6A27( var_6, 0, "traverse" );
                return;
                return;
            }

            var_26 = getnotetracktimes( var_7, "gravity on" );

            if ( var_26.size > 0 )
            {
                var_27 = var_0 _id_4104();

                if ( isdefined( var_27 ) )
                {
                    var_28 = var_27 - self.origin;
                    var_29 = var_1.origin - var_27;
                    var_30 = getmovedelta( var_7, 0, var_26[0] );
                    var_10 = maps\mp\agents\_scriptedagents::_id_3EFB( var_28, var_30 );
                    self _meth_8395( var_10._id_A3A8, var_10.z );
                    maps\mp\agents\_scriptedagents::_id_6A27( var_6, 0, "traverse", "gravity on" );
                    var_31 = getmovedelta( var_7, var_26[0], 1 );
                    var_10 = maps\mp\agents\_scriptedagents::_id_3EFB( var_29, var_31 );
                    self _meth_8395( var_10._id_A3A8, var_10.z );
                    maps\mp\agents\_scriptedagents::_id_A0F7( "traverse", "code_move" );
                    return;
                }
            }

            var_32 = getanimlength( var_7 );
            self _meth_839F( var_0.origin, var_1.origin, var_32 );
            maps\mp\agents\_scriptedagents::_id_6A27( var_6, 0, "traverse" );
            return;
            return;
        }

        var_26 = getnotetracktimes( var_7, "gravity on" );

        if ( var_26.size > 0 )
        {
            self _meth_8395( var_10._id_A3A8, 1 );
            maps\mp\agents\_scriptedagents::_id_6A27( var_6, 0, "traverse", "gravity on" );
            var_33 = getmovedelta( var_7, 0, var_26[0] );
            var_34 = var_33[2] - var_9[2];

            if ( abs( var_34 ) > 0 )
            {
                var_35 = self.origin[2] - var_1.origin[2];
                var_13 = var_35 / var_34;
                self _meth_8395( var_10._id_A3A8, var_13 );
                var_36 = clamp( 2 / var_13, 0.5, 1 );
                var_37 = var_6 + "_norestart";
                self _meth_83D2( var_37, 0, var_36 );
            }

            maps\mp\agents\_scriptedagents::_id_A0F7( "traverse", "code_move" );
        }
        else
        {
            self _meth_8395( var_10._id_A3A8, var_10.z );
            var_36 = clamp( 2 / var_10.z, 0.5, 1 );
            var_14 = getnotetracktimes( var_7, "traverse_jump_end" );

            if ( var_14.size > 0 )
            {
                maps\mp\agents\_scriptedagents::_id_6A25( var_6, 0, var_36, "traverse", "traverse_jump_end" );
                var_37 = var_6 + "_norestart";
                self _meth_83D2( var_37, 0, 1 );
                maps\mp\agents\_scriptedagents::_id_A0F7( "traverse", "code_move" );
            }
            else
                maps\mp\agents\_scriptedagents::_id_6A27( var_6, 0, "traverse" );
        }

        self _meth_8395( 1, 1 );
    }
}

_id_0140()
{
    self _meth_8395( 1, 1 );
    self._id_14B3 = 0;
}

_id_4104()
{
    if ( isdefined( self._id_91C3 ) )
        return self._id_91C3;

    var_0 = getent( self.target, "targetname" );

    if ( !isdefined( var_0 ) )
        return undefined;

    self._id_91C3 = var_0.origin;
    var_0 delete();
    return self._id_91C3;
}

_id_4DAE()
{
    level._id_2CDF = [];
    level._id_2CDF["hjk_tree_hop"] = "traverse_jump_over_24";
    level._id_2CDF["jump_across_72"] = "traverse_jump_over_24";
    level._id_2CDF["wall_hop"] = "traverse_jump_over_36";
    level._id_2CDF["window_2"] = "traverse_jump_over_36";
    level._id_2CDF["wall_over_40"] = "traverse_jump_over_36";
    level._id_2CDF["wall_over"] = "traverse_jump_over_36";
    level._id_2CDF["window_divethrough_36"] = "traverse_jump_over_36";
    level._id_2CDF["window_over_40"] = "traverse_jump_over_36";
    level._id_2CDF["window_over_quick"] = "traverse_jump_over_36";
    level._id_2CDF["jump_up_80"] = "traverse_jump_up_70";
    level._id_2CDF["jump_standing_80"] = "traverse_jump_up_70";
    level._id_2CDF["jump_down_80"] = "traverse_jump_down_70";
    level._id_2CDF["jumpdown_96"] = "traverse_jump_down_70";
    level._id_2CDF["jump_up_40"] = "traverse_jump_up_40";
    level._id_2CDF["jump_down_40"] = "traverse_jump_down_40";
    level._id_2CDF["step_up"] = "traverse_jump_up_24";
    level._id_2CDF["step_up_24"] = "traverse_jump_up_24";
    level._id_2CDF["step_down"] = "traverse_jump_down_24";
    level._id_2CDF["jump_down"] = "traverse_jump_down_24";
    level._id_2CDF["jump_across"] = "traverse_jump_over_36";
    level._id_2CDF["jump_across_100"] = "traverse_jump_over_36";
}