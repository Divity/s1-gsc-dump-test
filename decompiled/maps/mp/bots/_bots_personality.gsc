// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setup_personalities()
{
    level.bot_personality = [];
    level.bot_personality_list = [];
    level.bot_personality["active"][0] = "default";
    level.bot_personality["active"][1] = "run_and_gun";
    level.bot_personality["active"][2] = "cqb";
    level.bot_personality["stationary"][0] = "camper";
    level.bot_personality_type = [];

    foreach ( var_5, var_1 in level.bot_personality )
    {
        foreach ( var_3 in var_1 )
        {
            level.bot_personality_type[var_3] = var_5;
            level.bot_personality_list[level.bot_personality_list.size] = var_3;
        }
    }

    level.bot_personality_types_desired = [];
    level.bot_personality_types_desired["active"] = 4;
    level.bot_personality_types_desired["stationary"] = 1;
    level.bot_pers_init = [];
    level.bot_pers_init["default"] = ::init_personality_default;
    level.bot_pers_init["camper"] = ::init_personality_camper;
    level.bot_pers_update["default"] = ::update_personality_default;
    level.bot_pers_update["camper"] = ::update_personality_camper;
}

bot_assign_personality_functions()
{
    self.personality = self _meth_8366();
    self.pers["personality"] = self.personality;
    self.personality_init_function = level.bot_pers_init[self.personality];

    if ( !isdefined( self.personality_init_function ) )
        self.personality_init_function = level.bot_pers_init["default"];

    self [[ self.personality_init_function ]]();
    self.personality_update_function = level.bot_pers_update[self.personality];

    if ( !isdefined( self.personality_update_function ) )
        self.personality_update_function = level.bot_pers_update["default"];
}

bot_balance_personality()
{
    if ( isdefined( self.personalitymanuallyset ) && self.personalitymanuallyset )
        return;

    if ( isdefined( self.pers["personality"] ) )
    {
        self _meth_8369( self.pers["personality"] );
        return;
    }

    var_0 = self.team;

    if ( !isdefined( var_0 ) && !isdefined( self.bot_team ) )
        var_0 = self.pers["team"];

    var_1 = [];
    var_2 = [];

    foreach ( var_8, var_4 in level.bot_personality )
    {
        var_2[var_8] = 0;

        foreach ( var_6 in var_4 )
            var_1[var_6] = 0;
    }

    foreach ( var_10 in level.participants )
    {
        if ( maps\mp\_utility::isteamparticipant( var_10 ) && isdefined( var_10.team ) && var_10.team == var_0 && var_10 != self && isdefined( var_10.has_balanced_personality ) )
        {
            var_6 = var_10 _meth_8366();
            var_8 = level.bot_personality_type[var_6];
            var_1[var_6] += 1;
            var_2[var_8] += 1;
        }
    }

    var_12 = undefined;

    while ( !isdefined( var_12 ) )
    {
        for ( var_13 = level.bot_personality_types_desired; var_13.size > 0; var_13[var_14] = undefined )
        {
            var_14 = maps\mp\bots\_bots_util::bot_get_string_index_for_integer( var_13, randomint( var_13.size ) );
            var_2[var_14] -= level.bot_personality_types_desired[var_14];

            if ( var_2[var_14] < 0 )
            {
                var_12 = var_14;
                break;
            }
        }
    }

    var_15 = undefined;
    var_16 = undefined;
    var_17 = 9999;
    var_18 = undefined;
    var_19 = -9999;
    var_20 = common_scripts\utility::array_randomize( level.bot_personality[var_12] );

    foreach ( var_6 in var_20 )
    {
        if ( var_1[var_6] < var_17 )
        {
            var_16 = var_6;
            var_17 = var_1[var_6];
        }

        if ( var_1[var_6] > var_19 )
        {
            var_18 = var_6;
            var_19 = var_1[var_6];
        }
    }

    if ( var_19 - var_17 >= 2 )
        var_15 = var_16;
    else
        var_15 = common_scripts\utility::random( level.bot_personality[var_12] );

    if ( self _meth_8366() != var_15 )
        self _meth_8369( var_15 );

    self.has_balanced_personality = 1;
}

