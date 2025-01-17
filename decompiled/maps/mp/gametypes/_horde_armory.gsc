// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

initarmories()
{
    level.hordearmories = getentarray( "horde_armory", "targetname" );

    foreach ( var_1 in level.hordearmories )
    {
        var_1.monitors = getentarray( var_1.target, "targetname" );
        var_1 thread armorythink();
    }
}

armorythink()
{
    level endon( "armories_online" );
    level endon( "game_ended" );
    self makeusable();
    self _meth_83FA( 5, 1 );

    foreach ( var_1 in self.monitors )
    {
        if ( self.script_parameters == "specops_ui_equipmentstore" && var_1.model == "mp_exo_upgrade_screen_01_glass" )
            var_1 _meth_80B1( "mp_weapon_upgrade_screen_01_glass" );

        var_1 _meth_83FA( 5, 1 );
    }

    var_3 = &"HORDE_ARMORY_EXO";
    var_4 = "specops_ui_exostore";

    if ( self.script_parameters == "specops_ui_equipmentstore" )
    {
        var_4 = "specops_ui_weaponstore";
        var_3 = &"HORDE_ARMORY_WEAPONS";
    }

    self _meth_80DB( var_3 );

    foreach ( var_6 in level.players )
        self.headicon = maps\mp\_entityheadicons::setheadicon( var_6, var_4, ( 0, 0, 48 ), 4, 4, undefined, undefined, 0, 1, undefined, 0 );

    var_8 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_8, "active", self.origin, var_4 );
    self.objectiveindex = var_8;

    for (;;)
    {
        self waittill( "trigger", var_6 );

        if ( iscarryingturrethead( var_6 ) )
        {
            var_6 iclientprintlnbold( &"HORDE_ARMORY_TURRET_DENIED" );
            level thread armorypurchasefail( var_6 );
            continue;
        }

        if ( isdefined( var_6.changingweapon ) && maps\mp\_utility::iskillstreakweapon( var_6.changingweapon ) )
        {
            level thread armorypurchasefail( var_6 );
            continue;
        }

        if ( var_6 _meth_84E0() || var_6 _meth_812C() || isdefined( var_6.changingweapon ) && ( var_6.changingweapon == var_6 _meth_831A() || var_6.changingweapon == var_6 _meth_8345() ) )
        {
            level thread armorypurchasefail( var_6 );
            continue;
        }

        if ( !isdefined( level.empowner ) )
        {
            var_6 _meth_82FB( "ui_horde_armory_type", self.script_noteworthy );
            var_6 _meth_82FB( "ui_horde_show_armory", 1 );
            var_6.usingarmory = 1;
            var_6 _meth_832A();
            var_6 notify( "exo_cloak_cancel" );
            continue;
        }

        var_6 iclientprintlnbold( &"HORDE_ARMORY_OFFLINE" );
    }
}

iscarryingturrethead( var_0 )
{
    var_1 = var_0 _meth_8312();

    if ( issubstr( var_1, "turret" ) )
        return 1;

    return 0;
}

hordedisablearmories()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.hordearmories )
    {
        foreach ( var_3 in level.players )
            var_1 maps\mp\_entityheadicons::setheadicon( "none", "", ( 0, 0, 0 ) );

        if ( isdefined( var_1.headicon ) )
            var_1.headicon destroy();

        maps\mp\_utility::_objective_delete( var_1.objectiveindex );
        var_1 _meth_83FB();

        foreach ( var_6 in var_1.monitors )
            var_6 _meth_83FB();
    }

    thread hordearmoryemptimeout();
    level waittill( "armories_online" );

    foreach ( var_1 in level.hordearmories )
        var_1 thread armorythink();
}

hordearmoryemptimeout()
{
    level endon( "game_ended" );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( level.hordeempduration );
    level notify( "armories_online" );
}

closehordearmoryonoffhandweapon()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "weapon_switch_started", var_0 );

        if ( self _meth_8447( "ui_horde_show_armory" ) == 1 && ( var_0 == self _meth_831A() || var_0 == self _meth_8345() ) )
        {
            var_1 = self _meth_8447( "ui_horde_armory_type" );

            if ( var_1 != "killstreak_armory" && var_1 != "perk_armory" )
                hordecleanuparmory( self );
        }
    }
}

classswitchwait()
{
    wait 1;
    self.classswitchwaiting = 0;
}

