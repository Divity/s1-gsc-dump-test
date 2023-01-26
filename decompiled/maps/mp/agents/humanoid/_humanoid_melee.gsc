// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self endon( "death" );
    self endon( "killanimscript" );
    self._id_24C6 endon( "disconnect" );
    var_0 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint( self._id_24C6 );

    if ( ismeleeblocked() )
        return _id_5B84();

    if ( maps\mp\zombies\_util::_id_508F( self.lungemeleeenabled ) && var_0._id_9C3B )
    {
        if ( !isdefined( self.lungelast ) )
            self.lungelast = 0;

        if ( isdefined( self.meleemovemode ) )
        {
            var_1 = gettime() - self.lungelast > self.lungedebouncems;
            var_2 = maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint( self.origin, var_0.origin );
            var_3 = distancesquared( self._id_24C6.origin, self.origin ) > self.lungeminrangesq;

            if ( var_1 && var_2 && var_3 )
            {
                self.lungelast = gettime();
                doattacklunge( self._id_24C6, var_0.origin );
                return;
            }
        }

        if ( !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase() )
        {
            lungemeleefailed();
            return;
        }
    }

    doattackstandard( self._id_24C6, var_0.origin );
}

ismeleeblocked()
{
    var_0 = self.origin + ( 0, 0, self.meleecheckheight );
    var_1 = self._id_24C6.origin + ( 0, 0, self.meleecheckheight );
    var_2 = undefined;

    if ( isdefined( self._id_24C6.classname ) && self._id_24C6.classname == "misc_turret" && isdefined( self._id_24C6.aiclip ) )
        var_2 = physicstrace( var_0, var_1, self._id_24C6.aiclip );
    else
        var_2 = physicstrace( var_0, var_1 );

    return distancesquared( var_2, var_1 ) > 1;
}

_id_0140()
{
    self _meth_8395( 1, 1 );
}

doattack( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self._id_55BA = undefined;
    self._id_55BB = undefined;

    if ( !isdefined( var_6 ) )
        var_6 = 0;

    var_7 = randomint( self _meth_83D6( var_2 ) );
    var_8 = self _meth_83D3( var_2, var_7 );
    var_9 = getanimlength( var_8 );
    var_10 = getnotetracktimes( var_8, "hit" );
    var_11 = var_9 / var_5 * 0.33;

    if ( var_10.size > 0 )
        var_11 = var_9 / var_5 * var_10[0];

    self _meth_8398( "gravity" );

    if ( var_4 )
        self _meth_8396( "face enemy" );
    else
        self _meth_8396( "face angle abs", ( 0, vectortoyaw( var_0.origin - self.origin ), 0 ) );

    self _meth_8397( "anim deltas" );
    maps\mp\agents\_scripted_agent_anim_util::set_anim_state( var_2, var_7, var_5 );

    if ( var_6 )
    {
        var_12 = getnotetracktimes( var_8, "lunge_start" );
        var_13 = 0;

        if ( var_12.size > 0 )
            var_13 = var_9 / var_5 * var_12[0];

        var_11 -= var_13;

        if ( var_13 > 0 )
            wait(var_13);

        maps\mp\agents\humanoid\_humanoid_util::play_boost_fx( self.lungefx );

        if ( self.lungeanimratescale )
        {
            var_14 = var_1 - self.origin;
            var_15 = getmovedelta( var_8, var_12[0], var_10[0] );
            var_16 = maps\mp\agents\_scripted_agent_anim_util::_id_3EFB( var_14, var_15 );
            var_5 *= clamp( 1 / var_16._id_A3A8, 0.5, 1 );
            var_11 = var_9 / var_5 * var_10[0] - var_9 / var_5 * var_12[0];
            maps\mp\agents\_scripted_agent_anim_util::set_anim_state( var_2 + "_norestart", var_7, var_5 );
        }
    }

    if ( var_3 )
    {
        self _meth_8395( 0, 1 );
        self _meth_839F( self.origin, var_1, var_11 );
        childthread _id_9B26( var_0, var_11, 1, self.lungelerprange );
        maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 1, "DoAttack" );
    }
    else
        self _meth_8395( 1, 1 );

    wait(var_11);
    self notify( "cancel_updatelerppos" );
    self _meth_8397( "anim deltas" );
    self _meth_8395( 1, 1 );

    if ( var_3 )
        maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 0, "DoAttack" );

    if ( attackshouldhit( var_0 ) )
    {
        self notify( "attack_hit", var_0, var_1 );
        var_17 = 0;

        if ( isdefined( var_0 ) )
            var_17 = var_0.health;

        if ( isdefined( self._id_5B83 ) )
            var_17 = self._id_5B83;

        if ( isalive( var_0 ) )
            _id_2CF2( var_0, var_17, "MOD_IMPACT" );
    }
    else
        self notify( "attack_miss", var_0, var_1 );

    self.lastmeleepos = self.origin;
    var_18 = var_9 / var_5 - var_11;

    if ( var_18 > 0 )
        maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe( "attack_anim", "end", var_18 );

    self.lastmeleefinishtime = gettime();
}

