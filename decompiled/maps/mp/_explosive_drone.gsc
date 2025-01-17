// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

watchexplosivedroneusage()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );

    if ( !isdefined( level.explosivedronesettings ) )
        explosivedroneinit();

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );
        var_2 = maps\mp\_utility::strip_suffix( var_1, "_lefthand" );

        if ( var_2 == "explosive_drone_mp" )
        {
            var_0.team = self.team;

            if ( !isdefined( var_0.owner ) )
                var_0.owner = self;

            if ( !isdefined( var_0.weaponname ) )
                var_0.weaponname = var_1;

            var_0 thread explosivedronelink();
        }
    }
}

explosivedronelink()
{
    thread watchforstick();
    wait 0.1;

    if ( isdefined( self ) )
    {
        self.explosivedrone = spawn( "script_model", self.origin );
        self.explosivedrone.targetname = "explosive_drone_head_model";
        self.explosivedrone _meth_80B1( level.explosivedronesettings.modelbase );
        self.explosivedrone.oldcontents = self.explosivedrone setcontents( 0 );
        self.explosivedrone _meth_804D( self, "tag_spike", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        self.explosivedrone.owner = self.owner;
        var_0 = self.explosivedrone;
        var_0 thread cleanup_on_grenade_death( self );
        thread monitorspikedestroy();
        thread monitorheaddestroy();
    }
}

cleanup_on_grenade_death( var_0 )
{
    var_0 waittill( "death" );

    if ( isdefined( self ) )
        self delete();
}

explosivegrenadedeath( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self ) )
    {
        self notify( "death" );

        if ( isdefined( self.explosivedrone ) )
            self.explosivedrone deleteexplosivedrone();

        self delete();
    }
}

explosiveheaddeath( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self ) )
        self delete();
}

explosivedroneinit()
{
    level.explosivedronemaxperplayer = 1;
    level.explosivedronesettings = spawnstruct();
    level.explosivedronesettings.timeout = 20.0;
    level.explosivedronesettings.explosivetimeout = 30.0;
    level.explosivedronesettings.health = 60;
    level.explosivedronesettings.maxhealth = 60;
    level.explosivedronesettings.vehicleinfo = "vehicle_tracking_drone_mp";
    level.explosivedronesettings.modelbase = "npc_drone_explosive_main";
    level.explosivedronesettings.fxid_sparks = loadfx( "vfx/sparks/direct_hack_stun" );
    level.explosivedronesettings.fxid_laser_glow = loadfx( "vfx/lights/tracking_drone_laser_blue" );
    level.explosivedronesettings.fxid_explode = loadfx( "vfx/explosion/explosive_drone_explosion" );
    level.explosivedronesettings.fxid_lethalexplode = loadfx( "vfx/explosion/explosive_drone_explosion" );
    level.explosivedronesettings.fxid_enemy_light = loadfx( "vfx/lights/light_explosive_drone_beacon_enemy" );
    level.explosivedronesettings.fxid_friendly_light = loadfx( "vfx/lights/light_explosive_drone_beacon_friendly" );
    level.explosivedronesettings.fxid_engine_distort = loadfx( "vfx/distortion/tracking_drone_distortion_hemi" );
    level.explosivedronesettings.fxid_launch_thruster = loadfx( "vfx/trail/explosive_drone_thruster_large" );
    level.explosivedronesettings.fxid_position_thruster = loadfx( "vfx/trail/explosive_drone_thruster_small" );
    level.explosivedronesettings.sound_explode = "wpn_explosive_drone_exp";
    level.explosivedronesettings.sound_lock = "wpn_explosive_drone_lock";
    level.explosivedronesettings.sound_launch = "wpn_explosive_drone_open";

    foreach ( var_1 in level.players )
        var_1.is_being_tracked = 0;

    level thread onexplosiveplayerconnect();
    level.explosivedronetimeout = level.explosivedronesettings.timeout;
    level.explosivedronetimeout = level.explosivedronesettings.explosivetimeout;
    level.explosivedronedebugposition = 0;
    level.explosivedronedebugpositionforward = 0;
    level.explosivedronedebugpositionheight = 0;
}

