// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_A212()
{
    self notify( "exo_health_taken" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_health_taken" );

    if ( !self hasweapon( "extra_health_mp" ) )
        return;

    _id_35AB();
    thread monitorplayerdeath();
    thread wait_for_game_end();

    for (;;)
    {
        self waittill( "exo_ability_activate", var_0 );

        if ( var_0 == "extra_health_mp" )
        {
            if ( !isalive( self ) )
                return;

            thread _id_98A9();
        }
    }
}

_id_35AB()
{
    self.exo_health_on = 0;
    self batterysetdischargescale( "extra_health_mp", 1.0 );
    var_0 = self batterygetsize( "extra_health_mp" );

    if ( self gettacticalweapon() == "extra_health_mp" )
    {
        self setclientomnvar( "exo_ability_nrg_req0", 0 );
        self setclientomnvar( "exo_ability_nrg_total0", var_0 );
        self setclientomnvar( "ui_exo_battery_level0", var_0 );
    }
    else if ( self getlethalweapon() == "extra_health_mp" )
    {
        self setclientomnvar( "exo_ability_nrg_req1", 0 );
        self setclientomnvar( "exo_ability_nrg_total1", var_0 );
        self setclientomnvar( "ui_exo_battery_level1", var_0 );
    }

    if ( !isdefined( level.exo_health_le_inactive_vfx ) )
        level.exo_health_le_inactive_vfx = loadfx( "vfx/unique/exo_health_le_inactive" );

    if ( !isdefined( level.exo_health_le_active_vfx ) )
        level.exo_health_le_active_vfx = loadfx( "vfx/unique/exo_health_le_active" );

    if ( !isdefined( level.exo_health_rt_inactive_vfx ) )
        level.exo_health_rt_inactive_vfx = loadfx( "vfx/unique/exo_health_rt_inactive" );

    if ( !isdefined( level.exo_health_rt_active_vfx ) )
        level.exo_health_rt_active_vfx = loadfx( "vfx/unique/exo_health_rt_active" );

    wait 0.05;

    if ( !maps\mp\_utility::invirtuallobby() )
    {
        playfxontag( level.exo_health_le_inactive_vfx, self, "J_Shoulder_LE" );
        playfxontag( level.exo_health_rt_inactive_vfx, self, "J_Shoulder_RI" );
    }
}

_id_98A9()
{
    self endon( "exo_health_taken" );

    if ( self.exo_health_on == 1 )
        thread stopextrahealth( 1 );
    else
        thread _id_8D0F();
}

_id_537E()
{
    if ( isdefined( self._id_8E33 ) )
    {
        self._id_8E33 delete();
        self._id_8E33 = undefined;
    }

    if ( isdefined( self._id_8E34 ) )
    {
        self._id_8E34 delete();
        self._id_8E34 = undefined;
    }
}

_id_8D0F()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_health_taken" );
    self endon( "EndExtraHealth" );
    self.exo_health_on = 1;
    self.maxhealth = int( self.maxhealth * 1.4 );
    self.ignoreregendelay = 1;
    self.healthregenlevel = 0.99;
    self notify( "damage" );
    self batterydischargebegin( "extra_health_mp" );
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar( "extra_health_mp", "ui_exo_battery_toggle", 1 );
    thread maps\mp\_exo_battery::update_exo_battery_hud( "extra_health_mp" );
    thread _id_5EDF();
    maps\mp\_snd_common_mp::snd_message( "mp_exo_health_activate" );
    _id_537E();
    wait 0.05;

    if ( !self.exo_health_on )
        return;

    if ( !isdefined( self.exo_cloak_on ) || self.exo_cloak_on == 0 )
    {
        self._id_8E33 = _func_2C1( level.exo_health_le_active_vfx, self, "J_Shoulder_LE" );
        self._id_8E34 = _func_2C1( level.exo_health_rt_active_vfx, self, "J_Shoulder_RI" );
        triggerfx( self._id_8E33 );
        triggerfx( self._id_8E34 );
    }
}

stopextrahealth( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_health_taken" );

    if ( !isdefined( self.exo_health_on ) || !self.exo_health_on )
        return;

    self notify( "EndExtraHealth" );
    self endon( "EndExtraHealth" );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    self.exo_health_on = 0;

    if ( isdefined( level.ishorde ) )
        self.maxhealth = self._id_1E37 + self._id_4957 * 40;
    else
        self.maxhealth = int( self.maxhealth / 1.4 );

    if ( self.health > self.maxhealth )
        self.health = self.maxhealth;

    self.healthregenlevel = undefined;
    self batterydischargeend( "extra_health_mp" );
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar( "extra_health_mp", "ui_exo_battery_toggle", 0 );
    _id_537E();

    if ( var_0 == 1 )
    {
        maps\mp\_snd_common_mp::snd_message( "mp_exo_health_deactivate" );
        wait 0.05;

        if ( !isdefined( self.exo_cloak_on ) || self.exo_cloak_on == 0 )
        {
            self._id_8E33 = _func_2C1( level.exo_health_le_inactive_vfx, self, "J_Shoulder_LE" );
            self._id_8E34 = _func_2C1( level.exo_health_rt_inactive_vfx, self, "J_Shoulder_RI" );
            triggerfx( self._id_8E33 );
            triggerfx( self._id_8E34 );
        }
    }
}

monitorplayerdeath()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    common_scripts\utility::waittill_any( "death", "joined_team", "faux_spawn", "exo_health_taken" );
    thread stopextrahealth( 0 );
}

_id_5EDF()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_health_taken" );

    while ( self.exo_health_on == 1 )
    {
        if ( self batterygetcharge( "extra_health_mp" ) <= 0 )
            thread stopextrahealth( 1 );

        wait 0.05;
    }
}

take_exo_health()
{
    self notify( "kill_battery" );
    self notify( "exo_health_taken" );
    self takeweapon( "extra_health_mp" );
}

give_exo_health()
{
    self giveweapon( "extra_health_mp" );
    thread _id_A212();
}

wait_for_game_end()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_health_taken" );
    level waittill( "game_ended" );
    thread stopextrahealth( 0 );
}
