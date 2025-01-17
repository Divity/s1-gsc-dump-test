// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    self _meth_818F( "face default" );
    self endon( "killanimscript" );
    animscripts\utility::initialize( "grenade_return_throw" );
    self _meth_818E( "zonly_physics" );
    var_0 = undefined;
    var_1 = 1000;

    if ( isdefined( self.enemy ) )
        var_1 = distance( self.origin, self.enemy.origin );

    var_2 = [];

    if ( var_1 < 600 && islowthrowsafe() )
    {
        if ( var_1 < 300 )
        {
            if ( animscripts\utility::usingsmg() )
                var_2 = animscripts\utility::lookupanim( "grenade", "return_throw_short_smg" );
            else
                var_2 = animscripts\utility::lookupanim( "grenade", "return_throw_short" );
        }
        else if ( animscripts\utility::usingsmg() )
            var_2 = animscripts\utility::lookupanim( "grenade", "return_throw_long_smg" );
        else
            var_2 = animscripts\utility::lookupanim( "grenade", "return_throw_long" );
    }

    if ( var_2.size == 0 )
    {
        if ( animscripts\utility::usingsmg() )
            var_2 = animscripts\utility::lookupanim( "grenade", "return_throw_default_smg" );
        else
            var_2 = animscripts\utility::lookupanim( "grenade", "return_throw_default" );
    }

    var_0 = var_2[randomint( var_2.size )];
    self _meth_8110( "throwanim", var_0, %body, 1, 0.3 );
    var_4 = animhasnotetrack( var_0, "grenade_left" ) || animhasnotetrack( var_0, "grenade_right" );

    if ( var_4 )
    {
        animscripts\shared::placeweaponon( self.weapon, "left" );
        thread putweaponbackinrighthand();
        thread notifygrenadepickup( "throwanim", "grenade_left" );
        thread notifygrenadepickup( "throwanim", "grenade_right" );
        self waittill( "grenade_pickup" );
        self _meth_8189();
        animscripts\battlechatter_ai::evaluateattackevent( "grenade" );

        if ( isdefined( self.team ) )
            maps\_dds::dds_notify_grenade( self.grenadeweapon, self.team == "allies", 1 );

        self waittillmatch( "throwanim", "grenade_throw" );
    }
    else
    {
        self waittillmatch( "throwanim", "grenade_throw" );
        self _meth_8189();
        animscripts\battlechatter_ai::evaluateattackevent( "grenade" );

        if ( isdefined( self.team ) )
            maps\_dds::dds_notify_grenade( self.grenadeweapon, self.team == "allies", 1 );
    }

    if ( isdefined( self.grenade ) )
        self _meth_81D3();

    wait 1;

    if ( var_4 )
    {
        self notify( "put_weapon_back_in_right_hand" );
        animscripts\shared::placeweaponon( self.weapon, "right" );
    }
}

islowthrowsafe()
{
    var_0 = ( self.origin[0], self.origin[1], self.origin[2] + 20 );
    var_1 = var_0 + anglestoforward( self.angles ) * 50;
    return sighttracepassed( var_0, var_1, 0, undefined );
}

putweaponbackinrighthand()
{
    self endon( "death" );
    self endon( "put_weapon_back_in_right_hand" );
    self waittill( "killanimscript" );
    animscripts\shared::placeweaponon( self.weapon, "right" );
}

notifygrenadepickup( var_0, var_1 )
{
    self endon( "killanimscript" );
    self endon( "grenade_pickup" );
    self waittillmatch( var_0, var_1 );
    self notify( "grenade_pickup" );
}
