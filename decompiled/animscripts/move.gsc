// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

init_animset_default_move()
{
    var_0 = [];
    var_0["fire"] = %exposed_shoot_auto_v3;
    var_0["single"] = [ %exposed_shoot_semi1 ];
    var_0["single_shotgun"] = [ %shotgun_stand_fire_1a, %shotgun_stand_fire_1b ];
    var_0["burst2"] = %exposed_shoot_burst3;
    var_0["burst3"] = %exposed_shoot_burst3;
    var_0["burst4"] = %exposed_shoot_burst4;
    var_0["burst5"] = %exposed_shoot_burst5;
    var_0["burst6"] = %exposed_shoot_burst6;
    var_0["semi2"] = %exposed_shoot_semi2;
    var_0["semi3"] = %exposed_shoot_semi3;
    var_0["semi4"] = %exposed_shoot_semi4;
    var_0["semi5"] = %exposed_shoot_semi5;
    anim.archetypes["soldier"]["shoot_while_moving"] = var_0;
    var_0 = [];
    var_0["shuffle_start_from_cover_left"] = %cornercrl_alert_2_shuffle;
    var_0["shuffle_start_from_cover_right"] = %cornercrr_alert_2_shuffle;
    var_0["shuffle_start_left"] = %covercrouch_hide_2_shufflel;
    var_0["shuffle_start_right"] = %covercrouch_hide_2_shuffler;
    var_0["shuffle_to_cover_left"] = %covercrouch_shufflel;
    var_0["shuffle_end_to_cover_left"] = %cornercrl_shuffle_2_alert;
    var_0["shuffle_to_cover_right"] = %covercrouch_shuffler;
    var_0["shuffle_end_to_cover_right"] = %cornercrr_shuffle_2_alert;
    var_0["shuffle_start_left_stand_to_stand"] = %coverstand_hide_2_shufflel;
    var_0["shuffle_left_stand_to_stand"] = %coverstand_shufflel;
    var_0["shuffle_end_left_stand_to_stand"] = %coverstand_shufflel_2_hide;
    var_0["shuffle_start_right_stand_to_stand"] = %coverstand_hide_2_shuffler;
    var_0["shuffle_right_stand_to_stand"] = %coverstand_shuffler;
    var_0["shuffle_end_right_stand_to_stand"] = %coverstand_shuffler_2_hide;
    var_0["shuffle_to_left_crouch"] = %covercrouch_shufflel;
    var_0["shuffle_end_to_left_stand"] = %coverstand_shufflel_2_hide;
    var_0["shuffle_end_to_left_crouch"] = %covercrouch_shufflel_2_hide;
    var_0["shuffle_to_right_crouch"] = %covercrouch_shuffler;
    var_0["shuffle_end_to_right_stand"] = %coverstand_shuffler_2_hide;
    var_0["shuffle_end_to_right_crouch"] = %covercrouch_shuffler_2_hide;
    anim.archetypes["soldier"]["shuffle"] = var_0;
}

init_animset_smg_move()
{
    var_0 = [];
    var_0["fire"] = %smg_exposed_shoot_auto_v3;
    var_0["single"] = [ %smg_exposed_shoot_semi1 ];
    var_0["single_shotgun"] = [ %shotgun_stand_fire_1a, %shotgun_stand_fire_1b ];
    var_0["burst2"] = %smg_exposed_shoot_burst3;
    var_0["burst3"] = %smg_exposed_shoot_burst3;
    var_0["burst4"] = %smg_exposed_shoot_burst4;
    var_0["burst5"] = %smg_exposed_shoot_burst5;
    var_0["burst6"] = %smg_exposed_shoot_burst6;
    var_0["semi2"] = %smg_exposed_shoot_semi2;
    var_0["semi3"] = %smg_exposed_shoot_semi3;
    var_0["semi4"] = %smg_exposed_shoot_semi4;
    var_0["semi5"] = %smg_exposed_shoot_semi5;
    anim.archetypes["soldier"]["smg_shoot_while_moving"] = var_0;
}

main()
{
    if ( isdefined( self.custom_animscript ) )
    {
        if ( isdefined( self.custom_animscript["move"] ) )
        {
            [[ self.custom_animscript["move"] ]]();
            return;
        }
    }

    self endon( "killanimscript" );
    [[ self.exception["move"] ]]();
    moveinit();
    getupifprone();
    animscripts\utility::initialize( "move" );
    var_0 = waspreviouslyincover();

    if ( var_0 && isdefined( self.shufflemove ) )
    {
        movecovertocover();
        movecovertocoverfinish();
    }
    else if ( isdefined( self.battlechatter ) && self.battlechatter )
    {
        var_1 = var_0;
        movestartbattlechatter( var_1 );
        animscripts\battlechatter::playbattlechatter();

        if ( isdefined( self.team ) )
        {
            if ( var_1 )
            {
                thread maps\_dds::dds_notify( "react_leave_cover", self.team != "allies" );
                thread maps\_dds::dds_notify( "thrt_breaking", self.team != "allies" );
                thread maps\_dds::dds_notify( "act_moving", self.team == "allies" );
                thread maps\_dds::dds_notify( "act_advancing", self.team == "allies" );
            }
            else
                thread maps\_dds::dds_notify( "react_cover", self.team != "allies" );
        }
    }

    thread updatestairsstate();
    var_2 = ::pathchangelistener;

    if ( isdefined( self.pathchangecheckoverridefunc ) )
        var_2 = self.pathchangecheckoverridefunc;

    self thread [[ var_2 ]]();
    thread animdodgeobstaclelistener();
    animscripts\exit_node::startmovetransition();
    self.doingreacquirestep = undefined;
    self.ignorepathchange = undefined;
    thread startthreadstorunwhilemoving();
    listenforcoverapproach();
    self.shoot_while_moving_thread = undefined;
    self.aim_while_moving_thread = undefined;
    self.runngun = undefined;
    movemainloop( 1 );
}

