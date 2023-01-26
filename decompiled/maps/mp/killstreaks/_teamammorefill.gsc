// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakfuncs["team_ammo_refill"] = ::_id_98C9;
}

_id_98C9( var_0, var_1 )
{
    var_2 = _id_4208();

    if ( var_2 )
        maps\mp\_matchdata::logkillstreakevent( "team_ammo_refill", self.origin );

    return var_2;
}

_id_4208()
{
    if ( level.teambased )
    {
        foreach ( var_1 in level.players )
        {
            if ( var_1.team == self.team )
                var_1 refillammo( 1 );
        }
    }
    else
        refillammo( 1 );

    level thread maps\mp\_utility::teamplayercardsplash( "used_team_ammo_refill", self );
    return 1;
}

refillammo( var_0 )
{
    var_1 = self getweaponslistall();

    foreach ( var_3 in var_1 )
    {
        if ( issubstr( var_3, "grenade" ) || getsubstr( var_3, 0, 2 ) == "gl" )
        {
            if ( !var_0 || self getammocount( var_3 ) >= 1 )
                continue;
        }

        self givemaxammo( var_3 );
    }

    self playlocalsound( "ammo_crate_use" );
}
