// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    if ( isdefined( level.createfx_enabled ) && level.createfx_enabled )
        return;

    if ( level.script == "mp_character_room" )
        return;

    if ( getdvarint( "virtualLobbyActive" ) == 1 )
        return;

    _id_806C();
    maps\mp\bots\_bots_personality::_id_8254();
    level._id_1262 = ::badplace_cylinder;
    level._id_1263 = ::badplace_delete;

    if ( isdefined( level.bot_killstreak_setup_func ) )
        [[ level.bot_killstreak_setup_func ]]();
    else
        maps\mp\bots\_bots_ks::_id_167A();

    maps\mp\bots\_bots_loadout::init();
    level thread init();
}

_id_806C()
{
    level.bot_funcs = [];
    level.bot_funcs["bots_spawn"] = ::_id_88D2;
    level.bot_funcs["bots_add_scavenger_bag"] = ::_id_15A4;
    level.bot_funcs["bots_add_to_level_targets"] = maps\mp\bots\_bots_util::_id_15A6;
    level.bot_funcs["bots_remove_from_level_targets"] = maps\mp\bots\_bots_util::_id_16CD;
    level.bot_funcs["bots_make_entity_sentient"] = ::_id_1697;
    level.bot_funcs["think"] = ::_id_170F;
    level.bot_funcs["on_killed"] = ::_id_643D;
    level.bot_funcs["should_do_killcam"] = ::_id_16F9;
    level.bot_funcs["get_attacker_ent"] = maps\mp\bots\_bots_util::_id_1634;
    level.bot_funcs["should_pickup_weapons"] = ::_id_16FB;
    level.bot_funcs["on_damaged"] = ::_id_15E9;
    level.bot_funcs["gametype_think"] = ::_id_277C;
    level.bot_funcs["leader_dialog"] = maps\mp\bots\_bots_util::_id_1681;
    level.bot_funcs["player_spawned"] = ::_id_16BA;
    level.bot_funcs["should_start_cautious_approach"] = maps\mp\bots\_bots_strategy::_id_8475;
    level.bot_funcs["know_enemies_on_start"] = ::_id_167D;
    level.bot_funcs["bot_get_rank_xp_and_prestige"] = ::_id_163B;
    level.bot_funcs["ai_3d_sighting_model"] = ::_id_159F;
    level.bot_funcs["dropped_weapon_think"] = ::_id_1716;
    level.bot_funcs["dropped_weapon_cancel"] = ::_id_8479;
    level.bot_funcs["crate_can_use"] = ::_id_2364;
    level.bot_funcs["crate_low_ammo_check"] = ::_id_236C;
    level.bot_funcs["crate_should_claim"] = ::_id_2371;
    level.bot_funcs["crate_wait_use"] = ::_id_2372;
    level.bot_funcs["crate_in_range"] = ::_id_2369;
    level.bot_funcs["post_teleport"] = ::_id_16BC;
    level._id_16C9 = [];
    level._id_16C9["allies"] = maps\mp\bots\_bots_personality::_id_16C8;
    level._id_16C9["axis"] = maps\mp\bots\_bots_personality::_id_16C8;
    level._id_15C9["deployable_vest"] = ::_id_16FE;
    level._id_15C9["deployable_ammo"] = ::_id_16FD;
    level._id_15C9["scavenger_bag"] = ::_id_1701;
    level._id_15C9["deployable_grenades"] = ::_id_16FF;
    level._id_15C9["deployable_juicebox"] = ::_id_1700;
    level._id_16C0["deployable_ammo"] = ::_id_16BF;
    level._id_16BE["deployable_ammo"] = ::_id_16BD;
    level._id_1611["capture"] = maps\mp\bots\_bots_strategy::_id_375D;
    level._id_1611["capture_zone"] = maps\mp\bots\_bots_strategy::_id_375E;
    level._id_1611["protect"] = maps\mp\bots\_bots_strategy::_id_3760;
    level._id_1611["bodyguard"] = maps\mp\bots\_bots_strategy::_id_375C;
    level._id_1611["patrol"] = maps\mp\bots\_bots_strategy::_id_375F;
    maps\mp\bots\_bots_gametype_war::_id_806C();
}

_id_00BA( var_0, var_1 )
{
    if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["leader_dialog"] ) )
        self [[ level.bot_funcs["leader_dialog"] ]]( var_0, var_1 );
}

init()
{
    thread _id_5E03();
    thread _id_171A();
    _id_4D90();

    if ( !_id_84A8() )
        return;

    _id_72BD();
    var_0 = botautoconnectenabled();

    if ( var_0 > 0 )
    {
        setmatchdata( "hasBots", 1 );
        level thread _id_15DF();
    }
    else
        level thread _id_16A5();
}

_id_4D90()
{
    if ( !isdefined( level._id_237E ) )
        level._id_237E = 500;

    if ( !isdefined( level._id_237A ) )
        level._id_237A = 3000;

    level._id_16AC = 3000;
    level._id_16CF["recruit"] = "iw5_maaws";
    level._id_16CF["regular"] = "iw5_stingerm7";
    level._id_16CF["hardened"] = "iw5_stingerm7";
    level._id_16CF["veteran"] = "iw5_stingerm7";
    level._id_160A = "iw5_combatknife";
    level._id_A3E6 = _func_201();
    _id_4D91();
}

_id_4D91()
{
    if ( isdefined( level._id_9255 ) )
        var_0 = [[ level._id_9255 ]]();
    else
        var_0 = getallnodes();

    level._id_169C = 0;
    level._id_1699 = 0;
    level._id_169D = 0;
    level._id_169A = 0;
    level._id_169E = 0;
    level._id_169B = 0;

    if ( var_0.size > 1 )
    {
        level._id_169C = var_0[0].origin[0];
        level._id_1699 = var_0[0].origin[0];
        level._id_169D = var_0[0].origin[1];
        level._id_169A = var_0[0].origin[1];
        level._id_169E = var_0[0].origin[2];
        level._id_169B = var_0[0].origin[2];

        for ( var_1 = 1; var_1 < var_0.size; var_1++ )
        {
            var_2 = var_0[var_1].origin;

            if ( var_2[0] < level._id_169C )
                level._id_169C = var_2[0];

            if ( var_2[0] > level._id_1699 )
                level._id_1699 = var_2[0];

            if ( var_2[1] < level._id_169D )
                level._id_169D = var_2[1];

            if ( var_2[1] > level._id_169A )
                level._id_169A = var_2[1];

            if ( var_2[2] < level._id_169E )
                level._id_169E = var_2[2];

            if ( var_2[2] > level._id_169B )
                level._id_169B = var_2[2];
        }
    }

    level._id_1698 = ( ( level._id_169C + level._id_1699 ) / 2, ( level._id_169D + level._id_169A ) / 2, ( level._id_169E + level._id_169B ) / 2 );
    level._id_1729 = 1;
}

_id_16BC()
{
    level._id_1729 = undefined;
    level._id_1656 = undefined;
    _id_4D91();
    maps\mp\bots\_bots_ks_remote_vehicle::_id_731F();
}

_id_84A8()
{
    return 1;
}

_id_72BD()
{
    wait 1;

    foreach ( var_1 in level.players )
    {
        if ( isbot( var_1 ) )
        {
            var_1._id_3342 = 1;
            var_1.bot_team = var_1.team;
            var_1._id_1703 = 1;
            var_1 thread [[ level.bot_funcs["think"] ]]();
        }
    }
}

_id_16BA()
{
    _id_16EC();
}

_id_16EC()
{
    if ( !isdefined( self._id_15D8 ) )
    {
        if ( !_id_1620() )
        {
            while ( !isdefined( level._id_1695 ) )
                wait 0.05;

            if ( isdefined( self._id_6610 ) )
                self._id_15D8 = [[ self._id_6610 ]]();
            else
                self._id_15D8 = maps\mp\bots\_bots_personality::_id_16F3();
        }
        else
            self._id_15D8 = self.class;
    }
}

_id_A1E8()
{
    for (;;)
    {
        level waittill( "connected", var_0 );

        if ( !isai( var_0 ) && level.players.size > 0 )
        {
            level._id_6D39 = common_scripts\utility::array_add( level._id_6D39, var_0 );
            childthread _id_174A( var_0 );
            childthread _id_1749( var_0 );
            childthread _id_174B( var_0 );
        }
    }
}

_id_174A( var_0 )
{
    var_0 endon( "bots_human_disconnected" );

    while ( !common_scripts\utility::array_contains( level.players, var_0 ) )
        wait 0.05;

    var_0 notify( "bots_human_spawned" );
}

_id_1749( var_0 )
{
    var_0 endon( "bots_human_spawned" );
    var_0 waittill( "disconnect" );
    var_0 notify( "bots_human_disconnected" );
}

_id_174B( var_0 )
{
    var_0 common_scripts\utility::waittill_any( "bots_human_spawned", "bots_human_disconnected" );
    level._id_6D39 = common_scripts\utility::array_remove( level._id_6D39, var_0 );
}

_id_5DD5()
{
    level._id_6D39 = [];
    childthread _id_A1E8();

    for (;;)
    {
        if ( level._id_6D39.size > 0 )
            level._id_6726 = 1;
        else
            level._id_6726 = 0;

        wait 0.5;
    }
}

