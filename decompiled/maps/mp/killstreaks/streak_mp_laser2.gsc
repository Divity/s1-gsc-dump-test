// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    initlaserfx();
    initlasersound();
    initlaser();
    initlaserents();
    level.killstreakfuncs["mp_laser2"] = ::tryusemplaser;
    level.mapkillstreak = "mp_laser2";
    level.mapkillstreakpickupstring = &"MP_LASER2_MAP_KILLSTREAK_PICKUP";
    level.mapkillstreakdamagefeedbacksound = ::handledamagefeedbacksound;
    level.killstreak_laser_fxmode = 0;
    level.mapcustombotkillstreakfunc = ::setupbotsformapkillstreak;
}

setupbotsformapkillstreak()
{
    level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func( "mp_laser2", maps\mp\bots\_bots_ks::bot_killstreak_simple_use );
}

initlaserfx()
{
    level.laser_fx["beahm"] = loadfx( "vfx/muzzleflash/laser_wv_mp_laser" );
    level.laser_fx["beahm_smoke"] = loadfx( "vfx/muzzleflash/laser_wv_mp_laser_smoke" );
    level.laser_fx["laser_field1"] = loadfx( "vfx/map/mp_laser2/laser_core_lvl1" );
    level.laser_fx["laser_field1_cheap"] = loadfx( "vfx/map/mp_laser2/laser_core_lvl1_cheap" );
    level.laser_fx["laser_field2"] = loadfx( "vfx/map/mp_laser2/laser_core_lvl2" );
    level.laser_fx["laser_field2_cheap"] = loadfx( "vfx/map/mp_laser2/laser_core_lvl2_cheap" );
    level.laser_fx["laser_field3"] = loadfx( "vfx/map/mp_laser2/laser_core_lvl3" );
    level.laser_fx["laser_field2_up"] = loadfx( "vfx/map/mp_laser2/laser_core_up_lvl2" );
    level.laser_fx["laser_field3_up"] = loadfx( "vfx/map/mp_laser2/laser_core_up_lvl3" );
    level.laser_fx["laser_field1_up_slow"] = loadfx( "vfx/map/mp_laser2/laser_core_up_slow_lvl1" );
    level.laser_fx["laser_field2_down"] = loadfx( "vfx/map/mp_laser2/laser_core_down_lvl2" );
    level.laser_fx["laser_field3_down"] = loadfx( "vfx/map/mp_laser2/laser_core_down_lvl3" );
    level.laser_fx["laser_field1_down_slow"] = loadfx( "vfx/map/mp_laser2/laser_core_down_slow_lvl1" );
    level.laser_fx["laser_charge1"] = loadfx( "vfx/map/mp_laser2/laser_energy_fire_lvl1" );
    level.laser_fx["laser_beam_done1"] = loadfx( "vfx/map/mp_laser2/laser_energy_beam_done_lvl1" );
    level.laser_fx["hatch_light"] = loadfx( "vfx/lights/mp_laser2/light_lasercore_glow" );
    level.laser_fx["hatch_light_close"] = loadfx( "vfx/lights/mp_laser2/light_lasercore_glow_close" );
    level.laser_fx["laser_steam"] = loadfx( "vfx/map/mp_laser2/laser_core_steam" );
    level.laser_fx["laser_movement_sparks"] = loadfx( "vfx/sparks/machinery_scrape_sparks_looping" );
}

initlasersound()
{
    game["dialog"]["laser_deactivated"] = "laser_deactivated";
    game["dialog"]["laser_offline"] = "laser_offline";
    game["dialog"]["laser_strength"] = "laser_strength";
}

initlaser()
{
    var_0 = spawnstruct();
    var_0.health = 999999;
    var_0.maxhealth = 1000;
    var_0.burstmin = 20;
    var_0.burstmax = 120;
    var_0.pausemin = 0.15;
    var_0.pausemax = 0.35;
    var_0.sentrymodeon = "sentry_manual";
    var_0.sentrymodeoff = "sentry_offline";
    var_0.timeout = 45.0;
    var_0.spinuptime = 0.05;
    var_0.overheattime = 8.0;
    var_0.cooldowntime = 0.1;
    var_0.fxtime = 0.3;
    var_0.streakname = "sky_laser_turret";
    var_0.weaponinfo = "sky_laser_mp";
    var_0.useweaponinfo = "killstreak_laser2_mp";
    var_0.modelbase = "mp_sky_laser_turret_head";
    var_0.modeldestroyed = "mp_sky_laser_turret_head";
    var_0.headicon = 1;
    var_0.teamsplash = "used_mp_laser2";
    var_0.shouldsplash = 0;
    var_0.vodestroyed = "laser_deactivated";
    var_0.vooffline = "laser_offline";
    var_0.vopower = "laser_strength";
    var_0.coreshellshock = "default";

    if ( !isdefined( level.sentrysettings ) )
        level.sentrysettings = [];

    level.sentrysettings["sky_laser_turret"] = var_0;
    level.killstreakwieldweapons["mp_laser2_core"] = "mp_laser2";
}