monitorupgrades( var_0 )
{
    level endon( "game_ended" );
    level thread horderesetarmory( var_0 );

    for (;;)
    {
        var_0.isrunningarmorycommand = 0;
        var_0 waittill( "luinotifyserver", var_1, var_2 );

        if ( maps\mp\gametypes\_horde_util::isplayerinlaststand( var_0 ) )
            continue;

        var_0.isrunningarmorycommand = 1;

        if ( !hordeisarmoryupgrade( var_1 ) )
            continue;

        var_3 = "mp/hordeMenus.csv";
        var_4 = tablelookup( var_3, 0, var_2, 2 );
        var_5 = int( tablelookup( var_3, 0, var_2, 6 ) );

        if ( var_2 == 9999 )
        {
            addarmorypoints( var_0, "support_bar_filled" );
            var_0 playsoundtoplayer( "new_title_unlocks", var_0 );
            continue;
        }

        if ( var_1 == "horde_stat_upgrade" )
        {
            var_6 = 0;

            switch ( var_4 )
            {
                case "horde_weapon_proficiency":
                    var_6 = var_0.weaponproficiency;
                    break;
                case "horde_armor":
                    var_6 = var_0.hordearmor;
                    break;
                case "horde_exo_battery":
                    var_6 = var_0.hordeexobattery;
                    break;
            }

            if ( var_6 > 9 )
                var_5 = 10 + int( ( var_6 - 10 ) * 0.5 );
            else if ( var_6 > 7 )
                var_5 += 3;
            else if ( var_6 > 5 )
                var_5 += 2;
            else if ( var_6 > 2 )
                var_5 += 1;
        }

        if ( hordeshouldupgradefail( var_0, var_1, var_4, var_5 ) )
        {
            level thread armorypurchasefail( var_0 );
            continue;
        }

        var_0 playsoundtoplayer( "new_title_unlocks", var_0 );
        var_0 _meth_82FB( "ui_horde_armory_purchase", var_2 );

        switch ( var_1 )
        {
            case "horde_exo_class":
                if ( var_4 == "light" || var_4 == "heavy" || var_4 == "support" || var_4 == "demolition" )
                {
                    var_0 notify( "horde_class_change" );
                    var_0.usingarmory = 0;
                    var_0.classselection = 0;
                    var_7 = var_0 _meth_8447( "ui_horde_player_class" );
                    maps\mp\gametypes\_horde_util::check_class_time( var_0 );
                    var_0.classdmgmod = var_0.classsettings[var_4]["classDmgMod"];
                    var_0.classmaxhealth = var_0.classsettings[var_4]["classhealth"];
                    var_8 = var_0.health / var_0.maxhealth;
                    var_0.maxhealth = var_0.classmaxhealth + var_0.hordearmor * 40;
                    var_0.health = int( var_0.maxhealth * var_8 );
                    var_0.movespeedscaler = var_0.classsettings[var_4]["speed"];
                    var_0 maps\mp\_utility::playerallowdodge( var_0.classsettings[var_4]["allowDodge"], "class" );
                    var_0 maps\mp\_utility::playerallowpowerslide( var_0.classsettings[var_4]["allowSlide"], "class" );
                    var_9 = var_0 _meth_831A();
                    var_0.classsettings[var_7]["battery"] = var_0 _meth_82F8( var_9 );

                    if ( isdefined( var_7 ) && var_7 != "none" && isdefined( var_0.loadoutequipment ) )
                    {
                        var_10 = var_0 _meth_8345();
                        var_0.hordeclassweapons[var_7]["lethalStoredGrenade"] = var_10;
                        var_0.hordeclassweapons[var_7]["lethalStoredGrenadeStock"] = var_0 _meth_82F9( var_10 );
                    }

                    if ( isdefined( var_7 ) && var_7 != "none" && isdefined( var_0.hordeclassweapons[var_7]["primary"] ) )
                    {
                        var_0.hordeclassweapons[var_7]["primaryStoredAmmoClip"] = var_0 _meth_82F8( var_0.hordeclassweapons[var_7]["primary"] );
                        var_0.hordeclassweapons[var_7]["primaryStoredAmmoStock"] = var_0 _meth_82F9( var_0.hordeclassweapons[var_7]["primary"] );
                    }

                    if ( isdefined( var_7 ) && var_7 != "none" && isdefined( var_0.hordeclassweapons[var_7]["secondary"] ) )
                    {
                        var_0.hordeclassweapons[var_7]["secondaryStoredAmmoClip"] = var_0 _meth_82F8( var_0.hordeclassweapons[var_7]["secondary"] );
                        var_0.hordeclassweapons[var_7]["secondaryStoredAmmoStock"] = var_0 _meth_82F9( var_0.hordeclassweapons[var_7]["secondary"] );
                    }

                    var_0 _meth_82FB( "ui_horde_player_class", var_4 );
                    hordegiveability( var_0, var_4 );
                    var_11 = var_0 _meth_830C();

                    foreach ( var_13 in var_11 )
                    {
                        if ( var_0 _meth_8447( "horde_first_spawn" ) == 1 )
                        {
                            if ( var_13 != var_0.hordeclassweapons[var_4]["primary"] )
                                var_0 _meth_830F( var_13 );

                            continue;
                        }

                        var_0 _meth_830F( var_13 );
                    }

                    var_0.isrunningweapongive = 1;
                    thread hordegiveclassweapons( var_0, var_4, var_7 );
                    var_0 armorygiveexoability( var_0.classsettings[var_4]["exoAbility"], 1 );
                    wait 0.1;

                    if ( var_0 _meth_8447( "horde_first_spawn" ) == 1 )
                        thread hordeclassrunfirstspawn( var_0 );

                    var_0.classswitchwaiting = 1;
                    var_0 thread classswitchwait();
                }

                break;
            case "horde_exo_upgrade":
                var_0 armorygiveexoability( var_4 );
                break;
            case "horde_equipment_upgrade":
                var_15 = var_0 _meth_8345();

                if ( var_4 != var_0 _meth_8345() )
                {
                    var_0 _meth_8344( var_4 );
                    var_0 _meth_830E( var_4 );
                    var_0 _meth_82F7( var_15, 0 );
                    var_0 _meth_82F6( var_15, 0 );
                }
                else
                    var_0 _meth_82F6( var_4, 4 );

                break;
            case "horde_weapon_upgrade":
                if ( !issubstr( var_4, "iw5" ) && !issubstr( var_4, "ammo" ) && !issubstr( var_4, "turrethead" ) )
                {
                    var_16 = var_0 _meth_8312();

                    if ( issubstr( var_4, "scopevz" ) )
                    {
                        if ( issubstr( var_16, "mors" ) )
                            var_4 = "morsscopevz";
                        else if ( issubstr( var_16, "thor" ) )
                            var_4 = "thorscopevz";
                        else if ( issubstr( var_16, "gm6" ) )
                            var_4 = "gm6scopevz";
                        else if ( issubstr( var_16, "m990" ) )
                            var_4 = "m990scopevz";
                    }

                    var_17 = maps\mp\gametypes\_horde_util::hordegetweaponupgrades( var_16, var_0 );
                    var_18 = maps\mp\gametypes\_horde_util::hordegetattachmentstring( var_17, var_4 );
                    wait 0.05;
                    var_19 = getweaponbasename( var_16 );
                    maps\mp\gametypes\_horde_util::trygivehordeweapon( var_0, var_19 + var_18, 1, 1 );
                }
                else if ( issubstr( var_4, "ammo" ) )
                {
                    var_11 = var_0 _meth_830C();

                    foreach ( var_21 in var_11 )
                    {
                        var_22 = weaponclipsize( var_21 );
                        var_0 _meth_82F6( var_21, var_22 );
                        var_0 _meth_8332( var_21 );
                    }
                }
                else
                {
                    wait 0.05;

                    if ( issubstr( var_4, "turrethead" ) )
                        var_0 thread maps\mp\killstreaks\_rippedturret::playergiveturrethead( var_4 );
                    else
                        maps\mp\gametypes\_horde_util::trygivehordeweapon( var_0, var_4, 1, 1 );
                }

                break;
            case "horde_perk_upgrade":
                if ( issubstr( var_4, "oost" ) )
                    setdvar( "high_jump_height", 512 );
                else if ( issubstr( var_4, "upgrade_points" ) )
                    addarmorypoints( var_0, "round" );
                else
                    var_0 hordegiveperk( var_4 );

                break;
            case "horde_killstreak_upgrade":
                var_0 hordegivekillstreak( var_4, var_2 );
                break;
            case "horde_stat_upgrade":
                switch ( var_4 )
                {
                    case "horde_weapon_proficiency":
                        var_0.weaponproficiency++;
                        var_0 _meth_82FB( var_4, var_0.weaponproficiency );
                        level thread hordeweaponlevel( var_0 );
                        maps\mp\gametypes\_horde_util::givegearformaxweaponproficiency( var_0 );
                        break;
                    case "horde_armor":
                        var_0.hordearmor++;
                        var_0 _meth_82FB( var_4, var_0.hordearmor );
                        var_0.maxhealth = var_0.classmaxhealth + var_0.hordearmor * 40;
                        var_0.health = var_0.maxhealth;
                        maps\mp\gametypes\_horde_util::givegearformaxarmorproficiency( var_0 );
                        break;
                    case "horde_exo_battery":
                        var_0.hordeexobattery += 1;
                        level thread hordebatterylevel( var_0 );
                        var_0 _meth_82FB( var_4, var_0.hordeexobattery );
                        var_9 = var_0 _meth_831A();
                        var_0 _meth_84A4( var_9 );
                        var_0 _meth_82FB( "ui_exo_battery_level0", var_0 _meth_84A5( var_9 ) );
                        break;
                }

                break;
            case "horde_ability_upgrade":
                hordegivescorestreakupgrade( var_0, var_4 );
                break;
        }

        if ( getdvarint( "horde_ignore_cost" ) == 0 )
        {
            if ( var_5 > 0 )
            {
                var_0.armorypoints -= var_5;
                var_0 _meth_82FB( "ui_horde_player_points", var_0.armorypoints );
            }
        }

        wait 0.05;
    }
}