tryuseexplosivedrone( var_0 )
{
    var_1 = 1;

    if ( maps\mp\_utility::isusingremote() )
        return 0;
    else if ( exceededmaxexplosivedrones() )
    {
        self iclientprintlnbold( &"MP_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iclientprintlnbold( &"MP_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( !isdefined( self.explosivedronearray ) )
        self.explosivedronearray = [];

    if ( self.explosivedronearray.size )
    {
        self.explosivedronearray = common_scripts\utility::array_removeundefined( self.explosivedronearray );

        if ( self.explosivedronearray.size >= level.explosivedronemaxperplayer )
        {
            if ( isdefined( self.explosivedronearray[0] ) )
                self.explosivedronearray[0] thread explosivedrone_leave();
        }
    }

    maps\mp\_utility::incrementfauxvehiclecount();
    var_2 = var_0 createexplosivedrone();

    if ( !isdefined( var_2 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    self playsound( level.explosivedronesettings.sound_launch );
    self playsound( level.explosivedronesettings.sound_lock );
    self.explosivedronearray[self.explosivedronearray.size] = var_2;
    thread startexplosivedrone( var_2 );
    playfxontag( level.explosivedronesettings.fxid_launch_thruster, var_2, "TAG_THRUSTER_BTM" );
    var_0 notify( "mine_selfdestruct" );
    return var_2;
}

createexplosivedrone( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !var_0 )
    {
        var_4 = self.angles;
        var_5 = anglestoforward( var_4 );
        var_6 = anglestoright( var_4 );
        var_7 = var_5 * 50;
        var_8 = var_6 * 0;
        var_9 = 80;

        if ( isdefined( self.explosivedrone ) )
        {
            var_11 = self.explosivedrone.origin;
            var_4 = self.explosivedrone.angles;
            self.explosivedrone deleteexplosivedrone();
            addtodeletespike();
        }
        else
            var_11 = self.origin;
    }
    else
    {
        var_11 = var_1;
        var_12 = var_1;
        var_4 = var_2;
    }

    var_13 = anglestoup( self.angles );
    var_11 += var_13 * 10;
    var_14 = spawnhelicopter( self.owner, var_11, var_4, level.explosivedronesettings.vehicleinfo, level.explosivedronesettings.modelbase );

    if ( !isdefined( var_14 ) )
        return;

    var_14.type = "explosive_drone";
    var_14 common_scripts\utility::make_entity_sentient_mp( self.owner.team );
    var_14 _meth_83F3( 1 );
    var_14 addtoexplosivedronelist();
    var_14 thread removefromexplosivedronelistondeath();
    var_14.health = level.explosivedronesettings.health;
    var_14.maxhealth = level.explosivedronesettings.maxhealth;
    var_14.damagetaken = 0;
    var_14.speed = 20;
    var_14.followspeed = 20;
    var_14.owner = self.owner;
    var_14.team = self.owner.team;
    var_14 _meth_8283( var_14.speed, 10, 10 );
    var_14 _meth_8292( 120, 90 );
    var_14 _meth_825A( 64 );
    var_14 _meth_8253( 20, 5, 5 );
    var_14.fx_tag0 = undefined;

    if ( isdefined( var_14.type ) )
    {
        if ( var_14.type == "explosive_drone" )
        {

        }
    }

    var_14.maxtrackingrange = 2000;
    var_14.maxlaserrange = 300;
    var_14.trackedplayer = undefined;
    var_15 = 45;
    var_16 = 45;
    var_14 _meth_8294( var_15, var_16 );
    var_14.targetpos = var_11;
    var_14.attract_strength = 10000;
    var_14.attract_range = 150;
    var_14.attractor = missile_createattractorent( var_14, var_14.attract_strength, var_14.attract_range );
    var_14.hasdodged = 0;
    var_14.stunned = 0;
    var_14.inactive = 0;
    var_14 thread maps\mp\gametypes\_damage::setentitydamagecallback( var_14.maxhealth, undefined, ::onexplosivedronedeath, undefined, 0 );
    var_14 thread explosivedrone_watchdisable();
    var_14 thread explosivedrone_watchdeath();
    var_14 thread explosivedrone_watchtimeout();
    var_14 thread explosivedrone_watchownerloss();
    var_14 thread explosivedrone_watchownerdeath();
    var_14 thread explosivedrone_watchroundend();
    var_14 thread explosivedrone_watchhostmigration();
    var_14 thread explosivedrone_enemy_lightfx();
    var_14 thread explosivedrone_friendly_lightfx();
    var_14 thread drone_thrusterfxexplosive();
    return var_14;
}

addtodeletespike()
{
    var_0 = 5;

    if ( !isdefined( level.spikelist ) )
    {
        level.spikelist = [];
        level.spikelistindex = 0;
    }

    if ( level.spikelist.size >= var_0 )
    {
        if ( isdefined( level.spikelist[level.spikelistindex] ) )
            level.spikelist[level.spikelistindex] delete();
    }

    level.spikelist[level.spikelistindex] = self;
    level.spikelistindex = ( level.spikelistindex + 1 ) % var_0;
}

idletargetmoverexplosive( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_1 = anglestoforward( self.angles );

    for (;;)
    {
        if ( maps\mp\_utility::isreallyalive( self ) && !maps\mp\_utility::isusingremote() && anglestoforward( self.angles ) != var_1 )
        {
            var_1 = anglestoforward( self.angles );
            var_2 = self.origin + var_1 * -100 + ( 0, 0, 40 );
            var_0 _meth_82AE( var_2, 0.5 );
        }

        wait 0.5;
    }
}

explosivedrone_enemy_lightfx()
{
    self endon( "death" );
    self.owner endon( "faux_spawn" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) && issentient( var_1 ) && issentient( self ) && var_1.team != self.team )
        {
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
        }
    }
}

explosivedrone_friendly_lightfx()
{
    self endon( "death" );
    self.owner endon( "faux_spawn" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) && issentient( var_1 ) && issentient( self ) && var_1.team == self.team )
        {
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1 );
        }
    }

    thread watchconnectedplayfxexplosive();
    thread watchjoinedteamplayfxexplosive();
}