_id_15C5( var_0 )
{
    if ( maps\mp\_utility::matchmakinggame() )
        return 1;

    if ( !level.teambased )
        return 1;

    if ( maps\mp\gametypes\_teams::getjointeampermissions( var_0 ) )
        return 1;

    return 0;
}

_id_15AA()
{
    if ( isdefined( level._id_1744 ) && level._id_1744 )
        return 0;

    if ( isdefined( level.matchrules_switchteamdisabled ) && level.matchrules_switchteamdisabled )
        return 0;

    return 1;
}

_id_15DF( var_0, var_1 )
{
    level endon( "game_ended" );
    self notify( "bot_connect_monitor" );
    self endon( "bot_connect_monitor" );
    level._id_6726 = 0;
    childthread _id_5DD5();
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 0.5 );
    var_2 = 1.5;

    if ( !isdefined( level._id_15DB ) )
        level._id_15DB = 0;

    if ( !isdefined( level._id_15DC ) )
        level._id_15DC = 0;

    if ( !isdefined( level._id_15DA ) )
        level._id_15DA = 0;

    for (;;)
    {
        if ( level._id_6726 )
        {
            maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_2 );
            continue;
        }

        var_3 = isdefined( level._id_1748 ) || !level.teambased;
        var_4 = _func_271( 0 );
        var_5 = _func_271( 1 );
        var_6 = spawnfxforclient( 0 );
        var_7 = spawnfxforclient( 1 );
        var_11 = "allies";
        var_12 = "axis";
        var_13 = _id_15D9();
        var_14 = _id_1BC7( var_13, "humans" );

        if ( var_14 > 1 )
        {
            var_15 = _id_1632();

            if ( !maps\mp\_utility::matchmakinggame() && isdefined( var_15 ) && var_15 != "spectator" )
            {
                var_11 = var_15;
                var_12 = maps\mp\_utility::getotherteam( var_15 );
            }
            else
            {
                var_16 = _id_1BC7( var_13, "humans_allies" );
                var_17 = _id_1BC7( var_13, "humans_axis" );

                if ( var_17 > var_16 )
                {
                    var_11 = "axis";
                    var_12 = "allies";
                }
            }
        }
        else
        {
            var_18 = _id_3DA1();

            if ( isdefined( var_18 ) )
            {
                var_19 = var_18 _id_163A();

                if ( isdefined( var_19 ) && var_19 != "spectator" )
                {
                    var_11 = var_19;
                    var_12 = maps\mp\_utility::getotherteam( var_19 );
                }
            }
        }

        var_20 = maps\mp\bots\_bots_util::_id_163D();
        var_21 = maps\mp\bots\_bots_util::_id_163D();
        var_22 = maps\mp\bots\_bots_util::_id_162C();

        if ( var_20 + var_21 < var_22 )
        {
            if ( var_20 < var_4 )
                var_20++;
            else if ( var_21 < var_5 )
                var_21++;
        }

        var_23 = _id_1BC7( var_13, "humans_" + var_11 );
        var_24 = _id_1BC7( var_13, "humans_" + var_12 );
        var_25 = var_23 + var_24;
        var_26 = _id_1BC7( var_13, "spectator" );
        var_27 = 0;

        for ( var_28 = 0; var_26 > 0; var_26-- )
        {
            var_29 = var_23 + var_27 + 1 <= var_20;
            var_30 = var_24 + var_28 + 1 <= var_21;

            if ( var_29 && !var_30 )
            {
                var_27++;
                continue;
            }

            if ( !var_29 && var_30 )
            {
                var_28++;
                continue;
            }

            if ( var_29 && var_30 )
            {
                if ( var_26 % 2 == 1 )
                {
                    var_27++;
                    continue;
                }

                var_28++;
            }
        }

        var_31 = _id_1BC7( var_13, "bots_" + var_11 );
        var_32 = _id_1BC7( var_13, "bots_" + var_12 );
        var_33 = var_31 + var_32;

        if ( var_33 > 0 )
            level._id_15DB = 1;

        var_34 = 0;

        if ( !level._id_15DA )
        {
            var_34 = !_id_1633();

            if ( !var_34 )
                level._id_15DA = 1;
        }

        if ( var_34 )
        {
            var_35 = 0;
            var_36 = !var_3 && var_5 != var_4 && !level._id_15DB && ( level._id_15DC < 10 || !maps\mp\_utility::gameflag( "prematch_done" ) );
            var_37 = 0;

            if ( var_35 || var_36 || var_37 )
            {
                level._id_15DC += var_2;
                maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_2 );
                continue;
            }
        }

        var_38 = int( min( var_20 - var_23 - var_27, var_4 ) );
        var_39 = int( min( var_21 - var_24 - var_28, var_5 ) );
        var_40 = 1;
        var_41 = var_38 + var_39 + var_14;
        var_42 = var_4 + var_5 + var_14;

        for ( var_43 = [ -1, -1 ]; var_41 < var_22 && var_41 < var_42; var_40 = !var_40 )
        {
            if ( var_40 && var_38 < var_4 && _id_15C5( var_11 ) )
                var_38++;
            else if ( !var_40 && var_39 < var_5 && _id_15C5( var_12 ) )
                var_39++;

            var_41 = var_38 + var_39 + var_14;

            if ( var_43[var_40] == var_41 )
                break;

            var_43[var_40] = var_41;
        }

        level._id_169F[var_11] = int( var_38 + var_23 + var_27 );
        level._id_169F[var_12] = int( var_39 + var_24 + var_28 );
        _id_9ABE();

        if ( var_4 == var_5 && !var_3 && var_27 == 1 && var_28 == 0 && var_39 > 0 )
        {
            if ( !isdefined( level._id_16C1 ) && maps\mp\_utility::gameflag( "prematch_done" ) )
                level._id_16C1 = gettime();

            if ( var_34 && ( !isdefined( level._id_16C1 ) || gettime() - level._id_16C1 < 10000 ) )
                var_39--;
        }

        var_45 = var_38 - var_31;
        var_46 = var_39 - var_32;
        var_47 = 1;

        if ( var_3 )
        {
            var_48 = var_20 + var_21;
            var_49 = var_4 + var_5;
            var_50 = var_23 + var_24;
            var_51 = var_31 + var_32;
            var_52 = int( min( var_48 - var_50, var_49 ) );
            var_53 = var_52 - var_51;

            if ( var_53 == 0 )
                var_47 = 0;
            else if ( var_53 > 0 )
            {
                var_45 = int( var_53 / 2 ) + var_53 % 2;
                var_46 = int( var_53 / 2 );
            }
            else if ( var_53 < 0 )
            {
                var_54 = var_53 * -1;
                var_45 = -1 * int( min( var_54, var_31 ) );
                var_46 = -1 * ( var_54 + var_45 );
            }
        }
        else if ( !maps\mp\_utility::matchmakinggame() && ( var_45 * var_46 < 0 && maps\mp\_utility::gameflag( "prematch_done" ) && _id_15AA() ) )
        {
            var_55 = int( min( abs( var_45 ), abs( var_46 ) ) );

            if ( var_45 > 0 )
                _id_5F00( var_55, var_12, var_11, var_6 );
            else if ( var_46 > 0 )
                _id_5F00( var_55, var_11, var_12, var_7 );

            var_47 = 0;
        }

        if ( var_47 )
        {
            if ( var_46 < 0 )
                _id_2F3D( var_46 * -1, var_12 );

            if ( var_45 < 0 )
                _id_2F3D( var_45 * -1, var_11 );

            if ( var_46 > 0 )
                level thread _id_88D2( var_46, var_12, undefined, undefined, "spawned_enemies", var_7 );

            if ( var_45 > 0 )
                level thread _id_88D2( var_45, var_11, undefined, undefined, "spawned_allies", var_6 );

            if ( var_46 > 0 && var_45 > 0 )
                level common_scripts\utility::waittill_multiple( "spawned_enemies", "spawned_allies" );
            else if ( var_46 > 0 )
                level waittill( "spawned_enemies" );
            else if ( var_45 > 0 )
                level waittill( "spawned_allies" );
        }

        if ( var_7 != var_6 )
        {
            _id_174C( var_12, var_7 );
            _id_174C( var_11, var_6 );
        }

        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_2 );
    }
}

_id_16A5()
{
    level endon( "game_ended" );
    self notify( "bot_monitor_team_limits" );
    self endon( "bot_monitor_team_limits" );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 0.5 );
    var_0 = 1.5;

    for (;;)
    {
        level._id_169F["allies"] = 0;
        level._id_169F["axis"] = 0;

        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2.team ) && ( var_2.team == "allies" || var_2.team == "axis" ) )
                level._id_169F[var_2.team]++;
        }

        _id_9ABE();
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
    }
}

_id_9ABE()
{
    if ( isdefined( level.agentarray ) )
    {
        foreach ( var_1 in level.agentarray )
        {
            if ( isdefined( var_1.isactive ) && var_1.isactive )
            {
                if ( maps\mp\_utility::isteamparticipant( var_1 ) && isdefined( var_1.team ) && ( var_1.team == "allies" || var_1.team == "axis" ) )
                    level._id_169F[var_1.team]++;
            }
        }
    }
}

