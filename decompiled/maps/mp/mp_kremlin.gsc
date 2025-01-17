// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::kremlin_callbackstartgametype;
    maps\mp\mp_kremlin_precache::main();
    maps\createart\mp_kremlin_art::main();
    maps\mp\mp_kremlin_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_kremlin_lighting::main();
    maps\mp\mp_kremlin_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_kremlin" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.ospvisionset = "mp_kremlin_osp";
    level.osplightset = "mp_kremlin_osp";
    level.dronevisionset = "mp_kremlin_drone";
    level.dronelightset = "mp_kremlin_drone";
    level.warbirdvisionset = "mp_kremlin_warbird";
    level.warbirdlightset = "mp_kremlin_warbird";
    map_restart( "krem_killstreak_mine_close" );
    map_restart( "krem_killstreak_mine_closed_idle" );
    map_restart( "krem_killstreak_mine_open" );
    map_restart( "krem_killstreak_mine_open_idle" );
    level.orbitalsupportoverridefunc = ::kremlinpaladinoverrides;
    thread mine_init();
    level dynamicevent_init_sound();
    level dynamicevent_init();
    level thread maps\mp\_dynamic_events::dynamicevent( ::startdynamicevent, ::resetdynamicevent, ::enddynamicevent );

    if ( level.nextgen )
        thread set_walker_tank_anims();

    level thread resetuplinkballoutofbounds();
    level.airstrikeoverrides = spawnstruct();
    level.airstrikeoverrides.spawnheight = 600;

    if ( level.nextgen )
        thread scriptpatchclip();
}

kremlin_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

kremlinpaladinoverrides()
{
    level.orbitalsupportoverrides.spawnanglemin = 30;
    level.orbitalsupportoverrides.spawnanglemax = 120;
    level.orbitalsupportoverrides.spawnheight = 7000;
    level.orbitalsupportoverrides.spawnradius = 5000;
    level.orbitalsupportoverrides.leftarc = 45;
    level.orbitalsupportoverrides.rightarc = 45;
    level.orbitalsupportoverrides.toparc = -32;
    level.orbitalsupportoverrides.bottomarc = 80;
}

set_walker_tank_anims()
{
    var_0 = getent( "walker_tank_south_1", "targetname" );
    var_0.animname = "krem_walker_tank_south01";
    var_0.animtime = 54.2;
    var_1 = getent( "walker_tank_north_1", "targetname" );
    var_1.animname = "krem_walker_tank_north01";
    var_1.animtime = 93.36;
    var_2 = getent( "walker_tank_north_2", "targetname" );
    var_2.animname = "krem_walker_tank_north02";
    var_2.animtime = 93.36;
    var_3 = getent( "walker_tank_west_1", "targetname" );
    var_3.animname = "krem_walker_tank_west01";
    var_3.animtime = 111;
    var_4 = [ var_0, var_1, var_2, var_3 ];

    foreach ( var_6 in var_4 )
        var_6 hide();

    var_1 thread sequence_walker_tank_anims();
    wait 10;
    var_3 thread sequence_walker_tank_anims();
}

sequence_walker_tank_anims()
{
    level endon( "game_ended" );

    for (;;)
    {
        play_walker_tank_anims();
        wait 10;
    }
}

play_walker_tank_anims()
{
    self _meth_8279( self.animname );
    self show();
    wait(self.animtime);
    self hide();
}

mine_init()
{
    level.minesettings = [];
    level.minesettings["mine"] = spawnstruct();
    level.minesettings["mine"].weaponinfo = "iw5_dlcgun12loot1_mp";
    level.minesettings["mine"].modelbase = "krm_mine";
    level.minesettings["mine"].animationactivate = "krem_killstreak_mine_open";
    level.minesettings["mine"].animationdeactivate = "krem_killstreak_mine_close";
    level.minesettings["mine"].animationidleactive = "krem_killstreak_mine_open_idle";
    level.minesettings["mine"].animationidleinactive = "krem_killstreak_mine_closed_idle";
    level.minesettings["mine"].lifespan = 90.0;
    level.minesettings["mine"].graceperiod = 0.2;
    level.minesettings["mine"].modelexplosive = "ims_scorpion_explosive_iw6";
    level.minesettings["mine"].tagexplosive1 = "tag_explosive1";
    level.minesettings["mine"].team = "neutral";
    level.minesettings["mine"].eventstartcountdown = 6;
    level.minesettings["mine"].eventduration = 60;
    level.minesettings["mine"].eventdisableduration = 1;
    level.minesettings["mine"].attackcooldown = 2;
    level.minesettings["mine"].empdisableduration = 10;

    if ( level.currentgen )
        level.minesettings["mine"].collision = getent( "mineField_mineCollision", "targetname" );

    level.minekillcamoffset = ( 0, 0, 12 );
    level._effect["mine_antenna_light_mp"] = loadfx( "vfx/map/mp_kremlin/krem_light_detonator_blink" );
    level._effect["mine_emp_disable_fx"] = loadfx( "vfx/sparks/emp_drone_damage" );
}