horderesetarmory( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_1 = 0;

    for (;;)
    {
        var_0 waittill( "luinotifyserver", var_2, var_3 );

        if ( var_2 == "horde_reset_armory" )
        {
            var_0 _meth_82FB( "ui_horde_armory_type", "none" );

            if ( var_3 == 2 )
                hordecleanuparmory( var_0 );

            continue;
        }

        if ( var_2 == "ui_horde_secondary_index" )
        {
            var_4 = var_0 _meth_830C();
            var_5 = maps\mp\gametypes\_horde_util::hordegetweaponbasenamespecial( var_0 _meth_8312() );

            foreach ( var_7 in var_4 )
            {
                var_8 = maps\mp\gametypes\_horde_util::hordegetweaponbasenamespecial( var_7 );

                if ( var_8 != var_5 )
                    var_1 = int( tablelookup( "mp/hordeMenus.csv", 2, var_8, 0 ) );
            }

            var_0 _meth_82FB( "ui_horde_secondary_index", var_1 );
        }
    }
}

hordecleanuparmory( var_0 )
{
    if ( isdefined( var_0.usingarmory ) )
    {
        var_0.usingarmory = undefined;
        var_0 _meth_82FB( "ui_horde_show_armory", 0 );

        if ( !maps\mp\gametypes\_horde_util::isplayerinlaststand( var_0 ) )
            var_0 _meth_832B();
    }
}