_id_163A()
{
    if ( isdefined( self.team ) )
        return self.team;

    if ( isdefined( self.pers["team"] ) )
        return self.pers["team"];

    return undefined;
}

_id_1632()
{
    foreach ( var_1 in level.players )
    {
        if ( !isai( var_1 ) && var_1 ishost() )
            return var_1 _id_163A();
    }

    return "spectator";
}

_id_1633()
{
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;

    foreach ( var_4 in level.players )
    {
        if ( !isai( var_4 ) )
        {
            if ( var_4 ishost() )
                var_0 = 1;

            if ( _id_6BB5( var_4 ) )
            {
                var_1 = 1;

                if ( var_4 ishost() )
                    var_2 = 1;
            }
        }
    }

    return var_2 || var_1 && !var_0;
}

_id_6BB5( var_0 )
{
    if ( isdefined( var_0.team ) && var_0.team != "spectator" )
        return 1;

    if ( isdefined( var_0.spectating_actively ) && var_0.spectating_actively )
        return 1;

    if ( var_0 ismlgspectator() )
        return 1;

    return 0;
}

_id_15D9()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < level.players.size; var_1++ )
    {
        var_2 = level.players[var_1];

        if ( isdefined( var_2 ) && isdefined( var_2.team ) )
        {
            var_0 = _id_1BC6( var_0, "all" );
            var_0 = _id_1BC6( var_0, var_2.team );

            if ( isbot( var_2 ) )
            {
                var_0 = _id_1BC6( var_0, "bots" );
                var_0 = _id_1BC6( var_0, "bots_" + var_2.team );
                continue;
            }

            var_0 = _id_1BC6( var_0, "humans" );
            var_0 = _id_1BC6( var_0, "humans_" + var_2.team );
        }
    }

    return var_0;
}

_id_1BC6( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = [];

    if ( !isdefined( var_0[var_1] ) )
        var_0[var_1] = 0;

    var_0[var_1] += 1;
    return var_0;
}

_id_1BC7( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !isdefined( var_0[var_1] ) )
        return 0;

    return var_0[var_1];
}

_id_5F00( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in level.players )
    {
        if ( !isdefined( var_5.team ) )
            continue;

        if ( isdefined( var_5.connected ) && var_5.connected && isbot( var_5 ) && var_5.team == var_1 )
        {
            var_5.bot_team = var_2;

            if ( isdefined( var_3 ) )
                var_5 maps\mp\bots\_bots_util::_id_16EB( var_3 );

            var_5 notify( "luinotifyserver", "team_select", _id_1696( var_2 ) );
            wait 0.05;
            var_5 notify( "luinotifyserver", "class_select", var_5._id_15D8 );
            var_0--;

            if ( var_0 <= 0 )
                break;
            else
                wait 0.1;
        }
    }
}

_id_174C( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( !isdefined( var_3.team ) )
            continue;

        if ( isdefined( var_3.connected ) && var_3.connected && isbot( var_3 ) && var_3.team == var_0 )
        {
            if ( var_1 != var_3 _meth_836B() )
                var_3 maps\mp\bots\_bots_util::_id_16EB( var_1 );
        }
    }
}

_id_1603()
{
    kick( self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE" );
    wait 0.1;
}

_id_2F3D( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in level.players )
    {
        if ( isdefined( var_4.connected ) && var_4.connected && isbot( var_4 ) && ( !isdefined( var_1 ) || isdefined( var_4.team ) && var_4.team == var_1 ) )
            var_2[var_2.size] = var_4;
    }

    for ( var_6 = var_2.size - 1; var_6 >= 0; var_6-- )
    {
        if ( var_0 <= 0 )
            break;

        if ( !maps\mp\_utility::isreallyalive( var_2[var_6] ) )
        {
            var_2[var_6] _id_1603();
            var_2 = common_scripts\utility::array_remove( var_2, var_2[var_6] );
            var_0--;
        }
    }

    for ( var_6 = var_2.size - 1; var_6 >= 0; var_6-- )
    {
        if ( var_0 <= 0 )
            break;

        var_2[var_6] _id_1603();
        var_0--;
    }
}

_id_1696( var_0 )
{
    if ( var_0 == "axis" )
        return 0;
    else if ( var_0 == "allies" )
        return 1;
    else if ( var_0 == "autoassign" || var_0 == "random" )
        return 2;
    else
        return 3;
}

_id_88D1( var_0, var_1, var_2 )
{
    var_3 = gettime() + 60000;

    while ( !self _meth_841A() )
    {
        if ( gettime() >= var_3 )
        {
            kick( self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE" );
            var_2._id_06BA = 1;
            return;
        }

        wait 0.05;

        if ( !isdefined( self ) )
        {
            var_2._id_06BA = 1;
            return;
        }
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( randomfloatrange( 0.25, 2.0 ) );

    if ( !isdefined( self ) )
    {
        var_2._id_06BA = 1;
        return;
    }

    self _meth_841B();
    self._id_3342 = 1;
    self.bot_team = var_0;

    if ( isdefined( var_2._id_2A5E ) )
        maps\mp\bots\_bots_util::_id_16EB( var_2._id_2A5E );

    if ( isdefined( var_1 ) )
        self [[ var_1 ]]();

    self thread [[ level.bot_funcs["think"] ]]();
    var_2._id_71D1 = 1;
}

_id_88D2( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = gettime() + 10000;
    var_7 = [];
    var_8 = var_7.size;

    while ( level.players.size < maps\mp\bots\_bots_util::_id_162C() && var_7.size < var_0 && gettime() < var_6 )
    {
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 0.05 );
        var_9 = _func_281( "", 0, 0, 0 );

        if ( !isdefined( var_9 ) )
        {
            if ( isdefined( var_3 ) && var_3 )
            {
                if ( isdefined( var_4 ) )
                    self notify( var_4 );

                return;
            }

            maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 1 );
            continue;
        }
        else
        {
            var_10 = spawnstruct();
            var_10._id_159E = var_9;
            var_10._id_71D1 = 0;
            var_10._id_06BA = 0;
            var_10.index = var_8;
            var_10._id_2A5E = var_5;
            var_7[var_7.size] = var_10;
            var_10._id_159E thread _id_88D1( var_1, var_2, var_10 );
            var_8++;
        }
    }

    var_11 = 0;
    var_6 = gettime() + 60000;

    while ( var_11 < var_7.size && gettime() < var_6 )
    {
        var_11 = 0;

        foreach ( var_10 in var_7 )
        {
            if ( var_10._id_71D1 || var_10._id_06BA )
                var_11++;
        }

        wait 0.05;
    }

    if ( isdefined( var_4 ) )
        self notify( var_4 );
}

_id_1621()
{
    var_0 = 0;

    if ( !level.teambased )
        var_0 = 1;

    if ( isdefined( level._id_1747 ) && level._id_1747 )
        var_0 = 1;

    return var_0;
}

_id_1620()
{
    return isdefined( level._id_1746 ) && level._id_1746;
}

_id_170F()
{
    self notify( "bot_think" );
    self endon( "bot_think" );
    self endon( "disconnect" );

    while ( !isdefined( self.pers["team"] ) )
        wait 0.05;

    level._id_471F = 1;

    if ( _id_1621() )
        self.bot_team = self.pers["team"];

    var_0 = self.bot_team;

    if ( !isdefined( var_0 ) )
        var_0 = self.pers["team"];

    self.entity_number = self getentitynumber();
    var_1 = 0;

    if ( !isdefined( self._id_1703 ) )
    {
        var_1 = 1;
        self._id_1703 = 1;

        if ( !_id_1621() )
        {
            var_2 = self.pers["team"] != "spectator" && !isdefined( self.bot_team );

            if ( !var_2 )
            {
                self notify( "luinotifyserver", "team_select", _id_1696( var_0 ) );
                wait 0.5;

                if ( self.pers["team"] == "spectator" )
                {
                    _id_1603();
                    return;
                }
            }
        }
    }

    for (;;)
    {
        maps\mp\bots\_bots_util::_id_16EB( self _meth_836B() );
        var_3 = self _meth_837B( "advancedPersonality" );

        if ( var_1 && isdefined( var_3 ) && var_3 != 0 )
            maps\mp\bots\_bots_personality::_id_15B0();

        maps\mp\bots\_bots_personality::_id_15AD();

        if ( var_1 )
        {
            _id_16EC();

            if ( !_id_1620() )
                self notify( "luinotifyserver", "class_select", self._id_15D8 );

            if ( self.health == 0 )
                self waittill( "spawned_player" );

            if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["know_enemies_on_start"] ) )
                self thread [[ level.bot_funcs["know_enemies_on_start"] ]]();

            var_1 = 0;
        }

        _id_16D0();
        wait 0.1;
        self waittill( "death" );
        _id_7473();
        self waittill( "spawned_player" );
    }
}

_id_7473()
{
    self endon( "started_spawnPlayer" );

    while ( !self.waitingtospawn )
        wait 0.05;

    if ( maps\mp\gametypes\_playerlogic::needsbuttontorespawn() )
    {
        while ( self.waitingtospawn )
        {
            if ( self.sessionstate == "spectator" )
            {
                if ( getdvarint( "numlives" ) == 0 || self.pers["lives"] > 0 )
                    self _meth_837E( "use", 0.5 );
            }

            wait 1.0;
        }
    }
}