dynamicevent_init_sound()
{
    level.minesoundactivatealarm = "mp_kre_mine_warning";
    level.minesoundactivatemine = "mp_kre_mine_activate";
    level.minesoundlaunchmine = "mp_kre_mine_popup";
}

dynamicevent_init()
{
    level endon( "game_ended" );
    maps\mp\_dynamic_events::setdynamiceventstartpercent( 0.5 );
    setdvar( "scr_dynamic_event_start_perc", level.dynamicevent["start_percent"] );
    level.minetype = "mine";
    thread minefielddeploy();
    level.cancelbadminefieldspawns = 0;
    level.mineeventcomplete = 0;
}

minefielddeploy()
{
    level endon( "game_ended" );
    level.minelist = [];
    level.minespawnlist = common_scripts\utility::getstructarray( "mineField_mineLoc", "targetname" );
    common_scripts\utility::array_randomize( level.minespawnlist );

    foreach ( var_1 in level.minespawnlist )
        createmine( var_1 );
}

startdynamicevent()
{
    level endon( "game_ended" );
    level notify( "minefield_beginActivation" );
    thread handleminefieldsettimer();
    thread minefieldsetactive();
    thread minefieldsetinactive();
    thread minefieldareafx();
}

resetdynamicevent()
{
    if ( !isdefined( level.mineeventcomplete ) || !level.mineeventcomplete )
        level waittill( "minefield_complete" );

    wait 1;
    level.cancelbadminefieldspawns = 0;
    level.mineeventcomplete = 0;
}

debugmineactivatewarning()
{
    level endon( "game_ended" );
    iprintlnbold( "Warning: Mine Field Active in 5 seconds..." );
    wait 2;
    iprintlnbold( "4..." );
    wait 1;
    iprintlnbold( "3..." );
    wait 1;
    iprintlnbold( "2..." );
    wait 1;
    iprintlnbold( "1..." );
    wait 1;
    iprintlnbold( "Mine Field Active" );
}

debugminedectivatewarning()
{
    level endon( "game_ended" );
    iprintlnbold( "Kremlin Defense Field is now deactive" );
}

enddynamicevent()
{
    level endon( "game_ended" );
    thread minefieldsetinactive();
}

createmine( var_0 )
{
    var_1 = level.minetype;
    var_2 = spawn( "script_model", var_0.origin );
    var_2 _meth_80B1( level.minesettings[var_1].modelbase );
    var_2.scale = 3;
    var_2.health = 1000;
    var_2.angles = ( 0, 0, 0 );

    if ( isdefined( var_0.angles ) )
        var_2.angles = var_0.angles;

    var_2.minetype = level.minetype;
    var_2.team = level.minesettings["mine"].team;
    var_2.shouldsplash = 0;
    var_2.attackradius = var_0.radius;
    var_2.attackheight = var_0.height;

    if ( var_0.origin == ( -204.3, 893.5, 122.9 ) )
        var_2.attackheight = 80;

    var_2.animationactivate = level.minesettings[var_2.minetype].animationactivate;
    var_2.animationdeactivate = level.minesettings[var_2.minetype].animationdeactivate;
    var_2.animationidleactive = level.minesettings[var_2.minetype].animationidleactive;
    var_2.animationidleinactive = level.minesettings[var_2.minetype].animationidleinactive;

    if ( isdefined( var_2.animationidleinactive ) )
        var_2 _meth_8279( var_2.animationidleinactive );

    if ( level.nextgen )
    {
        var_3 = var_0.target;
        var_2.minecollision = getent( var_3, "targetname" );
    }

    var_2.explosive = spawn( "script_model", var_2 gettagorigin( level.minesettings[var_2.minetype].tagexplosive1 ) );
    var_2.explosive _meth_80B1( level.minesettings[var_2.minetype].modelexplosive );
    var_2.explosive.tag = level.minesettings[var_2.minetype].tagexplosive1;
    var_2.explosive _meth_804D( var_2 );
    var_2.explosive.isenvironmentweapon = 1;
    var_2.script_stay_drone = 1;

    if ( level.nextgen )
    {
        var_2.explosive.killcament = spawn( "script_model", var_2.explosive.origin + level.minekillcamoffset );
        var_2.explosive.killcament _meth_834D( "explosive" );
    }

    var_2 _meth_82C0( 0 );
    level.minelist = common_scripts\utility::add_to_array( level.minelist, var_2 );
    var_2.activateoffsettime = level.minelist.size * 0.1;
    return var_2;
}

