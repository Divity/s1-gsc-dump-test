// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precacheshellshock( "flashbang_mp" );
}

startmonitoringflash()
{
    thread monitorflash();
}

stopmonitoringflash( var_0 )
{
    self notify( "stop_monitoring_flash" );
}

flashrumbleloop( var_0 )
{
    self endon( "stop_monitoring_flash" );
    self endon( "flash_rumble_loop" );
    self notify( "flash_rumble_loop" );
    var_1 = gettime() + var_0 * 1000;

    while ( gettime() < var_1 )
    {
        self _meth_80AD( "damage_heavy" );
        wait 0.05;
    }
}

monitorflash()
{
    self endon( "disconnect" );
    self notify( "monitorFlash" );
    self endon( "monitorFlash" );
    self.flashendtime = 0;
    var_0 = 2.5;

    for (;;)
    {
        self waittill( "flashbang", var_1, var_2, var_3, var_4, var_5, var_6 );

        if ( !isalive( self ) )
            break;

        if ( isdefined( self.usingremote ) )
            continue;

        if ( !isdefined( var_6 ) )
            var_6 = 0;

        var_7 = 0;
        var_8 = 1;

        if ( var_3 < 0.25 )
            var_3 = 0.25;
        else if ( var_3 > 0.8 )
            var_3 = 1;

        var_9 = var_2 * var_3 * var_0;
        var_9 += var_6;

        if ( isdefined( self.stunscaler ) )
            var_9 *= self.stunscaler;

        if ( var_9 < 0.25 )
            continue;

        var_10 = undefined;

        if ( var_9 > 2 )
            var_10 = 0.75;
        else
            var_10 = 0.25;

        if ( level.teambased && isdefined( var_4 ) && isdefined( var_4.team ) && var_4.team == self.team && var_4 != self )
        {
            if ( level.friendlyfire == 0 )
                continue;
            else if ( level.friendlyfire == 1 )
            {

            }
            else if ( level.friendlyfire == 2 )
            {
                var_9 *= 0.5;
                var_10 *= 0.5;
                var_8 = 0;
                var_7 = 1;
            }
            else if ( level.friendlyfire == 3 )
            {
                var_9 *= 0.5;
                var_10 *= 0.5;
                var_7 = 1;
            }
        }
        else if ( isdefined( var_4 ) )
        {
            if ( var_4 != self )
                var_4 maps\mp\gametypes\_missions::processchallenge( "ch_indecentexposure" );
        }

        if ( var_8 && isdefined( self ) )
        {
            thread applyflash( var_9, var_10 );

            if ( isdefined( var_4 ) && var_4 != self )
            {
                var_4 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "flash" );
                var_11 = self;

                if ( isplayer( var_4 ) && var_4 _meth_8221( "specialty_paint" ) && var_4 maps\mp\_utility::_hasperk( "specialty_paint" ) )
                {
                    if ( !var_11 maps\mp\perks\_perkfunctions::ispainted() )
                        var_4 maps\mp\gametypes\_missions::processchallenge( "ch_paint_pro" );

                    var_11 thread maps\mp\perks\_perkfunctions::setpainted( var_4 );
                }
            }
        }

        if ( var_7 && isdefined( var_4 ) )
            var_4 thread applyflash( var_9, var_10 );
    }
}

applyflash( var_0, var_1 )
{
    if ( !isdefined( self.flashduration ) || var_0 > self.flashduration )
        self.flashduration = var_0;

    if ( !isdefined( self.flashrumbleduration ) || var_1 > self.flashrumbleduration )
        self.flashrumbleduration = var_1;

    wait 0.05;

    if ( isdefined( self.flashduration ) )
    {
        self shellshock( "flashbang_mp", self.flashduration );
        self.flashendtime = gettime() + self.flashduration * 1000;
        thread maps\mp\_utility::light_set_override_for_player( "flashed", 0.1, 0.1, self.flashduration - 0.1 );
    }

    if ( isdefined( self.flashrumbleduration ) )
        thread flashrumbleloop( self.flashrumbleduration );

    self.flashduration = undefined;
    self.flashrumbleduration = undefined;
}

isflashbanged()
{
    return isdefined( self.flashendtime ) && gettime() < self.flashendtime;
}