hordeclassrunfirstspawn( var_0 )
{
    var_0.health = var_0.classmaxhealth;
    var_0.ignoreme = 0;
    var_0 _meth_82FB( "horde_first_spawn", 0 );
    var_0 _meth_82FB( "ui_horde_show_armory", 0 );
    var_0.classchosen = 1;
    var_0 hordeequipstartgrenade();
    level.noonespawnedyet = 0;
}

hordeequipstartgrenade()
{
    var_0 = 4;
    var_1 = self _meth_8447( "ui_horde_player_class" );
    var_2 = self.classsettings[var_1]["classGrenade"];
    self _meth_8344( var_2 );
    self _meth_82F6( var_2, var_0 );
    self _meth_830E( var_2 );
}

hordegiveclassweapons( var_0, var_1, var_2 )
{
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    var_3 = undefined;
    var_4 = undefined;

    if ( var_2 != "none" )
    {
        var_3 = var_0.hordeclassweapons[var_2]["secondary"];
        var_4 = var_0.hordeclassweapons[var_2]["primary"];
    }

    maps\mp\gametypes\_horde_util::trygivehordeweapon( var_0, var_0.hordeclassweapons[var_1]["secondary"], 1, 0, var_3, "secondary" );

    if ( var_0 _meth_8447( "horde_first_spawn" ) == 0 || var_0 _meth_8447( "horde_first_spawn" ) == 1 && var_0.hordeclassweapons[var_1]["primary"] != "iw5_kf5_mp" )
        maps\mp\gametypes\_horde_util::trygivehordeweapon( var_0, var_0.hordeclassweapons[var_1]["primary"], 1, 1, var_4, "primary" );

    if ( isdefined( var_1 ) && ( isdefined( var_2 ) && var_2 != "none" ) )
    {
        if ( isdefined( var_0.hordeclassweapons[var_1]["primaryStoredAmmoClip"] ) )
            var_0 _meth_82F6( var_0.hordeclassweapons[var_1]["primary"], var_0.hordeclassweapons[var_1]["primaryStoredAmmoClip"] );

        if ( isdefined( var_0.hordeclassweapons[var_1]["primaryStoredAmmoStock"] ) )
            var_0 _meth_82F7( var_0.hordeclassweapons[var_1]["primary"], var_0.hordeclassweapons[var_1]["primaryStoredAmmoStock"] );

        if ( isdefined( var_0.hordeclassweapons[var_1]["secondaryStoredAmmoClip"] ) )
            var_0 _meth_82F6( var_0.hordeclassweapons[var_1]["secondary"], var_0.hordeclassweapons[var_1]["secondaryStoredAmmoClip"] );

        if ( isdefined( var_0.hordeclassweapons[var_1]["secondaryStoredAmmoStock"] ) )
            var_0 _meth_82F7( var_0.hordeclassweapons[var_1]["secondary"], var_0.hordeclassweapons[var_1]["secondaryStoredAmmoStock"] );

        if ( !isdefined( var_0.hordeclassweapons[var_1]["lethalStoredGrenade"] ) )
            var_0 hordeequipstartgrenade();
        else
        {
            var_0 _meth_8344( var_0.hordeclassweapons[var_1]["lethalStoredGrenade"] );
            var_0 _meth_830E( var_0.hordeclassweapons[var_1]["lethalStoredGrenade"] );
            var_0 _meth_82F7( var_0.hordeclassweapons[var_1]["lethalStoredGrenade"], var_0.hordeclassweapons[var_1]["lethalStoredGrenadeStock"] );
            var_0 _meth_82F6( var_0.hordeclassweapons[var_1]["lethalStoredGrenade"], var_0.hordeclassweapons[var_1]["lethalStoredGrenadeStock"] );
        }
    }

    var_0.isrunningweapongive = 0;
}