reload_mine()
{
    if ( isdefined( self.explosive ) )
    {
        self.explosive.fired = undefined;
        self.explosive.origin = self gettagorigin( level.minesettings[self.minetype].tagexplosive1 );
        self.explosive.angles = ( 0, 0, 0 );
        self.explosive _meth_804D( self );

        if ( level.nextgen )
            self.explosive.killcament.origin = self.explosive.origin + level.minekillcamoffset;

        self.explosive show();
    }

    if ( level.currentgen && isdefined( self.targetplayer ) )
        self.targetplayer = undefined;
}

handleminefieldsettimer()
{
    level endon( "game_ended" );
    level waittill( "minefield_active" );

    if ( isdefined( level.minesettings["mine"].eventdisableduration ) && level.minesettings["mine"].eventdisableduration == 1 )
        return;

    wait(level.minesettings[level.minetype].eventduration);
    level notify( "minefield_beginDisable" );
}

minefieldsetactive()
{
    level endon( "game_ended" );
    level endon( "minefield_deactiavte_begin" );
    var_0 = getentarray( "mine_field_trigger", "targetname" );
    thread handleminefieldwarningsound();
    thread disconnectnodesslowly();

    if ( isdefined( level.minelist ) )
    {
        foreach ( var_2 in level.minelist )
            var_2 thread activateminewithdelay();
    }

    if ( level.currentgen )
        thread cg_minecollisionmoveup();

    level notify( "minefield_active" );
}

cg_minecollisionmoveup()
{
    var_0 = level.minelist.size * 0.1 + 2.2;
    wait(var_0);

    if ( isdefined( level.minesettings["mine"].collision ) )
        level.minesettings["mine"].collision _meth_82AE( level.minesettings["mine"].collision.origin + ( 0, 0, 30 ), 0.5 );
}

cg_minecollisionmovedown()
{
    if ( isdefined( level.minesettings["mine"].collision ) )
        level.minesettings["mine"].collision _meth_82AE( level.minesettings["mine"].collision.origin + ( 0, 0, -30 ), 0.5 );
}

activateminewithdelay()
{
    var_0 = level.minesettings[self.minetype].eventstartcountdown;

    if ( isdefined( self.activateoffsettime ) )
        wait(self.activateoffsettime);

    thread play_mine_open_anim();
    thread play_mine_fx();
    wait(var_0);
    thread mine_setactive();
}

minefieldsetinactive()
{
    level endon( "game_ended" );
    level waittill( "minefield_beginDisable" );
    var_0 = getentarray( "mine_field_trigger", "targetname" );

    foreach ( var_2 in var_0 )
        thread clearsetupsupportdropvolumes( var_2 );

    thread reconnectnodesslowly();

    if ( isdefined( level.minelist ) )
    {
        foreach ( var_5 in level.minelist )
            var_5 thread mine_setinactive();
    }

    if ( level.currentgen )
        thread cg_minecollisionmovedown();

    level.mineeventcomplete = 1;
    level notify( "minefield_complete" );
}

minefieldareafx()
{
    thread maps\mp\mp_kremlin_fx::laser_grid_a_fx();
    thread maps\mp\mp_kremlin_fx::laser_grid_b_fx();
}