initlaserents()
{
    var_0 = "sky_laser_turret";
    precacheitem( "mp_laser2_core" );
    precacheitem( "tablet_use_weapon_mp" );
    precachemodel( "lsr_laser_button_01_obj" );
    var_1 = getent( "lasergun", "targetname" );
    var_1 hide();
    var_1 laserlightfill();
    var_1.fxents = var_1 laser_initfxents();
    var_1.offswitch = var_1 laser_initoffswitch();
    var_1.lifter = getent( "laser_animated_prop", "targetname" );
    var_1.lifter.parts = getentarray( "lsr_animated_parts", "targetname" );
    var_1.lifter laserlightfill();
    var_1.moveorgs = var_1.lifter laser_initmoveorgs();
    var_1.lifter.animup = "lsr_laser_turret_up";
    var_1.lifter.animdown = "lsr_laser_turret_down";
    var_1.lifter.animidledown = "lsr_laser_turret_idle_down";
    var_1.lifter.animidleup = "lsr_laser_turret_idle_up";
    var_1.generatorhat = getent( "generator_hat", "targetname" );
    var_1.generatorhat.anim_up = "laser_button_on";
    var_1.generatorhat.anim_down = "laser_button_off";
    var_1.generatorhat.anim_idle_up = "laser_button_idle_on";
    var_1.generatorhat.anim_idle_down = "laser_button_idle_off";
    var_1.coredamagetrig = getent( "trig_lasercore_damage", "targetname" );
    var_1.coredeathtrig = getent( "trig_lasercore_death", "targetname" );
    var_1.firingdamagetrig = getent( "trig_laserfire_damage", "targetname" );
    var_1.ownerlist = [];
    var_1.collision = spawnstruct();
    var_1.collision.col_base = getent( "laser_collision_base", "targetname" );
    var_1.collision.col_head = getent( "laser_collision_head", "targetname" );
    var_1.flaps_top = getentarray( "lsr_flap_top", "targetname" );
    var_1.attachments = getentarray( "lsr_geo_attach", "targetname" );
    var_1.lifter linkgeototurret( var_1, 1 );
    var_2 = getentarray( "lsr_flap_bottom", "targetname" );
    var_1.flaps = common_scripts\utility::array_combine( var_1.flaps_top, var_2 );

    foreach ( var_4 in var_1.flaps )
    {
        var_4.col_base = getent( var_4.target, "targetname" );

        if ( isdefined( var_4.col_base ) )
            var_4.col_base.unresolved_collision_kill = 1;

        var_4.col_t = getent( var_4.col_base.target, "targetname" );

        if ( isdefined( var_4.col_t ) )
            var_4.col_t.unresolved_collision_kill = 1;

        var_4.col_base _meth_8446( var_4, "mainFlapBase" );
        var_4.col_t _meth_8446( var_4, "mainFlap_T" );
    }

    var_1.flap_animclose = "lsr_energy_hatch_close";
    var_1.flap_animidleclose = "lsr_energy_hatch_close_idle";
    var_1.flap_animopen = "lsr_energy_hatch_open";
    var_1.flap_animidleopen = "lsr_energy_hatch_open_idle";
    level.sentrygun = var_1;
    level.sentrygun laser_initsentry( var_0 );
}

linkgeototurret( var_0, var_1 )
{
    if ( var_1 == 0 )
    {
        var_0.collision.col_base _meth_804F();
        var_0.collision.col_head _meth_804F();

        foreach ( var_3 in var_0.flaps_top )
            var_3 _meth_804F();

        foreach ( var_6 in var_0.attachments )
            var_6 _meth_804F();

        foreach ( var_9 in var_0.lifter.parts )
            var_9 _meth_804F();
    }
    else if ( var_1 == 1 )
    {
        var_0.collision.col_base _meth_804D( self, "tag_origin" );
        var_0.collision.col_head _meth_804D( self, "tag_aim_pivot" );

        foreach ( var_3 in var_0.flaps_top )
            var_3 _meth_8446( self );

        foreach ( var_6 in var_0.attachments )
            var_6 _meth_8446( self );

        foreach ( var_9 in var_0.lifter.parts )
            var_9 _meth_8446( self );
    }
}

laser_initmoveorgs()
{
    var_0 = common_scripts\utility::getstruct( "laser_lifter_top_loc", "targetname" );
    var_1 = common_scripts\utility::getstruct( "laser_lifter_bottom_loc", "targetname" );
    var_2 = var_0.origin - var_1.origin;
    var_3 = [];
    var_3["bottom"] = self.origin;
    var_3["top"] = self.origin + var_2;
    return var_3;
}

laser_initfxents()
{
    var_0 = undefined;
    var_1 = common_scripts\utility::getstruct( "laser_core_fx_pos", "targetname" );
    var_0 = var_1 common_scripts\utility::spawn_tag_origin();
    var_0 show();
    var_2 = [];
    var_2["charge_up"] = var_0;
    return var_2;
}

laser_initoffswitch()
{
    var_0 = getent( "laser_use_trig", "targetname" );
    var_1 = getent( "laser_switch", "targetname" );
    var_2 = [];
    var_3 = spawn( "script_model", var_1.origin );
    var_3.angles = var_1.angles;
    var_3 _meth_80B1( "lsr_laser_button_01_obj" );
    var_3 hide();
    var_4 = [ var_3 ];
    var_5 = maps\mp\gametypes\_gameobjects::createuseobject( "none", var_0, var_4, ( 0, 0, 64 ) );
    var_5 maps\mp\gametypes\_gameobjects::allowuse( "none" );
    var_5 maps\mp\gametypes\_gameobjects::setusetime( 5 );
    var_5 maps\mp\gametypes\_gameobjects::setusetext( &"MP_LASERTURRET_HACKING" );
    var_5 maps\mp\gametypes\_gameobjects::setusehinttext( &"MP_LASERTURRET_HACK" );
    var_5.onbeginuse = ::laser_offswitch_onbeginuse;
    var_5.onenduse = ::laser_offswitch_onenduse;
    var_5.onuse = ::laser_offswitch_onuseplantobject;
    var_5.oncantuse = ::laser_offswitch_oncantuse;
    var_5.useweapon = "tablet_use_weapon_mp";
    var_5.attachdefault3pmodel = 0;
    var_2 = [];
    var_2["switch_obj"] = var_3;
    var_2["use_zone"] = var_5;
    return var_2;
}

laser_offswitch_onbeginuse( var_0 )
{

}

laser_offswitch_onenduse( var_0, var_1, var_2 )
{

}

laser_offswitch_onuseplantobject( var_0 )
{
    level.sentrygun endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( level.sentrygun.owner ) )
        level.sentrygun.owner thread maps\mp\_utility::leaderdialogonplayer( level.sentrysettings[level.sentrygun.sentrytype].vodestroyed );

    var_0 playsound( "mp_bomb_plant" );
    var_1 = level.sentrysettings["sky_laser_turret"].maxhealth;
    level.sentrygun notify( "damage", var_1, var_0, ( 0, 0, 0 ), ( 0, 0, 0 ), "MOD_UNKNOWN", undefined, undefined, undefined, undefined, "none" );
}

laser_offswitch_oncantuse( var_0 )
{

}

