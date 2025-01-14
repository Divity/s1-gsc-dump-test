// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

trap_electrofloor_player_watch( var_0 )
{
    self endon( "cooldown" );
    self endon( "no_power" );
    self endon( "deactivate" );
    self endon( "ready" );
    var_1 = 0;
    var_2 = 0.25;

    if ( isdefined( self.script_duration ) )
        var_3 = self.script_duration;
    else
        var_3 = 20;

    while ( var_1 < var_3 )
    {
        wait(var_2);
        var_1 += var_2;

        foreach ( var_5 in level.players )
        {
            if ( !var_5 _meth_80A9( var_0 ) )
                continue;

            var_5 thread electrofloorplayer();
        }
    }
}

trap_electrofloor_trigger_watch( var_0 )
{
    self endon( "cooldown" );
    self endon( "no_power" );
    self endon( "deactivate" );
    self endon( "ready" );
    var_1 = 0;
    var_2 = 0.15;

    if ( isdefined( self.script_duration ) )
        var_3 = self.script_duration;
    else
        var_3 = 20;

    while ( var_1 < var_3 )
    {
        wait(var_2);
        var_1 += var_2;

        if ( !isdefined( level.agentarray ) )
            continue;

        foreach ( var_5 in level.agentarray )
        {
            if ( !isdefined( var_5 ) || !isalive( var_5 ) )
                continue;

            if ( isplayer( var_5 ) )
                continue;

            if ( isdefined( var_5.inspawnanim ) && var_5.inspawnanim == 1 )
                continue;

            if ( !var_5 _meth_80A9( var_0 ) )
                continue;

            var_5 maps\mp\zombies\_zombies::addbuff( "electroBuff", var_5 getelectrobuff( self.owner ) );
        }
    }
}

getelectrobuff( var_0 )
{
    var_1 = maps\mp\zombies\_zombies::getbuff( "electroBuff" );

    if ( !isdefined( var_1 ) )
        var_1 = spawnelectrobuff();

    var_1.lifespan = 0.2;
    var_1.player = var_0;
    return var_1;
}

spawnelectrobuff()
{
    var_0 = spawnstruct();
    var_0.buffremove = ::removeelectrobuff;
    var_0.lifespan = 0.2;
    var_0.damageperstep = 60 * maps\mp\zombies\_zombies::getbufftimestep();
    var_0.speedmultiplier = 0.6;
    self notify( "speed_debuffs_changed" );
    return var_0;
}

updateelectrobuff( var_0 )
{
    var_1 = var_0.player;

    if ( _func_294( var_1 ) )
        var_1 = undefined;

    self _meth_8051( var_0.damageperstep, self.origin, var_1, undefined, "MOD_TRIGGER_HURT", "trap_zm_mp", "none" );
}

removeelectrobuff( var_0 )
{
    self notify( "speed_debuffs_changed" );
}

electrofloorplayer()
{
    if ( isplayer( self ) && maps\mp\_utility::isreallyalive( self ) )
    {
        if ( isdefined( self.exosuitonline ) && self.exosuitonline )
        {
            thread maps\mp\zombies\_mutators::mutatoremz_applyemp();
            playfx( level._effect["mut_emz_attack_sm"], self.origin );
            self playlocalsound( "zmb_emz_impact" );
        }
    }
}