drone_thrusterfxexplosive()
{
    self endon( "death" );
    self endon( "disconnect" );
    self.owner endon( "faux_spawn" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            thread drone_thrusterfx_bottom_threaded( var_1 );
            thread drone_thrusterfx_side_threaded( var_1 );
        }

        wait 1.1;
    }
}

drone_thrusterfx_side_threaded( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self.owner endon( "faux_spawn" );
    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_X_nY_Z", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_X_nY_nZ", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_nX_nY_Z", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_nX_nY_nZ", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_nX_Y_nZ", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_nX_Y_Z", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_X_Y_Z", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_X_Y_nZ", var_0 );
}

drone_thrusterfx_bottom_threaded( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self.owner endon( "faux_spawn" );
    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_engine_distort ) )
        playfxontagforclients( level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_engine_distort ) )
        playfxontagforclients( level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_engine_distort ) )
        playfxontagforclients( level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_engine_distort ) )
        playfxontagforclients( level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_engine_distort ) )
        playfxontagforclients( level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_position_thruster ) )
        playfxontagforclients( level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level.explosivedronesettings.fxid_engine_distort ) )
        playfxontagforclients( level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0 );
}

watchconnectedplayfxexplosive()
{
    self endon( "death" );
    self.owner endon( "faux_spawn" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 waittill( "spawned_player" );

        if ( isdefined( var_0 ) && var_0.team == self.team )
        {
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0 );
        }
    }
}

watchjoinedteamplayfxexplosive()
{
    self endon( "death" );
    self.owner endon( "faux_spawn" );

    for (;;)
    {
        level waittill( "joined_team", var_0 );
        var_0 waittill( "spawned_player" );

        if ( isdefined( var_0 ) && var_0.team == self.team )
        {
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0 );
        }
    }
}

startexplosivedrone( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 thread explosivedrone_followtarget();
    var_0 thread createkillcamentity();

    if ( isdefined( var_0.type ) )
    {
        if ( var_0.type == "explosive_drone" )
            var_0 thread checkforexplosivegoalexplosive();
    }
}

checkforexplosivegoalexplosive()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    var_0 = gettime();
    thread blowupatendoftrackingtime( var_0 );
}

blowupatendoftrackingtime( var_0 )
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );

    while ( gettime() - var_0 < 3000 )
        waitframe();

    if ( isdefined( self ) )
    {
        self notify( "exploding" );
        thread blowupdronesequenceexplosive();
    }
}

blowupdronesequenceexplosive()
{
    var_0 = undefined;

    if ( isdefined( self ) )
    {
        if ( isdefined( self.owner ) )
            var_0 = self.owner;

        self playsound( level.explosivedronesettings.sound_lock );
        wait 0.5;
    }

    if ( isdefined( self ) )
    {
        self playsound( "wpn_explosive_drone_exp" );
        var_1 = anglestoup( self.angles );
        var_2 = anglestoforward( self.angles );
        playfx( level.explosivedronesettings.fxid_lethalexplode, self.origin, var_2, var_1 );

        if ( isdefined( var_0 ) )
            self entityradiusdamage( self.origin, 256, 130, 55, var_0, "MOD_EXPLOSIVE", "explosive_drone_mp" );
        else
            self entityradiusdamage( self.origin, 256, 130, 55, undefined, "MOD_EXPLOSIVE", "explosive_drone_mp" );

        self notify( "death" );
    }
}