laser_initsentry( var_0 )
{
    self.sentrytype = var_0;
    self _meth_80B1( level.sentrysettings[self.sentrytype].modelbase );
    self.shouldsplash = 1;
    self _meth_82C0( 0 );
    self _meth_8138();
    self _meth_8156( 180 );
    self _meth_8155( 180 );
    self _meth_8157( 80 );
    self _meth_815A( -10 );
    self.laser_on = 0;
    self.lifter _meth_827B( self.lifter.animidledown );

    foreach ( var_2 in self.lifter.parts )
        var_2 _meth_827B( self.lifter.animidledown );

    var_4 = spawn( "script_model", self gettagorigin( "tag_laser" ) );
    var_4 _meth_804D( self );
    self.killcament = var_4;
    self.killcament _meth_834D( "explosive" );
    maps\mp\killstreaks\_autosentry::sentry_makesolid();
    self _meth_817A( 1 );
    laser_setinactive();
    thread laser_handledamage();
    thread laser_handlefakedeath();
    thread maps\mp\killstreaks\_autosentry::sentry_beepsounds();
}

laser_handledamage()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self.health = level.sentrysettings[self.sentrytype].health;
        self.maxhealth = level.sentrysettings[self.sentrytype].maxhealth;
        self.damagetaken = 0;
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( !maps\mp\gametypes\_weapons::friendlyfirecheck( self.owner, var_1 ) )
            continue;

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self.wasdamagedfrombulletpenetration = 1;

        switch ( var_9 )
        {
            case "stealth_bomb_mp":
            case "artillery_mp":
                var_0 *= 4;
                break;
            case "bomb_site_mp":
                var_0 = self.maxhealth;
                break;
        }

        if ( var_4 == "MOD_MELEE" )
            self.damagetaken += self.maxhealth;

        var_10 = var_0;

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "sentry" );

            if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                var_10 = var_0 * level.armorpiercingmod;
        }

        if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
            var_1.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "sentry" );

        if ( isdefined( var_9 ) )
        {
            var_11 = maps\mp\_utility::strip_suffix( var_9, "_lefthand" );

            switch ( var_11 )
            {
                case "remotemissile_projectile_mp":
                case "stinger_mp":
                case "ac130_40mm_mp":
                case "ac130_105mm_mp":
                    self.largeprojectiledamage = 1;
                    var_10 = self.maxhealth + 1;
                    break;
                case "stealth_bomb_mp":
                case "artillery_mp":
                    self.largeprojectiledamage = 0;
                    var_10 += var_0 * 4;
                    break;
                case "emp_grenade_var_mp":
                case "emp_grenade_mp":
                case "bomb_site_mp":
                    self.largeprojectiledamage = 0;
                    var_10 = self.maxhealth + 1;
                    break;
            }

            maps\mp\killstreaks\_killstreaks::killstreakhit( var_1, var_9, self );
        }

        self.damagetaken += var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_0, var_4, var_9 );

            if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
                level thread maps\mp\gametypes\_rank::awardgameevent( "kill", var_1, var_9, undefined, var_4 );

            if ( isdefined( self.owner ) )
                self.owner thread maps\mp\_utility::leaderdialogonplayer( level.sentrysettings[self.sentrytype].vodestroyed, undefined, undefined, self.origin );

            self notify( "fakedeath" );
        }
    }
}

laser_handlefakedeath()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "fakedeath" );
        laser_setinactive();
        self.ownerlist = [];
        self _meth_8103( undefined );
        self.samtargetent = undefined;

        if ( level.teambased )
            self.team = undefined;

        if ( isdefined( self.ownertrigger ) )
            self.ownertrigger delete();

        self playsound( "sentry_explode" );

        if ( isdefined( self.inuseby ) )
        {
            self.inuseby.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
            self.inuseby maps\mp\killstreaks\_autosentry::restoreperks();
            self.inuseby maps\mp\killstreaks\_autosentry::restoreweapons();
            self notify( "deleting" );
            wait 1.0;
            continue;
        }

        wait 1.5;
        self playsound( "sentry_explode_smoke" );

        for ( var_0 = 8; var_0 > 0; var_0 -= 0.4 )
            wait 0.4;
    }
}

tryusemplaser( var_0, var_1 )
{
    if ( !playercanuselaser() )
    {
        self iclientprintlnbold( &"MP_LASERTURRET_ENEMY" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    if ( isdefined( level.sentrygun.locked ) && level.sentrygun.locked == 1 )
    {
        self iclientprintlnbold( &"MP_LASERTURRET_BUSY" );
        return 0;
    }

    maps\mp\_matchdata::logkillstreakevent( "mp_laser2", self.origin );
    level.sentrygun laser_setowner( self );
    var_2 = level.sentrygun _meth_8066();

    if ( ( !isdefined( level.sentrygun.mode ) || level.sentrygun.mode == "off" ) && ( !isdefined( level.sentrygun.moving ) || level.sentrygun.moving == 0 ) )
        laser_setplacesentry( level.sentrygun, level.sentrygun.sentrytype );

    return 1;
}

playercanuselaser()
{
    if ( !isdefined( level.sentrygun ) )
        return 0;

    if ( level.teambased )
    {
        if ( isdefined( level.sentrygun.team ) && level.sentrygun.team != self.team )
            return 0;
    }
    else
    {
        foreach ( var_1 in level.sentrygun.ownerlist )
        {
            if ( isdefined( var_1 ) && var_1 != self )
                return 0;
        }
    }

    return 1;
}

laser_setowner( var_0 )
{
    self.owner = var_0;
    self.ownerlist = common_scripts\utility::array_add( self.ownerlist, var_0 );
    self _meth_8103( self.owner );
    self _meth_8105( 1, "sam_turret" );

    if ( level.teambased )
    {
        self.team = self.owner.team;
        self _meth_8135( self.team );
    }

    thread laser_handleownerdisconnect( var_0 );
    thread player_sentry_timeout( var_0 );

    if ( self.ownerlist.size > 1 )
        thread playlasercontainmentswap();
}

laser_handleownerdisconnect( var_0 )
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );
    var_0 common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self.ownerlist = common_scripts\utility::array_remove( self.ownerlist, var_0 );

    if ( var_0 != self.owner )
        thread stoplasercontainmentswap();
    else if ( var_0 == self.owner )
    {
        var_1 = getnextplayerinownerqueue( self.ownerlist );

        if ( isdefined( var_1 ) )
            laser_setowner( var_1 );
        else
            self notify( "fakedeath" );
    }
}