mine_setactive()
{
    thread mine_handledamage();
    self _meth_82C0( 1 );
    self _meth_8388();
    var_0 = ( 0, 0, 20 );
    var_1 = ( 0, 0, 128 );
    var_2 = [];
    var_3 = self gettagorigin( level.minesettings[self.minetype].tagexplosive1 ) + var_0;
    var_2[0] = bullettrace( var_3, var_3 + var_1 - var_0, 0, self );
    var_4 = var_2[0];

    for ( var_5 = 0; var_5 < var_2.size; var_5++ )
    {
        if ( var_2[var_5]["position"][2] < var_4["position"][2] )
            var_4 = var_2[var_5];
    }

    self.attackheightpos = var_4["position"] - ( 0, 0, 20 );
    var_6 = spawn( "trigger_radius", self.origin, 0, self.attackradius, self.attackheight );
    self.attacktrigger = var_6;
    self.attackmovetime = distance( self.origin, self.attackheightpos ) / 350;
    thread mine_attacktargets();
}

mine_setinactive()
{
    self _meth_82C0( 0 );
    self _meth_813A();

    if ( isdefined( self.activateoffsettime ) )
        wait(self.activateoffsettime);

    thread play_mine_close_anim();

    if ( isdefined( self.attacktrigger ) )
        self.attacktrigger delete();

    self notify( "mine_deactivate" );
}

mine_attacktargets()
{
    level endon( "game_ended" );
    self endon( "mine_deactivate" );

    for (;;)
    {
        if ( !isdefined( self.attacktrigger ) )
            break;

        self.attacktrigger waittill( "trigger", var_0 );

        if ( isplayer( var_0 ) )
        {
            if ( isdefined( var_0 ) && var_0 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
                continue;

            if ( !maps\mp\_utility::isreallyalive( var_0 ) )
                continue;
        }
        else if ( isdefined( var_0.owner ) )
            continue;

        if ( !sighttracepassed( self.attackheightpos, var_0.origin + ( 0, 0, 50 ), 0, self ) || !sighttracepassed( self gettagorigin( level.minesettings[self.minetype].tagexplosive1 ) + ( 0, 0, 5 ), var_0.origin + ( 0, 0, 50 ), 0, self ) )
            continue;

        if ( level.currentgen )
        {
            self.targetplayer = var_0;
            var_1 = 0;
            var_2 = common_scripts\utility::array_remove( level.minelist, self );

            foreach ( var_4 in var_2 )
            {
                if ( isdefined( var_4.targetplayer ) && var_4.targetplayer == self.targetplayer )
                {
                    var_1 = 1;
                    self.targetplayer = undefined;
                    break;
                }
            }

            if ( var_1 == 1 )
                continue;
        }

        if ( isplayer( var_0 ) && var_0 maps\mp\_utility::_hasperk( "specialty_delaymine" ) )
        {
            var_0 notify( "triggered_mine" );
            wait(level.delayminetime);
        }
        else
            wait(level.minesettings[self.minetype].graceperiod);

        self playsound( level.minesoundactivatemine );

        if ( isdefined( self.explosive ) && !isdefined( self.explosive.fired ) )
            fire_sensor( self.explosive );

        wait(level.minesettings[self.minetype].attackcooldown);
        thread reload_mine();
    }
}

fire_sensor( var_0 )
{
    var_0.fired = 1;
    var_0 _meth_804F();
    var_0 _meth_82B7( 3600, self.attackmovetime );
    var_0 _meth_82AE( self.attackheightpos, self.attackmovetime, self.attackmovetime * 0.25, self.attackmovetime * 0.25 );

    if ( isdefined( var_0.killcament ) )
        var_0.killcament _meth_82AE( self.attackheightpos + level.minekillcamoffset, self.attackmovetime, self.attackmovetime * 0.25, self.attackmovetime * 0.25 );

    var_0 playsound( level.minesoundlaunchmine );
    var_0 waittill( "movedone" );
    var_0 _meth_856A( level.minesettings["mine"].weaponinfo );
    var_0 hide();
}

mine_handledamage()
{
    self endon( "mine_deactivate" );
    level endon( "game_ended" );
    self.health = 999999;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( isdefined( var_9 ) )
        {
            var_10 = maps\mp\_utility::strip_suffix( var_9, "_lefthand" );

            switch ( var_10 )
            {
                case "emp_grenade_var_mp":
                case "emp_grenade_mp":
                    thread mine_temporary_emp_disable();
                    break;
            }
        }

        self.health = 999999;
    }
}