end_script()
{
    if ( isdefined( self.oldgrenadeweapon ) )
    {
        self.grenadeweapon = self.oldgrenadeweapon;
        self.oldgrenadeweapon = undefined;
    }

    self.teamflashbangimmunity = undefined;
    self.minindoortime = undefined;
    self.ignorepathchange = undefined;
    self.shufflemove = undefined;
    self.shufflenode = undefined;
    self.runngun = undefined;
    self.reactingtobullet = undefined;
    self.requestreacttobullet = undefined;
    self.currentdodgeanim = undefined;
    self.moveloopoverridefunc = undefined;
    animscripts\run::setshootwhilemoving( 0 );

    if ( self.swimmer )
        animscripts\swim::swim_moveend();

    self _meth_8142( %head, 0.2 );
    self.facialidx = undefined;
}

moveinit()
{
    self.reactingtobullet = undefined;
    self.requestreacttobullet = undefined;
    self.update_move_anim_type = undefined;
    self.update_move_front_bias = undefined;
    self.runngunweight = 0;
    self.arrivalstartdist = undefined;
}

getupifprone()
{
    if ( self.a.pose == "prone" )
    {
        var_0 = animscripts\utility::choosepose( "stand" );

        if ( var_0 != "prone" )
        {
            self _meth_818F( "face current" );
            self _meth_818E( "zonly_physics", 0 );
            var_1 = 1;

            if ( isdefined( self.grenade ) )
                var_1 = 2;

            animscripts\cover_prone::proneto( var_0, var_1 );
            self _meth_818E( "none", 0 );
            self _meth_818F( "face default" );
        }
    }
}

waspreviouslyincover()
{
    switch ( self.prevscript )
    {
        case "cover_wide_right":
        case "cover_wide_left":
        case "concealment_stand":
        case "concealment_prone":
        case "concealment_crouch":
        case "cover_prone":
        case "cover_swim_right":
        case "cover_swim_left":
        case "cover_left":
        case "turret":
        case "hide":
        case "cover_multi":
        case "cover_right":
        case "cover_stand":
        case "cover_crouch":
            return 1;
    }

    return 0;
}

movestartbattlechatter( var_0 )
{
    if ( self.movemode == "run" )
    {
        animscripts\battlechatter_ai::evaluatemoveevent( var_0 );
        maps\_dds::evaluatemoveevent( var_0 );
    }
}

movemainloop( var_0 )
{
    movemainloopinternal( var_0 );
    self notify( "abort_reload" );
}

archetypechanged()
{
    if ( isdefined( self.animarchetype ) && self.animarchetype != self.prevmovearchetype )
        return 1;
    else if ( !isdefined( self.animarchetype ) && self.prevmovearchetype != "none" )
        return 1;

    return 0;
}