init_personality_camper()
{
    clear_camper_data();
}

init_personality_default()
{
    clear_camper_data();
}

update_personality_camper()
{
    if ( should_select_new_ambush_point() && !maps\mp\bots\_bots_util::bot_is_defending() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
    {
        var_0 = self _meth_835D();
        var_1 = 0;

        if ( !isdefined( self.camper_time_started_hunting ) )
            self.camper_time_started_hunting = 0;

        var_2 = var_0 == "hunt";
        var_3 = gettime() > self.camper_time_started_hunting + 10000;

        if ( ( !var_2 || var_3 ) && !maps\mp\bots\_bots_util::bot_out_of_ammo() )
        {
            if ( !self _meth_8365() )
                bot_random_path();

            var_1 = find_camp_node();

            if ( !var_1 )
                self.camper_time_started_hunting = gettime();
        }

        if ( isdefined( var_1 ) && var_1 )
        {
            self.ambush_entrances = maps\mp\bots\_bots_util::bot_queued_process( "bot_find_ambush_entrances", ::bot_find_ambush_entrances, self.node_ambushing_from, 1 );
            var_4 = maps\mp\bots\_bots_strategy::bot_get_ambush_trap_item( "trap_directional", "trap", "c4" );

            if ( isdefined( var_4 ) )
            {
                var_5 = gettime();
                maps\mp\bots\_bots_strategy::bot_set_ambush_trap( var_4, self.ambush_entrances, self.node_ambushing_from, self.ambush_yaw );
                var_5 = gettime() - var_5;

                if ( var_5 > 0 && isdefined( self.ambush_end ) && isdefined( self.node_ambushing_from ) )
                {
                    self.ambush_end += var_5;
                    self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
                }
            }

            if ( !maps\mp\bots\_bots_strategy::bot_has_tactical_goal() && !maps\mp\bots\_bots_util::bot_is_defending() && isdefined( self.node_ambushing_from ) )
            {
                self _meth_8355( self.node_ambushing_from, "camp", self.ambush_yaw );
                thread clear_script_goal_on( "bad_path", "node_relinquished", "out_of_ammo" );
                thread watch_out_of_ammo();
                thread bot_add_ambush_time_delayed( "clear_camper_data", "goal" );
                thread bot_watch_entrances_delayed( "clear_camper_data", "bot_add_ambush_time_delayed", self.ambush_entrances, self.ambush_yaw );
                childthread bot_try_trap_follower( "clear_camper_data", "goal" );
                return;
            }
        }
        else
        {
            if ( var_0 == "camp" )
                self _meth_8356();

            update_personality_default();
        }
    }
}

update_personality_default()
{
    var_0 = undefined;
    var_1 = self _meth_8365();

    if ( var_1 )
        var_0 = self _meth_835A();

    if ( gettime() - self.lastspawntime > 5000 )
        bot_try_trap_follower();

    if ( !maps\mp\bots\_bots_strategy::bot_has_tactical_goal() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
    {
        var_2 = undefined;
        var_3 = undefined;

        if ( var_1 )
        {
            var_2 = distancesquared( self.origin, var_0 );
            var_3 = self _meth_835B();
            var_4 = var_3 * 2;

            if ( isdefined( self.bot_memory_goal ) && var_2 < var_4 * var_4 )
            {
                var_5 = botmemoryflags( "investigated" );
                botflagmemoryevents( 0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_4, "kill", var_5, self );
                botflagmemoryevents( 0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_4, "death", var_5, self );
                self.bot_memory_goal = undefined;
                self.bot_memory_goal_time = undefined;
            }
        }

        if ( !var_1 || var_2 < var_3 * var_3 )
        {
            var_6 = bot_random_path();

            if ( var_6 && randomfloat( 100 ) < 25 )
            {
                var_7 = maps\mp\bots\_bots_strategy::bot_get_ambush_trap_item( "trap_directional", "trap" );

                if ( isdefined( var_7 ) )
                {
                    var_8 = self _meth_835A();

                    if ( isdefined( var_8 ) )
                    {
                        var_9 = getclosestnodeinsight( var_8 );

                        if ( isdefined( var_9 ) )
                        {
                            var_10 = bot_find_ambush_entrances( var_9, 0 );
                            var_11 = maps\mp\bots\_bots_strategy::bot_set_ambush_trap( var_7, var_10, var_9 );

                            if ( !isdefined( var_11 ) || var_11 )
                            {
                                self _meth_8356();
                                var_6 = bot_random_path();
                            }
                        }
                    }
                }
            }

            if ( var_6 )
                thread clear_script_goal_on( "enemy", "bad_path", "goal", "node_relinquished", "search_end" );
        }
    }
}

bot_try_trap_follower( var_0, var_1 )
{
    self notify( "bot_try_trap_follower" );
    self endon( "bot_try_trap_follower" );
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( var_0 ) )
        self endon( var_0 );

    self endon( "node_relinquished" );
    self endon( "bad_path" );

    if ( isdefined( var_1 ) )
        self waittill( var_1 );

    var_2 = maps\mp\bots\_bots_strategy::bot_get_ambush_trap_item( "trap_follower" );

    if ( isdefined( var_2 ) && self _meth_8341() )
    {
        var_3 = maps\mp\bots\_bots_util::bot_get_nodes_in_cone( 300, 600, 0.7, 1 );

        if ( var_3.size > 0 )
        {
            self _meth_837E( var_2["item_action"] );
            common_scripts\utility::waittill_any_timeout( 5, "grenade_fire", "missile_fire" );
        }
    }
}

clear_script_goal_on( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "clear_script_goal_on" );
    self endon( "clear_script_goal_on" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "start_tactical_goal" );
    var_5 = self _meth_835A();
    var_6 = 1;

    while ( var_6 )
    {
        var_7 = common_scripts\utility::waittill_any_return( var_0, var_1, var_2, var_3, var_4, "script_goal_changed" );
        var_6 = 0;
        var_8 = 1;

        if ( var_7 == "node_relinquished" || var_7 == "goal" || var_7 == "script_goal_changed" )
        {
            if ( !self _meth_8365() )
                var_8 = 0;
            else
            {
                var_9 = self _meth_835A();
                var_8 = maps\mp\bots\_bots_util::bot_vectors_are_equal( var_5, var_9 );
            }
        }

        if ( var_7 == "enemy" && isdefined( self.enemy ) )
        {
            var_8 = 0;
            var_6 = 1;
        }

        if ( var_8 )
            self _meth_8356();
    }
}

