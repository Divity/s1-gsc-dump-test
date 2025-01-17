// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level._effect["microwave_buff"][0] = loadfx( "vfx/weaponimpact/xombie_flesh_microwave_bubbles_1" );
    level._effect["microwave_buff"][1] = loadfx( "vfx/weaponimpact/xombie_flesh_microwave_bubbles_2" );
    level._effect["microwave_buff_head"] = loadfx( "vfx/weaponimpact/xombie_flesh_microwave_bubbles_head_2" );
    level._effect["microwave_buff_shoulder_left"] = loadfx( "vfx/weaponimpact/xombie_flesh_microwave_bubbles_le_2" );
    level._effect["microwave_buff_shoulder_right"] = loadfx( "vfx/weaponimpact/xombie_flesh_microwave_bubbles_ri_2" );
    level._effect["gib_full_body_microwave"] = loadfx( "vfx/blood/dlc_zombie_microwave_death" );
}

onplayerspawn()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );
    self notify( "onPlayerSpawnMicrowaveGun" );
    self endon( "onPlayerSpawnMicrowaveGun" );
    maps\mp\gametypes\zombies::createzombieweaponstate( self, "iw5_microwavezm_mp" );
    self.weaponstate["iw5_microwavezm_mp"]["weapon_level_increase"] = 0.2;
    var_0 = self.team;
    var_1 = spawnstruct();
    var_1.lastfiredtime = 0;
    var_1.beamrange = 650;
    var_2 = 0;
    self.microwavegundata = var_1;
    setmicrowaveweaponlevel( 1 );
    childthread updatebeamrange( var_1 );
    childthread playermonitormicrowaveweapon( var_1 );
    childthread update_microwave_heat_omnvar();
    childthread updatecookzombieburger( var_1 );

    for (;;)
    {
        wait 0.05;

        if ( gettime() - var_1.lastfiredtime > 100 )
        {
            var_2 = 0;
            continue;
        }

        var_2 = 1;
        cookenemiesinrange( var_1, var_0 );
    }
}

updatebeamrange( var_0 )
{
    for (;;)
    {
        wait 0.5;
        var_1 = self _meth_8311( 0 );

        if ( !issubstr( var_1, "iw5_microwavezm_mp" ) )
            continue;

        var_2 = self getangles();
        var_3 = anglestoforward( var_2 );
        var_4 = self _meth_80A8();
        var_5 = var_4 + var_3 * 850;
        var_6 = bullettrace( var_4, var_5, 0, self, 0, 0, 0, 0, 0, 1, 0 );

        if ( var_6["fraction"] < 1 )
        {
            var_0.beamrange = length( var_6["position"] - var_4 );
            continue;
        }

        var_0.beamrange = 850;
    }
}

cookenemiesinrange( var_0, var_1 )
{
    var_2 = var_0.beamrange;

    if ( self _meth_8340() < 0.3 )
        var_2 = min( var_2, 650 );

    var_3 = squared( var_2 + var_0.beamwidth * 2 );
    var_4 = squared( var_0.beamwidth );
    var_5 = self _meth_80A8();
    var_6 = self getangles();
    var_7 = anglestoforward( var_6 );
    var_8 = var_5 + var_7 * var_0.beamwidth;
    var_9 = var_8 + var_7 * var_2;

    foreach ( var_11 in level.agentarray )
    {
        if ( !isdefined( var_11 ) || !isalive( var_11 ) || isdefined( var_11.team ) && !isenemyteam( var_1, var_11.team ) )
            continue;

        if ( distancesquared( self.origin, var_11.origin ) > var_3 )
            continue;

        var_12 = ( var_11.origin - var_5 ) * ( 1, 1, 0 );

        if ( vectordot( var_12, var_7 * ( 1, 1, 0 ) ) < 0 )
            continue;

        var_13 = pointdistancetolinesq( var_11 _meth_80A8(), var_8, var_9 );
        var_14 = pointdistancetolinesq( var_11 gettagorigin( "J_Spine4" ), var_8, var_9 );
        var_15 = min( var_13, var_14 );

        if ( var_15 > var_4 )
            continue;

        if ( maps\mp\zombies\_util::isinstakill() )
        {
            var_11 explodezombie( self );
            continue;
        }

        var_11 _meth_8051( 30, var_11 _meth_80A8(), self, undefined, "MOD_EXPLOSIVE", "iw5_microwavezm_mp", "none" );

        if ( !isdefined( var_11 ) || !isalive( var_11 ) )
            continue;

        var_11 maps\mp\zombies\_zombies::addbuff( "microwaveBuff", var_11 getmicrowavebuff( self ) );
    }
}