turnondangerlightsexplosive()
{
    if ( isdefined( self ) )
    {

    }

    wait 0.05;

    if ( isdefined( self ) )
    {

    }

    wait 0.15;

    if ( isdefined( self ) )
        return;
}

explosivedrone_followtarget()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "exploding" );

    if ( !isdefined( self.owner ) )
    {
        thread explosivedrone_leave();
        return;
    }

    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self _meth_8283( self.followspeed, 10, 10 );
    self.previoustrackedplayer = self.owner;
    self.trackedplayer = undefined;

    for (;;)
    {
        if ( isdefined( self.stunned ) && self.stunned )
        {
            wait 0.5;
            continue;
        }

        if ( isdefined( self.owner ) && isalive( self.owner ) )
        {
            var_0 = self.maxtrackingrange * self.maxtrackingrange;
            var_1 = var_0;

            if ( !isdefined( self.trackedplayer ) || self.trackedplayer == self.owner )
            {
                foreach ( var_3 in level.players )
                {
                    if ( isdefined( var_3 ) && isalive( var_3 ) && var_3 != self.owner && ( !level.teambased || var_3.team != self.team ) && !var_3 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
                    {
                        var_4 = distancesquared( self.origin, var_3.origin );

                        if ( var_4 < var_1 )
                        {
                            var_1 = var_4;
                            self.trackedplayer = var_3;
                            thread watchplayerdeathdisconnectexplosive( var_3 );
                        }
                    }
                }
            }

            if ( !isdefined( self.trackedplayer ) )
                thread explosivedroneexplode();

            if ( isdefined( self.trackedplayer ) )
                explosivedrone_movetoplayer( self.trackedplayer );

            if ( self.trackedplayer != self.previoustrackedplayer )
            {
                stophighlightingplayerexplosive( self.previoustrackedplayer );
                self.previoustrackedplayer = self.trackedplayer;
            }
        }

        wait 1;
    }
}

watchplayerdeathdisconnectexplosive( var_0 )
{
    var_0 common_scripts\utility::waittill_any( "death", "disconnect", "faux_spawn", "joined_team" );

    if ( var_0.is_being_tracked == 1 )
        thread explosivedrone_leave();
    else
        self.trackedplayer = undefined;
}

explosivedrone_movetoplayer( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "explosiveDrone_moveToPlayer" );
    self endon( "explosiveDrone_moveToPlayer" );
    var_1 = 0;
    var_2 = 0;
    var_3 = 65;

    switch ( var_0 _meth_817C() )
    {
        case "stand":
            var_3 = 65;
            break;
        case "crouch":
            var_3 = 50;
            break;
        case "prone":
            var_3 = 22;
            break;
    }

    var_4 = ( var_2, var_1, var_3 );
    self _meth_83F9( var_0, var_4 );
    self.intransit = 1;
    thread explosivedrone_watchforgoal();
    thread explosivedrone_watchtargetdisconnect();
}

explosivedrone_stopmovement()
{
    self _meth_825B( self.origin, 1 );
    self.intransit = 0;
    self.inactive = 1;
}