watch_out_of_ammo()
{
    self notify( "watch_out_of_ammo" );
    self endon( "watch_out_of_ammo" );
    self endon( "death" );
    self endon( "disconnect" );

    while ( !maps\mp\bots\_bots_util::bot_out_of_ammo() )
        wait 0.5;

    self notify( "out_of_ammo" );
}

bot_add_ambush_time_delayed( var_0, var_1 )
{
    self notify( "bot_add_ambush_time_delayed" );
    self endon( "bot_add_ambush_time_delayed" );
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( var_0 ) )
        self endon( var_0 );

    self endon( "node_relinquished" );
    self endon( "bad_path" );
    var_2 = gettime();

    if ( isdefined( var_1 ) )
        self waittill( var_1 );

    if ( isdefined( self.ambush_end ) && isdefined( self.node_ambushing_from ) )
    {
        self.ambush_end += gettime() - var_2;
        self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
    }

    self notify( "bot_add_ambush_time_delayed" );
}

bot_watch_entrances_delayed( var_0, var_1, var_2, var_3 )
{
    self notify( "bot_watch_entrances_delayed" );

    if ( var_2.size > 0 )
    {
        self endon( "bot_watch_entrances_delayed" );
        self endon( "death" );
        self endon( "disconnect" );
        self endon( var_0 );
        self endon( "node_relinquished" );
        self endon( "bad_path" );

        if ( isdefined( var_1 ) )
            self waittill( var_1 );

        self endon( "path_enemy" );
        childthread maps\mp\bots\_bots_util::bot_watch_nodes( var_2, var_3, 0, self.ambush_end );
        childthread bot_monitor_watch_entrances_camp();
    }
}