_id_1667()
{
    return self _meth_837D();
}

_id_163B()
{
    var_0 = spawnstruct();

    if ( !_id_1667() )
    {
        if ( !isdefined( self.pers["rankxp"] ) )
            self.pers["rankxp"] = 0;

        if ( !isdefined( self.pers["prestige"] ) )
            self.pers["prestige"] = 0;

        var_0.rankxp = self.pers["rankxp"];
        var_0.prestige = self.pers["prestige"];
        return var_0;
    }

    var_1 = self _meth_836B();
    var_2 = "bot_rank_" + var_1;
    var_3 = "bot_prestige_" + var_1;
    var_4 = self.pers[var_2];
    var_5 = self.pers[var_3];
    var_6 = undefined;

    if ( isdefined( var_4 ) )
        var_0.rankxp = var_4;
    else
    {
        if ( !isdefined( var_6 ) )
            var_6 = _id_16CA( var_1 );

        var_7 = var_6["rank"];
        var_8 = maps\mp\gametypes\_rank::getrankinfominxp( var_7 );
        var_9 = maps\mp\gametypes\_rank::getrankinfomaxxp( var_7 );
        var_10 = randomintrange( var_8, var_9 );
        self.pers[var_2] = var_10;
        var_0.rankxp = var_10;
    }

    if ( isdefined( var_5 ) )
        var_0.prestige = var_5;
    else
    {
        if ( !isdefined( var_6 ) )
            var_6 = _id_16CA( var_1 );

        var_11 = var_6["prestige"];
        self.pers[var_3] = var_11;
        var_0.prestige = var_11;
    }

    return var_0;
}

_id_159F( var_0 )
{
    thread _id_15A0( var_0 );
}

_id_15A0( var_0 )
{
    var_0 endon( "disconnect" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( isalive( self ) && !self _meth_836F( var_0 ) && common_scripts\utility::within_fov( self.origin, self.angles, var_0.origin, self _meth_8373() ) )
            self _meth_8377( var_0, var_0.origin );

        wait 0.1;
    }
}

_id_16CA( var_0 )
{
    var_1 = [];
    var_1["rank"] = 0;
    var_1["prestige"] = 0;

    if ( var_0 == "default" )
        return var_1;

    if ( !isdefined( level._id_16D3 ) )
    {
        level._id_16D3 = [];
        level._id_16D3["recruit"][0] = 0;
        level._id_16D3["recruit"][1] = 1;
        level._id_16D3["regular"][0] = 16;
        level._id_16D3["regular"][1] = 24;
        level._id_16D3["hardened"][0] = 36;
        level._id_16D3["hardened"][1] = 44;
        level._id_16D3["veteran"][0] = 46;
        level._id_16D3["veteran"][1] = 49;
    }

    if ( !isdefined( level._id_16D2 ) )
    {
        level._id_16D2 = [];
        level._id_16D2["recruit"][0] = 0;
        level._id_16D2["recruit"][1] = 0;
        level._id_16D2["regular"][0] = 0;
        level._id_16D2["regular"][1] = 0;
        level._id_16D2["hardened"][0] = 0;
        level._id_16D2["hardened"][1] = 0;
        level._id_16D2["veteran"][0] = 0;
        level._id_16D2["veteran"][1] = 9;
    }

    var_1["rank"] = randomintrange( level._id_16D3[var_0][0], level._id_16D3[var_0][1] + 1 );
    var_1["prestige"] = randomintrange( level._id_16D2[var_0][0], level._id_16D2[var_0][1] + 1 );
    return var_1;
}

_id_2364( var_0 )
{
    if ( isagent( self ) && !isdefined( var_0._id_175D ) )
        return 0;

    return 1;
}

_id_3DA1()
{
    var_0 = undefined;
    var_1 = getentarray( "player", "classname" );

    if ( isdefined( var_1 ) )
    {
        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            if ( isdefined( var_1[var_2] ) && isdefined( var_1[var_2].connected ) && var_1[var_2].connected && !isai( var_1[var_2] ) && ( !isdefined( var_0 ) || var_0.team == "spectator" ) )
                var_0 = var_1[var_2];
        }
    }

    return var_0;
}

_id_15E9( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( self ) || !isalive( self ) )
        return;

    if ( var_2 == "MOD_FALLING" || var_2 == "MOD_SUICIDE" )
        return;

    if ( var_1 <= 0 )
        return;

    if ( !isdefined( var_4 ) )
    {
        if ( !isdefined( var_0 ) )
            return;

        var_4 = var_0;
    }

    if ( isdefined( var_4 ) )
    {
        if ( level.teambased )
        {
            if ( isdefined( var_4.team ) && var_4.team == self.team )
                return;
            else if ( isdefined( var_0 ) && isdefined( var_0.team ) && var_0.team == self.team )
                return;
        }

        var_6 = maps\mp\bots\_bots_util::_id_1634( var_0, var_4 );

        if ( isdefined( var_6 ) )
            self _meth_8359( var_6 );
    }
}

_id_643D( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self _meth_8358();
    self _meth_8356();
    var_10 = maps\mp\bots\_bots_util::_id_1634( var_1, var_0 );

    if ( isdefined( var_10 ) && var_10.classname == "misc_turret" && isdefined( var_10.chopper ) )
        var_10 = var_10.chopper;

    if ( isdefined( var_10 ) && ( var_10.classname == "script_vehicle" || var_10.classname == "script_model" ) && isdefined( var_10.helitype ) )
    {
        var_11 = self _meth_837B( "launcherRespawnChance" );

        if ( randomfloat( 1.0 ) < var_11 )
            self._id_7474 = 1;
    }
}

_id_16F9()
{
    var_0 = 0.0;
    var_1 = self _meth_836B();

    if ( var_1 == "recruit" )
        var_0 = 0.1;
    else if ( var_1 == "regular" )
        var_0 = 0.4;
    else if ( var_1 == "hardened" )
        var_0 = 0.7;
    else if ( var_1 == "veteran" )
        var_0 = 1.0;

    return randomfloat( 1.0 ) < 1.0 - var_0;
}

_id_16FB()
{
    if ( maps\mp\_utility::isjuggernaut() )
        return 0;

    return 1;
}

_id_16D0()
{
    thread _id_1719();
    thread maps\mp\bots\_bots_strategy::_id_1717();
    self thread [[ level.bot_funcs["dropped_weapon_think"] ]]();
    thread _id_1714();
    thread _id_1710();
    thread _id_1711();
    thread maps\mp\bots\_bots_ks::_id_1713();
    thread maps\mp\bots\_bots_ks::_id_1718();
    thread _id_1712();
}

_id_1719( var_0 )
{
    var_1 = "spawned_player";

    if ( isdefined( var_0 ) && var_0 )
        var_1 = "death";

    self notify( "bot_think_watch_enemy" );
    self endon( "bot_think_watch_enemy" );
    self endon( var_1 );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._id_5520 = gettime();

    for (;;)
    {
        if ( isdefined( self._id_0143 ) )
        {
            if ( self _meth_836F( self._id_0143 ) )
                self._id_5520 = gettime();
        }

        wait 0.05;
    }
}

_id_1716()
{
    self notify( "bot_think_seek_dropped_weapons" );
    self endon( "bot_think_seek_dropped_weapons" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = 0;

        if ( maps\mp\bots\_bots_util::_id_16AB() && self [[ level.bot_funcs["should_pickup_weapons"] ]]() && !maps\mp\bots\_bots_util::_id_1664() )
        {
            var_1 = getentarray( "dropped_weapon", "targetname" );
            var_2 = common_scripts\utility::get_array_of_closest( self.origin, var_1 );

            if ( var_2.size > 0 )
            {
                var_3 = var_2[0];
                _id_16D9( var_3 );
            }
        }

        wait(randomfloatrange( 0.25, 0.75 ));
    }
}

_id_16D9( var_0 )
{
    if ( maps\mp\bots\_bots_strategy::_id_1649( "seek_dropped_weapon", var_0 ) == 0 )
    {
        var_1 = undefined;

        if ( var_0.targetname == "dropped_weapon" )
        {
            var_2 = 1;
            var_3 = self getweaponslistprimaries();

            foreach ( var_5 in var_3 )
            {
                if ( var_0.model == getweaponmodel( var_5 ) )
                    var_2 = 0;
            }

            if ( var_2 )
                var_1 = ::_id_16B9;
        }

        var_7 = spawnstruct();
        var_7._id_62DE = var_0;
        var_7._id_79F9 = 12;
        var_7._id_8447 = level.bot_funcs["dropped_weapon_cancel"];
        var_7._id_06ED = var_1;
        maps\mp\bots\_bots_strategy::_id_16A9( "seek_dropped_weapon", var_0.origin, 100, var_7 );
    }
}

_id_16B9( var_0 )
{
    self _meth_837E( "use", 2 );
    wait 2;
}

_id_8479( var_0 )
{
    if ( !isdefined( var_0._id_62DE ) )
        return 1;

    if ( var_0._id_62DE.targetname == "dropped_weapon" )
    {
        if ( maps\mp\bots\_bots_util::_id_1641() > 0 )
            return 1;
    }
    else if ( var_0._id_62DE.targetname == "dropped_knife" )
    {
        if ( maps\mp\bots\_bots_util::_id_1650() )
        {
            self._id_4257 = undefined;
            return 1;
        }
    }

    return 0;
}