explosivedrone_changeowner( var_0 )
{
    maps\mp\_utility::incrementfauxvehiclecount();
    var_1 = var_0 createexplosivedrone( 1, self.origin, self.angles );

    if ( !isdefined( var_1 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    if ( !isdefined( var_0.explosivedronearray ) )
        var_0.explosivedronearray = [];

    var_0.explosivedronearray[var_0.explosivedronearray.size] = var_1;
    var_0 thread startexplosivedrone( var_1 );

    if ( isdefined( level.explosivedronesettings.fxid_sparks ) )
    {

    }

    removeexplosivedrone();
    return 1;
}

explosivedrone_highlighttarget()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    if ( !isdefined( self.owner ) )
    {
        thread explosivedrone_leave();
        return;
    }

    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    self.lasertag = spawn( "script_model", self.origin );
    self.lasertag _meth_80B1( "tag_laser" );

    for (;;)
    {
        if ( isdefined( self.trackedplayer ) )
        {
            self.lasertag.origin = self gettagorigin( "tag_weapon" );
            var_0 = 20;
            var_1 = ( randomfloat( var_0 ), randomfloat( var_0 ), randomfloat( var_0 ) ) - ( 10, 10, 10 );
            var_2 = 65;

            switch ( self.trackedplayer _meth_817C() )
            {
                case "stand":
                    var_2 = 65;
                    break;
                case "crouch":
                    var_2 = 50;
                    break;
                case "prone":
                    var_2 = 22;
                    break;
            }

            self.lasertag.angles = vectortoangles( self.trackedplayer.origin + ( 0, 0, var_2 - 20 ) + var_1 - self.origin );
        }

        if ( isdefined( self.stunned ) && self.stunned )
        {
            wait 0.5;
            continue;
        }

        var_3 = undefined;

        if ( isdefined( self.trackedplayer ) )
        {
            var_4 = bullettrace( self.origin, self.trackedplayer.origin, 1, self );
            var_3 = var_4["entity"];
        }

        if ( isdefined( self.trackedplayer ) && self.trackedplayer != self.owner && isdefined( var_3 ) && var_3 == self.trackedplayer && distancesquared( self.origin, self.trackedplayer.origin ) < self.maxlaserrange * self.maxlaserrange )
        {
            if ( self.trackedplayer.is_being_tracked == 0 )
                starthighlightingplayerexplosive( self.trackedplayer );
        }
        else if ( isdefined( self.trackedplayer ) && self.trackedplayer.is_being_tracked == 1 )
            stophighlightingplayerexplosive( self.trackedplayer );

        wait 0.05;
    }
}

starthighlightingplayerexplosive( var_0 )
{
    self.lasertag _meth_80B2( "explosive_drone_laser" );
    playfxontag( level.explosivedronesettings.fxid_laser_glow, self.lasertag, "tag_laser" );

    if ( isdefined( level.explosivedronesettings.sound_lock ) )
        self playsound( level.explosivedronesettings.sound_lock );

    var_0 _meth_82A6( "specialty_radararrow", 1, 0 );

    if ( var_0.is_being_tracked == 0 )
    {
        var_0.is_being_tracked = 1;
        var_0.trackedbyplayer = self.owner;
    }
}

stophighlightingplayerexplosive( var_0 )
{
    if ( isdefined( self.lasertag ) )
    {
        self.lasertag _meth_80B3();
        stopfxontag( level.explosivedronesettings.fxid_laser_glow, self.lasertag, "tag_laser" );
    }

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( level.explosivedronesettings.sound_lock ) )
            self _meth_80AB();

        if ( var_0 _meth_82A7( "specialty_radararrow", 1 ) )
            var_0 _meth_82A9( "specialty_radararrow", 1 );

        var_0 notify( "player_not_tracked" );
        var_0.is_being_tracked = 0;
        var_0.trackedbyplayer = undefined;
    }
}

onexplosiveplayerconnect()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.is_being_tracked = 0;

        foreach ( var_0 in level.players )
        {
            if ( !isdefined( var_0.is_being_tracked ) )
                var_0.is_being_tracked = 0;
        }
    }
}

explosivedrone_watchforgoal()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "explosiveDrone_watchForGoal" );
    self endon( "explosiveDrone_watchForGoal" );
    var_0 = common_scripts\utility::waittill_any_return( "goal", "near_goal", "hit_goal" );
    self.intransit = 0;
    self.inactive = 0;
    self notify( "hit_goal" );
}

explosivedrone_watchdeath()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );
    thread explosivedronedestroyed();
}

explosivedrone_watchtimeout()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    var_0 = level.explosivedronetimeout;

    if ( self.type == "explosive_drone" )
        var_0 = level.explosivedronetimeout;

    wait(var_0);
    thread explosivedrone_leave();
}

explosivedrone_watchownerloss()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "owner_gone" );
    thread explosivedrone_leave();
}

explosivedrone_watchownerdeath()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    for (;;)
    {
        self.owner waittill( "death" );
        thread explosivedrone_leave();
    }
}

explosivedrone_watchtargetdisconnect()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "explosiveDrone_watchTargetDisconnect" );
    self endon( "explosiveDrone_watchTargetDisconnect" );
    self.trackedplayer waittill( "disconnect" );
    stophighlightingplayerexplosive( self.trackedplayer );
    explosivedrone_movetoplayer( self.owner );
}

explosivedrone_watchroundend()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level common_scripts\utility::waittill_any( "round_end_finished", "game_ended" );
    thread explosivedrone_leave();
}