updatemovemode( var_0 )
{
    if ( var_0 != self.prevmovemode || archetypechanged() )
    {
        if ( isdefined( self.custommoveanimset ) && isdefined( self.custommoveanimset[var_0] ) )
            self.a.moveanimset = self.custommoveanimset[var_0];
        else
        {
            self.a.moveanimset = animscripts\utility::lookupanimarray( var_0 );

            if ( ( self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only" ) && ( isdefined( self.pathgoalpos ) && distancesquared( self.origin, self.pathgoalpos ) > squared( 100 ) ) )
            {
                self.sidesteprate = 1;
                animscripts\animset::set_ambush_sidestep_anims();
            }
            else
                self.sidesteprate = 1.35;
        }

        self.prevmovemode = var_0;

        if ( isdefined( self.animarchetype ) )
            self.prevmovearchetype = self.animarchetype;
    }
}

movemainloopinternal( var_0 )
{
    self endon( "killanimscript" );
    self endon( "move_interrupt" );
    var_1 = self _meth_814F( %walk_and_run_loops );
    self.a.runloopcount = randomint( 10000 );
    self.prevmovemode = "none";
    self.prevmovearchetype = "none";
    self.moveloopcleanupfunc = undefined;

    for (;;)
    {
        var_2 = self _meth_814F( %walk_and_run_loops );

        if ( var_2 < var_1 )
            self.a.runloopcount++;

        var_1 = var_2;
        updatemovemode( self.movemode );

        if ( isdefined( self.movemainloopprocessoverridefunc ) )
            self [[ self.movemainloopprocessoverridefunc ]]( self.movemode );
        else
            movemainloopprocess( self.movemode );

        if ( isdefined( self.moveloopcleanupfunc ) )
        {
            self [[ self.moveloopcleanupfunc ]]();
            self.moveloopcleanupfunc = undefined;
        }

        self notify( "abort_reload" );
    }
}

register_pluggable_move_loop_override( var_0 )
{
    self.pluggable_move_loop_override_function = var_0;
}

clear_pluggable_move_loop_override()
{
    self.pluggable_move_loop_override_function = undefined;
}

movemainloopprocess( var_0 )
{
    self endon( "move_loop_restart" );
    animscripts\face::setidlefacedelayed( anim.alertface );

    if ( isdefined( self.moveloopoverridefunc ) )
        self [[ self.moveloopoverridefunc ]]();
    else if ( isdefined( self.pluggable_move_loop_override_function ) )
        self [[ self.pluggable_move_loop_override_function ]]();
    else if ( animscripts\utility::shouldcqb() )
        animscripts\cqb::movecqb();
    else if ( self.swimmer )
        animscripts\swim::moveswim();
    else if ( var_0 == "run" )
        animscripts\run::moverun();
    else
        animscripts\walk::movewalk();

    self.requestreacttobullet = undefined;
}

mayshootwhilemoving()
{
    if ( self.weapon == "none" )
        return 0;

    if ( isdefined( self.mech ) && self.mech )
    {
        if ( self.movemode == "run" )
            return 0;
    }

    var_0 = weaponclass( self.weapon );

    if ( !animscripts\utility::usingriflelikeweapon() )
        return 0;

    if ( animscripts\combat_utility::issniper() )
    {
        if ( !animscripts\utility::iscqbwalking() && self.facemotion )
            return 0;
    }

    if ( isdefined( self.dontshootwhilemoving ) )
        return 0;

    return 1;
}

shootwhilemoving()
{
    self endon( "killanimscript" );
    self notify( "doing_shootWhileMoving" );
    self endon( "doing_shootWhileMoving" );
    var_0 = animscripts\utility::lookupanimarray( "shoot_while_moving" );

    if ( animscripts\utility::usingsmg() )
        var_0 = animscripts\utility::lookupanimarray( "smg_shoot_while_moving" );

    if ( isdefined( var_0 ) )
    {
        foreach ( var_3, var_2 in var_0 )
            self.a.array[var_3] = var_2;
    }

    if ( isdefined( self.combatstandanims ) && isdefined( self.combatstandanims["fire"] ) )
        self.a.array["fire"] = self.combatstandanims["fire"];

    if ( isdefined( self.weapon ) && animscripts\utility::weapon_pump_action_shotgun() )
        self.a.array["single"] = animscripts\utility::lookupanim( "shotgun_stand", "single" );

    for (;;)
    {
        if ( !self.bulletsinclip )
        {
            if ( animscripts\utility::iscqbwalkingorfacingenemy() )
            {
                self.ammocheattime = 0;
                animscripts\combat_utility::cheatammoifnecessary();
            }

            if ( !self.bulletsinclip )
            {
                wait 0.5;
                continue;
            }
        }

        animscripts\combat_utility::shootuntilshootbehaviorchange();
        self _meth_8142( %exposed_aiming, 0.2 );
    }
}

startthreadstorunwhilemoving()
{
    self endon( "killanimscript" );
    wait 0.05;
    thread bulletwhizbycheck_whilemoving();
    thread meleeattackcheck_whilemoving();
    thread animscripts\door::indoorcqbtogglecheck();
    thread animscripts\door::doorenterexitcheck();
}

updatestairsstate()
{
    self endon( "killanimscript" );
    self.prevstairsstate = self.stairsstate;

    for (;;)
    {
        wait 0.05;

        if ( self.prevstairsstate != self.stairsstate )
        {
            if ( !isdefined( self.ignorepathchange ) || self.stairsstate != "none" )
                self notify( "move_loop_restart" );
        }

        self.prevstairsstate = self.stairsstate;
    }
}

restartmoveloop( var_0 )
{
    self endon( "killanimscript" );

    if ( !var_0 )
        animscripts\exit_node::startmovetransition();

    self.ignorepathchange = undefined;
    self _meth_8142( %animscript_root, 0.1 );
    self _meth_818F( "face default" );
    self _meth_818E( "none", 0 );
    self.requestarrivalnotify = 1;
    movemainloop( !var_0 );
}

pathchangelistener()
{
    self endon( "killanimscript" );
    self endon( "move_interrupt" );

    for (;;)
    {
        self waittill( "path_changed", var_0, var_1, var_2 );

        if ( isdefined( self.ignorepathchange ) || isdefined( self.noturnanims ) )
            continue;

        if ( isdefined( var_0 ) && var_0 )
            continue;

        if ( !self.facemotion )
        {
            if ( !isdefined( self.mech ) )
                continue;
        }

        if ( self.a.pose != "stand" )
            continue;

        self notify( "stop_move_anim_update" );
        self.update_move_anim_type = undefined;
        var_3 = vectortoangles( var_1 );
        var_4 = angleclamp180( self.angles[1] - var_3[1] );
        var_5 = angleclamp180( self.angles[0] - var_3[0] );
        var_6 = pathchange_getturnanim( var_4, var_5 );

        if ( isdefined( var_6 ) )
        {
            self.turnanim = var_6;
            self.turntime = gettime();
            self.moveloopoverridefunc = ::pathchange_doturnanim;
            self notify( "move_loop_restart" );
            animscripts\run::endfaceenemyaimtracking();
        }
    }
}

pathchange_getturnanim( var_0, var_1 )
{
    if ( isdefined( self.pathturnanimoverridefunc ) )
        return [[ self.pathturnanimoverridefunc ]]( var_0, var_1 );

    var_2 = undefined;
    var_3 = undefined;

    if ( self.swimmer )
        var_4 = animscripts\swim::getswimanim( "turn" );
    else if ( animscripts\utility::isunstableground() )
        var_4 = animscripts\utility::lookupanimarray( "unstable_run_turn" );
    else if ( self.movemode == "walk" )
    {
        var_5 = "cqb_turn";

        if ( isdefined( self.animarchetype ) && isdefined( anim.archetypes[self.animarchetype]["walk_turn"] ) || isdefined( anim.archetypes["soldier"]["walk_turn"] ) )
            var_5 = "walk_turn";

        var_4 = animscripts\utility::lookupanimarray( var_5 );
    }
    else if ( animscripts\utility::shouldcqb() )
        var_4 = animscripts\utility::lookupanimarray( "cqb_run_turn" );
    else if ( animscripts\utility::usingsmg() )
        var_4 = animscripts\utility::lookupanimarray( "smg_run_turn" );
    else
        var_4 = animscripts\utility::lookupanimarray( "run_turn" );

    if ( var_0 < 0 )
    {
        if ( var_0 > -45 )
            var_6 = 3;
        else
            var_6 = int( ceil( ( var_0 + 180 - 10 ) / 45 ) );
    }
    else if ( var_0 < 45 )
        var_6 = 5;
    else
        var_6 = int( floor( ( var_0 + 180 + 10 ) / 45 ) );

    var_2 = var_4[var_6];

    if ( isdefined( var_2 ) )
    {
        if ( isarray( var_2 ) )
        {
            while ( var_2.size > 0 )
            {
                var_7 = randomint( var_2.size );

                if ( pathchange_candoturnanim( var_2[var_7] ) )
                    return var_2[var_7];

                var_2[var_7] = var_2[var_2.size - 1];
                var_2[var_2.size - 1] = undefined;
            }
        }
        else if ( pathchange_candoturnanim( var_2 ) )
            return var_2;
    }

    var_8 = -1;

    if ( var_0 < -60 )
    {
        var_8 = int( ceil( ( var_0 + 180 ) / 45 ) );

        if ( var_8 == var_6 )
            var_8 = var_6 - 1;
    }
    else if ( var_0 > 60 )
    {
        var_8 = int( floor( ( var_0 + 180 ) / 45 ) );

        if ( var_8 == var_6 )
            var_8 = var_6 + 1;
    }

    if ( var_8 >= 0 && var_8 < 9 )
        var_3 = var_4[var_8];

    if ( isdefined( var_3 ) )
    {
        if ( isarray( var_3 ) )
            var_3 = var_3[0];

        if ( pathchange_candoturnanim( var_3 ) )
            return var_3;
    }

    return undefined;
}

pathchange_candoturnanim( var_0 )
{
    if ( !isdefined( self.pathgoalpos ) )
        return 0;

    var_1 = getnotetracktimes( var_0, "code_move" );
    var_2 = var_1[0];
    var_3 = getmovedelta( var_0, 0, var_2 );
    var_4 = self _meth_81B0( var_3 );

    if ( isdefined( self.arrivalstartdist ) && squared( self.arrivalstartdist ) > distancesquared( self.pathgoalpos, var_4 ) )
        return 0;

    var_3 = getmovedelta( var_0, 0, 1 );
    var_5 = self _meth_81B0( var_3 );
    var_5 = var_4 + vectornormalize( var_5 - var_4 ) * 20;
    var_6 = !self.swimmer;
    var_7 = self _meth_81C4( var_4, var_5, var_6, 1 );
    return var_7;
}

pathchange_doturnanim()
{
    self endon( "killanimscript" );
    self.moveloopoverridefunc = undefined;
    var_0 = self.turnanim;

    if ( gettime() > self.turntime + 50 )
        return;

    if ( self.swimmer )
        self _meth_818E( "nogravity", 0 );
    else
        self _meth_818E( "zonly_physics", 0 );

    var_1 = 0.1;

    if ( isdefined( self.pathturnanimblendtime ) )
        var_1 = self.pathturnanimblendtime;

    self _meth_8142( %body, var_1 );
    self.moveloopcleanupfunc = ::pathchange_cleanupturnanim;
    self.ignorepathchange = 1;
    var_1 = 0.05;

    if ( isdefined( self.pathturnanimblendtime ) )
        var_1 = self.pathturnanimblendtime;

    self notify( "turn_start" );
    self _meth_8113( "turnAnim", var_0, 1, var_1, self.moveplaybackrate );

    if ( animscripts\utility::isspaceai() )
        self _meth_818F( "face angle 3d", self.angles );
    else
        self _meth_818F( "face angle", self.angles[1] );

    if ( isdefined( self.dynamicturnscaling ) )
        childthread manage_turn( var_0, 1, "code_move" );

    animscripts\shared::donotetracks( "turnAnim" );
    self.ignorepathchange = undefined;
    self _meth_818F( "face motion" );
    self _meth_818E( "none", 0 );
    animscripts\shared::donotetracks( "turnAnim" );
    self notify( "turn_end" );
}

getcurrentforwardmovementanimation()
{
    var_0 = self _meth_84F4();

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( var_0[var_1]["animation"] == %combatrun_forward )
        {
            if ( var_0[var_1 + 1].size > 2 )
                return var_0[var_1 + 1];
            else
                return undefined;
        }
    }

    return undefined;
}

manage_turn( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = 45;
    var_4 = getnotetracktimes( var_0, var_2 );
    var_5 = self.origin;
    var_6 = self.angles;
    var_5 = getstartorigin( var_5, var_6, var_0 );
    var_6 = getstartangles( var_5, var_6, var_0 );
    var_7 = getanimlength( var_0 ) * var_4[0];
    var_8 = int( maps\_utility::round_float( var_7 * 20, 0, 0 ) );

    if ( var_8 < 1 )
        return;

    var_9 = 1.0 / var_8;
    var_10 = 0;
    var_11 = self.origin;

    for (;;)
    {
        var_12 = var_10 * var_9;
        var_13 = 1.0 - ( var_8 * var_9 - var_12 );
        var_10++;

        if ( !isdefined( self.ignorepathchange ) && var_1 || var_12 > 1.0 )
            break;

        var_14 = getmovedelta( var_0, 0, var_12 );
        var_15 = _func_221( var_0, 0, var_12 );
        var_16 = transformmove( var_5, var_6, ( 0, 0, 0 ), ( 0, 0, 0 ), var_14, var_15 );
        var_17 = var_16["origin"];
        var_18 = var_16["angles"];
        var_19 = self.lookaheaddir;
        var_20 = vectortoangles( self.lookaheaddir )[1];
        var_21 = var_18[1];
        var_22 = angleclamp180( var_20 - var_21 );
        var_23 = var_22 * var_13;
        var_23 = abs( clamp( var_23, -1 * var_3, var_3 ) );
        var_19 = vectorlerp( anglestoforward( var_18 ), self.lookaheaddir, var_23 / var_3 * var_13 );
        self _meth_818F( "face direction", var_19 );
        waitframe();
    }
}

pathchange_cleanupturnanim()
{
    self.ignorepathchange = undefined;
    self _meth_818F( "face default" );
    self _meth_8142( %animscript_root, 0.1 );
    self _meth_818E( "none", 0 );

    if ( self.swimmer )
        animscripts\swim::swim_cleanupturnanim();
}

dodgemoveloopoverride()
{
    self _meth_81A3( 1 );
    self _meth_818E( "zonly_physics", 0 );
    self _meth_8142( %body, 0.2 );
    self _meth_8113( "dodgeAnim", self.currentdodgeanim, 1, 0.2, 1 );
    animscripts\shared::donotetracks( "dodgeAnim" );
    self _meth_818E( "none", 0 );
    self _meth_818F( "face default" );

    if ( animhasnotetrack( self.currentdodgeanim, "code_move" ) )
        animscripts\shared::donotetracks( "dodgeAnim" );

    self _meth_8142( %civilian_dodge, 0.2 );
    self _meth_81A3( 0 );
    self.currentdodgeanim = undefined;
    self.moveloopoverridefunc = undefined;
    return 1;
}

trydodgewithanim( var_0, var_1 )
{
    var_2 = ( self.lookaheaddir[1], -1 * self.lookaheaddir[0], 0 );
    var_3 = self.lookaheaddir * var_1[0];
    var_4 = var_2 * var_1[1];
    var_5 = self.origin + var_3 - var_4;
    self _meth_81A3( 1 );

    if ( self _meth_81C3( var_5 ) )
    {
        self.currentdodgeanim = var_0;
        self.moveloopoverridefunc = ::dodgemoveloopoverride;
        self notify( "move_loop_restart" );
        return 1;
    }

    self _meth_81A3( 0 );
    return 0;
}

animdodgeobstaclelistener()
{
    if ( !isdefined( self.dodgeleftanim ) || !isdefined( self.dodgerightanim ) )
        return;

    self endon( "killanimscript" );
    self endon( "move_interrupt" );

    for (;;)
    {
        self waittill( "path_need_dodge", var_0, var_1 );
        animscripts\utility::updateisincombattimer();

        if ( animscripts\utility::isincombat() )
        {
            self.nododgemove = 0;
            return;
        }

        if ( !issentient( var_0 ) )
            continue;

        var_2 = vectornormalize( var_1 - self.origin );

        if ( self.lookaheaddir[0] * var_2[1] - var_2[0] * self.lookaheaddir[1] > 0 )
        {
            if ( !trydodgewithanim( self.dodgerightanim, self.dodgerightanimoffset ) )
                trydodgewithanim( self.dodgeleftanim, self.dodgeleftanimoffset );
        }
        else if ( !trydodgewithanim( self.dodgeleftanim, self.dodgeleftanimoffset ) )
            trydodgewithanim( self.dodgerightanim, self.dodgerightanimoffset );

        if ( isdefined( self.currentdodgeanim ) )
        {
            wait(getanimlength( self.currentdodgeanim ));
            continue;
        }

        wait 0.1;
    }
}

setdodgeanims( var_0, var_1 )
{
    self.nododgemove = 1;
    self.dodgeleftanim = var_0;
    self.dodgerightanim = var_1;
    var_2 = 1;

    if ( animhasnotetrack( var_0, "code_move" ) )
        var_2 = getnotetracktimes( var_0, "code_move" )[0];

    self.dodgeleftanimoffset = getmovedelta( var_0, 0, var_2 );
    var_2 = 1;

    if ( animhasnotetrack( var_1, "code_move" ) )
        var_2 = getnotetracktimes( var_1, "code_move" )[0];

    self.dodgerightanimoffset = getmovedelta( var_1, 0, var_2 );
    self.interval = 80;
}

cleardodgeanims()
{
    self.nododgemove = 0;
    self.dodgeleftanim = undefined;
    self.dodgerightanim = undefined;
    self.dodgeleftanimoffset = undefined;
    self.dodgerightanimoffset = undefined;
}

meleeattackcheck_whilemoving()
{
    self endon( "killanimscript" );

    for (;;)
    {
        if ( isdefined( self.enemy ) && ( isai( self.enemy ) || isdefined( self.meleeplayerwhilemoving ) ) )
        {
            if ( abs( self _meth_8190() ) <= 135 )
                animscripts\melee::melee_tryexecuting();
        }

        wait 0.1;
    }
}

bulletwhizbycheck_whilemoving()
{
    self endon( "killanimscript" );

    if ( isdefined( self.disablebulletwhizbyreaction ) )
        return;

    for (;;)
    {
        self waittill( "bulletwhizby", var_0 );

        if ( self.movemode != "run" || !self.facemotion || self.a.pose != "stand" || isdefined( self.reactingtobullet ) )
            continue;

        if ( self.stairsstate != "none" )
            continue;

        if ( !isdefined( self.enemy ) && !self.ignoreall && isdefined( var_0.team ) && isenemyteam( self.team, var_0.team ) )
        {
            self.whizbyenemy = var_0;
            self _meth_819A( animscripts\reactions::bulletwhizbyreaction );
            continue;
        }

        if ( self.lookaheadhitsstairs || self.lookaheaddist < 100 )
            continue;

        if ( isdefined( self.pathgoalpos ) && distancesquared( self.origin, self.pathgoalpos ) < 10000 )
        {
            wait 0.2;
            continue;
        }

        self.requestreacttobullet = gettime();
        self notify( "move_loop_restart" );
        animscripts\run::endfaceenemyaimtracking();
    }
}

get_shuffle_to_corner_start_anim( var_0, var_1 )
{
    var_2 = var_1.type;

    if ( var_2 == "Cover Multi" )
        var_2 = animscripts\utility::getcovermultipretendtype( var_1 );

    if ( var_2 == "Cover Left" )
        return animscripts\utility::lookupanim( "shuffle", "shuffle_start_from_cover_left" );
    else if ( var_2 == "Cover Right" )
        return animscripts\utility::lookupanim( "shuffle", "shuffle_start_from_cover_right" );
    else if ( var_0 )
        return animscripts\utility::lookupanim( "shuffle", "shuffle_start_left" );
    else
        return animscripts\utility::lookupanim( "shuffle", "shuffle_start_right" );
}

setup_shuffle_anim_array( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = var_2.type;

    if ( var_4 == "Cover Multi" )
        var_4 = animscripts\utility::getcovermultipretendtype( var_2 );

    if ( var_4 == "Cover Left" )
    {
        var_3["shuffle_start"] = get_shuffle_to_corner_start_anim( var_0, var_1 );
        var_3["shuffle"] = animscripts\utility::lookupanim( "shuffle", "shuffle_to_cover_left" );
        var_3["shuffle_end"] = animscripts\utility::lookupanim( "shuffle", "shuffle_end_to_cover_left" );
    }
    else if ( var_4 == "Cover Right" )
    {
        var_3["shuffle_start"] = get_shuffle_to_corner_start_anim( var_0, var_1 );
        var_3["shuffle"] = animscripts\utility::lookupanim( "shuffle", "shuffle_to_cover_right" );
        var_3["shuffle_end"] = animscripts\utility::lookupanim( "shuffle", "shuffle_end_to_cover_right" );
    }
    else if ( var_4 == "Cover Stand" && var_1.type == var_4 )
    {
        if ( var_0 )
        {
            var_3["shuffle_start"] = animscripts\utility::lookupanim( "shuffle", "shuffle_start_left_stand_to_stand" );
            var_3["shuffle"] = animscripts\utility::lookupanim( "shuffle", "shuffle_left_stand_to_stand" );
            var_3["shuffle_end"] = animscripts\utility::lookupanim( "shuffle", "shuffle_end_left_stand_to_stand" );
        }
        else
        {
            var_3["shuffle_start"] = animscripts\utility::lookupanim( "shuffle", "shuffle_start_right_stand_to_stand" );
            var_3["shuffle"] = animscripts\utility::lookupanim( "shuffle", "shuffle_right_stand_to_stand" );
            var_3["shuffle_end"] = animscripts\utility::lookupanim( "shuffle", "shuffle_end_right_stand_to_stand" );
        }
    }
    else if ( var_0 )
    {
        var_3["shuffle_start"] = get_shuffle_to_corner_start_anim( var_0, var_1 );
        var_3["shuffle"] = animscripts\utility::lookupanim( "shuffle", "shuffle_to_left_crouch" );

        if ( var_4 == "Cover Stand" )
            var_3["shuffle_end"] = animscripts\utility::lookupanim( "shuffle", "shuffle_end_to_left_stand" );
        else
            var_3["shuffle_end"] = animscripts\utility::lookupanim( "shuffle", "shuffle_end_to_left_crouch" );
    }
    else
    {
        var_3["shuffle_start"] = get_shuffle_to_corner_start_anim( var_0, var_1 );
        var_3["shuffle"] = animscripts\utility::lookupanim( "shuffle", "shuffle_to_right_crouch" );

        if ( var_4 == "Cover Stand" )
            var_3["shuffle_end"] = animscripts\utility::lookupanim( "shuffle", "shuffle_end_to_right_stand" );
        else
            var_3["shuffle_end"] = animscripts\utility::lookupanim( "shuffle", "shuffle_end_to_right_crouch" );
    }

    self.a.array = var_3;
}

movecovertocover_checkstartpose( var_0, var_1 )
{
    if ( self.a.pose == "stand" && ( var_1.type != "Cover Stand" || var_0.type != "Cover Stand" ) )
    {
        self.a.pose = "crouch";
        return 0;
    }

    return 1;
}

movecovertocover_checkendpose( var_0 )
{
    if ( self.a.pose == "crouch" && var_0.type == "Cover Stand" )
    {
        self.a.pose = "stand";
        return 0;
    }

    return 1;
}

movecovertocover()
{
    self endon( "killanimscript" );
    self endon( "goal_changed" );
    var_0 = self.shufflenode;
    self.shufflemove = undefined;
    self.shufflenode = undefined;
    self.shufflemoveinterrupted = 1;

    if ( !isdefined( self.prevnode ) )
        return;

    if ( !isdefined( self.node ) || !isdefined( var_0 ) || self.node != var_0 )
        return;

    var_1 = self.prevnode;
    var_2 = self.node;
    var_3 = var_2.origin - self.origin;

    if ( lengthsquared( var_3 ) < 1 )
        return;

    var_3 = vectornormalize( var_3 );
    var_4 = anglestoforward( var_2.angles );
    var_5 = var_4[0] * var_3[1] - var_4[1] * var_3[0] > 0;

    if ( movedoorsidetoside( var_5, var_1, var_2 ) )
        return;

    if ( movecovertocover_checkstartpose( var_1, var_2 ) )
        var_6 = 0.1;
    else
        var_6 = 0.4;

    setup_shuffle_anim_array( var_5, var_1, var_2 );
    self _meth_818E( "zonly_physics", 0 );
    self _meth_8142( %body, var_6 );
    var_7 = animscripts\utility::animarray( "shuffle_start" );
    var_8 = animscripts\utility::animarray( "shuffle" );
    var_9 = animscripts\utility::animarray( "shuffle_end" );

    if ( animhasnotetrack( var_7, "finish" ) )
        var_10 = getnotetracktimes( var_7, "finish" )[0];
    else
        var_10 = 1;

    var_11 = length( getmovedelta( var_7, 0, var_10 ) );
    var_12 = length( getmovedelta( var_8, 0, 1 ) );
    var_13 = length( getmovedelta( var_9, 0, 1 ) );
    var_14 = distance( self.origin, var_2.origin );

    if ( var_14 > var_11 )
    {
        self _meth_818F( "face angle", animscripts\utility::getnodeforwardyaw( var_1 ) );
        self _meth_8113( "shuffle_start", var_7, 1, var_6 );
        animscripts\shared::donotetracks( "shuffle_start" );
        self _meth_8142( var_7, 0.2 );
        var_14 -= var_11;
        var_6 = 0.2;
    }
    else
        self _meth_818F( "face angle", var_2.angles[1] );

    var_15 = 0;

    if ( var_14 > var_13 )
    {
        var_15 = 1;
        var_14 -= var_13;
    }

    var_16 = getanimlength( var_8 );
    var_17 = var_16 * var_14 / var_12 * 0.9;
    var_17 = floor( var_17 * 20 ) * 0.05;
    self _meth_8111( "shuffle", var_8, 1, var_6 );
    animscripts\notetracks::donotetracksfortime( var_17, "shuffle" );

    for ( var_18 = 0; var_18 < 2; var_18++ )
    {
        var_14 = distance( self.origin, var_2.origin );

        if ( var_15 )
            var_14 -= var_13;

        if ( var_14 < 4 )
            break;

        var_17 = var_16 * var_14 / var_12 * 0.9;
        var_17 = floor( var_17 * 20 ) * 0.05;

        if ( var_17 < 0.05 )
            break;

        animscripts\notetracks::donotetracksfortime( var_17, "shuffle" );
    }

    if ( var_15 )
    {
        if ( movecovertocover_checkendpose( var_2 ) )
            var_6 = 0.2;
        else
            var_6 = 0.4;

        self _meth_8142( var_8, var_6 );
        self _meth_8111( "shuffle_end", var_9, 1, var_6 );
        animscripts\shared::donotetracks( "shuffle_end" );
    }

    self _meth_81C7( var_2.origin );
    self _meth_818E( "normal" );
    self.shufflemoveinterrupted = undefined;
}

movecovertocoverfinish()
{
    if ( isdefined( self.shufflemoveinterrupted ) )
    {
        self _meth_8142( %cover_shuffle, 0.2 );
        self.shufflemoveinterrupted = undefined;
        self _meth_818E( "none", 0 );
        self _meth_818F( "face default" );
    }
    else
    {
        wait 0.2;
        self _meth_8142( %cover_shuffle, 0.2 );
    }
}

movedoorsidetoside( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( var_1.type == "Cover Right" && var_2.type == "Cover Left" && !var_0 )
        var_3 = %corner_standr_door_r2l;
    else if ( var_1.type == "Cover Left" && var_2.type == "Cover Right" && var_0 )
        var_3 = %corner_standl_door_l2r;

    if ( !isdefined( var_3 ) )
        return 0;

    self _meth_818E( "zonly_physics", 0 );
    self _meth_818F( "face current" );
    self _meth_8113( "sideToSide", var_3, 1, 0.2 );
    animscripts\shared::donotetracks( "sideToSide", ::handlesidetosidenotetracks );
    var_4 = self _meth_814F( var_3 );
    var_5 = var_2.origin - var_1.origin;
    var_5 = vectornormalize( ( var_5[0], var_5[1], 0 ) );
    var_6 = getmovedelta( var_3, var_4, 1 );
    var_7 = var_2.origin - self.origin;
    var_7 = ( var_7[0], var_7[1], 0 );
    var_8 = vectordot( var_7, var_5 ) - abs( var_6[1] );

    if ( var_8 > 2 )
    {
        var_9 = getnotetracktimes( var_3, "slide_end" )[0];
        var_10 = ( var_9 - var_4 ) * getanimlength( var_3 );
        var_11 = int( ceil( var_10 / 0.05 ) );
        var_12 = var_5 * var_8 / var_11;
        thread slidefortime( var_12, var_11 );
    }

    animscripts\shared::donotetracks( "sideToSide" );
    self _meth_81C7( var_2.origin );
    self _meth_818E( "none" );
    self _meth_818F( "face default" );
    self.shufflemoveinterrupted = undefined;
    wait 0.2;
    return 1;
}

handlesidetosidenotetracks( var_0 )
{
    if ( var_0 == "slide_start" )
        return 1;
}

slidefortime( var_0, var_1 )
{
    self endon( "killanimscript" );
    self endon( "goal_changed" );

    while ( var_1 > 0 )
    {
        self _meth_81C7( self.origin + var_0 );
        var_1--;
        wait 0.05;
    }
}

movestand_moveoverride( var_0, var_1 )
{
    self endon( "movemode" );
    self _meth_8142( %combatrun, 0.6 );
    self _meth_8147( %combatrun, %body, 1, 0.5, self.moveplaybackrate );

    if ( isdefined( self.requestreacttobullet ) && gettime() - self.requestreacttobullet < 100 && isdefined( self.run_overridebulletreact ) && randomfloat( 1 ) < self.a.reacttobulletchance )
    {
        animscripts\run::customrunningreacttobullets();
        return;
    }

    var_2 = undefined;

    if ( isdefined( self.run_overrideanim_hasstairanimarray ) )
    {
        if ( animscripts\run::move_checkstairstransition() )
            return;

        self _meth_8142( %stair_transitions, 0.1 );

        if ( self.stairsstate == "up" )
            var_2 = animscripts\utility::getmoveanim( "stairs_up" );
        else if ( self.stairsstate == "down" )
            var_2 = animscripts\utility::getmoveanim( "stairs_down" );
    }

    if ( !isdefined( var_2 ) )
    {
        if ( isarray( var_0 ) )
        {
            if ( isdefined( self.run_override_weights ) )
                var_2 = common_scripts\utility::choose_from_weighted_array( var_0, var_1 );
            else
                var_2 = var_0[randomint( var_0.size )];
        }
        else
            var_2 = var_0;
    }

    self _meth_8152( "moveanim", var_2, 1, 0.2, self.moveplaybackrate );
    animscripts\shared::donotetracks( "moveanim" );
}

listenforcoverapproach()
{
    thread animscripts\cover_arrival::setupapproachnode( 1 );
}