mine_temporary_emp_disable()
{
    level endon( "game_ended" );
    self notify( "mine_emp" );
    self endon( "mine_emp" );

    if ( !isdefined( self.empdisable ) || self.empdisable == 0 )
    {
        self.empdisable = 1;

        if ( isdefined( self.attacktrigger ) )
            self.attacktrigger common_scripts\utility::trigger_off();

        playfxontag( common_scripts\utility::getfx( "mine_emp_disable_fx" ), self, "tag_origin" );
    }

    wait_for_emp_disable_done();
    stopfxontag( common_scripts\utility::getfx( "mine_emp_disable_fx" ), self, "tag_origin" );

    if ( isdefined( self.attacktrigger ) )
        self.attacktrigger common_scripts\utility::trigger_on();

    self.empdisable = 0;
    self notify( "emp_Disable_Complete" );
}

wait_for_emp_disable_done()
{
    self endon( "mine_deactivate" );
    var_0 = 0.75;
    wait(level.minesettings[self.minetype].empdisableduration - var_0);
    self notify( "emp_disable_almost_complete" );
    wait(var_0);
}

spawnsetup()
{
    level.dynamicspawns = ::getlistofgoodspawnpoints;
}

getlistofgoodspawnpoints( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.targetname ) || var_3.targetname == "" || var_3 isvalidspawn() == 1 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

isvalidspawn()
{
    if ( level.cancelbadminefieldspawns == 1 && self.targetname == "mineField_spawn" )
        return 0;

    return 1;
}

handleminefieldwarningsound()
{
    level endon( "game_ended" );
    var_0 = common_scripts\utility::getstructarray( "speaker_ent", "targetname" );
    var_1 = 0;

    for (;;)
    {
        if ( isdefined( var_0 ) )
        {
            foreach ( var_3 in var_0 )
                playsoundatpos( var_3.origin, level.minesoundactivatealarm );

            playsoundatpos( ( 0, 0, 0 ), level.minesoundactivatealarm );
        }

        wait 4;
        var_1 += 1;

        if ( var_1 > 2 )
            return;
    }
}

play_mine_open_anim()
{
    wait 2.2;
    thread maps\mp\mp_kremlin_fx::snow_puff_fx();

    if ( isdefined( self.animationactivate ) )
    {
        var_0 = 2.94;
        self _meth_8279( self.animationactivate );
        wait(var_0);
    }

    if ( level.nextgen )
        self.minecollision thread minecollisionmoveup();

    if ( isdefined( self.animationidleactive ) )
        self _meth_8279( self.animationidleactive );

    self notify( "mine_opened" );
}

play_mine_close_anim()
{
    if ( isdefined( self.empdisable ) && self.empdisable == 1 )
        self waittill( "emp_Disable_Complete" );

    if ( isdefined( self.animationdeactivate ) )
    {
        var_0 = 5.03;
        self _meth_8279( self.animationdeactivate );
        wait(var_0);
    }

    if ( level.nextgen )
        self.minecollision thread minecollisionmovedown();

    if ( isdefined( self.animationidleinactive ) )
        self _meth_8279( self.animationidleinactive );
}

minecollisionmoveup()
{
    self _meth_82AE( self.origin + ( 0, 0, 30 ), 0.5 );
}

minecollisionmovedown()
{
    self _meth_82AE( self.origin + ( 0, 0, -30 ), 0.5 );
}