_id_1714( var_0 )
{
    self notify( "bot_think_level_actions" );
    self endon( "bot_think_level_actions" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        common_scripts\utility::waittill_notify_or_timeout( "calculate_new_level_targets", randomfloatrange( 2, 10 ) );

        if ( !isdefined( level._id_56CE ) || level._id_56CE.size == 0 )
            continue;

        if ( maps\mp\bots\_bots_strategy::_id_1649( "map_interactive_object" ) )
            continue;

        if ( maps\mp\bots\_bots_util::_id_1650() || maps\mp\bots\_bots_util::_id_1664() )
            continue;

        var_1 = undefined;

        foreach ( var_3 in level._id_56CE )
        {
            if ( common_scripts\utility::array_contains( var_3.high_priority_for, self ) )
            {
                var_1 = var_3;
                break;
            }
        }

        if ( !isdefined( var_1 ) )
        {
            if ( randomint( 100 ) > 25 )
                continue;

            var_5 = common_scripts\utility::get_array_of_closest( self.origin, level._id_56CE );
            var_6 = 256;

            if ( isdefined( var_0 ) )
                var_6 = var_0;
            else if ( self _meth_835D() == "hunt" && self _meth_8375() )
                var_6 = 512;

            if ( distancesquared( self.origin, var_5[0].origin ) > var_6 * var_6 )
                continue;

            var_1 = var_5[0];
        }

        var_7 = 0;

        if ( var_1.bot_interaction_type == "damage" )
        {
            var_7 = _id_16FA( var_1 );

            if ( var_7 )
            {
                var_8 = var_1.origin[2] - var_1._id_170D[0].origin[2] + 55;
                var_9 = var_1.origin[2] - var_1._id_170D[1].origin[2] + 55;

                if ( var_8 > 55 && var_9 > 55 )
                {
                    if ( common_scripts\utility::array_contains( var_1.high_priority_for, self ) )
                        var_1.high_priority_for = common_scripts\utility::array_remove( var_1.high_priority_for, self );

                    continue;
                }
            }

            var_10 = weaponclass( self getcurrentweapon() );

            if ( var_10 == "spread" )
            {
                var_11 = var_1._id_170D[0].origin - var_1.origin;
                var_12 = var_1._id_170D[1].origin - var_1.origin;
                var_13 = lengthsquared( var_11 );
                var_14 = lengthsquared( var_12 );

                if ( var_13 > 22500 && var_14 > 22500 )
                {
                    if ( common_scripts\utility::array_contains( var_1.high_priority_for, self ) )
                        var_1.high_priority_for = common_scripts\utility::array_remove( var_1.high_priority_for, self );

                    continue;
                }
            }
        }

        var_15 = spawnstruct();
        var_15._id_62DE = var_1;

        if ( var_1.bot_interaction_type == "damage" )
        {
            if ( var_7 )
                var_15._id_8447 = ::_id_56D4;
            else
                var_15._id_8447 = ::_id_56D5;
        }

        if ( var_1.bot_interaction_type == "use" )
        {
            var_15._id_06ED = ::_id_9BE7;
            var_15._id_8447 = ::_id_56D3;
            var_15._id_79FB = vectortoangles( var_1.origin - var_1._id_170B.origin )[1];
            maps\mp\bots\_bots_strategy::_id_16A9( "map_interactive_object", var_1._id_170B.origin, 10, var_15 );
            continue;
        }

        if ( var_1.bot_interaction_type == "damage" )
        {
            if ( var_7 )
            {
                var_15._id_06ED = ::_id_5B49;
                var_15._id_79F9 = 20;
            }
            else
            {
                var_15._id_06ED = ::_id_0E10;
                var_15._id_79F9 = 50;
            }

            var_16 = undefined;
            var_17 = maps\mp\bots\_bots_util::_id_16C3( "GetPathDistLevelAction", maps\mp\bots\_bots_util::_id_3AE8, self.origin, var_1._id_170D[0].origin );
            var_18 = maps\mp\bots\_bots_util::_id_16C3( "GetPathDistLevelAction", maps\mp\bots\_bots_util::_id_3AE8, self.origin, var_1._id_170D[1].origin );

            if ( !isdefined( var_1 ) )
                continue;

            if ( var_17 <= 0 && var_18 <= 0 )
                continue;

            if ( var_17 > 0 )
            {
                if ( var_18 < 0 || var_17 <= var_18 )
                    var_16 = var_1._id_170D[0];
            }

            if ( var_18 > 0 )
            {
                if ( var_17 < 0 || var_18 <= var_17 )
                    var_16 = var_1._id_170D[1];
            }

            if ( !var_7 )
                childthread _id_5DCB( var_16 );

            maps\mp\bots\_bots_strategy::_id_16A9( "map_interactive_object", var_16.origin, 10, var_15 );
        }
    }
}

_id_16FA( var_0 )
{
    var_1 = self getcurrentweapon();
    var_2 = maps\mp\bots\_bots_util::_id_16AB() || maps\mp\_riotshield::hasriotshieldequipped() || isdefined( self.isjuggernautmaniac ) && self.isjuggernautmaniac == 1 || weaponclass( var_1 ) == "grenade" || var_1 == "iw5_combatknife_mp";
    return var_2;
}

_id_5DCB( var_0 )
{
    self endon( "goal" );
    wait 0.1;

    for (;;)
    {
        if ( weaponclass( self getcurrentweapon() ) == "spread" )
        {
            if ( distancesquared( self.origin, var_0.origin ) > 90000 )
            {
                wait 0.05;
                continue;
            }
        }

        var_1 = self _meth_8387();

        if ( isdefined( var_1 ) )
        {
            if ( getnodesintrigger( var_1, var_0, 1 ) )
            {
                if ( sighttracepassed( self.origin + ( 0.0, 0.0, 55.0 ), var_0.origin + ( 0.0, 0.0, 55.0 ), 0, self ) )
                    self notify( "goal" );
            }
        }

        wait 0.05;
    }
}

_id_0E10( var_0 )
{
    if ( var_0._id_62DE.origin[2] - self geteye()[2] > 55 )
    {
        if ( _func_220( var_0._id_62DE.origin, self.origin ) < 225 )
            return;
    }

    self _meth_8351( "disable_movement", 1 );
    _id_584E( var_0._id_62DE, 0.3 );
    self _meth_837E( "ads", 0.3 );
    wait 0.25;
    var_1 = gettime();

    while ( isdefined( var_0._id_62DE ) && !isdefined( var_0._id_62DE._id_0AFF ) && gettime() - var_1 < 5000 )
    {
        _id_584E( var_0._id_62DE, 0.15 );
        self _meth_837E( "ads", 0.15 );
        self _meth_837E( "attack" );
        wait 0.1;
    }

    self _meth_8351( "disable_movement", 0 );
}

_id_5B49( var_0 )
{
    self _meth_8351( "disable_movement", 1 );
    _id_584E( var_0._id_62DE, 0.3 );
    wait 0.25;
    var_1 = gettime();

    while ( isdefined( var_0._id_62DE ) && !isdefined( var_0._id_62DE._id_0AFF ) && gettime() - var_1 < 5000 )
    {
        _id_584E( var_0._id_62DE, 0.15 );
        self _meth_837E( "melee" );
        wait 0.1;
    }

    self _meth_8351( "disable_movement", 0 );
}

_id_584E( var_0, var_1 )
{
    var_2 = var_0.origin;

    if ( _func_220( self.origin, var_2 ) < 100 )
        var_2 = ( var_2[0], var_2[1], self geteye()[2] );

    self _meth_836D( var_2, var_1, "script_forced" );
}

_id_9BE7( var_0 )
{
    if ( isagent( self ) )
    {
        common_scripts\utility::_enableusability();
        var_0._id_62DE enableplayeruse( self );
        wait 0.05;
    }

    var_1 = var_0._id_62DE.use_time;
    self _meth_837E( "use", var_1 );
    wait(var_1);

    if ( isagent( self ) )
    {
        common_scripts\utility::_disableusability();

        if ( isdefined( var_0._id_62DE ) )
            var_0._id_62DE disableplayeruse( self );
    }
}

_id_56D4( var_0 )
{
    if ( _id_56D3( var_0 ) )
        return 1;

    if ( !_id_16FA( var_0._id_62DE ) )
        return 1;

    return 0;
}

_id_56D5( var_0 )
{
    if ( _id_56D3( var_0 ) )
        return 1;

    if ( _id_16FA( var_0._id_62DE ) )
        return 1;

    return 0;
}

_id_56D3( var_0 )
{
    if ( !isdefined( var_0._id_62DE ) )
        return 1;

    if ( isdefined( var_0._id_62DE._id_0AFF ) )
        return 1;

    if ( maps\mp\bots\_bots_util::_id_1650() )
        return 1;

    return 0;
}

_id_2369( var_0 )
{
    if ( !isdefined( var_0.owner ) || var_0.owner != self )
    {
        if ( distancesquared( self.origin, var_0.origin ) > 4194304 )
            return 0;
    }

    return 1;
}

