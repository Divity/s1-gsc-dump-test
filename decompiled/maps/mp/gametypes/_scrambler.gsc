// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

playersethudempscrambled( var_0, var_1, var_2 )
{
    var_3 = gettime();

    if ( var_3 > var_0 )
        return;

    if ( !isdefined( self.scrambleevents ) )
        self.scrambleevents = [];

    _playercleanupscrambleevents();
    var_4 = spawnstruct();
    var_4.endtime = var_0;
    var_4.textid = var_1;
    var_4.typeid = _getscrambletypeidforstring( var_2 );
    var_4.scrambleid = _playergetuniquescrambleid();
    self.scrambleevents[self.scrambleevents.size] = var_4;

    if ( !isdefined( self.scrambleeventcurrent ) || isevent1highpriority( var_4, self.scrambleeventcurrent ) )
    {
        self _meth_82FB( "ui_exo_reboot_end_time", var_4.endtime );
        self _meth_82FB( "ui_exo_reboot_text", var_4.textid );
        self _meth_82FB( "ui_exo_reboot_type", var_4.typeid );
        self.scrambleeventcurrent = var_4;
        thread _playermonitorscrambleevents( var_4 );
    }

    return var_4.scrambleid;
}

playersethudempscrambledoff( var_0 )
{
    if ( !isdefined( self.scrambleevents ) )
        return;

    var_1 = _playergetscrambleevent( var_0 );
    _playercleanupscrambleevents();

    if ( isdefined( var_1 ) )
    {
        self.scrambleevents = common_scripts\utility::array_remove( self.scrambleevents, var_1 );
        var_1 notify( "done" );

        if ( var_1 == self.scrambleeventcurrent )
        {
            var_2 = _playergetnextevent();

            if ( isdefined( var_2 ) )
            {
                self _meth_82FB( "ui_exo_reboot_end_time", var_2.endtime );
                self _meth_82FB( "ui_exo_reboot_text", var_2.textid );
                self _meth_82FB( "ui_exo_reboot_type", var_2.typeid );
                self.scrambleeventcurrent = var_2;
            }
        }
    }

    if ( self.scrambleevents.size == 0 )
    {
        self _meth_82FB( "ui_exo_reboot_end_time", 0 );
        self _meth_82FB( "ui_exo_reboot_type", 0 );
        self.scrambleevents = undefined;
        self.scrambleeventcurrent = undefined;
    }
}

_playermonitorscrambleevents( var_0 )
{
    self notify( "_waitToStartNextScrambleEvent" );
    self endon( "_waitToStartNextScrambleEvent" );
    level endon( "game_ended" );
    self endon( "disconnect" );

    while ( isdefined( self.scrambleeventcurrent ) )
    {
        var_1 = ( self.scrambleeventcurrent.endtime - gettime() ) / 1000;
        var_2 = self.scrambleeventcurrent common_scripts\utility::waittill_notify_or_timeout_return( "done", var_1 );

        if ( isdefined( var_2 ) && var_2 == "timeout" )
            playersethudempscrambledoff( self.scrambleeventcurrent.scrambleid );
    }
}

_getscrambletypeidforstring( var_0 )
{
    switch ( var_0 )
    {
        case "emp":
            return 1;
        case "systemHack":
            return 2;
        default:
            return 0;
    }
}

_playercleanupscrambleevents()
{
    if ( self.scrambleevents.size == 0 )
        return;

    var_0 = [];
    var_1 = gettime();

    foreach ( var_3 in self.scrambleevents )
    {
        if ( var_1 < var_3.endtime )
            var_0[var_0.size] = var_3;
    }

    self.scrambleevents = var_0;
}

_playergetuniquescrambleid()
{
    var_0 = 0;

    foreach ( var_2 in self.scrambleevents )
    {
        if ( var_2.scrambleid >= var_0 )
            var_0 = var_2.scrambleid + 1;
    }

    return var_0;
}

_playergetscrambleevent( var_0 )
{
    foreach ( var_2 in self.scrambleevents )
    {
        if ( var_2.scrambleid == var_0 )
            return var_2;
    }
}

_playergetnextevent()
{
    if ( self.scrambleevents.size == 0 )
        return;

    var_0 = self.scrambleevents[0];

    for ( var_1 = 1; var_1 < self.scrambleevents.size; var_1++ )
    {
        var_2 = self.scrambleevents[var_1];

        if ( isevent1highpriority( var_2, var_0 ) )
            var_0 = var_2;
    }

    return var_0;
}

isevent1highpriority( var_0, var_1 )
{
    return var_0.typeid > var_1.typeid || var_0.typeid == var_1.typeid && var_0.endtime > var_1.endtime;
}

deletescrambler( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2 ) )
            var_2.inplayerscrambler = undefined;
    }

    var_0 notify( "death" );
    var_0 delete();
    self.deployedscrambler = undefined;
    var_4 = [];
    var_4 = maps\mp\_utility::cleanarray( level.scramblers );
    level.scramblers = var_4;
}