updatecookzombieburger( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    level waittill( "main_stage5_over" );
    var_1 = getent( "zombie_patty_raw", "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    var_1.cooktime = 0;
    var_2 = 0.5;

    for (;;)
    {
        wait(var_2);

        if ( gettime() - var_0.lastfiredtime > 100 )
            continue;

        cookzombieburger( var_0, var_1, var_2 );

        if ( var_1.cooktime >= 5 )
            break;
    }

    level notify( "burger_patty_cooked", self );
}

cookzombieburger( var_0, var_1, var_2 )
{
    var_3 = squared( var_0.beamrange + var_0.beamwidth * 2 );
    var_4 = squared( var_0.beamwidth );
    var_5 = self _meth_80A8();
    var_6 = self getangles();
    var_7 = anglestoforward( var_6 );
    var_8 = var_5 + var_7 * var_0.beamwidth;
    var_9 = var_8 + var_7 * var_0.beamrange;

    if ( distancesquared( self.origin, var_1.origin ) > var_3 )
        return;

    var_10 = ( var_1.origin - var_5 ) * ( 1, 1, 0 );

    if ( vectordot( var_10, var_7 * ( 1, 1, 0 ) ) < 0 )
        return;

    var_11 = pointdistancetolinesq( var_1.origin, var_8, var_9 );

    if ( var_11 > var_4 )
        return;

    var_1.cooktime += var_2;
}

pointdistancetolinesq( var_0, var_1, var_2 )
{
    var_3 = lengthsquared( var_2 - var_1 );

    if ( var_3 == 0 )
        return lengthsquared( var_1 - var_0 );

    var_4 = vectordot( var_0 - var_1, var_2 - var_1 ) / var_3;

    if ( var_4 < 0 )
        return lengthsquared( var_0 - var_1 );
    else if ( var_4 > 1 )
        return lengthsquared( var_0 - var_2 );

    var_5 = var_1 + var_4 * ( var_2 - var_1 );
    var_6 = lengthsquared( var_0 - var_5 );
    return var_6;
}

getmicrowavebuff( var_0 )
{
    var_1 = maps\mp\zombies\_zombies::getbuff( "microwaveBuff" );

    if ( !isdefined( var_1 ) )
    {
        var_1 = spawnmicrowavebuff( var_0 );
        maps\mp\zombies\_util::playfxontagnetwork( level._effect["microwave_buff"][0], self, "J_Spine4" );
        var_2 = clamp( var_1.bufflevel / var_1.timetoexplode, 0, 1 );
        thread audio_flesh_bubble( var_2 );
    }
    else
    {
        var_3 = var_1.bufflevel;
        var_1.bufflevel += 0.05;
        var_2 = clamp( var_1.bufflevel / var_1.timetoexplode, 0, 1 );
        var_1.speedmultiplier = calculatebuffspeedmultiplier( var_1.bufflevel, var_2, var_1.lifespan, var_1.player );
        var_4 = getmicrowavebufffxindex( var_3, var_1.timetoexplode );
        var_5 = getmicrowavebufffxindex( var_1.bufflevel, var_1.timetoexplode );

        if ( var_5 > var_4 )
        {
            maps\mp\zombies\_util::stopfxontagnetwork( level._effect["microwave_buff"][var_4], self, "J_Spine4" );
            maps\mp\zombies\_util::playfxontagnetwork( level._effect["microwave_buff"][var_5], self, "J_Spine4" );
            maps\mp\zombies\_util::playfxontagnetwork( level._effect["microwave_buff_head"], self, "J_head" );

            if ( canplayadditionalbufffx() )
            {
                maps\mp\zombies\_util::playfxontagnetwork( level._effect["microwave_buff_shoulder_left"], self, "J_Shoulder_LE" );
                maps\mp\zombies\_util::playfxontagnetwork( level._effect["microwave_buff_shoulder_right"], self, "J_Shoulder_RI" );
            }
        }

        audio_flesh_bubble_volume( var_2 );
    }

    var_1.lifespan = var_0.microwavegundata.bufflifespan;
    var_1.player = var_0;
    return var_1;
}

calculatebuffspeedmultiplier( var_0, var_1, var_2, var_3 )
{
    var_4 = clamp( var_0 / 0.2, 0, 1 );

    if ( var_2 < 2.0 )
        var_4 = clamp( var_2 / 2.0, 0, 1 );

    return maps\mp\zombies\_util::lerp( var_4, 0.9, var_3.microwavegundata.fullyslowed );
}

audio_flesh_bubble( var_0 )
{
    if ( !isdefined( self.fleshbubblesound ) )
        self.fleshbubblesound = spawn( "script_origin", self.origin );

    self.fleshbubblesound _meth_804D( self );
    thread common_scripts\utility::delete_on_death( self.fleshbubblesound );
    self.fleshbubblesound _meth_8075( "npc_mwave_flesh_bubble" );
    self.fleshbubblesound _meth_806F( clamp( var_0, 0, 1 ), 0 );
}

audio_flesh_bubble_volume( var_0 )
{
    if ( isdefined( self.fleshbubblesound ) )
        self.fleshbubblesound _meth_806F( clamp( var_0, 0, 1 ), 0 );
}

audio_stop_flesh_bubble()
{
    if ( !isdefined( self.fleshbubblesound ) )
        return;

    var_0 = self.fleshbubblesound;
    var_0 endon( "death" );
    wait 1.3;
    var_0 _meth_806F( 0, 1.0 );
    wait 1.0;
    var_0 _meth_80AB();
    waitframe();
    var_0 delete();
    var_0 = undefined;
}

getmicrowavebufffxindex( var_0, var_1 )
{
    var_2 = var_0 / var_1;

    if ( var_2 < 0.25 )
        return 0;

    return 1;
}

canplayadditionalbufffx()
{
    return self.species != "dog";
}

spawnmicrowavebuff( var_0 )
{
    var_1 = spawnstruct();
    var_1.buffupdate = ::updatemicrowavebuff;
    var_1.buffremove = ::removemicrowavebuff;
    var_1.lifespan = var_0.microwavegundata.bufflifespan;
    var_1.speedmultiplier = 0.9;
    var_1.bufflevel = 0.05;
    var_1.timetoexplode = 2;
    return var_1;
}

explodezombie( var_0 )
{
    earthquake( randomfloatrange( 0.5, 1 ), randomfloatrange( 0.5, 1 ), self.origin, 128 );
    self _meth_8051( self.maxhealth + 10, self _meth_80A8(), var_0, undefined, "MOD_EXPLOSIVE", "iw5_microwavezm_mp", "none" );
}

givezombiescookedachievement( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) || !issubstr( var_1, "iw5_microwavezm_mp" ) )
        return;

    if ( !isdefined( var_0.numzombiescooked ) )
        var_0.numzombiescooked = 0;

    var_0.numzombiescooked++;

    if ( var_0.numzombiescooked == 50 )
        var_0 maps\mp\gametypes\zombies::givezombieachievement( "DLC2_ZOMBIE_POPCORN" );
}