_id_15E3( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( maps\mp\_utility::isjuggernaut() && maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod( var_0 ) )
        return 0;

    if ( !self [[ level.bot_funcs["crate_can_use"] ]]( var_0 ) )
        return 0;

    if ( !_id_236B( var_0 ) )
        return 0;

    if ( level.teambased && isdefined( var_0._id_1529 ) && isdefined( var_0.team ) && var_0.team == self.team )
        return 0;

    if ( !self [[ level.bot_funcs["crate_in_range"] ]]( var_0 ) )
        return 0;

    if ( isdefined( var_0._id_175D ) )
    {
        if ( isdefined( level._id_175A ) && isdefined( level._id_175A[var_0._id_175D] ) && ![[ level._id_175A[var_0._id_175D]._id_1AF9 ]]() )
            return 0;

        if ( isdefined( var_0._id_2AFE ) && isdefined( var_0._id_2AFE[self getentitynumber()] ) && var_0._id_2AFE[self getentitynumber()] )
            return 0;

        if ( !self [[ level._id_15C9[var_0._id_175D] ]]( var_0 ) )
            return 0;
    }

    return isdefined( var_0 );
}

_id_236B( var_0 )
{
    if ( !_id_2368( var_0 ) )
        return 0;

    if ( !_id_236A( var_0 ) )
        return 0;

    return isdefined( var_0 );
}

_id_2368( var_0 )
{
    if ( isdefined( var_0._id_175D ) )
        return gettime() > var_0.birthtime + 1000;
    else
        return isdefined( var_0._id_2F75 ) && !var_0._id_2F75;
}

_id_236A( var_0 )
{
    if ( !isdefined( var_0.on_path_grid ) )
        _id_2362( var_0 );

    return isdefined( var_0 ) && var_0.on_path_grid;
}

_id_6129( var_0, var_1 )
{
    if ( isdefined( var_1._id_175D ) && var_1._id_175D == "scavenger_bag" )
        return abs( var_0.origin[0] - var_1.origin[0] ) < 36 && abs( var_0.origin[0] - var_1.origin[0] ) < 36 && abs( var_0.origin[0] - var_1.origin[0] ) < 18;
    else
    {
        var_2 = getdvarfloat( "player_useRadius" );
        var_3 = distancesquared( var_1.origin, var_0.origin + ( 0.0, 0.0, 40.0 ) );
        return var_3 <= var_2 * var_2;
    }
}

_id_2362( var_0 )
{
    var_0 thread _id_236D();
    var_0.on_path_grid = 0;
    var_1 = undefined;
    var_2 = undefined;

    if ( isdefined( var_0.forcedisconnectuntil ) )
    {
        var_1 = var_0.forcedisconnectuntil;
        var_2 = gettime() + 30000;
        var_0.forcedisconnectuntil = var_2;
        var_0 notify( "path_disconnect" );
    }

    wait 0.05;

    if ( !isdefined( var_0 ) )
        return;

    var_3 = [];

    if ( !maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod( var_0 ) )
        var_3 = _id_2367( var_0 );

    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_3 ) && var_3.size > 0 )
    {
        var_0._id_6070 = var_3;
        var_0.on_path_grid = 1;
    }
    else
    {
        var_4 = getdvarfloat( "player_useRadius" );
        var_5 = getnodesinradiussorted( var_0.origin, var_4 * 2, 0 )[0];
        var_6 = var_0 getpointinbounds( 0, 0, -1 );
        var_7 = undefined;

        if ( isdefined( var_0._id_175D ) && var_0._id_175D == "scavenger_bag" )
        {
            if ( maps\mp\bots\_bots_util::_id_16BB( var_0.origin ) )
                var_7 = var_0.origin;
        }
        else
            var_7 = _func_1FD( var_0.origin, var_4 );

        if ( isdefined( var_5 ) && !var_5 _meth_8386() && isdefined( var_7 ) && abs( var_5.origin[2] - var_6[2] ) < 30 )
        {
            var_0._id_6071 = [ var_7 ];
            var_0._id_6070 = [ var_5 ];
            var_0.on_path_grid = 1;
        }
    }

    if ( isdefined( var_0.forcedisconnectuntil ) )
    {
        if ( var_0.forcedisconnectuntil == var_2 )
            var_0.forcedisconnectuntil = var_1;
    }
}

_id_2367( var_0 )
{
    var_1 = getnodesinradiussorted( var_0.origin, 256, 0 );

    for ( var_2 = var_1.size; var_2 > 0; var_2-- )
        var_1[var_2] = var_1[var_2 - 1];

    var_1[0] = getclosestnodeinsight( var_0.origin );
    var_3 = undefined;

    if ( isdefined( var_0.forcedisconnectuntil ) )
        var_3 = getallnodes();

    var_4 = [];
    var_5 = 1;

    if ( !isdefined( var_0._id_175D ) )
        var_5 = 2;

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_6 = var_1[var_2];

        if ( !isdefined( var_6 ) || !isdefined( var_0 ) )
            continue;

        if ( var_6 _meth_8386() )
            continue;

        if ( !_id_6129( var_6, var_0 ) )
        {
            if ( var_2 == 0 )
                continue;
            else
                break;
        }

        wait 0.05;

        if ( !isdefined( var_0 ) )
            break;

        if ( sighttracepassed( var_0.origin, var_6.origin + ( 0.0, 0.0, 55.0 ), 0, var_0 ) )
        {
            wait 0.05;

            if ( !isdefined( var_0 ) )
                break;

            if ( !isdefined( var_0.forcedisconnectuntil ) )
            {
                var_4[var_4.size] = var_6;

                if ( var_4.size == var_5 )
                    return var_4;
                else
                    continue;
            }

            var_7 = undefined;
            var_8 = 0;

            while ( !isdefined( var_7 ) && var_8 < 100 )
            {
                var_8++;
                var_9 = common_scripts\utility::random( var_3 );

                if ( distancesquared( var_6.origin, var_9.origin ) > 250000 )
                    var_7 = var_9;
            }

            if ( isdefined( var_7 ) )
            {
                var_10 = maps\mp\bots\_bots_util::_id_16C3( "GetNodesOnPathCrate", maps\mp\bots\_bots_util::_id_3AE7, var_6.origin, var_7.origin );

                if ( isdefined( var_10 ) )
                {
                    var_4[var_4.size] = var_6;

                    if ( var_4.size == var_5 )
                        return var_4;
                    else
                        continue;
                }
            }
        }
    }

    return undefined;
}

_id_2366( var_0 )
{
    if ( isdefined( var_0._id_6071 ) )
        return var_0._id_6071[0];

    if ( isdefined( var_0._id_6070 ) && var_0._id_6070.size > 0 )
    {
        var_1 = common_scripts\utility::array_reverse( self _meth_8380( var_0._id_6070, "node_exposed" ) );
        return common_scripts\utility::random_weight_sorted( var_1 ).origin;
    }
}