addarmorypoints( var_0, var_1 )
{
    var_2 = 0;

    switch ( var_1 )
    {
        case "round":
            var_2 = 2;
            break;
        case "support_bar_filled":
            var_2 = 1;
            break;
        case "objective_complete":
            var_2 = 2;
            break;
    }

    var_0.armorypoints += var_2;
    var_0.armorypoints = int( min( var_0.armorypoints, 999 ) );
    var_0 _meth_82FB( "ui_horde_player_points", var_0.armorypoints );
    var_0.roundupgradepoints += var_2;
}

armorygiveexoability( var_0, var_1 )
{
    var_2 = self _meth_8447( "ui_horde_player_class" );
    var_3 = self _meth_831A();

    switch ( var_3 )
    {
        case "exocloakhorde_equipment_mp":
            maps\mp\_exo_cloak::take_exo_cloak();
            break;
        case "exohoverhorde_equipment_mp":
            maps\mp\_exo_hover::take_exo_hover();
            break;
        case "exoshieldhorde_equipment_mp":
            maps\mp\_exo_shield::take_exo_shield();
            break;
        case "exoping_equipment_mp":
            maps\mp\_exo_ping::take_exo_ping();
            break;
        case "exorepulsor_equipment_mp":
            maps\mp\_exo_repulsor::take_exo_repulsor();
            break;
        case "extra_health_mp":
            maps\mp\_extrahealth::take_exo_health();
            break;
    }

    wait 0.05;
    self _meth_8319( var_0 );

    switch ( var_0 )
    {
        case "exocloakhorde_equipment_mp":
            maps\mp\_exo_cloak::give_exo_cloak();
            break;
        case "exohoverhorde_equipment_mp":
            maps\mp\_exo_hover::give_exo_hover();
            break;
        case "exoshieldhorde_equipment_mp":
            maps\mp\_exo_shield::give_exo_shield();
            break;
        case "exoping_equipment_mp":
            maps\mp\_exo_ping::give_exo_ping();
            break;
        case "exorepulsor_equipment_mp":
            maps\mp\_exo_repulsor::give_exo_repulsor();
            break;
        case "extra_health_mp":
            maps\mp\_extrahealth::give_exo_health();
            break;
    }

    waitframe();

    if ( isdefined( var_1 ) && var_1 )
    {
        self _meth_84A3( var_0, self.classsettings[var_2]["battery"] );
        self _meth_82FB( "ui_exo_battery_level0", self.classsettings[var_2]["battery"] );
    }
    else
        self _meth_84A4( var_0 );

    self.classsettings[var_2]["exoAbility"] = var_0;
    level thread hordebatterylevel( self );
}

armorypurchasefail( var_0 )
{
    var_0 playsoundtoplayer( "disable_activeperk", var_0 );
}

hordeweaponlevel( var_0 )
{
    var_1 = var_0.weaponproficiency;

    while ( isdefined( var_0.updatinglootweapon ) && var_0.updatinglootweapon )
        waitframe();

    if ( var_0.weaponproficiency > var_1 )
        return;

    var_2 = getweaponbasename( var_0 _meth_8312() );

    if ( isdefined( var_2 ) )
        var_2 = maps\mp\_utility::strip_suffix( var_2, "_mp" );

    var_3 = var_0 _meth_830C();

    foreach ( var_5 in var_3 )
    {
        var_6 = 0;

        if ( !isdefined( var_2 ) || issubstr( var_5, var_2 ) )
            var_6 = 1;

        if ( issubstr( var_5, "alt_iw5" ) )
            continue;

        var_7 = getweaponbasename( var_5 );
        var_8 = getsubstr( var_5, var_7.size );
        var_9 = var_7 + var_8;
        maps\mp\gametypes\_horde_util::trygivehordeweapon( var_0, var_9, 1, var_6, var_5 );
    }

    var_0.weapondmgmod += 0.2;
}

hordebatterylevel( var_0 )
{
    var_1 = -0.1;
    var_0 _meth_84A6( "exocloakhorde_equipment_mp", 1 + var_0.hordeexobattery * var_1 );
    var_0 _meth_84A6( "exoshieldhorde_equipment_mp", 1 + var_0.hordeexobattery * var_1 );
    var_0 _meth_84A6( "exohoverhorde_equipment_mp", 1 + var_0.hordeexobattery * var_1 );
    var_0 _meth_84A6( "exorepulsor_equipment_mp", 1 + var_0.hordeexobattery * var_1 );
    var_0 _meth_84A6( "extra_health_mp", 1 + var_0.hordeexobattery * var_1 );
}