array_removefirstinqueue( var_0, var_1 )
{
    var_2 = [];
    var_3 = undefined;

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        if ( var_0[var_4] == var_1 )
            var_2[var_2.size] = var_4;
    }

    var_3 = var_2[var_2.size - 1];
    var_5 = [];

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        if ( var_4 != var_3 )
            var_5[var_5.size] = var_0[var_4];
    }

    return var_5;
}

getnextplayerinownerqueue( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    var_0 = common_scripts\utility::array_reverse( var_0 );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && isplayer( var_2 ) && isalive( var_2 ) )
            return var_2;
    }

    return undefined;
}

laser_setplacesentry( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_2 = self;

    if ( !var_2 maps\mp\_utility::validateusestreak() )
        return 0;

    var_2.last_sentry = var_1;
    var_0 laser_setplaced( self );
    return 1;
}

laser_setplaced( var_0 )
{
    if ( self _meth_8066() == "manual" )
    {
        self _meth_8065( level.sentrysettings[self.sentrytype].sentrymodeoff );
        self.mode = "off";
    }

    self _meth_8104( undefined );
    self _meth_82C0( 1 );

    if ( isdefined( self.owner ) )
        self.owner.iscarrying = 0;

    thread laser_setactive( var_0 );
    thread playlasercoreevent();
    thread playlasercontainmentstart();
    self playsound( "sentry_gun_plant" );
    self notify( "placed" );
}

playlasercoreevent()
{
    wait 2.0;
    playfxontag( level.laser_fx["laser_steam"], self.fxents["charge_up"], "tag_origin" );
}

stoplasercoreevent()
{
    wait 4;
    stopfxontag( level.laser_fx["laser_steam"], self.fxents["charge_up"], "tag_origin" );
    level endon( "laser_exploder_disabled" );
    wait 3.5;
    var_0 = 200;
    level.laser_exploder_disabled = undefined;
    common_scripts\_exploder::activate_clientside_exploder( var_0 );
}

startlaserlights()
{
    var_0 = _func_231( "laser_light", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "lsr_part_a", "laser_on_a" );

    var_0 = _func_231( "laser_light_b", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "lsr_part_b", "laser_on_b" );

    var_0 = _func_231( "laser_point_lights", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "static_part1", "warning" );
}

stoplaserlights()
{
    var_0 = _func_231( "laser_light", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "lsr_part_a", "laser_off_a" );

    var_0 = _func_231( "laser_light_b", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "lsr_part_b", "laser_off_b" );

    var_0 = _func_231( "laser_point_lights", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "static_part1", "healthy" );
}

playlasercontainmentstart()
{
    level.killstreak_laser_fxmode = 1;
    var_0 = 200;
    level notify( "laser_exploder_disabled" );
    level.laser_exploder_disabled = 1;
    _func_292( var_0 );
    playfxontag( level.laser_fx["hatch_light"], self.fxents["charge_up"], "tag_origin" );
    playfxontag( level.laser_fx["hatch_light"], level.sentrygun.lifter, "tag_origin" );
    wait 5.33;
    startlaserlights();
    playfxontag( level.laser_fx["laser_field1_up_slow"], self.fxents["charge_up"], "tag_origin" );
    wait 1.0;
    playfxontag( level.laser_fx["laser_field1"], self.fxents["charge_up"], "tag_origin" );
}

playlasercontainmentswap()
{
    if ( !isdefined( self.ownerlist ) || self.ownerlist.size < 1 )
        return;

    level.killstreak_laser_fxmode = self.ownerlist.size;
    var_0 = level.killstreak_laser_fxmode;

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            stopfxontag( level.laser_fx["laser_field1"], self.fxents["charge_up"], "tag_origin" );
            playfxontag( level.laser_fx["laser_field1_cheap"], self.fxents["charge_up"], "tag_origin" );
            playfxontag( level.laser_fx["laser_field2_up"], self.fxents["charge_up"], "tag_origin" );
            wait 1.0;
            var_1 = _func_231( "laser_light", "targetname" );

            foreach ( var_3 in var_1 )
                var_3 _meth_83F6( "lsr_part_a", "laser_on_02_a" );

            var_5 = _func_231( "laser_light_b", "targetname" );

            foreach ( var_7 in var_5 )
                var_7 _meth_83F6( "lsr_part_b", "laser_on_02_b" );

            playfxontag( level.laser_fx["laser_field2"], self.fxents["charge_up"], "tag_origin" );
            break;
        case 3:
            stopfxontag( level.laser_fx["laser_field2"], self.fxents["charge_up"], "tag_origin" );
            playfxontag( level.laser_fx["laser_field2_cheap"], self.fxents["charge_up"], "tag_origin" );
            playfxontag( level.laser_fx["laser_field3_up"], self.fxents["charge_up"], "tag_origin" );
            wait 1.0;
            var_9 = _func_231( "laser_light", "targetname" );

            foreach ( var_11 in var_9 )
                var_11 _meth_83F6( "lsr_part_a", "laser_on_03_a" );

            var_5 = _func_231( "laser_light_b", "targetname" );

            foreach ( var_7 in var_5 )
                var_7 _meth_83F6( "lsr_part_b", "laser_on_03_b" );

            playfxontag( level.laser_fx["laser_field3"], self.fxents["charge_up"], "tag_origin" );
            break;
        default:
            break;
    }
}