_id_1710()
{
    self notify( "bot_think_crate" );
    self endon( "bot_think_crate" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = getdvarfloat( "player_useRadius" );

    for (;;)
    {
        var_1 = randomfloatrange( 2, 4 );
        common_scripts\utility::waittill_notify_or_timeout( "new_crate_to_take", var_1 );

        if ( isdefined( self._id_1759 ) && self._id_1759.size == 0 )
            self._id_1759 = undefined;

        var_2 = [];

        foreach ( var_4 in level.carepackages )
        {
            if ( maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod( var_4 ) )
                var_2[var_2.size] = var_4;
        }

        if ( !maps\mp\bots\_bots_util::_id_1650() && isdefined( self._id_1759 ) )
            var_2 = common_scripts\utility::array_combine( var_2, self._id_1759 );

        if ( isdefined( level._id_16D4 ) && maps\mp\_utility::_hasperk( "specialty_scavenger" ) )
            var_2 = common_scripts\utility::array_combine( var_2, level._id_16D4 );

        var_2 = common_scripts\utility::array_removeundefined( var_2 );

        if ( var_2.size == 0 )
            continue;

        if ( maps\mp\bots\_bots_strategy::_id_1649( "airdrop_crate" ) || self _meth_835D() == "tactical" || maps\mp\bots\_bots_util::_id_1664() )
            continue;

        var_6 = [];

        foreach ( var_8 in var_2 )
        {
            if ( _id_15E3( var_8 ) )
                var_6[var_6.size] = var_8;
        }

        var_6 = common_scripts\utility::array_remove_duplicates( var_6 );

        if ( var_6.size == 0 )
            continue;

        var_6 = common_scripts\utility::get_array_of_closest( self.origin, var_6 );
        var_10 = self _meth_8387();

        if ( !isdefined( var_10 ) )
            continue;

        var_11 = self [[ level.bot_funcs["crate_low_ammo_check"] ]]();
        var_12 = ( var_11 || randomint( 100 ) < 50 ) && !maps\mp\_utility::isemped();
        var_13 = undefined;

        foreach ( var_8 in var_6 )
        {
            var_15 = 0;

            if ( ( !isdefined( var_8.owner ) || var_8.owner != self ) && !isdefined( var_8._id_175D ) )
            {
                var_16 = [];

                foreach ( var_18 in level.players )
                {
                    if ( !isdefined( var_18.team ) )
                        continue;

                    if ( !isai( var_18 ) && level.teambased && var_18.team == self.team )
                    {
                        if ( distancesquared( var_18.origin, var_8.origin ) < 490000 )
                            var_16[var_16.size] = var_18;
                    }
                }

                if ( var_16.size > 0 )
                {
                    var_20 = var_16[0] _meth_8387();

                    if ( isdefined( var_20 ) )
                    {
                        var_15 = 0;

                        foreach ( var_22 in var_8._id_6070 )
                            var_15 |= getnodesintrigger( var_20, var_22, 1 );
                    }
                }
            }

            if ( !var_15 )
            {
                var_24 = isdefined( var_8._id_1743 ) && isdefined( var_8._id_1743[self.team] ) && var_8._id_1743[self.team] > 0;
                var_25 = 0;

                foreach ( var_22 in var_8._id_6070 )
                    var_25 |= getnodesintrigger( var_10, var_22, 1 );

                if ( var_25 || var_12 && !var_24 )
                {
                    var_13 = var_8;
                    break;
                }
            }
        }

        if ( isdefined( var_13 ) )
        {
            if ( self [[ level.bot_funcs["crate_should_claim"] ]]() )
            {
                if ( !isdefined( var_13._id_175D ) )
                {
                    if ( !isdefined( var_13._id_1743 ) )
                        var_13._id_1743 = [];

                    var_13._id_1743[self.team] = 1;
                }
            }

            var_29 = spawnstruct();
            var_29._id_62DE = var_13;
            var_29._id_8CBD = ::_id_A1CF;
            var_29._id_8447 = ::_id_2370;
            var_30 = undefined;

            if ( isdefined( var_13._id_175D ) )
            {
                if ( isdefined( var_13._id_175B ) && var_13._id_175B )
                {
                    var_29._id_79F9 = 16;
                    var_29._id_06ED = undefined;
                    var_30 = var_13.origin;
                }
                else
                {
                    var_29._id_79F9 = 50;
                    var_29._id_06ED = ::_id_9BCC;
                    var_31 = _id_2366( var_13 ) - var_13.origin;
                    var_32 = length( var_31 ) * randomfloat( 1.0 );
                    var_30 = var_13.origin + vectornormalize( var_31 ) * var_32 + ( 0.0, 0.0, 12.0 );
                }
            }
            else
            {
                var_29._id_06ED = ::_id_9BCF;
                var_29._id_3150 = ::_id_8ECB;
                var_30 = _id_2366( var_13 );

                if ( !maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod( var_13 ) )
                    var_29._id_79F9 = var_0 - distance( var_13.origin, var_30 + ( 0.0, 0.0, 40.0 ) );

                var_30 += ( 0.0, 0.0, 24.0 );
            }

            if ( isdefined( var_29._id_79F9 ) )
            {

            }

            var_13 notify( "path_disconnect" );
            wait 0.05;

            if ( !isdefined( var_13 ) )
                continue;

            maps\mp\bots\_bots_strategy::_id_16A9( "airdrop_crate", var_30, 30, var_29 );
        }
    }
}

_id_16FE( var_0 )
{
    return 1;
}

_id_2371()
{
    return 1;
}

_id_236C()
{
    return 0;
}

_id_16FD( var_0 )
{
    if ( self getcurrentweapon() == level._id_175A[var_0._id_175D]._id_5C6F )
        return 0;

    return 1;
}

_id_16BF( var_0 )
{
    self switchtoweapon( self.secondaryweapon );
    wait 1.0;
}

_id_16BD( var_0 )
{
    self switchtoweapon( "none" );
    self.secondaryweapon = self getcurrentweapon();
}

_id_1701( var_0 )
{
    if ( maps\mp\bots\_bots_util::_id_1635( 0.66 ) )
    {
        var_1 = self _meth_8387();

        if ( isdefined( var_0._id_6070 ) && isdefined( var_0._id_6070[0] ) && isdefined( var_1 ) )
        {
            if ( getnodesintrigger( var_1, var_0._id_6070[0], 1 ) )
            {
                if ( common_scripts\utility::within_fov( self.origin, self.angles, var_0.origin, self _meth_8373() ) )
                    return 1;
            }
        }
    }

    return 0;
}

_id_16FF( var_0 )
{
    var_1 = self getweaponslistoffhands();

    foreach ( var_3 in var_1 )
    {
        if ( self getweaponammostock( var_3 ) == 0 )
            return 1;
    }

    return 0;
}

_id_1700( var_0 )
{
    return 1;
}

_id_236D()
{
    self notify( "crate_monitor_position" );
    self endon( "crate_monitor_position" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = self.origin;
        wait 0.5;

        if ( !isdefined( self ) )
            return;

        if ( !maps\mp\bots\_bots_util::_id_172A( self.origin, var_0 ) )
        {
            self.on_path_grid = undefined;
            self._id_6070 = undefined;
            self._id_6071 = undefined;
        }
    }
}

_id_2372()
{

}

_id_2370( var_0 )
{
    if ( !isdefined( var_0._id_62DE ) )
        return 1;

    return 0;
}

_id_9BCF( var_0 )
{
    if ( maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod( var_0._id_62DE ) )
    {
        var_0.was_goliath_pod_goal = 1;
        self _meth_8352( "stand" );
        self _meth_836D( var_0._id_62DE.origin + ( 0, 0, self _meth_82F2() ), level._id_237A / 1000 + 1.0, "script_forced" );
    }

    if ( isagent( self ) )
    {
        common_scripts\utility::_enableusability();
        var_0._id_62DE enableplayeruse( self );
        wait 0.05;
    }

    self [[ level.bot_funcs["crate_wait_use"] ]]();

    if ( isdefined( var_0._id_62DE.owner ) && var_0._id_62DE.owner == self )
        var_1 = level._id_237E / 1000 + 0.5;
    else
        var_1 = level._id_237A / 1000 + 1.0;

    self _meth_837E( "use", var_1 );
    wait(var_1);

    if ( isagent( self ) )
    {
        common_scripts\utility::_disableusability();

        if ( isdefined( var_0._id_62DE ) )
            var_0._id_62DE disableplayeruse( self );
    }

    if ( isdefined( var_0._id_62DE ) )
    {
        if ( !isdefined( var_0._id_62DE._id_174D ) )
            var_0._id_62DE._id_174D = [];

        var_0._id_62DE._id_174D[var_0._id_62DE._id_174D.size] = self;
    }
}

_id_9BCC( var_0 )
{
    if ( isagent( self ) )
    {
        common_scripts\utility::_enableusability();
        var_0._id_62DE enableplayeruse( self );
        wait 0.05;
    }

    if ( isdefined( var_0._id_62DE ) && isdefined( var_0._id_62DE._id_175D ) )
    {
        var_1 = var_0._id_62DE._id_175D;

        if ( isdefined( level._id_16C0[var_1] ) )
            self [[ level._id_16C0[var_1] ]]( var_0._id_62DE );

        if ( isdefined( var_0._id_62DE ) )
        {
            var_2 = level._id_175A[var_0._id_62DE._id_175D].usetime / 1000 + 0.5;
            self _meth_837E( "use", var_2 );
            wait(var_2);

            if ( isdefined( level._id_16BE[var_1] ) )
                self [[ level._id_16BE[var_1] ]]( var_0._id_62DE );
        }
    }

    if ( isagent( self ) )
    {
        common_scripts\utility::_disableusability();

        if ( isdefined( var_0._id_62DE ) )
            var_0._id_62DE disableplayeruse( self );
    }
}

_id_A1CF( var_0 )
{
    thread _id_1733( var_0._id_62DE );
}

_id_8ECB( var_0 )
{
    if ( isdefined( var_0.was_goliath_pod_goal ) && var_0.was_goliath_pod_goal )
    {
        self _meth_8352( "none" );
        self _meth_836D( undefined );
    }

    if ( isdefined( var_0._id_62DE ) )
        var_0._id_62DE._id_1743[self.team] = 0;
}

_id_1733( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "revived" );
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = self.team;
    common_scripts\utility::waittill_any( "death", "disconnect" );

    if ( isdefined( var_0 ) )
        var_0._id_1743[var_1] = 0;
}

_id_1711()
{
    self notify( "bot_think_crate_blocking_path" );
    self endon( "bot_think_crate_blocking_path" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = getdvarfloat( "player_useRadius" );

    for (;;)
    {
        wait 3;

        if ( self usebuttonpressed() )
            continue;

        if ( maps\mp\_utility::isusingremote() )
            continue;

        var_1 = level.carepackages;

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_3 = var_1[var_2];

            if ( !isdefined( var_3 ) )
                continue;

            if ( maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod( var_3 ) )
            {
                if ( !maps\mp\_utility::isjuggernaut() && distancesquared( self.origin, var_3.origin ) < 3600 )
                {
                    var_4 = spawnstruct();
                    var_4._id_62DE = var_3;
                    self _meth_8351( "disable_movement", 1 );
                    _id_9BCF( var_4 );
                    _id_8ECB( var_4 );
                    self _meth_8351( "disable_movement", 0 );
                }

                continue;
            }

            var_5 = self _meth_84C5();

            if ( !isdefined( var_5 ) || var_5 != var_3 )
                continue;

            if ( distancesquared( self.origin, var_3.origin ) < var_0 * var_0 )
            {
                if ( isdefined( var_3.owner ) && var_3.owner == self )
                {
                    self _meth_837E( "use", level._id_237E / 1000 + 0.5 );
                    continue;
                }

                self _meth_837E( "use", level._id_237A / 1000 + 0.5 );
            }
        }
    }
}