explosivedrone_watchhostmigration()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level waittill( "host_migration_begin" );
    stophighlightingplayerexplosive( self.trackedplayer );
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    thread explosivedrone_changeowner( self.owner );
}

explosivedrone_leave()
{
    self endon( "death" );
    self notify( "leaving" );
    stophighlightingplayerexplosive( self.trackedplayer );
    explosivedroneexplode();
}

onexplosivedronedeath( var_0, var_1, var_2, var_3 )
{
    self notify( "death" );
}

explosivedrone_grenade_watchdisable()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    self.stunned = 0;

    for (;;)
    {
        self waittill( "emp_damage", var_0, var_1 );
        thread explosivedrone_grenade_stunned();
    }
}

explosivedrone_watchdisable()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage", var_0, var_1 );
        thread explosivedrone_stunned();
    }
}

explosivedrone_grenade_stunned()
{
    self notify( "explosiveDrone_stunned" );
    self endon( "explosiveDrone_stunned" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    explosivedrone_grenade_stunbegin();
    wait 10.0;
    explosivedrone_grenade_stunend();
}

explosivedrone_stunned()
{
    self notify( "explosiveDrone_stunned" );
    self endon( "explosiveDrone_stunned" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    explosivedrone_stunbegin();
    wait 10.0;
    explosivedrone_stunend();
}

explosivedrone_grenade_stunbegin()
{
    if ( self.stunned )
        return;

    self.stunned = 1;

    if ( isdefined( level.explosivedronesettings.fxid_sparks ) )
        playfxontag( level.explosivedronesettings.fxid_sparks, self, "TAG_BEACON" );
}

explosivedrone_stunbegin()
{
    if ( self.stunned )
        return;

    self.stunned = 1;

    if ( isdefined( level.explosivedronesettings.fxid_sparks ) )
        playfxontag( level.explosivedronesettings.fxid_sparks, self, "TAG_BEACON" );

    thread stophighlightingplayerexplosive( self.trackedplayer );
    self.trackedplayer = undefined;
    self.previoustrackedplayer = self.owner;
    thread explosivedrone_stopmovement();
}

explosivedrone_grenade_stunend()
{
    if ( isdefined( level.explosivedronesettings.fxid_sparks ) )
        killfxontag( level.explosivedronesettings.fxid_sparks, self, "TAG_BEACON" );

    self.stunned = 0;
    self.inactive = 0;
}

explosivedrone_stunend()
{
    if ( isdefined( level.explosivedronesettings.fxid_sparks ) )
        killfxontag( level.explosivedronesettings.fxid_sparks, self, "TAG_BEACON" );

    self.stunned = 0;
    self.inactive = 0;
}

explosivedronedestroyed()
{
    if ( !isdefined( self ) )
        return;

    stophighlightingplayerexplosive( self.trackedplayer );
    explosivedrone_stunend();
    explosivedroneexplode();
}

explosivedroneexplode()
{
    if ( isdefined( level.explosivedronesettings.fxid_explode ) )
        playfx( level.explosivedronesettings.fxid_explode, self.origin );

    if ( isdefined( level.explosivedronesettings.sound_explode ) )
        self playsound( level.explosivedronesettings.sound_explode );

    self notify( "exploding" );
    removeexplosivedrone();
}

deleteexplosivedrone()
{
    if ( isdefined( self.attractor ) )
        missile_deleteattractor( self.attractor );

    removekillcamentity();
    self delete();
}

removeexplosivedrone()
{
    maps\mp\_utility::decrementfauxvehiclecount();

    if ( isdefined( self.owner ) && isdefined( self.owner.explosivedrone ) )
        self.owner.explosivedrone = undefined;

    deleteexplosivedrone();
}

addtoexplosivedronelist()
{
    level.explosivedrones[self _meth_81B1()] = self;
}

removefromexplosivedronelistondeath()
{
    var_0 = self _meth_81B1();
    self waittill( "death" );
    level.explosivedrones[var_0] = undefined;
    level.explosivedrones = common_scripts\utility::array_removeundefined( level.explosivedrones );
}

exceededmaxexplosivedrones()
{
    if ( isdefined( level.explosivedrones ) && level.explosivedrones.size >= maps\mp\_utility::maxvehiclesallowed() )
        return 1;
    else
        return 0;
}

explosivedroneproximitytrigger()
{
    self endon( "mine_destroyed" );
    self endon( "mine_selfdestruct" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "faux_spawn" );
    wait 3;

    if ( isdefined( self ) && isdefined( self.explosivedrone ) )
    {
        var_0 = self.explosivedrone gettagorigin( "TAG_BEACON" ) - self gettagorigin( "TAG_BEACON" ) + ( 0, 0, 10 );

        if ( level.teambased )
            maps\mp\_entityheadicons::setteamheadicon( self.owner.team, var_0, "TAG_BEACON" );
        else
            maps\mp\_entityheadicons::setplayerheadicon( self.owner, var_0, "TAG_BEACON" );

        var_1 = spawn( "trigger_radius", self.origin + ( 0, 0, -96 ), 0, 192, 192 );
        var_1.owner = self;
        thread explosivedronedeletetrigger( var_1 );
        thread watchforpickup( var_1 );
        var_2 = undefined;

        while ( isdefined( self ) && isdefined( self.explosivedrone ) )
        {
            var_1 waittill( "trigger", var_2 );

            if ( !isdefined( var_2 ) )
            {
                wait 0.1;
                continue;
            }

            if ( var_2 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
            {
                wait 0.1;
                continue;
            }

            if ( isdefined( self.explosivedrone ) && !var_2 _meth_81D8( self.explosivedrone gettagorigin( "TAG_BEACON" ), self.explosivedrone ) )
            {
                wait 0.1;
                continue;
            }

            if ( isdefined( self.explosivedrone ) )
            {
                var_3 = self.explosivedrone gettagorigin( "TAG_BEACON" );
                var_4 = var_2 _meth_80A8();

                if ( !bullettracepassed( var_3, var_4, 0, self.explosivedrone ) )
                {
                    wait 0.1;
                    continue;
                }
            }

            if ( maps\mp\_utility::isreallyalive( var_2 ) && var_2 != self.owner && ( !level.teambased || var_2.team != self.owner.team ) && !self.stunned )
                var_2 tryuseexplosivedrone( self );
        }
    }
}

explosivedronedeletetrigger( var_0 )
{
    common_scripts\utility::waittill_any( "mine_triggered", "mine_destroyed", "mine_selfdestruct", "death" );

    if ( isdefined( self.entityheadicon ) )
    {
        self notify( "kill_entity_headicon_thread" );
        self.entityheadicon destroy();
    }

    var_0 delete();
}

showdebugradius( var_0 )
{
    var_1 = spawnfx( level.explosivedronesettings.dome, var_0.origin );
    triggerfx( var_1 );
    self waittill( "death" );
    var_1 delete();
}

endonplayerspawn()
{
    self.owner common_scripts\utility::waittill_any( "spawned_player", "faux_spawn", "delete_explosive_drones" );
    explosivegrenadedeath();
}

monitorspikedestroy()
{
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "faux_spawn" );
    common_scripts\utility::waittill_any( "mine_selfdestruct" );
    explosivegrenadedeath();
}

monitorheaddestroy()
{
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "faux_spawn" );

    while ( isdefined( self.explosivedrone ) )
        wait 0.15;

    if ( isdefined( self ) )
    {
        self playsound( "wpn_explosive_drone_exp" );
        var_0 = anglestoup( self.angles );
        var_1 = anglestoforward( self.angles );
        playfx( level.explosivedronesettings.fxid_lethalexplode, self.origin, var_1, var_0 );
        self entityradiusdamage( self.origin, 256, 130, 55, self.owner, "MOD_EXPLOSIVE", "explosive_drone_mp" );
        self notify( "death" );
    }

    explosivegrenadedeath();
}

startgrenadelightfx()
{
    self endon( "death" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    var_0 = 0.6;

    while ( isdefined( self.explosivedrone ) )
    {
        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2 ) && issentient( var_2 ) && var_2.team == self.team && isdefined( self.explosivedrone ) )
                thread fxblink( level.explosivedronesettings.fxid_friendly_light, self.explosivedrone, "TAG_BEACON", var_2 );

            if ( isdefined( var_2 ) && issentient( var_2 ) && var_2.team != self.team && isdefined( self.explosivedrone ) )
                thread fxblink( level.explosivedronesettings.fxid_enemy_light, self.explosivedrone, "TAG_BEACON", var_2 );
        }

        wait(var_0);
    }
}