play_mine_fx()
{
    level endon( "game_ended" );
    self waittill( "mine_opened" );
    var_0 = 1;
    self.mine_fx_on = 1;
    playfxontag( common_scripts\utility::getfx( "krem_mine_laser_origin_main" ), self, "tag_origin" );

    if ( level.nextgen )
    {
        var_1 = _func_2DF( common_scripts\utility::getfx( "mine_antenna_light_mp" ), self, "tag_fx", var_0, 0 );
        mine_fx_wait_for_end( var_1 );

        if ( isdefined( self.mine_fx_on ) && self.mine_fx_on == 1 )
        {
            killfxontag( common_scripts\utility::getfx( "krem_mine_laser_origin_main" ), self, "tag_origin" );

            if ( isdefined( var_1 ) )
                var_1 delete();

            self.mine_fx_on = 0;
            return;
        }
    }
    else
    {
        mine_fx_wait_for_end();

        if ( isdefined( self.mine_fx_on ) && self.mine_fx_on == 1 )
        {
            killfxontag( common_scripts\utility::getfx( "krem_mine_laser_origin_main" ), self, "tag_origin" );
            self.mine_fx_on = 0;
        }
    }
}

mine_fx_wait_for_end( var_0 )
{
    level endon( "minefield_complete" );
    self endon( "mine_deactivate" );

    if ( isdefined( level.mineeventcomplete ) && level.mineeventcomplete == 1 )
        return;

    for (;;)
    {
        if ( !isdefined( self.empdisable ) || self.empdisable == 0 )
            self waittill( "mine_emp" );

        if ( isdefined( var_0 ) )
            var_0 hide();

        killfxontag( common_scripts\utility::getfx( "krem_mine_laser_origin_main" ), self, "tag_origin" );
        self.mine_fx_on = 0;
        self waittill( "emp_disable_almost_complete" );

        if ( isdefined( var_0 ) )
            var_0 show();

        playfxontag( common_scripts\utility::getfx( "krem_mine_laser_origin_main" ), self, "tag_origin" );
        self.mine_fx_on = 1;
        common_scripts\utility::waittill_any( "emp_Disable_Complete", "mine_emp" );
    }
}

disconnectnodesslowly()
{
    var_0 = getnodearray( "minefield_node", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_0[var_1] _meth_8059();

        if ( var_1 % 50 == 0 )
            waitframe();
    }

    waitframe();
    var_2 = getnodearray( "minefield_node", "script_noteworthy" );

    for ( var_1 = 0; var_1 < var_2.size; var_1++ )
    {
        var_2[var_1] _meth_8059();

        if ( var_1 % 50 == 0 )
            waitframe();
    }
}

reconnectnodesslowly()
{
    var_0 = getnodearray( "minefield_node", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_0[var_1] _meth_805A();

        if ( var_1 % 50 == 0 )
            waitframe();
    }

    waitframe();
    var_2 = getnodearray( "minefield_node", "script_noteworthy" );

    for ( var_1 = 0; var_1 < var_2.size; var_1++ )
    {
        var_2[var_1] _meth_805A();

        if ( var_1 % 50 == 0 )
            waitframe();
    }
}

setupsupportdropvolumes( var_0 )
{
    while ( !isdefined( level.orbital_util_covered_volumes ) )
        waitframe();

    level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_0;

    while ( !isdefined( level.goliath_bad_landing_volumes ) )
        waitframe();

    level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_0;
}

clearsetupsupportdropvolumes( var_0 )
{
    while ( !isdefined( level.orbital_util_covered_volumes ) )
        waitframe();

    level.orbital_util_covered_volumes = common_scripts\utility::array_remove( level.orbital_util_covered_volumes, var_0 );

    while ( !isdefined( level.goliath_bad_landing_volumes ) )
        waitframe();

    level.goliath_bad_landing_volumes = common_scripts\utility::array_remove( level.goliath_bad_landing_volumes, var_0 );
}

resetuplinkballoutofbounds()
{
    level endon( "game_ended" );

    if ( level.gametype == "ball" )
    {
        while ( !isdefined( level.balls ) )
            wait 0.05;

        foreach ( var_1 in level.balls )
            var_1 thread watchcarryobjects();
    }
}

watchcarryobjects()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "dropped" );
        wait 0.1;
        thread monitorballstate();
        var_0 = common_scripts\utility::waittill_any_return( "pickup_object", "reset" );
    }
}

monitorballstate()
{
    self endon( "pickup_object" );
    self endon( "reset" );

    for (;;)
    {
        if ( isoutofbounds() )
        {
            thread maps\mp\gametypes\_gameobjects::returnhome();
            return;
        }

        wait 0.05;
    }
}