monitorscrambleruse()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );

        if ( var_1 == "scrambler" || var_1 == "scrambler_mp" )
        {
            if ( !isalive( self ) )
            {
                var_0 delete();
                return;
            }

            var_0 hide();
            var_0 waittill( "missile_stuck" );
            var_2 = 40;

            if ( var_2 * var_2 < distancesquared( var_0.origin, self.origin ) )
            {
                var_3 = bullettrace( self.origin, self.origin - ( 0, 0, var_2 ), 0, self );

                if ( var_3["fraction"] == 1 )
                {
                    var_0 delete();
                    self _meth_82F7( "scrambler_mp", self _meth_82F9( "scrambler_mp" ) + 1 );
                    continue;
                }

                var_0.origin = var_3["position"];
            }

            var_0 show();

            if ( isdefined( self.deployedscrambler ) )
                deletescrambler( self.deployedscrambler );

            var_4 = var_0.origin;
            var_5 = spawn( "script_model", var_4 );
            var_5.health = 100;
            var_5.team = self.team;
            var_5.owner = self;
            var_5 _meth_82C0( 1 );
            var_5 makescrambler( self );
            var_5 common_scripts\utility::make_entity_sentient_mp( self.team, 1 );
            var_5 scramblersetup( self );
            var_5 thread maps\mp\gametypes\_weapons::createbombsquadmodel( "weapon_jammer_bombsquad", "tag_origin", self );
            level.scramblers[level.scramblers.size] = var_5;
            self.deployedscrambler = var_5;
            self.changingweapon = undefined;
            wait 0.05;

            if ( isdefined( var_0 ) )
                var_0 delete();
        }
    }
}

scramblersetup( var_0 )
{
    self _meth_80B1( "weapon_jammer" );

    if ( level.teambased )
        maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0, 0, 20 ) );
    else
        maps\mp\_entityheadicons::setplayerheadicon( var_0, ( 0, 0, 20 ) );

    thread scramblerdamagelistener( var_0 );
    thread scrambleruselistener( var_0 );
    var_0 thread scramblerwatchowner( self );
    thread scramblerbeepsounds();
    thread maps\mp\_utility::notusableforjoiningplayers( var_0 );
}

scramblerwatchowner( var_0 )
{
    var_0 endon( "death" );
    level endon( "game_ended" );
    common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators", "death" );
    level thread deletescrambler( var_0 );
}

scramblerbeepsounds()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 3.0;
        self playsound( "scrambler_beep" );
    }
}

scramblerdamagelistener( var_0 )
{
    self endon( "death" );
    self.health = 999999;
    self.maxhealth = 100;
    self.damagetaken = 0;

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

        if ( !maps\mp\gametypes\_weapons::friendlyfirecheck( self.owner, var_2 ) )
            continue;

        if ( isdefined( var_10 ) )
        {
            var_11 = maps\mp\_utility::strip_suffix( var_10, "_lefthand" );

            switch ( var_11 )
            {
                case "smoke_grenade_var_mp":
                case "stun_grenade_var_mp":
                case "smoke_grenade_mp":
                case "stun_grenade_mp":
                case "concussion_grenade_mp":
                case "flash_grenade_mp":
                    continue;
            }
        }

        if ( !isdefined( self ) )
            return;

        if ( maps\mp\_utility::ismeleemod( var_5 ) )
            self.damagetaken += self.maxhealth;

        if ( isdefined( var_9 ) && var_9 & level.idflags_penetration )
            self.wasdamagedfrombulletpenetration = 1;

        self.wasdamaged = 1;
        self.damagetaken += var_1;

        if ( isplayer( var_2 ) )
            var_2 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "scrambler" );

        if ( self.damagetaken >= self.maxhealth )
        {
            if ( isdefined( var_0 ) && var_2 != var_0 )
                var_2 notify( "destroyed_explosive" );

            self playsound( "sentry_explode" );
            self.deatheffect = playfx( common_scripts\utility::getfx( "equipment_explode" ), self.origin );
            self _meth_813A();
            var_2 thread deletescrambler( self );
        }
    }
}

scrambleruselistener( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    self _meth_80DA( "HINT_NOICON" );
    self _meth_80DB( &"MP_PATCH_PICKUP_SCRAMBLER" );
    maps\mp\_utility::setselfusable( var_0 );

    for (;;)
    {
        self waittill( "trigger", var_0 );
        var_1 = var_0 _meth_82F9( "scrambler_mp" );

        if ( var_1 < _func_1E1( "scrambler_mp" ) )
        {
            var_0 playlocalsound( "scavenger_pack_pickup" );
            var_0 _meth_82F7( "scrambler_mp", var_1 + 1 );
            var_0 thread deletescrambler( self );
        }
    }
}

scramblerproximitytracker()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );
    level endon( "game_ended" );
    self.scramproxyactive = 0;
    var_0 = 512;

    for (;;)
    {
        wait 0.05;
        self.scramproxyactive = 0;

        foreach ( var_2 in level.scramblers )
        {
            if ( !isdefined( var_2 ) )
                continue;

            if ( !maps\mp\_utility::isreallyalive( self ) )
                continue;

            var_3 = distancesquared( var_2.origin, self.origin );

            if ( level.teambased && var_2.team != self.team || !level.teambased && isdefined( var_2.owner ) && var_2.owner != self )
            {
                if ( var_3 < var_0 * var_0 )
                    self.inplayerscrambler = var_2.owner;
                else
                    self.inplayerscrambler = undefined;

                continue;
            }

            if ( var_3 < var_0 * var_0 )
            {
                self.scramproxyactive = 1;
                break;
            }
        }

        if ( self.scramproxyactive )
        {
            if ( !maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
            {
                maps\mp\_utility::giveperk( "specialty_blindeye", 0 );
                self.scramproxyperk = 1;
            }

            continue;
        }

        if ( isdefined( self.scramproxyperk ) && self.scramproxyperk )
            self.scramproxyperk = 0;
    }
}