stoplasercontainmentswap()
{
    if ( !isdefined( level.killstreak_laser_fxmode ) )
        return;

    var_0 = level.killstreak_laser_fxmode;
    level.killstreak_laser_fxmode = self.ownerlist.size;
    wait 1.0;

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            playfxontag( level.laser_fx["laser_field2_down"], self.fxents["charge_up"], "tag_origin" );
            stopfxontag( level.laser_fx["laser_field2"], self.fxents["charge_up"], "tag_origin" );
            stopfxontag( level.laser_fx["laser_field1_cheap"], self.fxents["charge_up"], "tag_origin" );
            playfxontag( level.laser_fx["laser_field1"], self.fxents["charge_up"], "tag_origin" );
            var_1 = _func_231( "laser_light", "targetname" );

            foreach ( var_3 in var_1 )
                var_3 _meth_83F6( "lsr_part_a", "laser_on_a" );

            var_1 = _func_231( "laser_light_b", "targetname" );

            foreach ( var_3 in var_1 )
                var_3 _meth_83F6( "lsr_part_b", "laser_on_b" );

            break;
        case 3:
            playfxontag( level.laser_fx["laser_field3_down"], self.fxents["charge_up"], "tag_origin" );
            stopfxontag( level.laser_fx["laser_field3"], self.fxents["charge_up"], "tag_origin" );
            stopfxontag( level.laser_fx["laser_field2_cheap"], self.fxents["charge_up"], "tag_origin" );
            playfxontag( level.laser_fx["laser_field2"], self.fxents["charge_up"], "tag_origin" );
            var_1 = _func_231( "laser_light", "targetname" );

            foreach ( var_3 in var_1 )
                var_3 _meth_83F6( "lsr_part_a", "laser_on_02_a" );

            var_1 = _func_231( "laser_light_b", "targetname" );

            foreach ( var_3 in var_1 )
                var_3 _meth_83F6( "lsr_part_b", "laser_on_02_b" );

            break;
        default:
            break;
    }
}

stoplasercontainmentend()
{
    if ( !isdefined( level.killstreak_laser_fxmode ) )
        return;

    var_0 = level.killstreak_laser_fxmode;
    level.killstreak_laser_fxmode = 0;
    wait 1.6;

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            playfxontag( level.laser_fx["laser_field1_down_slow"], self.fxents["charge_up"], "tag_origin" );
            killfxontag( level.laser_fx["laser_field1"], self.fxents["charge_up"], "tag_origin" );
            stoplaserlights();
            wait 1.5;
            playfxontag( level.laser_fx["hatch_light_close"], self.fxents["charge_up"], "tag_origin" );
            playfxontag( level.laser_fx["hatch_light_close"], level.sentrygun.lifter, "tag_origin" );
            break;
        default:
            break;
    }
}

laser_setinactive()
{
    self.samtargetent = undefined;
    self _meth_8108();
    self _meth_8065( level.sentrysettings[self.sentrytype].sentrymodeoff );
    self.mode = "off";
    var_0 = self _meth_81B1();
    maps\mp\killstreaks\_autosentry::removefromturretlist( var_0 );

    if ( level.teambased )
        setteamheadicon_large( "none", ( 0, 0, 0 ) );
    else if ( isdefined( self.owner ) )
        setteamheadicon_large( "none", ( 0, 0, 0 ) );

    self _meth_815A( -10 );
    level.sentrygun _meth_8105( 0 );
    self _meth_8105( 0 );
    self _meth_82C0( 0 );
    laser_coredamage_deactivated( self.coredamagetrig );
    laser_coredamage_deactivated( self.coredeathtrig );

    if ( self.lifter.origin != self.moveorgs["bottom"] )
    {
        laser_usableoffswitch_off();
        thread stoplasercoreevent();
        thread stoplasercontainmentend();
        thread laser_handlemovebottom();
    }
}

laser_handlemovebottom()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );

    foreach ( var_1 in self.lifter.parts )
    {

    }

    self.locked = 1;
    self.moving = 1;
    wait 1;
    linkgeototurret( self, 0 );
    self.lifter show();
    self.lifter linkgeototurret( self, 1 );
    self hide();
    var_3 = [];
    var_3["laser_xform_down_sec1_start"] = "laser_xform_down_sec1_start";
    var_3["laser_xform_down_sec1_end"] = "laser_xform_down_sec1_end";
    var_3["laser_xform_down_sec2_start"] = "laser_xform_down_sec2_start";
    var_3["laser_xform_down_sec2_end"] = "laser_xform_down_sec2_end";
    self.lifter _meth_827B( self.lifter.animdown, "laser_xform_down_sec1_start" );

    foreach ( var_1 in self.lifter.parts )
        var_1 _meth_827B( self.lifter.animdown, "laser_xform_down_sec1_start" );

    self.lifter thread maps\mp\_audio::snd_play_on_notetrack( var_3, "laser_xform_down_sec1_start" );

    foreach ( var_7 in self.flaps )
    {
        if ( isdefined( var_7.targetname ) && var_7.targetname == "lsr_flap_bottom" )
        {
            var_7 _meth_827B( self.flap_animclose );
            continue;
        }

        var_7 _meth_8279( self.flap_animclose );
    }

    self.lifter thread aud_play_laser_move_down( 6 );
    self.lifter thread playmovementsparks( 2.5 );
    self.lifter maps\mp\_utility::delaythread( 6, ::stopmovementsparks );
    wait 7.8;
    self.moving = 0;
    self.locked = 0;
}

laser_handlemovetop()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );

    foreach ( var_1 in self.lifter.parts )
    {

    }

    self.moving = 1;
    var_3 = [];
    var_3["laser_xform_up_sec1_start"] = "laser_xform_up_sec1_start";
    var_3["laser_xform_up_sec1_end"] = "laser_xform_up_sec1_end";
    var_3["laser_xform_up_sec2_start"] = "laser_xform_up_sec2_start";
    var_3["laser_xform_up_sec2_end"] = "laser_xform_up_sec2_end";
    self.lifter _meth_827B( self.lifter.animup, "laser_xform_up_sec1_start" );

    foreach ( var_1 in self.lifter.parts )
        var_1 _meth_827B( self.lifter.animup, "laser_xform_up_sec1_start" );

    self.lifter thread maps\mp\_audio::snd_play_on_notetrack( var_3, "laser_xform_up_sec1_start" );

    foreach ( var_7 in self.flaps )
    {
        if ( isdefined( var_7.targetname ) && var_7.targetname == "lsr_flap_bottom" )
        {
            var_7 _meth_827B( self.flap_animopen );
            continue;
        }

        var_7 _meth_8279( self.flap_animopen );
    }

    self.lifter thread aud_play_laser_move_up( 5.0 );
    self.lifter thread playmovementsparks( 1.5 );
    self.lifter maps\mp\_utility::delaythread( 5.0, ::stopmovementsparks );
    wait 8;
    self.lifter linkgeototurret( self, 0 );
    self show();
    linkgeototurret( self, 1 );
    self.lifter hide();
    waittillframeend;
    self.moving = 0;
}