isoutofbounds()
{
    var_0 = getentarray( "object_out_of_bounds", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !self.visuals[0] _meth_80A9( var_0[var_1] ) )
            continue;

        return 1;
    }

    return 0;
}

scriptpatchclip()
{
    thread northgallerybigwindow();
    thread atriumsidewallstanding();
    thread westcourtyardvehiclebounds();
    thread bridgeledgewestside();
    thread atriumgrapplegap();
    thread southeasttreeledge();
    thread northwestgrappleintowall();
    thread northwestledgeoutsidetower();
    thread breachhovertowallstand();
}

breachhovertowallstand()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 2016, -862, 769 ), ( 0, 0, 0 ) );
    var_0 = 865;

    for ( var_1 = 0; var_1 < 11; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 1984, -830, var_0 ), ( 0, 0, 0 ) );
        var_0 += 128;
    }
}

northwestledgeoutsidetower()
{
    var_0 = 555.5;

    for ( var_1 = 0; var_1 < 12; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2099, 345, var_0 ), ( 0, 0, 0 ) );
        var_0 += 128;
    }
}

northgallerybigwindow()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1572, 1061, 736 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1572, 1273, 736 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1572, 1110, 728 ), ( 0, 0, -25.9002 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1572, 1224, 728 ), ( 180, 0, -25.9002 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1572, 1167, 775 ), ( 0, 0, 0 ) );
}

atriumsidewallstanding()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1258, -374, 429 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1258, -374, 685 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1258, -374, 941 ), ( 0, 270, 0 ) );
}

westcourtyardvehiclebounds()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( -44, 1440, 188 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 210, 1409, 188 ), ( 0, 256, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 458, 1347, 188 ), ( 0, 256, 0 ) );
}

bridgeledgewestside()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -364.5, 215, 209 ), ( 5, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -620.5, 217, 186 ), ( 5, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 236, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 169, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 105, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 41, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -23, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -87, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -151, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -215, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -279, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -343, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -407, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -471, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -535, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -599, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -663, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -727, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -791, 208, 303.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 105, 208, 357.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 41, 208, 352.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -23, 208, 347.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -87, 208, 342.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -151, 208, 336.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -215, 208, 329.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -279, 208, 321.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -343, 208, 315.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -407, 208, 313.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -471, 208, 306.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -535, 208, 298.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -599, 208, 295.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -663, 208, 288.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -727, 208, 282.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -791, 208, 277.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 256, 212, 236 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 512, 212, 236 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 262.344, 212, 280.126 ), ( 0, 270, 5 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 517.156, 212, 302.374 ), ( 0, 270, 5 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 158, 212, 402 ), ( 0, 270, 5 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 168.5, 212, 403 ), ( 0, 270, 5 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -160, 209, 288 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -144, 199, 333.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -176, 199, 333.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -208, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -240, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -272, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -304, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -336, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -368, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -400, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -432, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -464, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -496, 199.5, 269.55 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -528, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -560, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -592, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -624, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -656, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -688, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -720, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -752, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -784, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -816, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -848, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -880, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -912, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -944, 199.5, 269.5 ), ( 8, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -976, 199.5, 269.5 ), ( 8, 270, 0 ) );
}

atriumgrapplegap()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1264, 260, 801 ), ( 270, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1264, 4, 801 ), ( 270, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1264, -252, 801 ), ( 270, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1384, 260, 921 ), ( 360, 180, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1384, 4, 921 ), ( 360, 180, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1384, -252, 921 ), ( 360, 180, -180 ) );
}

southeasttreeledge()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 160 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 288 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 416 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 544 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 672 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 800 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 928 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 1056 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 1184 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 1312 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514, 1440 ), ( 0, 324, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 160 ), ( 0, 290.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 288 ), ( 0, 290.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 416 ), ( 0, 290.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 544 ), ( 0, 290.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 672 ), ( 0, 290.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 800 ), ( 0, 290.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 928 ), ( 0, 290.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 1056 ), ( 0, 290.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 1184 ), ( 0, 290.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 1312 ), ( 0, 290.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896, -566.5, 1440 ), ( 0, 290.9, 0 ) );
}

northwestgrappleintowall()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1698, 1823, 928 ), ( 0, 350.3, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1682, 1823, 928 ), ( 0, 350.3, 0 ) );
}
