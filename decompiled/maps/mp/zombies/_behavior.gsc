// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

humanoid_begin_melee()
{
    if ( self.ignoreall )
        return 0;

    if ( !isdefined( self.curmeleetarget ) )
        return 0;

    if ( self.aistate == "melee" || maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
        return 0;

    if ( !maps\mp\zombies\_util::has_entered_game() )
        return 0;

    if ( maps\mp\agents\humanoid\_humanoid::wanttoattacktargetbutcant() )
        return 0;

    if ( maps\mp\agents\humanoid\_humanoid::didpastmeleefail() )
        return 0;

    var_0 = maps\mp\zombies\_util::is_true( self.lungemeleeenabled ) && isdefined( self.lungelast ) && gettime() - self.lungelast <= self.lungedebouncems;

    if ( maps\mp\agents\humanoid\_humanoid::didpastlungemeleefail() || var_0 )
    {
        if ( !maps\mp\agents\humanoid\_humanoid::readytomeleetarget( "base" ) )
            return 0;
    }
    else if ( !maps\mp\agents\humanoid\_humanoid::readytomeleetarget( "normal" ) )
        return 0;

    if ( isdefined( self.meleedebouncetime ) )
    {
        var_1 = gettime() - self.lastmeleefinishtime;

        if ( var_1 < self.meleedebouncetime * 1000 )
            return 0;
    }

    if ( !isdefined( self.lastmeleepos ) || distancesquared( self.lastmeleepos, self.origin ) > 256 )
        self.meleemovemode = self.movemode;

    self _meth_839C( self.curmeleetarget );
    return 1;
}

humanoid_seek_enemy_melee( var_0 )
{
    if ( self.ignoreall )
    {
        self.curmeleetarget = undefined;
        return 0;
    }

    var_1 = undefined;

    if ( isdefined( self.distractiondrone ) && maps\mp\agents\humanoid\_humanoid_util::shouldtargetdistractiondrone() )
        var_1 = self.distractiondrone;
    else if ( isdefined( level.zmbhighpriorityenemy ) && !maps\mp\zombies\_util::shouldignoreent( level.zmbhighpriorityenemy ) )
        var_1 = level.zmbhighpriorityenemy;
    else if ( isdefined( self.enemy ) && !maps\mp\zombies\_util::shouldignoreent( self.enemy ) )
        var_1 = self.enemy;

    if ( isdefined( var_1 ) )
    {
        var_2 = self.attackoffset + self.radius * 2;
        var_3 = var_2 * var_2;

        if ( maps\mp\zombies\_util::getzombieslevelnum() >= 3 )
            var_4 = var_2 - self.attackoffset;
        else
            var_4 = self.attackoffset;

        var_5 = var_4 * var_4;
        self.curmeleetarget = var_1;
        var_6 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint( var_1 );
        var_7 = var_6.enemysectororigin;
        var_8 = distancesquared( var_6.origin, self.origin );
        var_9 = distancesquared( var_7, self.origin );
        var_10 = self.bhasnopath;

        if ( var_9 < squared( self.radius ) && distancesquared( var_7, var_6.origin ) > squared( self.radius ) )
        {
            var_10 = 1;
            self notify( "attack_anim", "end" );
        }

        if ( isdefined( var_0 ) && var_0 )
        {
            if ( !var_10 && var_9 > var_3 )
                var_10 = 1;
        }
        else if ( !var_10 && var_9 > var_3 && var_8 > var_5 )
            var_10 = 1;

        if ( var_6.valid )
        {
            if ( !var_10 && var_9 <= var_3 && var_8 > squared( self.defaultgoalradius ) )
                var_10 = 1;

            self _meth_8394( self.defaultgoalradius );
        }
        else if ( !maps\mp\agents\humanoid\_humanoid_util::hasvalidmeleesectorsfortype( var_1, self.meleesectortype ) )
        {
            self _meth_8394( self.defaultgoalradius );
            var_10 = 1;
        }
        else
        {
            self _meth_8394( var_2 );

            if ( var_9 <= var_3 )
            {
                var_6.origin = self.origin;
                var_10 = 1;
            }
        }

        if ( var_10 )
            self _meth_8390( var_6.origin );

        return 1;
    }
    else
    {
        if ( isdefined( self.curmeleetarget ) )
            self.bhasnopath = 1;

        self.curmeleetarget = undefined;
    }

    return 0;
}

humanoid_seek_enemies_all_known()
{
    var_0 = [];
    var_1 = level.characters;

    if ( isdefined( level.npcs ) )
        var_1 = common_scripts\utility::array_combine( var_1, level.npcs );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.ignoreme || isdefined( var_3.owner ) && var_3.owner.ignoreme )
            continue;

        if ( ( isagent( var_3 ) || isplayer( var_3 ) ) && ( var_3 _meth_8546() || isdefined( var_3.owner ) && var_3.owner _meth_8546() ) )
            continue;

        if ( _func_285( self, var_3 ) )
            continue;

        if ( maps\mp\zombies\_util::shouldignoreent( var_3 ) )
            continue;

        if ( isdefined( var_3.canbetargetedby ) )
        {
            if ( !var_3 [[ var_3.canbetargetedby ]]( self ) )
                continue;
        }
        else if ( !isalive( var_3 ) )
            continue;

        var_0[var_0.size] = var_3;
    }

    var_5 = undefined;

    if ( var_0.size > 0 )
        var_5 = sortbydistance( var_0, self.origin );

    if ( isdefined( var_5 ) && var_5.size > 0 )
    {
        var_6 = 300;
        var_7 = distancesquared( var_5[0].origin, self.origin );

        if ( var_7 < var_6 * var_6 )
            var_6 = 16;

        if ( self.bhasnopath || distancesquared( self _meth_8391(), var_5[0].origin ) > var_6 * var_6 )
        {
            self _meth_8390( var_5[0].origin );
            self.bhasnopath = 0;
        }

        return 1;
    }

    return 0;
}

humanoid_seek_random_loc()
{
    var_0 = distancesquared( self _meth_8391(), self.origin ) < self.defaultgoalradius * self.defaultgoalradius;

    if ( var_0 || self.bhasnopath )
    {
        self.last_random_path_node = undefined;

        if ( !isdefined( self.last_random_path_node ) )
        {
            var_1 = getnodesinradiussorted( self.origin, 1024, 256, 512, "Path" );
            var_2 = maps\mp\agents\humanoid\_humanoid_util::find_valid_pathnodes_for_random_pathing( var_1 );

            if ( var_2.size > 0 )
                self.last_random_path_node = common_scripts\utility::random( var_2 );
        }

        if ( isdefined( self.last_random_path_node ) )
        {
            self _meth_8390( self.last_random_path_node.origin );
            self.bhasnopath = 0;
        }
    }

    return !self.bhasnopath;
}

humanoid_follow( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( self.bhasnopath || distancesquared( self _meth_8391(), var_0.origin ) < 16384 )
    {
        self _meth_8390( var_0.origin );
        self.bhasnopath = 0;
    }

    return 1;
}