hordegiveability( var_0, var_1 )
{
    var_0.currentkillstreaks[1] = var_0.classsettings[var_1]["killstreak"];

    if ( var_0.classabilityready )
    {
        var_2 = var_0 maps\mp\killstreaks\_killstreaks::getnexthordekillstreakslotindex( 1 );
        var_0 thread maps\mp\killstreaks\_killstreaks::givehordekillstreak( var_0.currentkillstreaks[1], self.owner, var_0.hordekillstreakmodules, 1, 1 );
        thread maps\mp\gametypes\_horde_util::hordescorestreaksplash( var_0, var_0.currentkillstreaks[1], "horde_ss_splash_" + var_0.currentkillstreaks[1], var_2 );
    }
    else
        var_0 thread maps\mp\killstreaks\_killstreaks::givehordekillstreak( var_0.currentkillstreaks[1], self.owner, var_0.hordekillstreakmodules, 1, 0 );

    level thread hordemonitorclassability( var_0, var_1 );
}

hordemonitorclassability( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "horde_class_change" );
    var_0 endon( "ability_upgraded" );
    var_0 endon( "horde_end_spectate" );
    level endon( "game_ended" );
    level endon( "zombies_start" );

    for (;;)
    {
        if ( var_1 == "light" )
            var_0 waittill( "used_horde_uav" );
        else if ( var_1 == "heavy" )
            var_0 waittill( "used_horde_goliath" );
        else if ( var_1 == "demolition" )
            var_0 waittill( "used_horde_missile_strike" );
        else if ( var_1 == "support" )
        {
            while ( !isdefined( var_0.hordeclassturret ) || isdefined( var_0.hordeclassturret ) && ( isdefined( var_0.iscarrying ) && var_0.iscarrying ) )
                wait 0.1;
        }

        var_0.classabilityready = 0;
        var_2 = getabilitywaittime( var_0 );

        if ( var_1 == "support" )
            level thread hordewaitforturretdeath( var_0, var_2 );
        else if ( var_1 == "heavy" )
            level thread hordewaitforgoliathdeath( var_0, var_2 );
        else
            level thread hordeabilityregenbar( var_0, var_2 );

        var_0 waittill( "ability_regenerated" );
    }
}

getabilitywaittime( var_0 )
{
    var_1 = 120;

    if ( var_0 maps\mp\_utility::_hasperk( "specialty_class_hardline" ) )
        var_1 = 90;

    return var_1;
}

hordeabilityregenbar( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "horde_end_spectate" );
    level endon( "game_ended" );
    level endon( "zombies_start" );
    var_2 = 0;

    while ( var_2 < 1 )
    {
        wait 1;
        var_2 += 1 / var_1;
        var_0 _meth_82FB( "ks_count1", var_2 );
        var_0 _meth_82FB( "ks_count_updated", 1 );
    }

    var_0 _meth_82FB( "ks_count1", 0 );
    var_0 _meth_82FB( "ks_count_updated", 1 );
    var_0.classabilityready = 1;
    var_3 = var_0 maps\mp\killstreaks\_killstreaks::getnexthordekillstreakslotindex( 1 );
    var_0 thread maps\mp\killstreaks\_killstreaks::givehordekillstreak( var_0.currentkillstreaks[1], self.owner, var_0.hordekillstreakmodules, 1, 1 );
    thread maps\mp\gametypes\_horde_util::hordescorestreaksplash( var_0, var_0.currentkillstreaks[1], "horde_ss_splash_" + var_0.currentkillstreaks[1], var_3 );
    var_0 notify( "ability_regenerated" );
}

hordewaitforturretdeath( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "becameSpectator" );
    level endon( "game_ended" );
    level endon( "zombies_start" );
    var_0.hordeclassturret waittill( "death" );
    var_0.hordeclassturret = undefined;
    level thread hordeabilityregenbar( var_0, var_1 );
}

hordewaitforgoliathdeath( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "becameSpectator" );
    var_0 endon( "cancel_goliath_wait" );
    level endon( "game_ended" );
    level endon( "zombies_start" );
    var_0 waittill( "startJuggCooldown" );
    level thread hordeabilityregenbar( var_0, var_1 );
}

hordeisarmoryupgrade( var_0 )
{
    if ( var_0 == "horde_stat_upgrade" || var_0 == "horde_weapon_upgrade" || var_0 == "horde_perk_upgrade" || var_0 == "horde_killstreak_upgrade" || var_0 == "horde_exo_upgrade" || var_0 == "horde_exo_class" || var_0 == "horde_equipment_upgrade" || var_0 == "horde_ability_upgrade" )
        return 1;

    return 0;
}

hordeisinscorestreakmodules( var_0, var_1 )
{
    if ( var_1 == "sentry_machinegun_turret" )
    {
        if ( common_scripts\utility::array_contains( var_0.hordekillstreakmodules, "sentry_energy_turret" ) )
            return 0;

        if ( common_scripts\utility::array_contains( var_0.hordekillstreakmodules, "sentry_rocket_turret" ) )
            return 0;

        return 1;
    }
    else
        return common_scripts\utility::array_contains( var_0.hordekillstreakmodules, var_1 );
}