_id_1715()
{
    self notify( "bot_think_revive" );
    self endon( "bot_think_revive" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !level.teambased )
        return;

    for (;;)
    {
        var_0 = 2.0;
        var_1 = getentarray( "revive_trigger", "targetname" );

        if ( var_1.size > 0 )
            var_0 = 0.05;

        level common_scripts\utility::waittill_notify_or_timeout( "player_last_stand", var_0 );

        if ( !_id_15C6() )
            continue;

        var_1 = getentarray( "revive_trigger", "targetname" );

        if ( var_1.size > 1 )
        {
            var_1 = sortbydistance( var_1, self.origin );

            if ( isdefined( self.owner ) )
            {
                for ( var_2 = 0; var_2 < var_1.size; var_2++ )
                {
                    if ( var_1[var_2].owner != self.owner )
                        continue;

                    if ( var_2 == 0 )
                        break;

                    var_3 = var_1[var_2];
                    var_1[var_2] = var_1[0];
                    var_1[0] = var_3;
                    break;
                }
            }
        }

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_4 = var_1[var_2];
            var_5 = var_4.owner;

            if ( !isdefined( var_5 ) )
                continue;

            if ( var_5 == self )
                continue;

            if ( !isalive( var_5 ) )
                continue;

            if ( var_5.team != self.team )
                continue;

            if ( !isdefined( var_5.inlaststand ) || !var_5.inlaststand )
                continue;

            if ( isdefined( var_5._id_1743 ) && isdefined( var_5._id_1743[self.team] ) && var_5._id_1743[self.team] > 0 )
                continue;

            if ( isdefined( level.shouldignoreplayerrevive ) && [[ level.shouldignoreplayerrevive ]]( var_5 ) )
                continue;

            if ( distancesquared( self.origin, var_5.origin ) < 4194304 )
            {
                var_6 = spawnstruct();
                var_6._id_62DE = var_4;
                var_6._id_79F9 = 64;

                if ( isdefined( self._id_554B ) && gettime() - self._id_554B < 1000 )
                    var_6._id_79F9 = 32;

                var_6._id_8CBD = ::_id_A1D0;
                var_6._id_3150 = ::_id_8EB5;
                var_6._id_8447 = ::_id_6BDE;
                var_6._id_06ED = ::_id_74F8;
                maps\mp\bots\_bots_strategy::_id_16A9( "revive", var_5.origin, 60, var_6 );
                break;
            }
        }
    }
}

_id_A1D0( var_0 )
{
    if ( isdefined( var_0._id_62DE ) )
        thread _id_1733( var_0._id_62DE.owner );
}

_id_8EB5( var_0 )
{
    if ( isdefined( var_0._id_62DE.owner ) )
        var_0._id_62DE.owner._id_1743[self.team] = 0;
}

_id_6BDE( var_0 )
{
    if ( !isdefined( var_0._id_62DE.owner ) || var_0._id_62DE.owner.health <= 0 )
        return 1;

    if ( !isdefined( var_0._id_62DE.owner.inlaststand ) || !var_0._id_62DE.owner.inlaststand )
        return 1;

    return 0;
}

_id_74F8( var_0 )
{
    if ( distancesquared( self.origin, var_0._id_62DE.owner.origin ) > 4096 )
    {
        self._id_554B = gettime();
        return;
    }

    if ( isagent( self ) )
    {
        common_scripts\utility::_enableusability();
        var_0._id_62DE enableplayeruse( self );
        wait 0.05;
    }

    var_1 = self.team;
    self notify( "bot_reviving" );
    self _meth_837E( "use", level._id_55F2 / 1000 + 0.5 );
    wait(level._id_55F2 / 1000 + 1.5);

    if ( isdefined( var_0._id_62DE.owner ) )
        var_0._id_62DE._id_1743[var_1] = 0;

    if ( isagent( self ) )
    {
        common_scripts\utility::_disableusability();

        if ( isdefined( var_0._id_62DE ) )
            var_0._id_62DE disableplayeruse( self );
    }
}

_id_15C6()
{
    if ( isdefined( self.laststand ) && self.laststand == 1 )
        return 0;

    if ( maps\mp\bots\_bots_strategy::_id_1649( "revive" ) )
        return 0;

    if ( maps\mp\bots\_bots_util::_id_1664() )
        return 0;

    if ( maps\mp\bots\_bots_util::_id_1659() )
        return 1;

    var_0 = self _meth_835D();

    if ( var_0 == "none" || var_0 == "hunt" || var_0 == "guard" )
        return 1;

    return 0;
}

_id_74F9( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "bad_path" );
    self endon( "goal" );
    var_0 common_scripts\utility::waittill_any( "death", "revived" );
    self notify( "bad_path" );
}

_id_167D()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( gettime() > 15000 )
        return;

    while ( !maps\mp\_utility::gamehasstarted() || !maps\mp\_utility::gameflag( "prematch_done" ) )
        wait 0.05;

    var_0 = undefined;
    var_1 = undefined;

    for ( var_2 = 0; var_2 < level.players.size; var_2++ )
    {
        var_3 = level.players[var_2];

        if ( isdefined( var_3 ) && isdefined( self.team ) && isdefined( var_3.team ) && !_func_285( self, var_3 ) )
        {
            if ( !isdefined( var_3._id_1706 ) )
                var_0 = var_3;

            if ( isai( var_3 ) && !isdefined( var_3._id_1705 ) )
                var_1 = var_3;
        }
    }

    if ( isdefined( var_0 ) )
    {
        self._id_1705 = 1;
        var_0._id_1706 = 1;
        self _meth_8165( var_0 );
    }

    if ( isdefined( var_1 ) )
    {
        var_1._id_1705 = 1;
        self._id_1706 = 1;
        var_1 _meth_8165( self );
    }
}

_id_1697( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        return self _meth_8139( var_0, var_1 );
    else
        return self _meth_8139( var_0 );
}

_id_1712()
{
    self notify( "bot_think_gametype" );
    self endon( "bot_think_gametype" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    maps\mp\_utility::gameflagwait( "prematch_done" );
    self thread [[ level.bot_funcs["gametype_think"] ]]();
}

_id_277C()
{

}

_id_5E03()
{
    for (;;)
    {
        level waittill( "smoke", var_0, var_1 );
        var_2 = maps\mp\_utility::strip_suffix( var_1, "_lefthand" );

        if ( var_2 == "smoke_grenade_mp" )
            var_0 thread _id_460B( 9.5 );
    }
}

_id_460B( var_0 )
{
    self waittill( "explode", var_1 );
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2 show();
    var_2.origin = var_1;
    var_3 = 0.8;
    wait(var_3);
    var_3 = 0.5;
    var_4 = getent( "smoke_grenade_sight_clip_64_short", "targetname" );

    if ( isdefined( var_4 ) )
        var_2 clonebrushmodeltoscriptmodel( var_4 );

    wait(var_3);
    var_3 = 0.6;
    var_5 = getent( "smoke_grenade_sight_clip_64_tall", "targetname" );

    if ( isdefined( var_5 ) )
        var_2 clonebrushmodeltoscriptmodel( var_5 );

    wait(var_3);
    var_3 = var_0;
    var_6 = getent( "smoke_grenade_sight_clip_256", "targetname" );

    if ( isdefined( var_6 ) )
        var_2 clonebrushmodeltoscriptmodel( var_6 );

    wait(var_3);
    var_2 delete();
}

_id_15A4( var_0 )
{
    var_1 = 0;
    var_0._id_175D = "scavenger_bag";
    var_0._id_175B = 1;

    if ( !isdefined( level._id_16D4 ) )
        level._id_16D4 = [];

    foreach ( var_4, var_3 in level._id_16D4 )
    {
        if ( !isdefined( var_3 ) )
        {
            var_1 = 1;
            level._id_16D4[var_4] = var_0;
            break;
        }
    }

    if ( !var_1 )
        level._id_16D4[level._id_16D4.size] = var_0;

    foreach ( var_6 in level.participants )
    {
        if ( isai( var_6 ) && var_6 maps\mp\_utility::_hasperk( "specialty_scavenger" ) )
            var_6 notify( "new_crate_to_take" );
    }
}

_id_171A()
{
    var_0 = getentarray( "bot_flag_set", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2.script_noteworthy ) )
            continue;

        var_2 thread _id_1618( var_2.script_noteworthy );
    }
}

_id_1618( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger", var_1 );

        if ( maps\mp\_utility::isaigameparticipant( var_1 ) )
        {
            var_1 notify( "flag_trigger_set_" + var_0 );
            var_1 _meth_8351( var_0, 1 );
            var_1 thread _id_1619( var_0 );
        }
    }
}

_id_1619( var_0 )
{
    self endon( "flag_trigger_set_" + var_0 );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    waitframe();
    waittillframeend;
    self _meth_8351( var_0, 0 );
}