aud_play_laser_move_up( var_0 )
{
    thread maps\mp\_audio::snd_play_in_space_delayed( "laser_beam_power_up", ( 15, 382, 902 ), 5.2 );
    thread maps\mp\_audio::snd_play_linked( "laser_platform_move_up_start", self );
    thread aud_laser_energy_beam_start();
    thread maps\mp\_audio::snd_play_loop_in_space( "laser_platform_move_alarm_lp", ( -1, 355, 945 ), "aud_stop_laser_alarm", 2 );
    wait(var_0);
    thread maps\mp\_audio::snd_play_linked( "laser_platform_move_up_end", self );
    level notify( "aud_stop_laser_alarm" );
}

aud_play_laser_move_down( var_0 )
{
    thread maps\mp\_audio::snd_play_in_space_delayed( "laser_beam_power_down", ( 15, 382, 902 ), 1.25 );
    thread aud_laser_pre_move_down();
    wait 2.5;
    var_1 = thread maps\mp\_audio::snd_play_linked( "laser_platform_move_down_start", self );
    wait 3;
    thread maps\mp\_audio::snd_play_linked( "laser_platform_move_down_legs_fold", self );
    var_1 _meth_806F( 0.0, 0.05 );
    var_1 _meth_80AC();
    level notify( "aud_laser_energy_lp_off" );
    wait 0.7;
    thread maps\mp\_audio::snd_play_linked( "laser_platform_move_down_end", self );
}

aud_laser_pre_move_down()
{
    wait 1;
    var_0 = thread maps\mp\_audio::snd_play_linked( "laser_platform_pre_move_down", self );
}

aud_laser_energy_beam_start()
{
    thread maps\mp\_audio::snd_play_loop_in_space( "laser_base_pulse_energy_lp", ( -13, 393, 352 ), "aud_laser_energy_lp_off", 2 );
    thread maps\mp\_audio::snd_play_loop_in_space( "laser_base_pulse_low_lp", ( -13, 393, 352 ), "aud_laser_energy_lp_off", 2 );
    thread maps\mp\_audio::snd_play_loop_in_space( "laser_base_pulse_motor_lp", ( -13, 393, 352 ), "aud_laser_energy_lp_off", 2 );
}

playmovementsparks( var_0 )
{
    wait(var_0);

    foreach ( var_2 in self.parts )
    {
        if ( var_2.model == "mp_sky_laser_turret_lega" )
            playfxontag( level.laser_fx["laser_movement_sparks"], var_2, "fx_joint_0" );
    }
}

stopmovementsparks()
{
    foreach ( var_1 in self.parts )
    {
        if ( var_1.model == "mp_sky_laser_turret_lega" )
            stopfxontag( level.laser_fx["laser_movement_sparks"], var_1, "fx_joint_0" );
    }
}

player_sentry_timeout( var_0 )
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "joined_team" );
    var_0 endon( "joined_spectators" );

    for ( var_1 = level.sentrysettings[self.sentrytype].timeout; var_1; var_1 = max( 0, var_1 - 1.0 ) )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    }

    if ( isdefined( var_0 ) )
    {
        self.ownerlist = array_removefirstinqueue( self.ownerlist, var_0 );

        if ( self.ownerlist.size != 0 )
        {
            var_0 thread maps\mp\_utility::leaderdialogonplayer( level.sentrysettings[level.sentrygun.sentrytype].vopower );
            thread stoplasercontainmentswap();
        }
        else
        {
            var_0 thread maps\mp\_utility::leaderdialogonplayer( level.sentrysettings[level.sentrygun.sentrytype].vooffline );
            self notify( "fakedeath" );
        }
    }
}

laser_setactive( var_0 )
{
    foreach ( var_0 in level.players )
    {
        var_2 = self _meth_81B1();
        maps\mp\killstreaks\_autosentry::addtoturretlist( var_2 );
    }

    if ( self.shouldsplash )
    {
        level thread maps\mp\_utility::teamplayercardsplash( level.sentrysettings[self.sentrytype].teamsplash, self.owner, self.owner.team );
        self.shouldsplash = 0;
    }

    laser_coredamage_activated( self.coredamagetrig );
    laser_coredamage_activated( self.coredeathtrig, 1 );
    laser_handlemovetop();
    self _meth_815A( 5 );
    self _meth_8065( level.sentrysettings[self.sentrytype].sentrymodeon );
    self.mode = "on";
    laser_usableoffswitch_on();

    if ( level.sentrysettings[self.sentrytype].headicon )
    {
        if ( level.teambased )
            setteamheadicon_large( self.team, ( 0, 0, 400 ) );
        else
            setteamheadicon_large( self.team, ( 0, 0, 400 ) );
    }

    thread laser_attacktargets();
    thread laser_watchdisabled();
}

laser_usableoffswitch_off()
{
    self.generatorhat _meth_8279( self.generatorhat.anim_down );
    level.sentrygun.offswitch["use_zone"] maps\mp\gametypes\_gameobjects::disableobject();
    level.sentrygun.offswitch["switch_obj"] hide();
}

laser_usableoffswitch_on()
{
    var_0 = "none";

    if ( isdefined( level.sentrygun.owner ) && isdefined( level.sentrygun.owner.team ) )
        var_0 = level.sentrygun.owner.team;

    self.generatorhat _meth_8279( self.generatorhat.anim_up );
    level.sentrygun.offswitch["use_zone"].interactteam = "enemy";
    level.sentrygun.offswitch["use_zone"] maps\mp\gametypes\_gameobjects::setownerteam( var_0 );

    foreach ( var_2 in level.players )
    {
        if ( var_2.team != var_0 && var_0 != "none" )
        {
            var_2.laseroffswitch_isvisible = 1;
            level.sentrygun.offswitch["switch_obj"] showtoplayer( var_2 );
        }
    }
}