updatemicrowavebuff( var_0 )
{
    var_1 = clamp( var_0.bufflevel / var_0.timetoexplode, 0, 1 );
    var_0.speedmultiplier = calculatebuffspeedmultiplier( var_0.bufflevel, var_1, var_0.lifespan, var_0.player );
}

removemicrowavebuff( var_0 )
{
    var_1 = getmicrowavebufffxindex( var_0.bufflevel, var_0.timetoexplode );
    maps\mp\zombies\_util::stopfxontagnetwork( level._effect["microwave_buff"][var_1], self, "J_Spine4" );
    thread audio_stop_flesh_bubble();

    if ( var_1 == 0 )
        return;

    maps\mp\zombies\_util::stopfxontagnetwork( level._effect["microwave_buff_head"], self, "J_head" );

    if ( canplayadditionalbufffx() )
    {
        maps\mp\zombies\_util::stopfxontagnetwork( level._effect["microwave_buff_shoulder_left"], self, "J_Shoulder_LE" );
        maps\mp\zombies\_util::stopfxontagnetwork( level._effect["microwave_buff_shoulder_right"], self, "J_Shoulder_RI" );
    }
}

playermonitormicrowaveweapon( var_0 )
{
    self endon( "disconnect" );
    self _meth_82FB( "ui_energy_ammo", 1 );

    for (;;)
    {
        self waittill( "weapon_change", var_1 );
        waitframe();
        thread playerdomicrowavelogic( var_1, var_0 );
    }
}

playerdomicrowavelogic( var_0, var_1 )
{
    self endon( "disconnect" );

    if ( !issubstr( var_0, "iw5_microwavezm_mp" ) )
    {
        if ( playerhasmicrowaveammoinfo() && playergetmicrowaveammo() <= 0 && !playerhasmicrowave() && !maps\mp\zombies\_util::isplayerinlaststand( self ) )
            playerclearmicrowaveammoinfo();

        return;
    }

    playersetmicrowaveammo();
    self _meth_82F7( var_0, 0 );
    thread playersetupmicrowaveammo( var_1 );
    self waittill( "weapon_change" );
    self _meth_8131( 1 );
    self _meth_849C( "fire_microwave_weapon", "+attack" );
    self _meth_849C( "fire_microwave_weapon", "+attack_akimbo_accessible" );
}

playerhasmicrowave()
{
    var_0 = self _meth_830C();

    foreach ( var_2 in var_0 )
    {
        if ( issubstr( var_2, "iw5_microwavezm_mp" ) )
            return 1;
    }

    return 0;
}

