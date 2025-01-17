// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    if ( !isdefined( level.sunenable ) )
        level.sunenable = getdvarint( "sm_sunenable", 1 );

    if ( !isdefined( level.sunshadowscale ) )
        level.sunshadowscale = getdvarfloat( "sm_sunshadowscale", 1.0 );

    if ( !isdefined( level.spotlimit ) )
        level.spotlimit = getdvarint( "sm_spotlimit", 4 );

    if ( !isdefined( level.sunsamplesizenear ) )
        level.sunsamplesizenear = getdvarfloat( "sm_sunsamplesizenear", 0.25 );

    if ( !isdefined( level.qualityspotshadow ) )
        level.qualityspotshadow = getdvarfloat( "sm_qualityspotshadow", 1.0 );

    thread monitorplayerspawns();

    if ( !isdefined( level._light ) )
    {
        level._light = spawnstruct();
        light_setup_common_flickerlight_presets();
        light_message_init();
    }

    var_0 = getentarray( "trigger_multiple_light_sunshadow", "classname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        level thread sun_shadow_trigger( var_0[var_1] );
}

set_smdvars( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_0 ) )
        level.sunenable = var_0;

    if ( isdefined( var_1 ) )
        level.sunshadowscale = var_1;

    if ( isdefined( var_2 ) )
        level.spotlimit = var_2;

    if ( isdefined( var_3 ) )
        level.sunsamplesizenear = var_3;

    if ( isdefined( var_4 ) )
        level.qualityspotshadow = var_4;
}

monitorplayerspawns()
{
    if ( isdefined( level.players ) )
    {
        foreach ( var_1 in level.players )
            var_1 initplayer();
    }

    for (;;)
    {
        level waittill( "connected", var_1 );
        var_1 initplayer();
        var_1 thread monitordeath();
    }
}

initplayer()
{
    self.sunenable = level.sunenable;
    self.sunshadowscale = level.sunshadowscale;
    self.spotlimit = level.spotlimit;
    self.sunsamplesizenear = level.sunsamplesizenear;
    self.qualityspotshadow = level.qualityspotshadow;
    self _meth_82FD( "sm_sunenable", self.sunenable, "sm_sunshadowscale", self.sunshadowscale, "sm_spotlimit", self.spotlimit, "sm_qualityspotshadow", self.qualityspotshadow, "sm_sunSampleSizeNear", self.sunsamplesizenear );
}

monitordeath()
{
    self waittill( "spawned" );
    initplayer();
}

sun_shadow_trigger( var_0 )
{
    var_1 = 1;

    if ( isdefined( var_0.script_duration ) )
        var_1 = var_0.script_duration;

    for (;;)
    {
        var_0 waittill( "trigger", var_2 );
        var_0 set_sun_shadow_params( var_1, var_2 );
    }
}

set_sun_shadow_params( var_0, var_1 )
{
    var_2 = var_1.sunenable;
    var_3 = var_1.sunshadowscale;
    var_4 = var_1.spotlimit;
    var_5 = var_1.sunsamplesizenear;
    var_6 = var_1.qualityspotshadow;

    if ( isdefined( self.script_sunenable ) )
        var_2 = self.script_sunenable;

    if ( isdefined( self.script_sunshadowscale ) )
        var_3 = self.script_sunshadowscale;

    if ( isdefined( self.script_spotlimit ) )
        var_4 = self.script_spotlimit;

    if ( isdefined( self.script_sunsamplesizenear ) )
        var_5 = self.script_sunsamplesizenear;

    var_5 = min( max( 0.016, var_5 ), 32 );

    if ( isdefined( self.script_qualityspotshadow ) )
        var_6 = self.script_qualityspotshadow;

    var_1 _meth_82FD( "sm_sunenable", var_2, "sm_sunshadowscale", var_3, "sm_spotlimit", var_4, "sm_qualityspotshadow", var_6 );
    var_1.sunenable = var_2;
    var_1.sunshadowscale = var_3;
    var_1.spotlimit = var_4;
    var_7 = var_1.sunsamplesizenear;
    var_1.sunsamplesizenear = var_5;
    var_1.qualityspotshadow = var_6;
    thread lerp_sunsamplesizenear_overtime( var_5, var_7, var_0, var_1 );
}