setteamheadicon_large( var_0, var_1 )
{
    if ( !level.teambased )
        return;

    if ( !isdefined( self.entityheadiconteam ) )
    {
        self.entityheadiconteam = "none";
        self.entityheadicon = undefined;
    }

    var_2 = game["entity_headicon_" + var_0];
    self.entityheadiconteam = var_0;

    if ( isdefined( var_1 ) )
        self.entityheadiconoffset = var_1;
    else
        self.entityheadiconoffset = ( 0, 0, 0 );

    self notify( "kill_entity_headicon_thread" );

    if ( var_0 == "none" )
    {
        if ( isdefined( self.entityheadicon ) )
            self.entityheadicon destroy();

        return;
    }

    var_3 = newteamhudelem( var_0 );
    var_3.archived = 1;
    var_3.x = self.origin[0] + self.entityheadiconoffset[0];
    var_3.y = self.origin[1] + self.entityheadiconoffset[1];
    var_3.z = self.origin[2] + self.entityheadiconoffset[2];
    var_3.alpha = 1;
    var_3 _meth_80CC( var_2, 50, 50 );
    var_3 _meth_80D8( 0, 0, 0, 1 );
    self.entityheadicon = var_3;
    thread maps\mp\_entityheadicons::keepiconpositioned();
    thread maps\mp\_entityheadicons::destroyheadiconsondeath();
}

setplayerheadicon_large( var_0, var_1 )
{
    if ( level.teambased )
        return;

    if ( !isdefined( self.entityheadiconteam ) )
    {
        self.entityheadiconteam = "none";
        self.entityheadicon = undefined;
    }

    self notify( "kill_entity_headicon_thread" );

    if ( !isdefined( var_0 ) )
    {
        if ( isdefined( self.entityheadicon ) )
            self.entityheadicon destroy();

        return;
    }

    var_2 = var_0.team;
    self.entityheadiconteam = var_2;

    if ( isdefined( var_1 ) )
        self.entityheadiconoffset = var_1;
    else
        self.entityheadiconoffset = ( 0, 0, 0 );

    var_3 = game["entity_headicon_" + var_2];
    var_4 = newclienthudelem( var_0 );
    var_4.archived = 1;
    var_4.x = self.origin[0] + self.entityheadiconoffset[0];
    var_4.y = self.origin[1] + self.entityheadiconoffset[1];
    var_4.z = self.origin[2] + self.entityheadiconoffset[2];
    var_4.alpha = 1;
    var_4 _meth_80CC( var_3, 50, 50 );
    var_4 _meth_80D8( 0, 0, 0, 1 );
    self.entityheadicon = var_4;
    thread maps\mp\_entityheadicons::keepiconpositioned();
    thread maps\mp\_entityheadicons::destroyheadiconsondeath();
}

laser_watchdisabled()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );
    self notify( "laser_watchDisabled" );
    self endon( "laser_watchDisabled" );

    for (;;)
    {
        self waittill( "emp_damage", var_0, var_1 );
        playfxontag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "tag_aim" );
        self _meth_815A( -10 );
        self _meth_8065( level.sentrysettings[self.sentrytype].sentrymodeoff );
        self.mode = "none";
        wait(var_1);
        self _meth_815A( 5 );
        self _meth_8065( level.sentrysettings[self.sentrytype].sentrymodeon );
        self.mode = "on";
    }
}

laser_attacktargets()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );
    self notify( "laser_attackTargets" );
    self endon( "laser_attackTargets" );
    self.samtargetent = undefined;
    self.sammissilegroups = [];

    for (;;)
    {
        self.samtargetent = maps\mp\killstreaks\_autosentry::sam_acquiretarget();
        laser_fireontarget();
        wait 0.05;
    }
}

laser_watchlightbeam()
{
    self endon( "death" );
    level endon( "game_ended" );
    wait 0.5;

    if ( !isdefined( self.ownerlist ) || self.ownerlist.size < 1 )
        return;

    var_0 = self.ownerlist.size;
    playfxontag( level.laser_fx["laser_charge1"], self.fxents["charge_up"], "tag_origin" );
    playfxontag( level.laser_fx["beahm"], self, "tag_laser" );
    laser_coredamage_activated( self.firingdamagetrig );
    var_1 = maps\mp\_audio::snd_play_linked( "wpn_skylaser_fire_startup", self );
    thread common_scripts\utility::play_loop_sound_on_entity( "wpn_skylaser_beam_lp" );
    self _meth_80B2( "mp_laser2_laser" );

    while ( isdefined( self.samtargetent ) && isdefined( self _meth_8109( 1 ) ) && self _meth_8109( 1 ) == self.samtargetent )
        wait 0.05;

    self _meth_80B3();
    stopfxontag( level.laser_fx["laser_charge1"], self.fxents["charge_up"], "tag_origin" );
    playfxontag( level.laser_fx["laser_beam_done1"], self.fxents["charge_up"], "tag_origin" );
    stopfxontag( level.laser_fx["beahm"], self, "tag_laser" );
    playfxontag( level.laser_fx["beahm_smoke"], self, "tag_laser" );
    laser_coredamage_deactivated( self.firingdamagetrig );
    common_scripts\utility::stop_loop_sound_on_entity( "wpn_skylaser_beam_lp" );
    var_2 = maps\mp\_audio::snd_play_linked( "wpn_skylaser_beam_stop", self );

    if ( isdefined( var_1 ) )
        var_1 _meth_80AC();
}