bot_monitor_watch_entrances_camp()
{
    self notify( "bot_monitor_watch_entrances_camp" );
    self endon( "bot_monitor_watch_entrances_camp" );
    self notify( "bot_monitor_watch_entrances" );
    self endon( "bot_monitor_watch_entrances" );
    self endon( "disconnect" );
    self endon( "death" );

    while ( !isdefined( self.watch_nodes ) )
        wait 0.05;

    while ( isdefined( self.watch_nodes ) )
    {
        foreach ( var_1 in self.watch_nodes )
            var_1.watch_node_chance[self.entity_number] = 1.0;

        maps\mp\bots\_bots_strategy::prioritize_watch_nodes_toward_enemies( 0.5 );
        wait(randomfloatrange( 0.5, 0.75 ));
    }
}

bot_find_ambush_entrances( var_0, var_1 )
{
    self endon( "disconnect" );
    var_2 = [];
    var_3 = _func_20D( var_0.origin );

    if ( isdefined( var_3 ) && var_3.size > 0 )
    {
        wait 0.05;
        var_4 = var_0.type != "Cover Stand" && var_0.type != "Conceal Stand";

        if ( var_4 && var_1 )
            var_3 = self _meth_8380( var_3, "node_exposure_vis", var_0.origin, "crouch" );

        foreach ( var_6 in var_3 )
        {
            if ( distancesquared( self.origin, var_6.origin ) < 90000 )
                continue;

            if ( var_4 && var_1 )
            {
                wait 0.05;

                if ( !maps\mp\bots\_bots_util::entrance_visible_from( var_6.origin, var_0.origin, "crouch" ) )
                    continue;
            }

            var_2[var_2.size] = var_6;
        }
    }

    return var_2;
}

bot_filter_ambush_inuse( var_0 )
{
    var_1 = [];
    var_2 = gettime();
    var_3 = var_0.size;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_5 = var_0[var_4];

        if ( !isdefined( var_5.bot_ambush_end ) || var_2 > var_5.bot_ambush_end )
            var_1[var_1.size] = var_5;
    }

    return var_1;
}

bot_filter_ambush_vicinity( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = [];
    var_5 = var_2 * var_2;

    if ( level.teambased )
    {
        foreach ( var_7 in level.participants )
        {
            if ( !maps\mp\_utility::isreallyalive( var_7 ) )
                continue;

            if ( !isdefined( var_7.team ) )
                continue;

            if ( var_7.team == var_1.team && var_7 != var_1 && isdefined( var_7.node_ambushing_from ) )
                var_4[var_4.size] = var_7.node_ambushing_from.origin;
        }
    }

    var_9 = var_4.size;
    var_10 = var_0.size;

    for ( var_11 = 0; var_11 < var_10; var_11++ )
    {
        var_12 = 0;
        var_13 = var_0[var_11];

        for ( var_14 = 0; !var_12 && var_14 < var_9; var_14++ )
        {
            var_15 = distancesquared( var_4[var_14], var_13.origin );
            var_12 = var_15 < var_5;
        }

        if ( !var_12 )
            var_3[var_3.size] = var_13;
    }

    return var_3;
}

clear_camper_data()
{
    self notify( "clear_camper_data" );

    if ( isdefined( self.node_ambushing_from ) && isdefined( self.node_ambushing_from.bot_ambush_end ) )
        self.node_ambushing_from.bot_ambush_end = undefined;

    self.node_ambushing_from = undefined;
    self.point_to_ambush = undefined;
    self.ambush_yaw = undefined;
    self.ambush_entrances = undefined;
    self.ambush_duration = randomintrange( 20000, 30000 );
    self.ambush_end = -1;
}