hordeshouldupgradefail( var_0, var_1, var_2, var_3 )
{
    var_4 = var_0 _meth_8447( "ui_horde_armory_type" );

    if ( var_0.classswitchwaiting )
        return 1;

    if ( getdvarint( "horde_ignore_cost" ) == 1 )
        return 0;

    var_5 = var_0 _meth_830C();
    var_6 = var_0 _meth_8312();
    var_7 = var_0 _meth_831A();
    var_8 = var_0 _meth_8345();
    var_9 = 9;
    var_10 = 9;

    if ( var_6 == "none" )
        return 1;

    if ( ( issubstr( var_6, "turret" ) || isdefined( var_0.iscarrying ) && var_0.iscarrying ) && !( var_4 == "perk_armory" || var_4 == "killstreak_armory" ) )
        return 1;

    if ( var_2 == var_7 || var_2 == var_8 || hordeisinscorestreakmodules( var_0, var_2 ) )
    {
        if ( var_7 == var_2 )
        {
            if ( var_0 _meth_8334( var_2 ) == 1 )
            {
                var_0 _meth_82FB( "ui_horde_armory_purchase_fail", 6 );
                return 1;
            }
        }
        else if ( var_2 == var_8 )
        {
            if ( var_0 _meth_8334( var_2 ) == 1 )
            {
                var_0 _meth_82FB( "ui_horde_armory_purchase_fail", 5 );
                return 1;
            }
        }
        else
        {
            var_0 _meth_82FB( "ui_horde_armory_purchase_fail", 1 );
            return 1;
        }
    }

    if ( var_1 == "horde_stat_upgrade" )
    {
        if ( var_2 == "horde_weapon_proficiency" && var_0.weaponproficiency > var_9 || var_2 == "horde_armor" && var_0.hordearmor > var_10 || var_2 == "horde_exo_battery" && var_0.hordeexobattery > 4 )
        {
            var_0 _meth_82FB( "ui_horde_armory_purchase_fail", 3 );
            return 1;
        }
    }

    if ( var_3 > var_0.armorypoints )
    {
        var_0 _meth_82FB( "ui_horde_armory_purchase_fail", 0 );
        return 1;
    }

    if ( var_1 == "horde_exo_class" && var_0 _meth_8447( "ui_horde_player_class" ) == var_2 )
    {
        var_0 _meth_82FB( "ui_horde_armory_purchase_fail", 1 );
        return 1;
    }

    if ( ( var_1 == "horde_exo_class" && var_0.classchosen || var_1 == "horde_weapon_upgrade" || var_2 == "horde_weapon_proficiency" ) && level.hordeweaponsjammed )
    {
        var_0 _meth_82FB( "ui_horde_armory_purchase_fail", 4 );
        return 1;
    }

    if ( var_1 == "horde_weapon_upgrade" )
    {
        if ( var_2 == "ammo" )
        {
            if ( hordeammofull( var_0, var_5 ) )
            {
                var_0 _meth_82FB( "ui_horde_armory_purchase_fail", 5 );
                return 1;
            }

            return 0;
        }
        else if ( !issubstr( var_2, "iw5_" ) )
        {
            var_11 = maps\mp\gametypes\_horde_util::hordegetweaponupgrades( var_6, var_0 );
            var_12 = maps\mp\gametypes\_horde_util::hordegetattachmentstring( var_11, var_2 );
            var_13 = 3;

            if ( issubstr( var_12, "optics" ) || issubstr( var_12, "variablereddot" ) || issubstr( var_12, "scope" ) || issubstr( var_6, "akimbosac3" ) )
                var_13 = 4;

            if ( issubstr( var_2, "optics" ) || issubstr( var_2, "variablereddot" ) || issubstr( var_2, "scope" ) )
                return 0;

            if ( var_11.size + 1 > var_13 )
            {
                var_0 _meth_82FB( "ui_horde_armory_purchase_fail", 2 );
                return 1;
            }
        }
        else
        {
            foreach ( var_15 in var_5 )
            {
                var_16 = getweaponbasename( var_15 );
                var_17 = maps\mp\gametypes\_horde_util::hordegetweaponsuffixspecial( var_2 );
                var_2 = maps\mp\_utility::strip_suffix( var_2, var_17 );

                if ( issubstr( var_16, var_2 ) )
                {
                    var_0 _meth_82FB( "ui_horde_armory_purchase_fail", 1 );
                    return 1;
                }
            }
        }
    }

    return 0;
}

hordeammofull( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
    {
        if ( issubstr( var_3, "turret" ) )
            continue;
        else if ( var_0 _meth_82F9( var_3 ) < _func_1E1( var_3 ) || var_0 _meth_82F8( var_3 ) < weaponclipsize( var_3 ) )
            return 0;
    }

    return 1;
}

hordegiveperk( var_0 )
{
    if ( !maps\mp\_utility::_hasperk( var_0 ) )
    {
        maps\mp\_utility::giveperk( var_0, 1, 1 );
        maps\mp\perks\_perks::applyperks();
        var_1 = tablelookup( "mp/hordeMenus.csv", 2, var_0, 0 );
        self _meth_82FB( "ui_horde_update_perk", int( var_1 ) );
        var_2 = self.horde_perks.size;
        self.horde_perks[var_2]["name"] = var_0;
        self.horde_perks[var_2]["index"] = int( var_1 );

        if ( var_0 == "specialty_horde_weaponsfree" )
            self _meth_82FB( "horde_has_weaponsfree", 1 );
    }
}