laser_fireontarget()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );

    if ( isdefined( self.samtargetent ) )
    {
        if ( isdefined( level.orbitalsupport_planemodel ) && self.samtargetent == level.orbitalsupport_planemodel && !isdefined( level.orbitalsupport_player ) )
        {
            self.samtargetent = undefined;
            self _meth_8108();
            return;
        }

        self _meth_8106( self.samtargetent );
        self waittill( "turret_on_target" );

        if ( !isdefined( self.samtargetent ) )
            return;

        if ( !self.laser_on )
        {
            thread laser_watchlightbeam();
            thread maps\mp\killstreaks\_autosentry::sam_watchlaser();
            thread maps\mp\killstreaks\_autosentry::sam_watchcrashing();
            thread maps\mp\killstreaks\_autosentry::sam_watchleaving();
            thread maps\mp\killstreaks\_autosentry::sam_watchlineofsight();
        }

        wait 0.5;

        if ( !isdefined( self.samtargetent ) )
            return;

        if ( isdefined( level.orbitalsupport_planemodel ) && self.samtargetent == level.orbitalsupport_planemodel && !isdefined( level.orbitalsupport_player ) )
        {
            self.samtargetent = undefined;
            self _meth_8108();
            return;
        }

        self _meth_80EA();
        firelaserbeam();
    }
}

firelaserbeam()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );
    var_0 = self gettagorigin( "tag_laser" );
    var_1 = anglestoforward( self gettagangles( "tag_laser" ) );
    var_2 = var_0 + 15000 * var_1;
    var_3 = bullettrace( var_0, var_2, 1, self );

    if ( isdefined( level.orbitalsupport_planemodel ) && self.samtargetent == level.orbitalsupport_planemodel && isdefined( level.orbitalsupport_player ) )
        radiusdamage( level.orbitalsupport_planemodel.origin, 512, 100, 100, self.owner, "MOD_EXPLOSIVE", "killstreak_laser2_mp" );
    else if ( isdefined( self.samtargetent.ispodrocket ) && self.samtargetent.ispodrocket )
        self.samtargetent notify( "damage", 1000, self.owner, undefined, undefined, "mod_explosive", undefined, undefined, undefined, undefined, "killstreak_laser2_mp" );
    else
        radiusdamage( var_3["position"], 512, 200, 200, self.owner, "MOD_EXPLOSIVE", "killstreak_laser2_mp" );
}

laser_coredamage_activated( var_0, var_1 )
{
    level endon( "game_ended" );
    thread watchplayerenterlasercore( var_0, var_1 );
    var_0 common_scripts\utility::trigger_on();
}

laser_coredamage_deactivated( var_0 )
{
    level endon( "game_ended" );
    var_0 notify( "laser_coreDamage_deactivated" );
    var_0 common_scripts\utility::trigger_off();
}

watchplayerenterlasercore( var_0, var_1 )
{
    level endon( "game_ended" );
    var_0 endon( "laser_coreDamage_deactivated" );

    for (;;)
    {
        var_0 waittill( "trigger", var_2 );

        if ( !isplayer( var_2 ) )
            continue;

        if ( !isalive( var_2 ) )
            continue;

        if ( isdefined( var_2.lasercoretrigids ) && isdefined( var_2.lasercoretrigids[var_0.targetname] ) && var_2.lasercoretrigids[var_0.targetname] == 1 )
            continue;
        else
        {
            if ( !isdefined( var_2.lasercoretrigids ) )
                var_2.lasercoretrigids = [];

            var_2.lasercoretrigids[var_0.targetname] = 1;
            var_2 thread player_lasercoreeffect( var_0, var_1 );

            if ( isalive( var_2 ) )
            {
                var_2 thread player_watchexitlasercore( var_0 );
                var_2 thread player_watchdeath( var_0 );
                continue;
            }

            var_2.lasercoretrigids[var_0.targetname] = 0;
        }
    }
}

player_watchexitlasercore( var_0 )
{
    level endon( "game_ended" );
    self endon( "player_leftLaserCoreTrigger" + var_0.targetname );
    self endon( "stop_watching_trig" );

    while ( self _meth_80A9( var_0 ) )
        wait 0.05;

    if ( isdefined( self.lasercoretrigids ) )
        self.lasercoretrigids[var_0.targetname] = 0;

    player_resetlasercorevalues();
    self notify( "player_leftLaserCoreTrigger" + var_0.targetname );
}

player_lasercoreeffect( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "player_leftLaserCoreTrigger" + var_0.targetname );
    self endon( "stop_watching_trig" );

    if ( isdefined( var_1 ) && var_1 )
    {
        maps\mp\_utility::_suicide();
        return;
    }

    self.poison = 0;
    var_2 = level.sentrysettings[level.sentrygun.sentrytype].coreshellshock;

    if ( !isdefined( self.usingremote ) && !isdefined( self.ridevisionset ) )
    {
        self _meth_82D4( "aftermath", 0.5 );
        self shellshock( var_2, 60 );
    }
    else
        self.lasercorevisualsblocked = 1;

    for (;;)
    {
        self.poison++;

        switch ( self.poison )
        {
            case 1:
                self _meth_81AF( 1, self.origin );
                break;
            case 2:
                self _meth_81AF( 3, self.origin );
                player_dolasercoredamage( 15 );
                break;
            case 3:
                self _meth_81AF( 15, self.origin );
                player_dolasercoredamage( 15 );
                break;
            case 4:
                self _meth_81AF( 75, self.origin );
                maps\mp\_utility::_suicide();
                return;
        }

        wait 1;
    }
}

player_watchdeath( var_0 )
{
    level endon( "game_ended" );
    self endon( "player_leftLaserCoreTrigger" + var_0.targetname );
    common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators", "death" );
    self.lasercoretrigids = undefined;
    player_resetlasercorevalues();
    self notify( "stop_watching_trig" );
}

player_resetlasercorevalues()
{
    if ( !isdefined( self.lasercorevisualsblocked ) )
    {
        self stopshellshock();
        thread maps\mp\_utility::revertvisionsetforplayer( 0.5 );
    }

    self.lasercorevisualsblocked = undefined;
}

laserlightfill()
{
    playfxontag( common_scripts\utility::getfx( "light_laser_fill" ), self, "tag_origin" );
}

player_dolasercoredamage( var_0 )
{
    if ( !isdefined( level.sentrygun.owner ) )
        return;

    self thread [[ level.callbackplayerdamage ]]( self, level.sentrygun.owner, var_0, 0, "MOD_TRIGGER_HURT", "mp_laser2_core", self.origin, ( 0, 0, 0 ) - self.origin, "none", 0 );
}

handledamagefeedbacksound( var_0 )
{

}