should_select_new_ambush_point()
{
    if ( maps\mp\bots\_bots_strategy::bot_has_tactical_goal() )
        return 0;

    if ( gettime() > self.ambush_end )
        return 1;

    if ( !self _meth_8365() )
        return 1;

    return 0;
}

find_camp_node()
{
    self notify( "find_camp_node" );
    self endon( "find_camp_node" );
    return maps\mp\bots\_bots_util::bot_queued_process( "find_camp_node_worker", ::find_camp_node_worker );
}

find_camp_node_worker()
{
    self notify( "find_camp_node_worker" );
    self endon( "find_camp_node_worker" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    clear_camper_data();

    if ( level.zonecount <= 0 )
        return 0;

    var_0 = _func_202( self.origin );
    var_1 = undefined;
    var_2 = undefined;
    var_3 = self.angles;

    if ( isdefined( var_0 ) )
    {
        var_4 = botzonenearestcount( var_0, self.team, -1, "enemy_predict", ">", 0, "ally", "<", 1 );

        if ( !isdefined( var_4 ) )
            var_4 = botzonenearestcount( var_0, self.team, -1, "enemy_predict", ">", 0 );

        if ( isdefined( var_4 ) )
        {
            var_5 = _func_208( var_4 );
            var_6 = getlinkednodes( var_5 );

            if ( var_6.size == 0 )
                var_4 = undefined;
        }

        if ( !isdefined( var_4 ) )
        {
            var_7 = -1;
            var_8 = -1;

            for ( var_9 = 0; var_9 < level.zonecount; var_9++ )
            {
                var_5 = _func_208( var_9 );
                var_6 = getlinkednodes( var_5 );

                if ( var_6.size > 0 )
                {
                    var_10 = common_scripts\utility::random( _func_203( var_9 ) );
                    var_11 = isdefined( var_10.targetname ) && var_10.targetname == "no_bot_random_path";

                    if ( !var_11 )
                    {
                        var_12 = _func_220( _func_205( var_9 ), self.origin );

                        if ( var_12 > var_7 )
                        {
                            var_7 = var_12;
                            var_8 = var_9;
                        }
                    }
                }
            }

            var_4 = var_8;
        }

        var_13 = _func_204( var_0, var_4 );

        if ( !isdefined( var_13 ) || var_13.size == 0 )
            return 0;

        for ( var_14 = 0; var_14 <= int( var_13.size / 2 ); var_14++ )
        {
            var_1 = var_13[var_14];
            var_2 = var_13[int( min( var_14 + 1, var_13.size - 1 ) )];

            if ( botzonegetcount( var_2, self.team, "enemy_predict" ) != 0 )
                break;
        }

        if ( isdefined( var_1 ) && isdefined( var_2 ) && var_1 != var_2 )
        {
            var_3 = _func_205( var_2 ) - _func_205( var_1 );
            var_3 = vectortoangles( var_3 );
        }
    }

    var_15 = undefined;

    if ( isdefined( var_1 ) )
    {
        var_16 = 1;
        var_17 = 1;
        var_18 = 0;

        while ( var_16 )
        {
            var_19 = _func_207( var_1, 800 * var_17, 1 );

            if ( var_19.size > 1024 )
                var_19 = _func_203( var_1, 0 );

            wait 0.05;
            var_20 = randomint( 100 );

            if ( var_20 < 66 && var_20 >= 33 )
                var_3 = ( var_3[0], var_3[1] + 45, 0 );
            else if ( var_20 < 33 )
                var_3 = ( var_3[0], var_3[1] - 45, 0 );

            if ( var_19.size > 0 )
            {
                while ( var_19.size > 1024 )
                    var_19[var_19.size - 1] = undefined;

                var_21 = int( clamp( var_19.size * 0.15, 1, 10 ) );

                if ( var_18 )
                    var_19 = self _meth_8371( var_19, var_21, var_21, "node_camp", anglestoforward( var_3 ), "lenient" );
                else
                    var_19 = self _meth_8371( var_19, var_21, var_21, "node_camp", anglestoforward( var_3 ) );

                var_19 = bot_filter_ambush_inuse( var_19 );

                if ( !isdefined( self.can_camp_near_others ) || !self.can_camp_near_others )
                {
                    var_22 = 800;
                    var_19 = bot_filter_ambush_vicinity( var_19, self, var_22 );
                }

                if ( var_19.size > 0 )
                    var_15 = common_scripts\utility::random_weight_sorted( var_19 );
            }

            if ( isdefined( var_15 ) )
                var_16 = 0;
            else if ( isdefined( self.camping_needs_fallback_camp_location ) )
            {
                if ( var_17 == 1 && !var_18 )
                    var_17 = 3;
                else if ( var_17 == 3 && !var_18 )
                    var_18 = 1;
                else if ( var_17 == 3 && var_18 )
                    var_16 = 0;
            }
            else
                var_16 = 0;

            if ( var_16 )
                wait 0.05;
        }
    }

    if ( !isdefined( var_15 ) || !self _meth_8360( var_15 ) )
        return 0;

    self.node_ambushing_from = var_15;
    self.ambush_end = gettime() + self.ambush_duration;
    self.node_ambushing_from.bot_ambush_end = self.ambush_end;
    self.ambush_yaw = var_3[1];
    return 1;
}

find_ambush_node( var_0, var_1 )
{
    clear_camper_data();

    if ( isdefined( var_0 ) )
        self.point_to_ambush = var_0;
    else
    {
        var_2 = undefined;
        var_3 = getnodesinradius( self.origin, 5000, 0, 2000 );

        if ( var_3.size > 0 )
            var_2 = self _meth_8364( var_3, var_3.size * 0.25, "node_traffic" );

        if ( isdefined( var_2 ) )
            self.point_to_ambush = var_2.origin;
        else
            return 0;
    }

    var_4 = 2000;

    if ( isdefined( var_1 ) )
        var_4 = var_1;

    var_5 = getnodesinradius( self.point_to_ambush, var_4, 0, 1000 );
    var_6 = undefined;

    if ( var_5.size > 0 )
    {
        var_7 = int( max( 1, int( var_5.size * 0.15 ) ) );
        var_5 = self _meth_8371( var_5, var_7, var_7, "node_ambush", self.point_to_ambush );
    }

    var_5 = bot_filter_ambush_inuse( var_5 );

    if ( var_5.size > 0 )
        var_6 = common_scripts\utility::random_weight_sorted( var_5 );

    if ( !isdefined( var_6 ) || !self _meth_8360( var_6 ) )
        return 0;

    self.node_ambushing_from = var_6;
    self.ambush_end = gettime() + self.ambush_duration;
    self.node_ambushing_from.bot_ambush_end = self.ambush_end;
    var_8 = vectornormalize( self.point_to_ambush - self.node_ambushing_from.origin );
    var_9 = vectortoangles( var_8 );
    self.ambush_yaw = var_9[1];
    return 1;
}

bot_random_path()
{
    if ( maps\mp\bots\_bots_util::bot_is_remote_or_linked() )
        return 0;

    var_0 = level.bot_random_path_function[self.team];
    return self [[ var_0 ]]();
}

bot_random_path_default()
{
    var_0 = 0;
    var_1 = 50;

    if ( self.personality == "camper" )
        var_1 = 0;

    var_2 = undefined;

    if ( randomint( 100 ) < var_1 )
        var_2 = maps\mp\bots\_bots_util::bot_recent_point_of_interest();

    if ( !isdefined( var_2 ) )
    {
        var_3 = self _meth_8361();

        if ( isdefined( var_3 ) )
            var_2 = var_3.origin;
    }

    if ( isdefined( var_2 ) )
        var_0 = self _meth_8354( var_2, 128, "hunt" );

    return var_0;
}

bot_setup_callback_class()
{
    if ( maps\mp\_utility::practiceroundgame() )
        return "practice" + randomintrange( 1, 6 );

    if ( maps\mp\bots\_bots_loadout::bot_setup_loadout_callback() )
        return "callback";
    else
        return "class0";
}