hordegivekillstreak( var_0, var_1 )
{
    var_2 = maps\mp\gametypes\_horde_util::getslotnumber( self );

    if ( !isdefined( var_2 ) )
        return;

    var_3 = strtok( tablelookup( "mp/hordeMenus.csv", 0, var_1, 8 ), " " );
    var_3 = common_scripts\utility::array_combine( var_3, self.hordekillstreakmodules );
    var_3 = common_scripts\utility::array_remove_duplicates( var_3 );
    self playlocalsound( "ammo_crate_use" );
    var_4 = maps\mp\killstreaks\_killstreaks::getnexthordekillstreakslotindex( var_2 );
    thread maps\mp\killstreaks\_killstreaks::givehordekillstreak( var_0, self, var_3, var_2, 1 );
    self.currentkillstreaks[var_2] = var_0;
    thread maps\mp\gametypes\_horde_util::hordescorestreaksplash( self, var_0, "horde_ss_splash_" + var_0, var_4 );
}

hordegivescorestreakupgrade( var_0, var_1 )
{
    var_2 = var_0 _meth_8447( "ui_horde_player_class" );
    var_0.hordekillstreakmodules[var_0.hordekillstreakmodules.size] = var_1;

    if ( var_1 == "sentry_machinegun_turret" || var_1 == "sentry_energy_turret" || var_1 == "sentry_rocket_turret" )
    {
        if ( var_1 == "sentry_machinegun_turret" )
        {
            foreach ( var_4 in var_0.hordekillstreakmodules )
            {
                if ( var_4 == "sentry_machinegun_turret" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "sentry_machinegun_turret" );
            }

            foreach ( var_4 in var_0.hordekillstreakmodules )
            {
                if ( var_4 == "sentry_energy_turret" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "sentry_energy_turret" );
            }

            foreach ( var_4 in var_0.hordekillstreakmodules )
            {
                if ( var_4 == "sentry_rocket_turret" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "sentry_rocket_turret" );
            }
        }
        else if ( var_1 == "sentry_energy_turret" )
        {
            foreach ( var_4 in var_0.hordekillstreakmodules )
            {
                if ( var_4 == "sentry_rocket_turret" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "sentry_rocket_turret" );
            }
        }
        else if ( var_1 == "sentry_rocket_turret" )
        {
            foreach ( var_4 in var_0.hordekillstreakmodules )
            {
                if ( var_4 == "sentry_energy_turret" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "sentry_energy_turret" );
            }
        }
    }
    else if ( var_1 == "warbird_ai_attack" || var_1 == "warbird_ai_follow" )
    {
        if ( var_1 == "warbird_ai_attack" )
        {
            foreach ( var_4 in var_0.hordekillstreakmodules )
            {
                if ( var_4 == "warbird_ai_follow" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "warbird_ai_follow" );
            }
        }
        else if ( var_1 == "warbird_ai_follow" )
        {
            foreach ( var_4 in var_0.hordekillstreakmodules )
            {
                if ( var_4 == "warbird_ai_attack" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "warbird_ai_attack" );
            }
        }
    }
    else if ( var_1 == "missile_strike_hellfire" || var_1 == "missile_strike_cluster" || var_1 == "missile_strike_chem" )
    {
        if ( var_1 == "missile_strike_cluster" )
        {
            foreach ( var_4 in var_0.hordekillstreakmodules )
            {
                if ( var_4 == "missile_strike_hellfire" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "missile_strike_hellfire" );

                if ( var_4 == "missile_strike_chem" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "missile_strike_chem" );
            }
        }
        else if ( var_1 == "missile_strike_hellfire" )
        {
            foreach ( var_4 in var_0.hordekillstreakmodules )
            {
                if ( var_4 == "missile_strike_cluster" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "missile_strike_cluster" );

                if ( var_4 == "missile_strike_chem" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "missile_strike_chem" );
            }
        }
        else if ( var_1 == "missile_strike_chem" )
        {
            foreach ( var_4 in var_0.hordekillstreakmodules )
            {
                if ( var_4 == "missile_strike_cluster" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "missile_strike_cluster" );

                if ( var_4 == "missile_strike_hellfire" )
                    var_0.hordekillstreakmodules = common_scripts\utility::array_remove( var_0.hordekillstreakmodules, "missile_strike_hellfire" );
            }
        }
    }

    for ( var_24 = var_0.currentkillstreaks.size; var_24 >= 0; var_24-- )
    {
        if ( var_0.pers["killstreaks"][var_24].available == 1 )
            var_0 thread maps\mp\killstreaks\_killstreaks::givehordekillstreak( var_0.currentkillstreaks[var_24], self.owner, var_0.hordekillstreakmodules, var_24, 1 );
    }
}
