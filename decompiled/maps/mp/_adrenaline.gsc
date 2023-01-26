// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_A1F2()
{
    self notify( "exo_overclock_taken" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_overclock_taken" );

    if ( !self hasweapon( "adrenaline_mp" ) )
        return;

    _id_0868();
    thread monitorplayerdeath();
    thread wait_for_game_end();

    for (;;)
    {
        self waittill( "exo_adrenaline_fire" );

        if ( !isalive( self ) )
            return;

        thread _id_98A1();
    }
}

_id_0868()
{
    self.overclock_on = 0;
    self batterysetdischargescale( "adrenaline_mp", 1.0 );
    var_0 = self batterygetsize( "adrenaline_mp" );

    if ( self gettacticalweapon() == "adrenaline_mp" )
    {
        self setclientomnvar( "exo_ability_nrg_req0", 0 );
        self setclientomnvar( "exo_ability_nrg_total0", var_0 );
        self setclientomnvar( "ui_exo_battery_level0", var_0 );
    }
    else if ( self getlethalweapon() == "adrenaline_mp" )
    {
        self setclientomnvar( "exo_ability_nrg_req1", 0 );
        self setclientomnvar( "exo_ability_nrg_total1", var_0 );
        self setclientomnvar( "ui_exo_battery_level1", var_0 );
    }

    if ( !isdefined( level.exo_overclock_vfx_le_active ) )
        level.exo_overclock_vfx_le_active = loadfx( "vfx/lights/exo_overclock_hip_le_start" );

    if ( !isdefined( level.exo_overclock_vfx_ri_active ) )
        level.exo_overclock_vfx_ri_active = loadfx( "vfx/lights/exo_overclock_hip_ri_start" );

    if ( !isdefined( level.exo_overclock_vfx_le_inactive ) )
        level.exo_overclock_vfx_le_inactive = loadfx( "vfx/lights/exo_overclock_hip_le_inactive" );

    if ( !isdefined( level.exo_overclock_vfx_ri_inactive ) )
        level.exo_overclock_vfx_ri_inactive = loadfx( "vfx/lights/exo_overclock_hip_ri_inactive" );

    wait 0.05;

    if ( !maps\mp\_utility::invirtuallobby() )
    {
        playfxontag( level.exo_overclock_vfx_le_inactive, self, "J_Hip_LE" );
        playfxontag( level.exo_overclock_vfx_ri_inactive, self, "J_Hip_RI" );
    }
}

_id_98A1()
{
    self endon( "exo_overclock_taken" );

    if ( self.overclock_on == 1 )
        thread stopadrenaline( 1 );
    else
        thread _id_8CF5();
}

_id_536F()
{
    if ( isdefined( self._id_65D3 ) )
    {
        self._id_65D3 delete();
        self._id_65D3 = undefined;
    }

    if ( isdefined( self._id_65D4 ) )
    {
        self._id_65D4 delete();
        self._id_65D4 = undefined;
    }
}

_id_8CF5()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_overclock_taken" );
    self endon( "EndAdrenaline" );
    self.overclock_on = 1;
    maps\mp\gametypes\_gamelogic::sethasdonecombat( self, 1 );
    self.adrenaline_speed_scalar = 1.12;

    if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        self.movespeedscaler = self.adrenaline_speed_scalar + maps\mp\_utility::lightweightscalar() - 1;
    else
        self.movespeedscaler = self.adrenaline_speed_scalar;

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        var_0 = self getclientomnvar( "ui_horde_player_class" );
        self.movespeedscaler = min( level._id_1E3A[var_0]["speed"] + 0.25, 1.12 );
    }

    maps\mp\gametypes\_weapons::updatemovespeedscale();
    self batterydischargebegin( "adrenaline_mp" );
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar( "adrenaline_mp", "ui_exo_battery_toggle", 1 );
    thread maps\mp\_exo_battery::update_exo_battery_hud( "adrenaline_mp" );
    thread _id_5DD2();
    maps\mp\_snd_common_mp::snd_message( "mp_exo_overclock_activate" );
    _id_536F();
    wait 0.05;

    if ( !self.overclock_on )
        return;

    if ( !isdefined( self.exo_cloak_on ) || self.exo_cloak_on == 0 )
    {
        self._id_65D3 = _func_2C1( level.exo_overclock_vfx_le_active, self, "J_Hip_LE" );
        self._id_65D4 = _func_2C1( level.exo_overclock_vfx_ri_active, self, "J_Hip_RI" );
        triggerfx( self._id_65D3 );
        triggerfx( self._id_65D4 );
    }
}

stopadrenaline( var_0 )
{
    if ( !isdefined( self.overclock_on ) || !self.overclock_on )
        return;

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    self notify( "EndAdrenaline" );
    self.overclock_on = 0;

    if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        self.movespeedscaler = maps\mp\_utility::lightweightscalar();
    else
        self.movespeedscaler = level.baseplayermovescale;

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        var_1 = self getclientomnvar( "ui_horde_player_class" );
        self.movespeedscaler = level._id_1E3A[var_1]["speed"];
    }

    maps\mp\gametypes\_weapons::updatemovespeedscale();
    self.adrenaline_speed_scalar = undefined;
    self batterydischargeend( "adrenaline_mp" );
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar( "adrenaline_mp", "ui_exo_battery_toggle", 0 );
    _id_536F();

    if ( var_0 == 1 )
    {
        maps\mp\_snd_common_mp::snd_message( "mp_exo_overclock_deactivate" );
        wait 0.05;

        if ( !isdefined( self.exo_cloak_on ) || self.exo_cloak_on == 0 )
        {
            self._id_65D3 = _func_2C1( level.exo_overclock_vfx_le_inactive, self, "J_Hip_LE" );
            self._id_65D4 = _func_2C1( level.exo_overclock_vfx_ri_inactive, self, "J_Hip_RI" );
            triggerfx( self._id_65D3 );
            triggerfx( self._id_65D4 );
        }
    }
}

monitorplayerdeath()
{
    self endon( "disconnect" );
    common_scripts\utility::waittill_any( "death", "joined_team", "faux_spawn", "exo_overclock_taken" );
    thread stopadrenaline( 0 );
}

_id_5DD2()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_overclock_taken" );
    self endon( "EndAdrenaline" );

    while ( self.overclock_on == 1 )
    {
        if ( self batterygetcharge( "adrenaline_mp" ) <= 0 )
            thread stopadrenaline( 1 );

        wait 0.05;
    }
}

take_exo_overclock()
{
    self notify( "kill_battery" );
    self notify( "exo_overclock_taken" );
    self takeweapon( "adrenaline_mp" );
}

give_exo_overclock()
{
    self giveweapon( "adrenaline_mp" );
    thread _id_A1F2();
}

wait_for_game_end()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_overclock_taken" );
    level waittill( "game_ended" );
    thread stopadrenaline( 0 );
}