attackshouldhit( var_0 )
{
    if ( !isalive( var_0 ) )
        return 0;

    if ( !withinmeleedamagerange() )
        return 0;

    if ( isenemyinfrontofme( var_0, self.meleedot ) )
        return 1;

    if ( maps\mp\agents\humanoid\_humanoid_util::isentstandingonme( var_0 ) )
        return 1;

    return 0;
}

isenemyinfrontofme( var_0, var_1 )
{
    var_2 = vectornormalize( ( var_0.origin - self.origin ) * ( 1.0, 1.0, 0.0 ) );
    var_3 = anglestoforward( self.angles );
    var_4 = vectordot( var_2, var_3 );
    return var_4 > var_1;
}

withinmeleedamagerange()
{
    if ( !maps\mp\agents\humanoid\_humanoid::_id_71E3( "normal" ) )
        return 0;

    if ( maps\mp\agents\humanoid\_humanoid_util::getmeleeradius() > self.meleeradiusbase && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase() )
        return 0;

    return 1;
}

doattackstandard( var_0, var_1 )
{
    var_2 = "attack_stand";
    var_3 = self.nonmoveratescale;
    var_4 = 0;

    if ( isdefined( self.meleemovemode ) )
    {
        var_2 = "attack_" + self.meleemovemode;
        var_4 = 1;
        self.meleemovemode = undefined;
    }

    doattack( var_0, var_1, var_2, 0, var_4, var_3 );
}

doattacklunge( var_0, var_1 )
{
    doattack( var_0, var_1, self.lungeanimstate, 1, 1, self.nonmoveratescale, 1 );
}

_id_9B26( var_0, var_1, var_2, var_3 )
{
    self endon( "killanimscript" );
    self endon( "death" );
    self endon( "cancel_updatelerppos" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    var_4 = self.origin;
    var_5 = var_1;
    var_6 = 0.05;

    for (;;)
    {
        wait(var_6);
        var_5 -= var_6;

        if ( var_5 <= 0 )
            break;

        var_7 = _id_4145( var_0, var_2 );

        if ( !isdefined( var_7 ) )
            break;

        if ( isdefined( var_3 ) )
            var_8 = var_3;
        else
            var_8 = maps\mp\agents\humanoid\_humanoid_util::getmeleeradius() - self.radius;

        var_9 = var_7 - var_4;

        if ( lengthsquared( var_9 ) > var_8 * var_8 )
            var_7 = var_4 + vectornormalize( var_9 ) * var_8;

        self _meth_8396( "face enemy" );
        self _meth_839F( self.origin, var_7, var_5 );
    }
}

_id_4145( var_0, var_1 )
{
    if ( !var_1 )
    {
        var_2 = maps\mp\zombies\_util::_id_2F8E( var_0.origin );
        return var_2;
    }
    else
    {
        var_3 = var_0.origin - self.origin;
        var_4 = length( var_3 );

        if ( var_4 < self._id_0E47 )
            return self.origin;
        else
        {
            var_3 /= var_4;
            var_5 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint( var_0 );

            if ( maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint( self.origin, var_5.origin ) )
                return var_5.origin;
            else
                return undefined;
        }
    }
}

_id_5183( var_0 )
{
    if ( var_0 maps\mp\_riotshield::_id_473D() )
    {
        var_1 = self.origin - var_0.origin;
        var_2 = vectornormalize( ( var_1[0], var_1[1], 0 ) );
        var_3 = anglestoforward( var_0.angles );
        var_4 = vectordot( var_3, var_1 );

        if ( var_0 maps\mp\_riotshield::hasriotshieldequipped() )
        {
            if ( var_4 > 0.766 )
                return 1;
        }
        else if ( var_4 < -0.766 )
            return 1;
    }

    return 0;
}

_id_2CF2( var_0, var_1, var_2 )
{
    if ( _id_5183( var_0 ) )
        return;

    var_0 dodamage( var_1, self.origin, self, self, var_2 );
}

_id_5B84()
{
    self._id_55BA = self.origin;
    self._id_55BB = self._id_24C6.origin;
}

lungemeleefailed()
{
    self.lastlungemeleefailedmypos = self.origin;
    self.lastlungemeleefailedpos = self._id_24C6.origin;
}
