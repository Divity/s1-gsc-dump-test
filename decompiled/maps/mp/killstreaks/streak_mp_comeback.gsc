// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakwieldweapons["killstreak_comeback_mp"] = "mp_comeback";
    level.killstreakfuncs["mp_comeback"] = ::tryusekillstreak;
    level.mapkillstreak = "mp_comeback";
    level.mapkillstreakpickupstring = &"MP_COMEBACK_MAP_KILLSTREAK_PICKUP";
    level.mapcustombotkillstreakfunc = ::setupbotsformapkillstreak;
    level.killstreak_tank_groups = [];
    level.killstreak_tanks = getentarray( "walker_tank", "targetname" );
    common_scripts\utility::array_thread( level.killstreak_tanks, ::init_tank );
    level.killstreak_tank_groups = common_scripts\utility::array_randomize( level.killstreak_tank_groups );
    level.sky_nodes = [];
    var_0 = getallnodes();

    foreach ( var_2 in var_0 )
    {
        if ( _func_20C( var_2, 1 ) )
            level.sky_nodes[level.sky_nodes.size] = var_2;
    }

    level.missile_start_offset = 20;
    map_restart( "mp_comeback_spider_tank_idle" );
    map_restart( "mp_comeback_spider_tank_fire" );
}

setupbotsformapkillstreak()
{
    level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func( "mp_comeback", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

tryusekillstreak( var_0, var_1 )
{
    var_2 = undefined;

    foreach ( var_4 in level.killstreak_tank_groups )
    {
        var_5 = !isdefined( var_2 ) || var_4.last_run_time < var_2.last_run_time;

        if ( !var_4.active && var_5 )
            var_2 = var_4;
    }

    if ( !isdefined( var_2 ) )
    {
        iprintlnbold( &"MP_COMEBACK_MAP_KILLSTREAK_NOT_AVAILABLE" );
        return 0;
    }

    var_2 thread group_run( self );
    return 1;
}

init_tank()
{
    self.start_origin = self.origin;
    self.start_angles = self.angles;
    self.objids = [];
    var_0 = [ "allies", "axis" ];

    foreach ( var_2 in var_0 )
    {
        self.objids[var_2] = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( self.objids[var_2], "invisible", ( 0, 0, 0 ) );
        objective_icon( self.objids[var_2], common_scripts\utility::ter_op( var_2 == "allies", "compass_objpoint_tank_friendly", "compass_objpoint_tank_enemy" ) );
    }

    self.group = self.script_noteworthy;

    if ( !isdefined( self.group ) )
        self.group = "default";

    if ( !isdefined( level.killstreak_tank_groups[self.group] ) )
        level.killstreak_tank_groups[self.group] = init_new_tank_group();

    var_4 = level.killstreak_tank_groups[self.group].tanks.size;
    level.killstreak_tank_groups[self.group].tanks[var_4] = self;
    tank_idle( self );
}

init_new_tank_group()
{
    var_0 = spawnstruct();
    var_0.active = 0;
    var_0.tanks = [];
    var_0.last_run_time = 0;
    return var_0;
}

group_run( var_0 )
{
    self.active = 1;
    self.owner_team = var_0.team;
    self.owner = var_0;
    self.last_run_time = gettime();
    self.tank_count = self.tanks.size;

    foreach ( var_2 in self.tanks )
        thread tank_run( var_2 );

    self waittill( "all_tanks_done" );
    self.active = 0;
}

tank_run( var_0, var_1 )
{
    tank_show_icon( var_0 );
    tank_attack( var_0 );
    tank_idle( var_0 );
    tank_end( var_0 );
}

tank_show_icon( var_0 )
{
    foreach ( var_3, var_2 in var_0.objids )
    {
        objective_state( var_2, "active" );

        if ( var_3 == "allies" )
            objective_playerteam( var_2, self.owner _meth_81B1() );
        else
            objective_playerenemyteam( var_2, self.owner _meth_81B1() );

        objective_onentitywithrotation( var_2, var_0 );
    }
}

tank_hide_icon( var_0 )
{
    foreach ( var_3, var_2 in var_0.objids )
        objective_state( var_2, "invisible" );
}

tank_idle( var_0 )
{
    var_0 _meth_827B( "mp_comeback_spider_tank_idle" );
}

tank_attack( var_0 )
{
    self.owner endon( "disconnect" );
    var_0 endon( "tank_destroyed" );
    var_0 playsound( "walker_start" );
    var_0 _meth_827B( "mp_comeback_spider_tank_fire", "comeback_tank" );
    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        var_0 waittill( "comeback_tank", var_3 );

        switch ( var_3 )
        {
            case "fire_right":
                var_1++;
                var_4 = "tag_missile_" + var_1 + "_r";
                tank_fire_missile( var_0, var_4 );
                break;
            case "fire_left":
                var_2++;
                var_4 = "tag_missile_" + var_2 + "_l";
                tank_fire_missile( var_0, var_4 );
                break;
            case "end":
                return;
        }
    }
}

tank_fire_missile( var_0, var_1 )
{
    var_2 = var_0 gettagorigin( var_1 );
    var_3 = var_0 gettagangles( var_1 );
    var_4 = anglestoforward( var_3 );
    var_5 = var_2 + var_4 * level.missile_start_offset;
    var_6 = var_5 + var_4;
    var_7 = magicbullet( "killstreak_comeback_mp", var_5, var_6, self.owner );
    thread tank_missile_set_target( var_7 );
}

tank_missile_set_target( var_0 )
{
    var_0 endon( "death" );
    wait(randomfloatrange( 0.2, 0.4 ));
    var_1 = undefined;
    var_2 = randomfloatrange( 0.5, 1.0 );
    var_3 = gettime() + var_2 * 1000;
    var_4 = maps\mp\_utility::getotherteam( self.owner_team );

    while ( gettime() < var_3 && !isdefined( var_1 ) )
    {
        var_5 = common_scripts\utility::array_randomize( level.players );

        foreach ( var_7 in var_5 )
        {
            if ( var_7.team != var_4 )
                continue;

            if ( !maps\mp\_utility::isreallyalive( var_7 ) )
                continue;

            if ( isdefined( var_7.tank_no_target_time ) && var_7.tank_no_target_time > gettime() )
                continue;

            if ( isdefined( var_7.spawntime ) && var_7.spawntime + 3000 > gettime() )
                continue;

            if ( sighttracepassed( var_0.origin, var_7.origin + ( 0, 0, 40 ), 0, var_0, var_7, 0 ) )
            {
                var_1 = var_7;
                break;
            }
        }

        wait 0.05;
    }

    if ( isdefined( var_1 ) )
    {
        var_1.tank_no_target_time = gettime() + 3000;
        var_0 _meth_81D9( var_1 );
    }
    else
    {
        var_9 = 250;
        var_10 = var_9 * var_9;
        var_11 = common_scripts\utility::random( level.sky_nodes );

        if ( isdefined( self.owner ) )
        {
            for ( var_12 = 0; var_12 < 10 && distancesquared( var_11.origin, self.owner.origin ) < var_10; var_12++ )
                var_11 = common_scripts\utility::random( level.sky_nodes );
        }

        var_0 _meth_81DA( var_11.origin );
    }
}

tank_end( var_0 )
{
    tank_hide_icon( var_0 );
    self.tank_count--;

    if ( self.tank_count == 0 )
        self notify( "all_tanks_done" );
}
