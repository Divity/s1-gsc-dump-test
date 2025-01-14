// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

movewalk()
{
    var_0 = undefined;

    if ( isdefined( self.pathgoalpos ) && distancesquared( self.origin, self.pathgoalpos ) > 4096 )
        var_0 = "stand";

    var_1 = [[ self.chooseposefunc ]]( var_0 );

    switch ( var_1 )
    {
        case "stand":
            if ( animscripts\setposemovement::standwalk_begin() )
                return;

            if ( isdefined( self.walk_overrideanim ) )
            {
                animscripts\move::movestand_moveoverride( self.walk_overrideanim, self.walk_override_weights );
                return;
            }

            dowalkanim( getwalkanim( "straight" ) );
            break;
        case "crouch":
            if ( animscripts\setposemovement::crouchwalk_begin() )
                return;

            dowalkanim( getwalkanim( "crouch" ) );
            break;
        default:
            if ( animscripts\setposemovement::pronewalk_begin() )
                return;

            self.a.movement = "walk";
            dowalkanim( getwalkanim( "prone" ) );
            break;
    }
}

#using_animtree("generic_human");

dowalkanimoverride( var_0 )
{
    self endon( "movemode" );
    self _meth_8142( %combatrun, 0.6 );
    self _meth_8147( %combatrun, %body, 1, 0.5, self.moveplaybackrate );

    if ( isarray( self.walk_overrideanim ) )
    {
        if ( isdefined( self.walk_override_weights ) )
            var_1 = common_scripts\utility::choose_from_weighted_array( self.walk_overrideanim, self.walk_override_weights );
        else
            var_1 = self.walk_overrideanim[randomint( self.walk_overrideanim.size )];
    }
    else
        var_1 = self.walk_overrideanim;

    self _meth_8152( "moveanim", var_1, 1, 0.2 );
    animscripts\shared::donotetracks( "moveanim" );
}

getwalkanim( var_0 )
{
    if ( self.stairsstate == "up" )
        return animscripts\utility::getmoveanim( "stairs_up" );
    else if ( self.stairsstate == "down" )
        return animscripts\utility::getmoveanim( "stairs_down" );

    var_1 = animscripts\utility::getmoveanim( var_0 );

    if ( !animscripts\utility::isincombat() && !( isdefined( self.noruntwitch ) && self.noruntwitch ) && !( isdefined( self.a.bdisablemovetwitch ) && self.a.bdisablemovetwitch ) )
    {
        var_2 = animscripts\utility::getmoveanim( "straight_twitch" );

        if ( isdefined( self.isunstableground ) && self.isunstableground )
        {
            var_3 = animscripts\traverse\shared::getnextfootdown();

            if ( var_3 == "Left" )
                var_2 = animscripts\utility::getmoveanim( "straight_twitch_l" );
            else if ( var_3 == "Right" )
                var_2 = animscripts\utility::getmoveanim( "straight_twitch_r" );
        }

        if ( isdefined( var_2 ) && var_2.size > 0 )
        {
            var_4 = animscripts\utility::getrandomintfromseed( self.a.runloopcount, 4 );

            if ( var_4 == 0 )
            {
                var_4 = animscripts\utility::getrandomintfromseed( self.a.runloopcount, var_2.size );
                return var_2[var_4];
            }
        }
    }

    if ( isarray( var_1 ) )
        var_1 = var_1[randomint( var_1.size )];

    return var_1;
}

dowalkanim( var_0 )
{
    self endon( "movemode" );
    var_1 = self.moveplaybackrate;

    if ( self.stairsstate != "none" )
        var_1 *= 0.6;

    if ( self.a.pose == "stand" )
    {
        if ( isdefined( self.enemy ) )
        {
            animscripts\cqb::cqbtracking();
            self _meth_810F( "walkanim", animscripts\cqb::determinecqbanim(), %walk_and_run_loops, 1, 1, var_1, 1 );
        }
        else
            self _meth_810F( "walkanim", var_0, %body, 1, 1, var_1, 1 );

        animscripts\run::setmovenonforwardanims( animscripts\utility::getmoveanim( "move_b" ), animscripts\utility::getmoveanim( "move_l" ), animscripts\utility::getmoveanim( "move_r" ) );
        thread animscripts\run::setcombatstandmoveanimweights( "walk" );
    }
    else if ( self.a.pose == "prone" )
        self _meth_8152( "walkanim", animscripts\utility::getmoveanim( "prone" ), 1, 0.3, self.moveplaybackrate );
    else
    {
        self _meth_810F( "walkanim", var_0, %body, 1, 1, var_1, 1 );
        animscripts\run::setmovenonforwardanims( animscripts\utility::getmoveanim( "move_b" ), animscripts\utility::getmoveanim( "move_l" ), animscripts\utility::getmoveanim( "move_r" ) );
        thread animscripts\run::setcombatstandmoveanimweights( "walk" );
    }

    animscripts\notetracks::donotetracksfortime( 0.2, "walkanim" );
    animscripts\run::setshootwhilemoving( 0 );
}