lerp_sunsamplesizenear_overtime( var_0, var_1, var_2, var_3 )
{
    level notify( "changing_sunsamplesizenear" + var_3.name );
    level endon( "changing_sunsamplesizenear" + var_3.name );

    if ( var_0 == var_1 )
        return;

    var_4 = var_0 - var_1;
    var_5 = 0.1;
    var_6 = var_2 / var_5;

    if ( var_6 > 0 )
    {
        var_7 = var_4 / var_6;
        var_8 = var_1;

        for ( var_9 = 0; var_9 < var_6; var_9++ )
        {
            var_8 += var_7;
            var_3 _meth_82FC( "sm_sunSampleSizeNear", var_8 );
            var_3.sunsamplesizenear = var_8;
            wait(var_5);
        }
    }

    var_3 _meth_82FC( "sm_sunSampleSizeNear", var_0 );
    var_3.sunsamplesizenear = var_0;
}

light_setup_common_flickerlight_presets()
{
    create_flickerlight_preset( "fire", ( 0.972549, 0.62451, 0.345098 ), ( 0.2, 0.146275, 0.0878432 ), 0.005, 0.2, 8 );
    create_flickerlight_preset( "blue_fire", ( 0.445098, 0.62451, 0.972549 ), ( 0.05, 0.150451, 0.307843 ), 0.005, 0.2, 8 );
    create_flickerlight_preset( "white_fire", ( 0.972549, 0.972549, 0.972549 ), ( 0.2, 0.2, 0.2 ), 0.005, 0.2, 8 );
    create_flickerlight_preset( "pulse", ( 0, 0, 0 ), ( 255, 107, 107 ), 0.2, 1, 8 );
    create_flickerlight_preset( "lightbulb", ( 0.972549, 0.62451, 0.345098 ), ( 0.2, 0.146275, 0.0878432 ), 0.005, 0.2, 6 );
    create_flickerlight_preset( "fluorescent", ( 0.972549, 0.62451, 0.345098 ), ( 0.2, 0.146275, 0.0878432 ), 0.005, 0.2, 7 );
    create_flickerlight_preset( "static_screen", ( 0.63, 0.72, 0.92 ), ( 0.4, 0.43, 0.48 ), 0.005, 0.2, 7 );
}

create_flickerlight_preset( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( level._light.flicker_presets ) )
        level._light.flicker_presets = [];

    var_6 = spawnstruct();
    var_6.color0 = var_1;
    var_6.color1 = var_2;
    var_6.mindelay = var_3;
    var_6.maxdelay = var_4;
    var_6.intensity = var_5;
    level._light.flicker_presets[var_0] = var_6;
}

get_flickerlight_preset( var_0 )
{
    if ( isdefined( level._light.flicker_presets ) && isdefined( level._light.flicker_presets[var_0] ) )
        return level._light.flicker_presets[var_0];

    return undefined;
}

play_flickerlight_preset( var_0, var_1, var_2 )
{
    var_3 = getent( var_1, "targetname" );

    if ( !isdefined( var_3 ) )
        return;

    var_4 = get_flickerlight_preset( var_0 );

    if ( !isdefined( var_4 ) )
        return;

    if ( isdefined( var_2 ) )
    {
        if ( var_2 < 0 )
            var_2 = 0;

        var_4.intensity = var_2;
    }

    var_3 _meth_81DF( var_4.intensity );
    var_3.islightflickering = 1;
    var_3.islightflickerpaused = 0;
    var_3 thread dyn_flickerlight( var_4.color0, var_4.color1, var_4.mindelay, var_4.maxdelay );
    return var_3;
}