fxblink( var_0, var_1, var_2, var_3 )
{
    for ( var_4 = 0; var_4 <= 4 && isdefined( var_1 ); var_4++ )
    {
        if ( isdefined( var_3 ) && isdefined( var_1 ) && isdefined( self.stunned ) && !self.stunned )
        {
            playfxontagforclients( var_0, var_1, var_2, var_3 );
            wait 0.15;
        }
    }
}

watchforstick()
{
    self endon( "death" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    var_0 = undefined;
    var_0 = common_scripts\utility::waittill_any_return_parms( "missile_stuck", "mp_exo_repulsor_repel" );

    while ( !isdefined( self.explosivedrone ) )
        waitframe();

    if ( isdefined( var_0[1] ) )
    {
        var_1 = var_0[1].script_stay_drone;

        if ( var_0[1].classname == "script_model" && !( isdefined( var_1 ) && var_1 == 1 ) )
        {
            self playsound( "wpn_explosive_drone_exp" );
            var_2 = anglestoup( self.angles );
            var_3 = anglestoforward( self.angles );
            playfx( level.explosivedronesettings.fxid_lethalexplode, self.origin, var_3, var_2 );
            self entityradiusdamage( self.origin, 256, 130, 55, self.owner, "MOD_EXPLOSIVE", "explosive_drone_mp" );
            thread explosivegrenadedeath();
        }
    }

    if ( isdefined( self ) )
    {
        self.explosivedrone setcontents( self.explosivedrone.oldcontents );
        thread explosivedroneproximitytrigger();
        thread endonplayerspawn();
        thread explosivedrone_grenade_watchdisable();
        thread startgrenadelightfx();
        thread maps\mp\gametypes\_damage::setentitydamagecallback( 100, undefined, ::explosivegrenadedeath, undefined, 0 );
        self.explosivedrone thread maps\mp\gametypes\_damage::setentitydamagecallback( 100, undefined, ::explosiveheaddeath, undefined, 0 );
        thread maps\mp\gametypes\_weapons::stickyhandlemovers( "mine_selfdestruct" );
    }
}

createkillcamentity()
{
    var_0 = ( 0, 0, 0 );
    self.killcament = spawn( "script_model", self.origin );
    self.killcament _meth_834D( "explosive" );
    self.killcament _meth_804D( self, "TAG_THRUSTER_BTM", var_0, ( 0, 0, 0 ) );
    self.killcament setcontents( 0 );
    self.killcament.starttime = gettime();
}

removekillcamentity()
{
    if ( isdefined( self.killcament ) )
        self.killcament delete();
}

watchforpickup( var_0 )
{
    self.owner endon( "disconnect" );
    self.owner endon( "faux_spawn" );
    level endon( "game_ended" );
    self endon( "death" );
    self.owner endon( "death" );
    self.explosivedrone makeusable();
    self.explosivedrone _meth_80DB( &"MP_PICKUP_EXPLOSIVE_DRONE" );
    self.explosivedrone _meth_849B( 1 );
    var_1 = getdvarfloat( "player_useRadius", 128 );
    var_1 *= var_1;

    for (;;)
    {
        if ( !isdefined( self ) || !isdefined( var_0 ) )
            break;

        var_2 = isdefined( self.explosivedrone ) && distancesquared( self.owner _meth_80A8(), self.explosivedrone.origin ) <= var_1;

        if ( self.owner _meth_80A9( var_0 ) && var_2 )
        {
            var_3 = 0;

            while ( self.owner usebuttonpressed() )
            {
                if ( !maps\mp\_utility::isreallyalive( self.owner ) )
                    break;

                if ( !self.owner _meth_80A9( var_0 ) )
                    break;

                if ( self.owner _meth_82EE() || self.owner _meth_82EF() || isdefined( self.owner.throwinggrenade ) )
                    break;

                if ( self.owner _meth_8342() || self.owner maps\mp\_utility::isusingremote() )
                    break;

                if ( isdefined( self.owner.iscapturingcrate ) && self.owner.iscapturingcrate )
                    break;

                if ( isdefined( self.owner.empgrenaded ) && self.owner.empgrenaded )
                    break;

                if ( isdefined( self.owner.using_remote_turret ) && self.owner.using_remote_turret )
                    break;

                var_3 += 0.05;

                if ( var_3 > 0.75 )
                {
                    self.owner _meth_82F7( self.weaponname, self.owner _meth_82F9( self.weaponname ) + 1 );
                    self.explosivedrone deleteexplosivedrone();
                    self delete();
                    break;
                }

                waitframe();
            }
        }

        waitframe();
    }
}