playerupdatemicrowaveomnvar()
{
    var_0 = getmicrowavemaxammo();
    var_1 = playergetmicrowaveammo();
    var_2 = var_1 / var_0;
    self _meth_82FB( "ui_energy_ammo", var_2 );
}

playersetupmicrowaveammo( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "weapon_change" );
    self _meth_82DD( "fire_microwave_weapon", "+attack" );
    self _meth_82DD( "fire_microwave_weapon", "+attack_akimbo_accessible" );
    var_1 = playergetmicrowaveammo();
    playerupdatemicrowaveomnvar();

    if ( var_1 <= 0 )
        self _meth_8131( 0 );

    for (;;)
    {
        if ( !self attackbuttonpressed() )
            self waittill( "fire_microwave_weapon" );

        var_2 = self _meth_8311();

        if ( self _meth_8337() || !issubstr( var_2, "iw5_microwavezm_mp" ) || !self _meth_812D() || self _meth_84E0() || self _meth_812E() )
        {
            waitframe();
            continue;
        }

        var_0.lastfiredtime = gettime();
        var_1 = playergetmicrowaveammo();
        playerupdatemicrowaveomnvar();

        if ( var_1 <= 0 )
        {
            var_3 = self _meth_830C();
            var_4 = maps\mp\_utility::getbaseweaponname( var_3[0] );

            if ( var_4 != "iw5_microwavezm" )
            {
                self _meth_8131( 0 );
                self _meth_8315( var_3[0] );
                waitframe();
                continue;
            }

            if ( var_3.size > 1 )
            {
                var_4 = maps\mp\_utility::getbaseweaponname( var_3[1] );

                if ( var_4 != "iw5_microwavezm" )
                {
                    self _meth_8315( var_3[1] );
                    self _meth_8131( 0 );
                    waitframe();
                    continue;
                }
            }

            self _meth_8131( 0 );
            waitframe();
            continue;
        }

        waitframe();

        if ( maps\mp\zombies\_util::gameflagexists( "unlimited_ammo" ) && maps\mp\_utility::gameflag( "unlimited_ammo" ) )
            continue;

        var_1 = playergetmicrowaveammo();
        playerrecordmicrowaveammo( var_1 - 1 );
    }
}

playersetmicrowaveammo()
{
    if ( !isdefined( self.pers["microwaveAmmo"] ) )
    {
        self.pers["microwaveAmmo"] = spawnstruct();
        playersetmicrowavemaxammo();
        self _meth_8131( 1 );
    }
}

getmicrowavemaxammo()
{
    return 900.0;
}

playersetmicrowavemaxammo()
{
    if ( isdefined( self.pers["microwaveAmmo"] ) )
    {
        self.pers["microwaveAmmo"].ammo = getmicrowavemaxammo();
        self _meth_82FB( "ui_energy_ammo", 1 );
        self _meth_8131( 1 );
    }
}

playergetmicrowaveammo()
{
    return self.pers["microwaveAmmo"].ammo;
}

playerrecordmicrowaveammo( var_0 )
{
    self.pers["microwaveAmmo"].ammo = var_0;
}

playerhasmicrowaveammoinfo()
{
    return isdefined( self.pers["microwaveAmmo"] );
}

playerclearmicrowaveammoinfo()
{
    self.pers["microwaveAmmo"] = undefined;
}

update_microwave_heat_omnvar()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = self _meth_8311();

        if ( issubstr( var_0, "iw5_microwavezm_mp" ) )
        {
            var_1 = self _meth_83B9( var_0 );
            self _meth_82FB( "ui_em1_heat", var_1 );
        }

        wait 0.05;
    }
}

playzombiekilledmicrowavefx()
{
    var_0 = common_scripts\utility::getfx( "gib_full_body_microwave" );
    var_1 = level.dismemberment["full"]["fxTagName"];
    playfx( var_0, self.body gettagorigin( var_1 ) );
    self.body playsound( "npc_mwave_flesh_expl_front" );
    self.body hide();
    self.body _meth_804A();
}

setmicrowaveweaponlevel( var_0 )
{
    var_0 = clamp( var_0, 1, 20 );

    if ( !isdefined( self.microwavegundata ) )
        return;

    var_1 = clamp( ( var_0 - 1 ) / 19.0, 0, 1 );
    self.microwavegundata.bufflifespan = maps\mp\zombies\_util::lerp( var_1, 3.0, 10.0 );
    self.microwavegundata.fullyslowed = maps\mp\zombies\_util::lerp( var_1, 0.6, 0.4 );
    self.microwavegundata.beamwidth = 25;
}

getmicrowavepointstimesec()
{
    return 0.5;
}