stop_flickerlight( var_0, var_1, var_2 )
{
    var_3 = getent( var_1, "targetname" );

    if ( !isdefined( var_3 ) )
        return;

    if ( !isdefined( var_3.islightflickering ) )
        return;

    if ( isdefined( var_2 ) )
    {
        if ( var_2 < 0 )
            var_2 = 0;
    }

    var_3 _meth_81DF( var_2 );
    var_3 notify( "kill_flicker" );
    var_3.islightflickering = undefined;
}

pause_flickerlight( var_0, var_1 )
{
    var_2 = getent( var_1, "targetname" );

    if ( !isdefined( var_2 ) )
        return;

    if ( !isdefined( var_2.islightflickering ) )
        return;

    var_2.islightflickerpaused = 1;
}

unpause_flickerlight( var_0, var_1 )
{
    var_2 = getent( var_1, "targetname" );

    if ( !isdefined( var_2 ) )
        return;

    if ( !isdefined( var_2.islightflickering ) )
        return;

    var_2.islightflickerpaused = 0;
}

dyn_flickerlight( var_0, var_1, var_2, var_3 )
{
    self endon( "kill_flicker" );
    var_4 = var_0;
    var_5 = 0.0;

    for (;;)
    {
        if ( self.islightflickerpaused )
        {
            wait 0.05;
            continue;
        }

        var_6 = var_4;
        var_4 = var_0 + ( var_1 - var_0 ) * randomfloat( 1.0 );

        if ( var_2 != var_3 )
            var_5 += randomfloatrange( var_2, var_3 );
        else
            var_5 += var_2;

        if ( var_5 == 0 )
            var_5 += 0.0000001;

        for ( var_7 = ( var_6 - var_4 ) * 1 / var_5; var_5 > 0 && !self.islightflickerpaused; var_5 -= 0.05 )
        {
            self _meth_8044( var_4 + var_7 * var_5 );
            wait 0.05;
        }
    }
}

model_flicker_preset( var_0, var_1, var_2, var_3 )
{
    var_4 = getentarray( var_0, "script_noteworthy" );

    if ( !isdefined( var_4 ) )
        return;

    self endon( "death" );
    var_5 = 0;
    var_6 = randomfloatrange( 0.1, 0.25 );

    if ( isdefined( var_2 ) )
        exploder( var_2 );

    while ( var_5 < var_1 )
    {
        if ( isdefined( var_3 ) )
            exploder( var_3 );

        foreach ( var_8 in var_4 )
            var_8 show();

        wait(var_6);

        if ( isdefined( var_3 ) )
            stop_exploder( var_3 );

        foreach ( var_8 in var_4 )
            var_8 hide();

        var_5++;
        wait(var_6);
    }
}

light_message_init()
{
    level._light.messages = [];
}

light_debug_dvar_init()
{

}

light_register_message( var_0, var_1 )
{
    level._light.messages[var_0] = var_1;
}

light_message( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level._light.messages[var_0] ) )
    {
        if ( isdefined( var_3 ) )
            thread [[ level._light.messages[var_0] ]]( var_1, var_2, var_3 );
        else if ( isdefined( var_2 ) )
            thread [[ level._light.messages[var_0] ]]( var_1, var_2 );
        else if ( isdefined( var_1 ) )
            thread [[ level._light.messages[var_0] ]]( var_1 );
        else
            thread [[ level._light.messages[var_0] ]]();
    }
}

stop_exploder( var_0 )
{
    var_0 += "";

    if ( isdefined( level.createfxexploders ) )
    {
        var_1 = level.createfxexploders[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( !isdefined( var_3.looper ) )
                    continue;

                var_3.looper delete();
            }

            return;
        }
    }
    else
    {
        for ( var_5 = 0; var_5 < level.createfxent.size; var_5++ )
        {
            var_3 = level.createfxent[var_5];

            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3.v["type"] != "exploder" )
                continue;

            if ( !isdefined( var_3.v["exploder"] ) )
                continue;

            if ( var_3.v["exploder"] + "" != var_0 )
                continue;

            if ( !isdefined( var_3.looper ) )
                continue;

            var_3.looper delete();
        }
    }
}

exploder( var_0 )
{
    [[ level.exploderfunction ]]( var_0 );
}
