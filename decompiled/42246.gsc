// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    if ( !isdefined( level.scr_notetrack ) )
        level.scr_notetrack = [];

    if ( !isdefined( level.scr_face ) )
        level.scr_face = [];

    if ( !isdefined( level.scr_look ) )
        level.scr_look = [];

    if ( !isdefined( level.scr_animsound ) )
        level.scr_animsound = [];

    if ( !isdefined( level.scr_sound ) )
        level.scr_sound = [];

    if ( !isdefined( level.scr_radio ) )
        level.scr_radio = [];

    if ( !isdefined( level.scr_text ) )
        level.scr_text = [];

    if ( !isdefined( level.scr_anim ) )
        level.scr_anim[0][0] = 0;

    if ( !isdefined( level.scr_radio ) )
        level.scr_radio = [];

    if ( !isdefined( level.scr_goaltime ) )
        level.scr_goaltime = [];

    common_scripts\utility::create_lock( "moreThanThreeHack", 3 );

    if ( maps\_utility::is_gen4() )
        common_scripts\utility::create_lock( "trace_part_for_efx", 12 );
    else
        common_scripts\utility::create_lock( "trace_part_for_efx" );
}

endonremoveanimactive( var_0, var_1 )
{
    self waittill( var_0 );

    foreach ( var_3 in var_1 )
    {
        var_4 = var_3["guy"];

        if ( !isdefined( var_4 ) )
            continue;

        var_4._animactive--;
        var_4._lastanimtime = gettime();
    }
}

anim_first_frame( var_0, var_1, var_2 )
{
    var_3 = get_anim_position( var_2 );
    var_4 = var_3["origin"];
    var_5 = var_3["angles"];
    common_scripts\utility::array_levelthread( var_0, ::anim_first_frame_on_guy, var_1, var_4, var_5 );
}

anim_generic_first_frame( var_0, var_1, var_2 )
{
    var_3 = get_anim_position( var_2 );
    var_4 = var_3["origin"];
    var_5 = var_3["angles"];
    thread anim_first_frame_on_guy( var_0, var_1, var_4, var_5, "generic" );
}

anim_generic( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    anim_single( var_3, var_1, var_2, 0, "generic" );
}

anim_generic_gravity( var_0, var_1, var_2 )
{
    var_3 = var_0.allowpain;
    var_0 maps\_utility::disable_pain();
    anim_generic_custom_animmode( var_0, "gravity", var_1, var_2 );

    if ( var_3 )
        var_0 maps\_utility::enable_pain();
}

anim_generic_run( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    anim_single( var_3, var_1, var_2, 0.25, "generic" );
}

anim_generic_reach( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    anim_reach( var_3, var_1, var_2, "generic" );
}

anim_generic_reach_and_arrive( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    anim_reach_with_funcs( var_3, var_1, var_2, "generic", ::reach_with_arrivals_begin, ::reach_with_standard_adjustments_end );
}

anim_reach_and_plant( var_0, var_1, var_2 )
{
    anim_reach_with_funcs( var_0, var_1, var_2, undefined, ::reach_with_planting, ::reach_with_standard_adjustments_end );
}

anim_reach_and_plant_and_arrive( var_0, var_1, var_2 )
{
    anim_reach_with_funcs( var_0, var_1, var_2, undefined, ::reach_with_planting_and_arrivals, ::reach_with_standard_adjustments_end );
}

anim_generic_loop( var_0, var_1, var_2, var_3 )
{
    var_4 = [];
    var_4["guy"] = var_0;
    var_4["entity"] = self;
    var_4["tag"] = var_3;
    var_5[0] = var_4;
    anim_loop_packet( var_5, var_1, var_2, "generic" );
}

anim_custom_animmode( var_0, var_1, var_2, var_3 )
{
    var_4 = get_anim_position( var_3 );
    var_5 = var_4["origin"];
    var_6 = var_4["angles"];
    var_7 = undefined;

    foreach ( var_9 in var_0 )
    {
        var_7 = var_9;
        thread anim_custom_animmode_on_guy( var_9, var_1, var_2, var_5, var_6, var_9.animname, 0 );
    }

    var_7 wait_until_anim_finishes( var_2 );
    self notify( var_2 );
}

anim_custom_animmode_loop( var_0, var_1, var_2, var_3 )
{
    var_4 = get_anim_position( var_3 );
    var_5 = var_4["origin"];
    var_6 = var_4["angles"];

    foreach ( var_8 in var_0 )
        thread anim_custom_animmode_on_guy( var_8, var_1, var_2, var_5, var_6, var_8.animname, 1 );

    var_0[0] wait_until_anim_finishes( var_2 );
    self notify( var_2 );
}

wait_until_anim_finishes( var_0 )
{
    self endon( "finished_custom_animmode" + var_0 );
    self waittill( "death" );
}

anim_generic_custom_animmode( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = get_anim_position( var_3 );
    var_7 = var_6["origin"];
    var_8 = var_6["angles"];
    thread anim_custom_animmode_on_guy( var_0, var_1, var_2, var_7, var_8, "generic", 0, var_4, var_5 );
    var_0 wait_until_anim_finishes( var_2 );
    self notify( var_2 );
}

anim_generic_custom_animmode_loop( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = get_anim_position( var_3 );
    var_7 = var_6["origin"];
    var_8 = var_6["angles"];
    thread anim_custom_animmode_on_guy( var_0, var_1, var_2, var_7, var_8, "generic", 1, var_4, var_5 );
    var_0 wait_until_anim_finishes( var_2 );
    self notify( var_2 );
}

anim_custom_animmode_solo( var_0, var_1, var_2, var_3 )
{
    var_4 = [];
    var_4[0] = var_0;
    anim_custom_animmode( var_4, var_1, var_2, var_3 );
}

anim_custom_animmode_loop_solo( var_0, var_1, var_2, var_3 )
{
    var_4 = [];
    var_4[0] = var_0;
    anim_custom_animmode_loop( var_4, var_1, var_2, var_3 );
}

anim_first_frame_solo( var_0, var_1, var_2, var_3 )
{
    var_4 = get_anim_position( var_2 );
    var_5 = var_4["origin"];
    var_6 = var_4["angles"];
    thread anim_first_frame_on_guy( var_0, var_1, var_5, var_6, var_3 );
}

anim_last_frame_solo( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    anim_first_frame( var_3, var_1, var_2 );
    anim_set_time( var_3, var_1, 1.0 );
}

assert_existance_of_anim( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = self.animname;

    var_2 = 0;

    if ( isdefined( level.scr_anim[var_1] ) )
    {
        var_2 = 1;

        if ( isdefined( level.scr_anim[var_1][var_0] ) )
            return;
    }

    var_3 = 0;

    if ( isdefined( level.scr_sound[var_1] ) )
    {
        var_3 = 1;

        if ( isdefined( level.scr_sound[var_1][var_0] ) )
            return;
    }

    if ( var_2 || var_3 )
    {
        if ( var_2 )
        {
            var_4 = getarraykeys( level.scr_anim[var_1] );

            foreach ( var_6 in var_4 )
            {

            }
        }

        if ( var_3 )
        {
            var_4 = getarraykeys( level.scr_sound[var_1] );

            foreach ( var_6 in var_4 )
            {

            }
        }

        return;
    }

    var_10 = getarraykeys( level.scr_anim );
    var_10 = common_scripts\utility::array_combine( var_10, getarraykeys( level.scr_sound ) );

    foreach ( var_12 in var_10 )
    {

    }
}

anim_first_frame_on_guy( var_0, var_1, var_2, var_3, var_4 )
{
    var_0.first_frame_time = gettime();

    if ( isdefined( var_4 ) )
        var_5 = var_4;
    else
        var_5 = var_0.animname;

    var_0 set_start_pos( var_1, var_2, var_3, var_5 );

    if ( isai( var_0 ) )
    {
        var_0._first_frame_anim = var_1;
        var_0._animname = var_5;
        var_0 _meth_819A( animscripts\first_frame::main );
    }
    else
    {
        var_0 _meth_8141();
        var_0 _meth_8143( level.scr_anim[var_5][var_1], 1, 0, 0 );
        var_0 _meth_8117( level.scr_anim[var_5][var_1], 0 );
    }
}

anim_custom_animmode_on_guy( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( isai( var_0 ) && var_0 maps\_utility::doinglongdeath() )
        return;

    var_9 = undefined;

    if ( isdefined( var_5 ) )
        var_9 = var_5;
    else
        var_9 = var_0.animname;

    if ( !isdefined( var_8 ) || !var_8 )
        var_0 set_start_pos( var_2, var_3, var_4, var_5, var_6 );

    var_0._animmode = var_1;
    var_0._custom_anim = var_2;
    var_0._tag_entity = self;
    var_0._anime = var_2;
    var_0._animname = var_9;
    var_0._custom_anim_loop = var_6;
    var_0._custom_anim_thread = var_7;
    var_0 _meth_819A( animscripts\animmode::main );
}

anim_loop( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];

    foreach ( var_7 in var_0 )
    {
        var_8 = [];
        var_8["guy"] = var_7;
        var_8["entity"] = self;
        var_8["tag"] = var_3;
        var_8["origin_offset"] = var_4;
        var_5[var_5.size] = var_8;
    }

    anim_loop_packet( var_5, var_1, var_2 );
}

anim_loop_packet_solo( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    anim_loop_packet( var_3, var_1, var_2 );
}

anim_loop_packet( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( var_0.size <= 0 )
        return;

    foreach ( var_5 in var_0 )
    {
        var_6 = var_5["guy"];

        if ( !isdefined( var_6 ) )
            continue;

        if ( !isdefined( var_6._animactive ) )
            var_6._animactive = 0;

        var_6 endon( "death" );
        var_6._animactive++;
    }

    var_8 = var_0[0]["guy"];

    if ( !isdefined( var_2 ) )
        var_2 = "stop_loop";

    thread endonremoveanimactive( var_2, var_0 );
    self endon( var_2 );
    var_9 = "looping anim";
    var_10 = undefined;

    if ( isdefined( var_3 ) )
        var_10 = var_3;
    else
        var_10 = var_8.animname;

    if ( !assert_existance_of_looping_anim( var_1, var_10 ) )
        return;

    var_11 = 0;
    var_12 = 0;

    for (;;)
    {
        for ( var_11 = anim_weight( var_10, var_1 ); var_11 == var_12 && var_11 != 0; var_11 = anim_weight( var_10, var_1 ) )
        {

        }

        var_12 = var_11;
        var_13 = undefined;
        var_14 = 999999;
        var_15 = undefined;
        var_6 = undefined;

        foreach ( var_34, var_5 in var_0 )
        {
            var_17 = var_5["entity"];
            var_6 = var_5["guy"];
            var_18 = var_17 get_anim_position( var_5["tag"] );
            var_19 = var_18["origin"];
            var_20 = var_18["angles"];

            if ( isdefined( var_5["origin_offset"] ) )
            {
                var_21 = var_5["origin_offset"];
                var_22 = anglestoforward( var_20 );
                var_23 = anglestoright( var_20 );
                var_24 = anglestoup( var_20 );
                var_19 += var_22 * var_21[0];
                var_19 += var_23 * var_21[1];
                var_19 += var_24 * var_21[2];
            }

            if ( isdefined( var_6.remove_from_animloop ) )
            {
                var_6.remove_from_animloop = undefined;
                var_0[var_34] = undefined;
                continue;
            }

            var_25 = 0;
            var_26 = 0;
            var_27 = 0;
            var_28 = 0;
            var_29 = undefined;
            var_30 = undefined;
            var_31 = undefined;

            if ( isdefined( var_3 ) )
                var_31 = var_3;
            else
                var_31 = var_6.animname;

            if ( isdefined( level.scr_face[var_31] ) && isdefined( level.scr_face[var_31][var_1] ) && isdefined( level.scr_face[var_31][var_1][var_11] ) )
            {
                var_25 = 1;
                var_29 = level.scr_face[var_31][var_1][var_11];
            }

            if ( isdefined( level.scr_sound[var_31] ) && isdefined( level.scr_sound[var_31][var_1] ) && isdefined( level.scr_sound[var_31][var_1][var_11] ) )
            {
                var_26 = 1;
                var_30 = level.scr_sound[var_31][var_1][var_11];
            }

            if ( isdefined( level.scr_animsound[var_31] ) && isdefined( level.scr_animsound[var_31][var_11 + var_1] ) )
                var_6 playsound( level.scr_animsound[var_31][var_11 + var_1] );

            if ( isdefined( level.scr_anim[var_31] ) && isdefined( level.scr_anim[var_31][var_1] ) && ( !isai( var_6 ) || !var_6 maps\_utility::doinglongdeath() ) )
                var_27 = 1;

            if ( var_27 )
            {
                if ( isdefined( level.scr_goaltime[var_31] ) && isdefined( level.scr_goaltime[var_31][var_1] ) )
                    var_32 = level.scr_goaltime[var_31][var_1];
                else
                    var_32 = 0.2;

                var_6 last_anim_time_check( var_1, var_31 );
                var_6 _meth_813E( var_9, var_19, var_20, level.scr_anim[var_31][var_1][var_11], undefined, undefined, var_32 );
                var_33 = getanimlength( level.scr_anim[var_31][var_1][var_11] );

                if ( var_33 < var_14 )
                {
                    var_14 = var_33;
                    var_13 = var_34;
                }

                thread start_notetrack_wait( var_6, var_9, var_1, var_31, level.scr_anim[var_31][var_1][var_11] );
                thread animscriptdonotetracksthread( var_6, var_9, var_1 );
            }

            if ( var_25 || var_26 )
            {
                if ( isai( var_6 ) )
                {
                    if ( var_27 )
                        var_6 animscripts\face::sayspecificdialogue( var_29, var_30, 1.0 );
                    else
                        var_6 animscripts\face::sayspecificdialogue( var_29, var_30, 1.0, var_9 );
                }
                else
                    var_6 maps\_utility::play_sound_on_entity( var_30 );

                var_15 = var_34;
            }
        }

        if ( !isdefined( var_6 ) )
            break;

        if ( isdefined( var_13 ) )
        {
            var_0[var_13]["guy"] waittillmatch( var_9, "end" );
            waittillframeend;
            continue;
        }

        if ( isdefined( var_15 ) )
        {
            var_0[var_15]["guy"] waittill( var_9 );
            continue;
        }

        return;
    }
}

start_notetrack_wait( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 notify( "stop_sequencing_notetracks" );
    thread notetrack_wait( var_0, var_1, self, var_2, var_3, var_4 );
}

anim_single_failsafeonguy( var_0, var_1 )
{

}

anim_single_failsafe( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
        var_3 thread anim_single_failsafeonguy( self, var_1 );
}

anim_single( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    anim_single_internal( var_0, var_1, var_2, var_3, var_4, var_5 );
}

anim_single_run( var_0, var_1, var_2, var_3 )
{
    anim_single_internal( var_0, var_1, var_2, 0.25, var_3 );
}

anim_single_internal( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = self;

    foreach ( var_8 in var_0 )
    {
        if ( !isdefined( var_8 ) )
            continue;

        if ( !isdefined( var_8._animactive ) )
            var_8._animactive = 0;

        var_8._animactive++;
    }

    var_10 = get_anim_position( var_2 );
    var_11 = var_10["origin"];
    var_12 = var_10["angles"];

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    var_13 = undefined;
    var_14 = 999999;

    if ( var_5 )
        var_14 = 0;

    var_15 = undefined;
    var_16 = undefined;
    var_17 = undefined;
    var_18 = "single anim";

    foreach ( var_31, var_8 in var_0 )
    {
        var_20 = 0;
        var_21 = 0;
        var_22 = 0;
        var_23 = 0;
        var_24 = undefined;
        var_25 = undefined;
        var_26 = undefined;

        if ( isdefined( var_4 ) )
            var_26 = var_4;
        else
            var_26 = var_8.animname;

        if ( isdefined( level.scr_face[var_26] ) && isdefined( level.scr_face[var_26][var_1] ) )
        {
            var_20 = 1;
            var_25 = level.scr_face[var_26][var_1];
            var_17 = var_25;
        }

        if ( isdefined( level.scr_sound[var_26] ) && isdefined( level.scr_sound[var_26][var_1] ) )
        {
            var_21 = 1;
            var_24 = level.scr_sound[var_26][var_1];
        }

        if ( isdefined( level.scr_anim[var_26] ) && isdefined( level.scr_anim[var_26][var_1] ) && ( !isai( var_8 ) || !var_8 maps\_utility::doinglongdeath() ) )
            var_22 = 1;

        if ( isdefined( level.scr_animsound[var_26] ) && isdefined( level.scr_animsound[var_26][var_1] ) )
            var_8 playsound( level.scr_animsound[var_26][var_1] );

        if ( var_22 )
        {
            if ( isdefined( level.scr_goaltime[var_26] ) && isdefined( level.scr_goaltime[var_26][var_1] ) )
                var_27 = level.scr_goaltime[var_26][var_1];
            else
                var_27 = 0.2;

            var_8 last_anim_time_check( var_1, var_26 );

            if ( isplayer( var_8 ) )
            {
                var_28 = level.scr_anim[var_26]["root"];
                var_8 _meth_814B( var_28, 0, var_27 );
                var_29 = level.scr_anim[var_26][var_1];
                var_8 _meth_8111( var_18, var_29, 1, var_27 );
            }
            else if ( var_8.code_classname == "misc_turret" )
            {
                var_29 = level.scr_anim[var_26][var_1];
                var_8 _meth_8111( var_18, var_29, 1, var_27 );
            }
            else
                var_8 _meth_813E( var_18, var_11, var_12, level.scr_anim[var_26][var_1], undefined, undefined, var_27 );

            var_30 = getanimlength( level.scr_anim[var_26][var_1] );

            if ( var_30 < var_14 && !var_5 || var_30 > var_14 && var_5 )
            {
                var_14 = var_30;
                var_13 = var_31;
            }

            thread start_notetrack_wait( var_8, var_18, var_1, var_26, level.scr_anim[var_26][var_1] );
            thread animscriptdonotetracksthread( var_8, var_18, var_1 );
        }

        if ( var_20 || var_21 )
        {
            if ( var_20 )
            {
                if ( var_21 )
                    var_8 thread delayeddialogue( var_1, var_20, var_24, level.scr_face[var_26][var_1] );

                thread anim_facialanim( var_8, var_1, level.scr_face[var_26][var_1] );
                var_16 = var_31;
            }
            else if ( isai( var_8 ) )
            {
                if ( var_22 )
                    var_8 animscripts\face::sayspecificdialogue( var_25, var_24, 1.0 );
                else
                {
                    if ( !isdefined( var_8.disablefacialfilleranims ) || !var_8.disablefacialfilleranims )
                        var_8 thread anim_facialfiller( "single dialogue" );

                    var_8 animscripts\face::sayspecificdialogue( var_25, var_24, 1.0, "single dialogue" );
                }
            }
            else
            {
                var_8 thread maps\_utility::play_sound_on_entity( var_24, "single dialogue" );

                if ( var_8 _meth_852B() )
                    var_8 thread anim_facialfiller( "single dialogue" );
            }

            var_15 = var_31;
        }
    }

    if ( isdefined( var_13 ) )
    {
        var_32 = spawnstruct();
        var_32 thread anim_deathnotify( var_0[var_13], var_1 );
        var_32 thread anim_animationendnotify( var_0[var_13], var_1, var_14, var_3 );
        var_32 waittill( var_1 );
    }
    else if ( isdefined( var_16 ) )
    {
        var_32 = spawnstruct();
        var_32 thread anim_deathnotify( var_0[var_16], var_1 );
        var_32 thread anim_facialendnotify( var_0[var_16], var_1, var_17 );
        var_32 waittill( var_1 );
    }
    else if ( isdefined( var_15 ) )
    {
        var_32 = spawnstruct();
        var_32 thread anim_deathnotify( var_0[var_15], var_1 );
        var_32 thread anim_dialogueendnotify( var_0[var_15], var_1 );
        var_32 waittill( var_1 );
    }

    foreach ( var_8 in var_0 )
    {
        if ( !isdefined( var_8 ) )
            continue;

        if ( isplayer( var_8 ) )
        {
            var_26 = undefined;

            if ( isdefined( var_4 ) )
                var_26 = var_4;
            else
                var_26 = var_8.animname;

            if ( isdefined( level.scr_anim[var_26][var_1] ) )
            {
                var_28 = level.scr_anim[var_26]["root"];
                var_8 _meth_814B( var_28, 1, 0.2 );
                var_29 = level.scr_anim[var_26][var_1];
                var_8 _meth_8142( var_29, 0.2 );
            }
        }

        var_8._animactive--;
        var_8._lastanimtime = gettime();
    }

    self notify( var_1 );
}

anim_deathnotify( var_0, var_1 )
{
    self endon( var_1 );
    var_0 waittill( "death" );

    if ( isdefined( var_0.anim_is_death ) && var_0.anim_is_death )
        return;

    self notify( var_1 );
}

anim_facialendnotify( var_0, var_1, var_2 )
{
    self endon( var_1 );
    var_3 = getanimlength( var_2 );
    wait(var_3);
    self notify( var_1 );
}

anim_dialogueendnotify( var_0, var_1 )
{
    self endon( var_1 );
    var_0 waittill( "single dialogue" );
    self notify( var_1 );
}

anim_animationendnotify( var_0, var_1, var_2, var_3 )
{
    self endon( var_1 );
    var_0 endon( "death" );
    var_2 -= var_3;

    if ( var_3 > 0 && var_2 > 0 )
    {
        var_0 maps\_utility::waittill_match_or_timeout( "single anim", "end", var_2 );
        var_0 _meth_8141();
    }
    else
        var_0 waittillmatch( "single anim", "end" );

    self notify( var_1 );
}

animscriptdonotetracksthread( var_0, var_1, var_2 )
{
    if ( isdefined( var_0.dontdonotetracks ) && var_0.dontdonotetracks )
        return;

    var_0 endon( "stop_sequencing_notetracks" );
    var_0 endon( "death" );
    var_0 animscripts\shared::donotetracks( var_1, undefined, undefined, 1 );
}

add_animsound( var_0 )
{
    for ( var_1 = 0; var_1 < level.animsound_hudlimit; var_1++ )
    {
        if ( isdefined( self.animsounds[var_1] ) )
            continue;

        self.animsounds[var_1] = var_0;
        return;
    }

    var_2 = getarraykeys( self.animsounds );
    var_3 = var_2[0];
    var_4 = self.animsounds[var_3].end_time;

    for ( var_1 = 1; var_1 < var_2.size; var_1++ )
    {
        var_5 = var_2[var_1];

        if ( self.animsounds[var_5].end_time < var_4 )
        {
            var_4 = self.animsounds[var_5].end_time;
            var_3 = var_5;
        }
    }

    self.animsounds[var_3] = var_0;
}

animsound_exists( var_0, var_1 )
{
    var_1 = tolower( var_1 );
    var_2 = getarraykeys( self.animsounds );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];

        if ( self.animsounds[var_4].anime != var_0 )
            continue;

        if ( self.animsounds[var_4].notetrack != var_1 )
            continue;

        self.animsounds[var_4].end_time = gettime() + 60000;
        return 1;
    }

    return 0;
}

animsound_tracker( var_0, var_1, var_2 )
{
    var_1 = tolower( var_1 );
    add_to_animsound();

    if ( var_1 == "end" )
        return;

    if ( animsound_exists( var_0, var_1 ) )
        return;

    var_3 = spawnstruct();
    var_3.anime = var_0;
    var_3.notetrack = var_1;
    var_3.animname = var_2;
    var_3.end_time = gettime() + 60000;
    add_animsound( var_3 );
}

animsound_start_tracker( var_0, var_1 )
{
    add_to_animsound();
    var_2 = spawnstruct();
    var_2.anime = var_0;
    var_2.notetrack = "#" + var_0;
    var_2.animname = var_1;
    var_2.end_time = gettime() + 60000;

    if ( animsound_exists( var_0, var_2.notetrack ) )
        return;

    add_animsound( var_2 );
}

animsound_start_tracker_loop( var_0, var_1, var_2 )
{
    add_to_animsound();
    var_0 = var_1 + var_0;
    var_3 = spawnstruct();
    var_3.anime = var_0;
    var_3.notetrack = "#" + var_0;
    var_3.animname = var_2;
    var_3.end_time = gettime() + 60000;

    if ( animsound_exists( var_0, var_3.notetrack ) )
        return;

    add_animsound( var_3 );
}

notetrack_wait( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_0 endon( "stop_sequencing_notetracks" );
    var_0 endon( "death" );

    if ( isdefined( var_2 ) )
        var_6 = var_2;
    else
        var_6 = self;

    var_7 = undefined;

    if ( isdefined( var_4 ) )
        var_7 = var_4;
    else
        var_7 = var_0.animname;

    var_8 = spawnstruct();
    var_8.dialog = [];
    var_9 = [];

    if ( isdefined( var_7 ) && isdefined( level.scr_notetrack[var_7] ) )
    {
        if ( isdefined( level.scr_notetrack[var_7][var_3] ) )
            var_9[var_3] = level.scr_notetrack[var_7][var_3];

        if ( isdefined( level.scr_notetrack[var_7]["any"] ) )
            var_9["any"] = level.scr_notetrack[var_7]["any"];
    }

    foreach ( var_18, var_11 in var_9 )
    {
        foreach ( var_13 in level.scr_notetrack[var_7][var_18] )
        {
            foreach ( var_15 in var_13 )
            {
                if ( isdefined( var_15["dialog"] ) )
                    var_8.dialog[var_15["dialog"]] = 1;
            }
        }
    }

    var_22 = 0;
    var_23 = 0;

    for (;;)
    {
        var_8.dialoguenotetrack = 0;
        var_20 = undefined;

        if ( !var_22 && isdefined( var_7 ) && isdefined( var_3 ) )
        {
            var_22 = 1;
            var_24 = undefined;
            var_23 = isdefined( level.scr_notetrack[var_7] ) && isdefined( level.scr_notetrack[var_7][var_3] ) && isdefined( level.scr_notetrack[var_7][var_3]["start"] );

            if ( !var_23 )
                continue;

            var_20 = "start";
        }
        else
            var_0 waittill( var_1, var_20 );

        if ( var_20 == "end" )
            return;

        foreach ( var_18, var_11 in var_9 )
        {
            if ( isdefined( level.scr_notetrack[var_7][var_18][var_20] ) )
            {
                foreach ( var_15 in level.scr_notetrack[var_7][var_18][var_20] )
                    anim_handle_notetrack( var_15, var_0, var_8, var_6 );
            }
        }

        var_28 = getsubstr( var_20, 0, 3 );

        if ( var_28 == "ps_" )
        {
            var_29 = getsubstr( var_20, 3 );

            if ( isdefined( var_0.anim_playsound_func ) )
                var_0 thread [[ var_0.anim_playsound_func ]]( var_29, "j_head", 1 );
            else
                var_0 thread maps\_utility::play_sound_on_tag( var_29, undefined, 1 );

            continue;
        }

        if ( var_28 == "vo_" )
        {
            var_29 = getsubstr( var_20, 3 );

            if ( isdefined( var_0.anim_playsound_func ) )
                var_0 thread [[ var_0.anim_playsound_func ]]( var_29, "j_head", 1 );
            else
                var_0 thread maps\_utility::play_sound_on_tag( var_29, "j_head", 1 );

            continue;
        }

        if ( var_28 == "sd_" )
        {
            var_29 = getsubstr( var_20, 3 );
            var_0 thread maps\_utility::smart_dialogue( var_29 );
            continue;
        }

        if ( var_28 == "fx_" )
        {
            var_30 = strtok( tolower( getsubstr( var_20, 3 ) ), ",() " );

            if ( var_30.size == 2 )
            {
                if ( var_30[0] == "exploder" )
                {
                    common_scripts\_exploder::exploder( var_30[1] );
                    continue;
                }
                else if ( var_30[0] == "stop_exploder" )
                {
                    maps\_utility::stop_exploder( var_30[1] );
                    continue;
                }
                else
                {
                    playfxontag( level._effect[var_30[0]], var_0, var_30[1] );
                    continue;
                }
            }
            else if ( var_30.size == 3 )
            {
                if ( var_30[0] == "playfxontag" )
                {
                    playfxontag( level._effect[var_30[1]], var_0, var_30[2] );
                    continue;
                }
                else if ( var_30[0] == "stopfxontag" )
                {
                    stopfxontag( level._effect[var_30[1]], var_0, var_30[2] );
                    continue;
                }
                else if ( var_30[0] == "killfxontag" )
                {
                    killfxontag( level._effect[var_30[1]], var_0, var_30[2] );
                    continue;
                }
            }
            else if ( var_30.size == 11 )
            {
                var_31 = ( float( var_30[2] ), float( var_30[3] ), float( var_30[4] ) );
                var_32 = ( float( var_30[5] ), float( var_30[6] ), float( var_30[7] ) );
                var_33 = ( float( var_30[8] ), float( var_30[9] ), float( var_30[10] ) );
                playfx( level._effect[var_30[1]], var_31, var_32, var_33 );
            }
        }

        var_28 = getsubstr( var_20, 0, 4 );

        if ( var_28 == "psr_" )
        {
            var_29 = getsubstr( var_20, 4 );
            maps\_utility::radio_dialogue( var_29 );
            continue;
        }

        switch ( var_20 )
        {
            case "ignoreall true":
                self.ignoreall = 1;
                break;
            case "ignoreall false":
                self.ignoreall = 0;
                break;
            case "ignoreme true":
                self.ignoreme = 1;
                break;
            case "ignoreme false":
                self.ignoreme = 0;
                break;
            case "allowdeath true":
                self.allowdeath = 1;
                break;
            case "allowdeath false":
                self.allowdeath = 0;
                break;
        }
    }
}

anim_handle_notetrack( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_0["function"] ) )
    {
        if ( !isdefined( var_0["function_args"] ) )
            self thread [[ var_0["function"] ]]( var_1 );
        else
            self thread [[ var_0["function"] ]]( var_1, var_0["function_args"] );
    }

    if ( isdefined( var_0["flag"] ) )
        common_scripts\utility::flag_set( var_0["flag"] );

    if ( isdefined( var_0["flag_clear"] ) )
        common_scripts\utility::flag_clear( var_0["flag_clear"] );

    if ( isdefined( var_0["notify"] ) )
        level notify( var_0["notify"] );

    if ( isdefined( var_0["attach gun left"] ) )
    {
        var_1 gun_pickup_left();
        return;
    }

    if ( isdefined( var_0["attach gun right"] ) )
    {
        var_1 gun_pickup_right();
        return;
    }

    if ( isdefined( var_0["detach gun"] ) )
    {
        var_1 gun_leave_behind( var_0 );
        return;
    }

    if ( isdefined( var_0["attach model"] ) )
    {
        if ( isdefined( var_0["selftag"] ) )
            var_1 attach( var_0["attach model"], var_0["selftag"] );
        else
            var_3 attach( var_0["attach model"], var_0["tag"] );

        return;
    }

    if ( isdefined( var_0["detach model"] ) )
    {
        waittillframeend;

        if ( isdefined( var_0["selftag"] ) )
            var_1 detach( var_0["detach model"], var_0["selftag"] );
        else
            var_3 detach( var_0["detach model"], var_0["tag"] );
    }

    if ( isdefined( var_0["sound"] ) )
    {
        var_4 = undefined;

        if ( !isdefined( var_0["sound_stays_death"] ) )
            var_4 = 1;

        var_5 = undefined;

        if ( isdefined( var_0["sound_on_tag"] ) )
            var_5 = var_0["sound_on_tag"];

        var_1 thread maps\_utility::play_sound_on_tag( var_0["sound"], var_5, var_4 );
    }

    if ( isdefined( var_0["playersound"] ) )
        level.player playsound( var_0["playersound"] );

    if ( !var_2.dialoguenotetrack )
    {
        if ( isdefined( var_0["dialog"] ) && isdefined( var_2.dialog[var_0["dialog"]] ) )
        {
            var_1 animscripts\face::sayspecificdialogue( undefined, var_0["dialog"], 1.0 );
            var_2.dialog[var_0["dialog"]] = undefined;
            var_2.dialoguenotetrack = 1;
        }
    }

    if ( isdefined( var_0["create model"] ) )
        anim_addmodel( var_1, var_0 );
    else if ( isdefined( var_0["delete model"] ) )
        anim_removemodel( var_1, var_0 );

    if ( isdefined( var_0["selftag"] ) )
    {
        if ( isdefined( var_0["effect"] ) )
        {
            var_6 = isdefined( var_0["moreThanThreeHack"] );

            if ( var_6 )
                common_scripts\utility::lock( "moreThanThreeHack" );

            playfxontag( level._effect[var_0["effect"]], var_1, var_0["selftag"] );

            if ( var_6 )
                common_scripts\utility::unlock( "moreThanThreeHack" );
        }

        if ( isdefined( var_0["stop_effect"] ) )
            stopfxontag( level._effect[var_0["stop_effect"]], var_1, var_0["selftag"] );

        if ( isdefined( var_0["swap_part_to_efx"] ) )
        {
            playfxontag( level._effect[var_0["swap_part_to_efx"]], var_1, var_0["selftag"] );
            var_1 _meth_8048( var_0["selftag"] );
        }

        if ( isdefined( var_0["trace_part_for_efx"] ) )
        {
            var_7 = undefined;
            var_8 = common_scripts\utility::getfx( var_0["trace_part_for_efx"] );

            if ( isdefined( var_0["trace_part_for_efx_water"] ) )
                var_7 = common_scripts\utility::getfx( var_0["trace_part_for_efx_water"] );

            var_9 = 0;

            if ( isdefined( var_0["trace_part_for_efx_delete_depth"] ) )
                var_9 = var_0["trace_part_for_efx_delete_depth"];

            var_1 thread trace_part_for_efx( var_0["selftag"], var_8, var_7, var_9 );
        }

        if ( isdefined( var_0["trace_part_for_efx_canceling"] ) )
            var_1 thread trace_part_for_efx_cancel( var_0["selftag"] );
    }

    if ( isdefined( var_0["tag"] ) && isdefined( var_0["effect"] ) )
        playfxontag( level._effect[var_0["effect"]], var_3, var_0["tag"] );

    if ( isdefined( var_0["selftag"] ) && isdefined( var_0["effect_looped"] ) )
        playfxontag( level._effect[var_0["effect_looped"]], var_1, var_0["selftag"] );

    if ( isdefined( var_0["lui_notify"] ) )
        _func_23F( var_0["lui_notify"], 0 );

    if ( isdefined( var_0["omnvar"] ) )
        setomnvar( var_0["omnvar"], var_0["value"] );
}

trace_part_for_efx_cancel( var_0 )
{
    self notify( "cancel_trace_for_part_" + var_0 );
}

trace_part_for_efx( var_0, var_1, var_2, var_3 )
{
    var_4 = "trace_part_for_efx";
    self endon( "cancel_trace_for_part_" + var_0 );
    var_5 = self gettagorigin( var_0 );
    var_6 = 0;
    var_7 = spawnstruct();
    var_7.last_pos = self gettagorigin( var_0 );
    var_7.hit_surface = 0;
    var_7.part = var_0;
    var_7.hit_water = 0;
    var_7.effect = var_1;
    var_7.stationary = 0;
    var_7.last_motion_time = gettime();

    while ( isdefined( self ) && !var_7.hit_surface )
    {
        common_scripts\utility::lock( var_4 );
        test_trace_tag( var_7 );
        common_scripts\utility::unlock_wait( var_4 );

        if ( var_7.stationary == 1 && gettime() - var_7.last_motion_time > 3000 )
            return;
    }

    if ( !isdefined( self ) )
        return;

    if ( isdefined( var_2 ) && var_7.hit_water )
        var_1 = var_2;

    playfx( var_1, var_7.last_pos );

    if ( var_3 == 0 )
        self _meth_8048( var_0 );
    else
        thread hidepartatdepth( var_7.last_pos[2] - var_3, var_0 );
}

hidepartatdepth( var_0, var_1 )
{
    self endon( "entitydeleted" );

    while ( self gettagorigin( var_1 )[2] > var_0 )
        wait 0.05;

    self _meth_8048( var_1 );
}

test_trace_tag( var_0 )
{
    var_1 = undefined;

    if ( !isdefined( self ) )
        return;

    var_0.current_pos = self gettagorigin( var_0.part );

    if ( var_0.current_pos != var_0.last_pos )
    {
        var_0.last_motion_time = gettime();
        var_0.stationary = 0;

        if ( !bullettracepassed( var_0.last_pos, var_0.current_pos, 0, self ) )
        {
            var_2 = bullettrace( var_0.last_pos, var_0.current_pos, 0, self );

            if ( var_2["fraction"] < 1.0 )
            {
                var_0.last_pos = var_2["position"];
                var_0.hit_water = var_2["surfacetype"] == "water";
                var_0.hit_surface = 1;
                return;
            }
            else
            {

            }
        }
    }
    else
        var_0.stationary = 1;

    var_0.last_pos = var_0.current_pos;
}

anim_addmodel( var_0, var_1 )
{
    if ( !isdefined( var_0.scriptmodel ) )
        var_0.scriptmodel = [];

    var_2 = var_0.scriptmodel.size;
    var_0.scriptmodel[var_2] = spawn( "script_model", ( 0, 0, 0 ) );
    var_0.scriptmodel[var_2] _meth_80B1( var_1["create model"] );
    var_0.scriptmodel[var_2].origin = var_0 gettagorigin( var_1["selftag"] );
    var_0.scriptmodel[var_2].angles = var_0 gettagangles( var_1["selftag"] );
}

anim_removemodel( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.scriptmodel.size; var_2++ )
    {
        if ( isdefined( var_1["explosion"] ) )
        {
            var_3 = anglestoforward( var_0.scriptmodel[var_2].angles );
            var_3 *= 120;
            var_3 += var_0.scriptmodel[var_2].origin;
            playfx( level._effect[var_1["explosion"]], var_0.scriptmodel[var_2].origin );
            radiusdamage( var_0.scriptmodel[var_2].origin, 350, 700, 50 );
        }

        var_0.scriptmodel[var_2] delete();
    }
}

gun_pickup_left()
{
    if ( !isdefined( self.gun_on_ground ) )
        return;

    self.gun_on_ground delete();
    self.dropweapon = 1;
    animscripts\shared::placeweaponon( self.weapon, "left" );
}

gun_pickup_right()
{
    if ( !isdefined( self.gun_on_ground ) )
        return;

    self.gun_on_ground delete();
    self.dropweapon = 1;
    animscripts\shared::placeweaponon( self.weapon, "right" );
}

gun_leave_behind( var_0 )
{
    if ( isdefined( self.gun_on_ground ) )
        return;

    var_1 = self gettagorigin( var_0["tag"] );
    var_2 = self gettagangles( var_0["tag"] );
    var_3 = 0;

    if ( isdefined( var_0["suspend"] ) )
        var_3 = var_0["suspend"];

    var_4 = spawn( "weapon_" + self.weapon, var_1, var_3 );
    var_4.angles = var_2;
    self.gun_on_ground = var_4;
    animscripts\shared::placeweaponon( self.weapon, "none" );
    self.dropweapon = 0;
}

assert_existance_of_looping_anim( var_0, var_1 )
{
    if ( !isdefined( level.scr_anim[var_1][var_0] ) )
        return 0;

    if ( !isarray( level.scr_anim[var_1][var_0] ) )
        return 0;

    return 1;
}

anim_weight( var_0, var_1 )
{
    var_2 = level.scr_anim[var_0][var_1].size;
    var_3 = randomint( var_2 );

    if ( var_2 > 1 )
    {
        var_4 = 0;
        var_5 = 0;

        for ( var_6 = 0; var_6 < var_2; var_6++ )
        {
            if ( isdefined( level.scr_anim[var_0][var_1 + "weight"] ) )
            {
                if ( isdefined( level.scr_anim[var_0][var_1 + "weight"][var_6] ) )
                {
                    var_4++;
                    var_5 += level.scr_anim[var_0][var_1 + "weight"][var_6];
                }
            }
        }

        if ( var_4 == var_2 )
        {
            var_7 = randomfloat( var_5 );
            var_5 = 0;

            for ( var_6 = 0; var_6 < var_2; var_6++ )
            {
                var_5 += level.scr_anim[var_0][var_1 + "weight"][var_6];

                if ( var_7 < var_5 )
                {
                    var_3 = var_6;
                    break;
                }
            }
        }
    }

    return var_3;
}

anim_reach_and_idle( var_0, var_1, var_2, var_3, var_4 )
{
    thread anim_reach( var_0, var_1, var_4 );
    var_5 = spawnstruct();
    var_5.reachers = 0;

    foreach ( var_7 in var_0 )
    {
        var_5.reachers++;
        thread idle_on_reach( var_7, var_2, var_3, var_4, var_5 );
    }

    for (;;)
    {
        var_5 waittill( "reached_position" );

        if ( var_5.reachers <= 0 )
            return;
    }
}

wait_for_guy_to_die_or_get_in_position()
{
    self endon( "death" );
    self waittill( "anim_reach_complete" );
}

idle_on_reach( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 wait_for_guy_to_die_or_get_in_position();
    var_4.reachers--;
    var_4 notify( "reached_position" );

    if ( isalive( var_0 ) )
        anim_loop_solo( var_0, var_1, var_2, var_3 );
}

get_anim_position( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;

    if ( isdefined( var_0 ) )
    {
        var_1 = self gettagorigin( var_0 );
        var_2 = self gettagangles( var_0 );
    }
    else
    {
        var_1 = self.origin;
        var_2 = self.angles;

        if ( !isdefined( var_2 ) )
            var_2 = ( 0, 0, 0 );
    }

    var_3 = [];
    var_3["angles"] = var_2;
    var_3["origin"] = var_1;
    return var_3;
}

anim_reach_together( var_0, var_1, var_2, var_3 )
{
    thread modify_moveplaybackrate_together( var_0 );
    anim_reach_with_funcs( var_0, var_1, var_2, var_3, ::reach_with_standard_adjustments_begin, ::reach_with_standard_adjustments_end );
}

modify_moveplaybackrate_together( var_0 )
{
    var_1 = 0.3;
    waittillframeend;

    for (;;)
    {
        var_0 = maps\_utility::remove_dead_from_array( var_0 );
        var_2 = [];
        var_3 = 0;

        foreach ( var_8, var_5 in var_0 )
        {
            var_6 = var_5.goalpos;

            if ( isdefined( var_5.reach_goal_pos ) )
                var_6 = var_5.reach_goal_pos;

            var_7 = distance( var_5.origin, var_6 );
            var_2[var_5.unique_id] = var_7;

            if ( var_7 <= 4 )
            {
                var_0[var_8] = undefined;
                continue;
            }

            var_3 += var_7;
        }

        if ( var_0.size <= 1 )
            break;

        var_3 /= var_0.size;

        foreach ( var_5 in var_0 )
        {
            var_10 = var_2[var_5.unique_id] - var_3;
            var_11 = var_10 * 0.003;

            if ( var_11 > var_1 )
                var_11 = var_1;
            else if ( var_11 < var_1 * -1 )
                var_11 = var_1 * -1;

            var_5.moveplaybackrate = 1 + var_11;
        }

        wait 0.05;
    }

    foreach ( var_5 in var_0 )
    {
        if ( isalive( var_5 ) )
            var_5.moveplaybackrate = 1;
    }
}

anim_reach_failsafe( var_0, var_1 )
{
    if ( isarray( var_0 ) )
    {
        foreach ( var_3 in var_0 )
            thread anim_reach_failsafe( var_3, var_1 );

        return;
    }

    var_3 = var_0;
    var_3 endon( "new_anim_reach" );
    wait(var_1);
    var_3 notify( "goal" );
}

anim_reach( var_0, var_1, var_2, var_3, var_4 )
{
    return anim_reach_with_funcs( var_0, var_1, var_2, var_3, ::reach_with_standard_adjustments_begin, ::reach_with_standard_adjustments_end, undefined, var_4 );
}

anim_reach_with_funcs( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = get_anim_position( var_2 );
    var_9 = var_8["origin"];
    var_10 = var_8["angles"];

    if ( isdefined( var_6 ) )
    {
        self.type = var_6;
        self.arrivalstance = "stand";
    }

    var_11 = spawnstruct();
    var_12 = 0;
    var_13 = 0;

    foreach ( var_15 in var_0 )
    {
        if ( isdefined( var_6 ) )
            var_15.scriptedarrivalent = self;

        if ( isdefined( var_3 ) )
            var_16 = var_3;
        else
            var_16 = var_15.animname;

        if ( isdefined( level.scr_anim[var_16][var_1] ) )
        {
            if ( isarray( level.scr_anim[var_16][var_1] ) )
                var_17 = getstartorigin( var_9, var_10, level.scr_anim[var_16][var_1][0] );
            else
                var_17 = getstartorigin( var_9, var_10, level.scr_anim[var_16][var_1] );
        }
        else
            var_17 = var_9;

        var_13++;
        var_15 thread begin_anim_reach( var_11, var_17, var_4, var_5, var_1, var_7 );
    }

    var_19 = 1;
    var_11 thread monitor_reach_thread_death( thisthread, var_0, self, var_6 );

    while ( var_13 )
    {
        var_11 waittill( "reach_notify", var_15, var_20 );

        if ( isdefined( var_15 ) )
            var_15.anim_reach_success = var_20;

        if ( !var_20 )
            var_19 = 0;

        var_13--;
    }

    anim_reach_cleanup( var_0, self, var_6 );
    var_11 notify( "end_reach_thread_monitor" );
    return var_19;
}

anim_reach_cleanup( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_0 )
    {
        if ( isalive( var_4 ) && var_4.anim_reach_success )
        {
            var_4.goalradius = var_4.oldgoalradius;
            var_4.scriptedarrivalent = undefined;
            var_4.stopanimdistsq = 0;
        }

        if ( isdefined( var_4 ) )
            var_4.anim_reach_success = undefined;
    }

    if ( isdefined( var_2 ) )
        var_1.type = undefined;
}

monitor_reach_thread_death( var_0, var_1, var_2, var_3 )
{
    self endon( "end_reach_thread_monitor" );

    while ( isdefined( var_0 ) )
        waitframe();

    foreach ( var_5 in var_1 )
    {
        if ( isdefined( var_5 ) )
        {
            var_5.anim_reach_success = 1;
            var_5.reach_aborted = 1;
            var_5 notify( "goal" );

            if ( isdefined( var_5.name ) )
            {

            }
            else
            {

            }

            continue;
        }
    }

    anim_reach_cleanup( var_1, var_2, var_3 );
}

anim_reach_cleanup_solo( var_0 )
{
    if ( !isalive( var_0 ) )
        return;

    if ( isdefined( var_0.oldgoalradius ) )
        var_0.goalradius = var_0.oldgoalradius;

    var_0.scriptedarrivalent = undefined;
    var_0.stopanimdistsq = 0;
}

anim_teleport( var_0, var_1, var_2 )
{
    var_3 = get_anim_position( var_2 );
    var_4 = var_3["origin"];
    var_5 = var_3["angles"];

    foreach ( var_7 in var_0 )
    {
        var_8 = getstartorigin( var_4, var_5, level.scr_anim[var_7.animname][var_1] );
        var_9 = getstartangles( var_4, var_5, level.scr_anim[var_7.animname][var_1] );

        if ( isai( var_7 ) )
        {
            var_7 _meth_81C5( var_8 );
            continue;
        }

        var_7.origin = var_8;
        var_7.angles = var_9;
    }
}

anim_moveto( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = get_anim_position( var_2 );
    var_7 = var_6["origin"];
    var_8 = var_6["angles"];

    foreach ( var_10 in var_0 )
    {
        var_11 = getstartorigin( var_7, var_8, level.scr_anim[var_10.animname][var_1] );
        var_12 = getstartangles( var_7, var_8, level.scr_anim[var_10.animname][var_1] );

        if ( isai( var_10 ) )
            continue;

        var_10 _meth_82AE( var_11, var_3, var_4, var_5 );
        var_10 _meth_82B5( var_12, var_3, var_4, var_5 );
    }
}

anim_generic_teleport( var_0, var_1, var_2 )
{
    var_3 = get_anim_position( var_2 );
    var_4 = var_3["origin"];
    var_5 = var_3["angles"];
    var_6 = getstartorigin( var_4, var_5, level.scr_anim["generic"][var_1] );
    var_7 = getstartangles( var_4, var_5, level.scr_anim["generic"][var_1] );

    if ( isai( var_0 ) )
        var_0 _meth_81C5( var_6 );
    else
    {
        var_0.origin = var_6;
        var_0.angles = var_7;
    }
}

anim_spawn_generic_model( var_0, var_1, var_2 )
{
    return anim_spawn_model( var_0, "generic", var_1, var_2 );
}

anim_spawn_model( var_0, var_1, var_2, var_3 )
{
    var_4 = get_anim_position( var_3 );
    var_5 = var_4["origin"];
    var_6 = var_4["angles"];
    var_7 = getstartorigin( var_5, var_6, level.scr_anim[var_1][var_2] );
    var_8 = getstartorigin( var_5, var_6, level.scr_anim[var_1][var_2] );
    var_9 = spawn( "script_model", var_7 );
    var_9 _meth_80B1( var_0 );
    var_9.angles = var_8;
    return var_9;
}

anim_spawn_tag_model( var_0, var_1 )
{
    self attach( var_0, var_1 );
}

anim_link_tag_model( var_0, var_1 )
{
    var_2 = self gettagorigin( var_1 );
    var_3 = spawn( "script_model", var_2 );
    var_3 _meth_80B1( var_0 );
    var_3 _meth_804D( self, var_1, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    return var_3;
}

anim_spawner_teleport( var_0, var_1, var_2 )
{
    var_3 = get_anim_position( var_2 );
    var_4 = var_3["origin"];
    var_5 = var_3["angles"];
    var_6 = spawnstruct();

    foreach ( var_8 in var_0 )
    {
        var_9 = getstartorigin( var_4, var_5, level.scr_anim[var_8.animname][var_1] );
        var_8.origin = var_9;
    }
}

reach_death_notify( var_0, var_1 )
{
    common_scripts\utility::waittill_either( "death", "goal" );
    var_2 = isalive( self ) && distancesquared( self.origin, var_1 ) <= 2500;
    var_0 notify( "reach_notify", self, var_2 );
}

begin_anim_reach( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "death" );
    self endon( "new_anim_reach" );
    var_1 = [[ var_2 ]]( var_1 );
    thread reach_death_notify( var_0, var_1 );
    maps\_utility::set_goal_pos( var_1 );
    self.reach_goal_pos = var_1;
    self.goalradius = 0;
    self waittill( "goal" );

    if ( isdefined( self.reach_aborted ) )
        self.reach_aborted = undefined;

    self notify( "anim_reach_complete" );
    [[ var_3 ]]();
    self notify( "new_anim_reach" );
}

reach_with_standard_adjustments_begin( var_0 )
{
    if ( isdefined( self.currently_anim_reaching ) )
    {

    }

    self.oldgoalradius = self.goalradius;
    self.oldpathenemyfightdist = self.pathenemyfightdist;
    self.oldpathenemylookahead = self.pathenemylookahead;
    self.pathenemyfightdist = 128;
    self.pathenemylookahead = 128;
    self.oldscriptforcecolor = isdefined( self.script_forcecolor );

    if ( !isdefined( self.perforing_color_driven_anim ) )
        maps\_utility::disable_ai_color();

    anim_changes_pushplayer( 1 );
    self.fixednodewason = self.fixednode;
    self.fixednode = 0;

    if ( !isdefined( self.scriptedarrivalent ) )
    {
        self.old_disablearrivals = self.disablearrivals;
        self.disablearrivals = 1;
    }

    self.reach_goal_pos = undefined;
    self.currently_anim_reaching = 1;
    return var_0;
}

reach_with_standard_adjustments_end()
{
    anim_changes_pushplayer( 0 );
    self.fixednode = self.fixednodewason;
    self.fixednodewason = undefined;
    self.pathenemyfightdist = self.oldpathenemyfightdist;
    self.pathenemylookahead = self.oldpathenemylookahead;
    self.disablearrivals = self.old_disablearrivals;

    if ( self.oldscriptforcecolor )
    {
        if ( !isdefined( self.perforing_color_driven_anim ) )
            maps\_utility::enable_ai_color_dontmove();

        self.oldscriptforcecolor = undefined;
    }

    self.currently_anim_reaching = undefined;
}

anim_changes_pushplayer( var_0 )
{
    if ( isdefined( self.dontchangepushplayer ) )
        return;

    self _meth_81A3( var_0 );
    return;
}

reach_with_arrivals_begin( var_0 )
{
    var_0 = reach_with_standard_adjustments_begin( var_0 );
    self.disablearrivals = 0;
    return var_0;
}

reach_with_planting( var_0 )
{
    var_1 = self _meth_813C( var_0 );
    var_0 = var_1;
    var_0 = reach_with_standard_adjustments_begin( var_0 );
    self.disablearrivals = 1;
    return var_0;
}

reach_with_planting_and_arrivals( var_0 )
{
    var_1 = self _meth_813C( var_0 );
    var_0 = var_1;
    var_0 = reach_with_standard_adjustments_begin( var_0 );
    self.disablearrivals = 0;
    return var_0;
}

setanimtree()
{
    self _meth_8115( level.scr_animtree[self.animname] );
}

anim_single_solo( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    var_5[0] = var_0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    anim_single( var_5, var_1, var_2, var_3, var_4 );
}

anim_single_solo_run( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3[0] = var_0;
    anim_single( var_3, var_1, var_2, 0.25 );
}

anim_single_run_solo( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_4[0] = var_0;
    anim_single( var_4, var_1, var_2, 0.25 );
}

anim_reach_and_idle_solo( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    var_5[0] = var_0;
    anim_reach_and_idle( var_5, var_1, var_2, var_3, var_4 );
}

anim_reach_solo( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_4[0] = var_0;
    return anim_reach( var_4, var_1, var_2, undefined, var_3 );
}

anim_reach_and_approach_solo( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_4[0] = var_0;
    anim_reach_and_approach( var_4, var_1, var_2, var_3 );
}

anim_reach_and_approach_node_solo( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    var_5[0] = var_0;
    var_6 = get_anim_position( var_2 );
    var_7 = var_6["origin"];
    var_8 = var_6["angles"];
    var_9 = var_0.animname;

    if ( isdefined( level.scr_anim[var_9][var_1] ) )
    {
        if ( isarray( level.scr_anim[var_9][var_1] ) )
            var_10 = level.scr_anim[var_9][var_1][0];
        else
            var_10 = level.scr_anim[var_9][var_1];

        var_7 = getstartorigin( var_7, var_8, var_10 );
        var_8 = getstartorigin( var_7, var_8, var_10 );
    }

    var_11 = spawn( "script_origin", var_7 );
    var_11.angles = var_8;

    if ( isdefined( var_3 ) )
        var_11.type = var_3;
    else
        var_11.type = self.type;

    if ( isdefined( var_4 ) )
        var_11.arrivalstance = var_4;
    else
        var_11.arrivalstance = self _meth_8034();

    var_0.scriptedarrivalent = var_11;
    anim_reach_and_approach( var_5, var_1, var_2 );
    var_0.scriptedarrivalent = undefined;
    var_11 delete();

    while ( var_0.a.movement != "stop" )
        wait 0.05;
}

anim_reach_and_approach( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    anim_reach_with_funcs( var_0, var_1, var_2, undefined, ::reach_with_arrivals_begin, ::reach_with_standard_adjustments_end, var_3 );
}

anim_loop_solo( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "death" );
    var_0 endon( "death" );
    var_6 = [];
    var_6["guy"] = var_0;
    var_6["entity"] = self;
    var_6["tag"] = var_3;
    var_6["origin_offset"] = var_5;
    var_7[0] = var_6;
    anim_loop_packet( var_7, var_1, var_2, var_4 );
}

anim_teleport_solo( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3[0] = var_0;
    anim_teleport( var_3, var_1, var_2 );
}

add_animation( var_0, var_1 )
{
    if ( !isdefined( level.completedanims ) )
        level.completedanims[var_0][0] = var_1;
    else if ( !isdefined( level.completedanims[var_0] ) )
        level.completedanims[var_0][0] = var_1;
    else
    {
        for ( var_2 = 0; var_2 < level.completedanims[var_0].size; var_2++ )
        {
            if ( level.completedanims[var_0][var_2] == var_1 )
                return;
        }

        level.completedanims[var_0][level.completedanims[var_0].size] = var_1;
    }
}

anim_single_queue( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( isdefined( var_0.last_queue_time ) )
        maps\_utility::wait_for_buffer_time_to_pass( var_0.last_queue_time, 0.5 );

    maps\_utility::function_stack( ::anim_single_solo, var_0, var_1, var_2, var_3 );

    if ( isalive( var_0 ) )
        var_0.last_queue_time = gettime();
}

anim_generic_queue( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 endon( "death" );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( isdefined( var_0.last_queue_time ) )
        maps\_utility::wait_for_buffer_time_to_pass( var_0.last_queue_time, 0.5 );

    if ( isdefined( var_4 ) )
        maps\_utility::function_stack_timeout( var_4, ::anim_single_solo, var_0, var_1, var_2, var_3, "generic" );
    else
        maps\_utility::function_stack( ::anim_single_solo, var_0, var_1, var_2, var_3, "generic" );

    if ( isalive( var_0 ) )
        var_0.last_queue_time = gettime();
}

anim_dontpushplayer( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 _meth_81A3( 0 );
}

anim_pushplayer( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 _meth_81A3( 1 );
}

removenotetrack( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 = tolower( var_1 );
    var_5 = level.scr_notetrack[var_0][var_2][var_1];
    var_2 = get_generic_anime( var_2 );
    var_6 = -1;

    if ( !isdefined( var_5 ) || !isarray( var_5 ) || var_5.size < 1 )
        return;

    for ( var_7 = 0; var_7 < var_5.size; var_7++ )
    {
        if ( isdefined( var_5[var_7][var_3] ) )
        {
            if ( !isdefined( var_4 ) || var_5[var_7][var_3] == var_4 )
            {
                var_6 = var_7;
                break;
            }
        }
    }

    if ( var_6 < 0 )
        return;

    if ( var_5.size == 1 )
        var_5 = [];
    else
        var_5 = maps\_utility::array_remove_index( var_5, var_6 );

    level.scr_notetrack[var_0][var_2][var_1] = var_5;
}

addnotetrack_dialogue( var_0, var_1, var_2, var_3 )
{
    var_1 = tolower( var_1 );
    var_2 = get_generic_anime( var_2 );
    var_4 = add_notetrack_and_get_index( var_0, var_1, var_2 );
    level.scr_notetrack[var_0][var_2][var_1][var_4] = [];
    level.scr_notetrack[var_0][var_2][var_1][var_4]["dialog"] = var_3;
}

add_notetrack_and_get_index( var_0, var_1, var_2 )
{
    var_1 = tolower( var_1 );
    add_notetrack_array( var_0, var_1, var_2 );
    return level.scr_notetrack[var_0][var_2][var_1].size;
}

add_notetrack_array( var_0, var_1, var_2 )
{
    var_1 = tolower( var_1 );

    if ( !isdefined( level.scr_notetrack ) )
        level.scr_notetrack = [];

    if ( !isdefined( level.scr_notetrack[var_0] ) )
        level.scr_notetrack[var_0] = [];

    if ( !isdefined( level.scr_notetrack[var_0][var_2] ) )
        level.scr_notetrack[var_0][var_2] = [];

    if ( !isdefined( level.scr_notetrack[var_0][var_2][var_1] ) )
        level.scr_notetrack[var_0][var_2][var_1] = [];
}

addnotetrack_sound( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_1 = tolower( var_1 );
    var_2 = get_generic_anime( var_2 );
    var_6 = add_notetrack_and_get_index( var_0, var_1, var_2 );
    level.scr_notetrack[var_0][var_2][var_1][var_6] = [];
    level.scr_notetrack[var_0][var_2][var_1][var_6]["sound"] = var_3;

    if ( isdefined( var_4 ) )
        level.scr_notetrack[var_0][var_2][var_1][var_6]["sound_stays_death"] = 1;

    if ( isdefined( var_5 ) )
        level.scr_notetrack[var_0][var_2][var_1][var_6]["sound_on_tag"] = var_5;
}

note_track_start_sound( var_0, var_1, var_2, var_3 )
{
    var_4 = get_datascene();
    addnotetrack_sound( var_4.animname, var_0, var_4.anim_sequence, var_1, var_2, var_3 );
}

addnotetrack_playersound( var_0, var_1, var_2, var_3 )
{
    var_1 = tolower( var_1 );
    var_2 = get_generic_anime( var_2 );
    var_4 = add_notetrack_and_get_index( var_0, var_1, var_2 );
    level.scr_notetrack[var_0][var_2][var_1][var_4] = [];
    level.scr_notetrack[var_0][var_2][var_1][var_4]["playersound"] = var_3;
}

get_generic_anime( var_0 )
{
    if ( !isdefined( var_0 ) )
        return "any";

    return var_0;
}

addonstart_animsound( var_0, var_1, var_2 )
{
    if ( !isdefined( level.scr_animsound[var_0] ) )
        level.scr_animsound[var_0] = [];

    level.scr_animsound[var_0][var_1] = var_2;
}

addnotetrack_animsound( var_0, var_1, var_2, var_3 )
{
    var_2 = tolower( var_2 );
    var_1 = get_generic_anime( var_1 );
    var_4 = add_notetrack_and_get_index( var_0, var_2, var_1 );
    var_5 = [];
    var_5["sound"] = var_3;
    var_5["created_by_animSound"] = 1;
    level.scr_notetrack[var_0][var_1][var_2][var_4] = var_5;
}

addnotetrack_attach( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 = tolower( var_1 );
    var_4 = get_generic_anime( var_4 );
    var_5 = add_notetrack_and_get_index( var_0, var_1, var_4 );
    var_6 = [];
    var_6["attach model"] = var_2;
    var_6["selftag"] = var_3;
    level.scr_notetrack[var_0][var_4][var_1][var_5] = var_6;
}

addnotetrack_detach( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 = tolower( var_1 );
    var_4 = get_generic_anime( var_4 );
    var_5 = add_notetrack_and_get_index( var_0, var_1, var_4 );
    var_6 = [];
    var_6["detach model"] = var_2;
    var_6["selftag"] = var_3;
    level.scr_notetrack[var_0][var_4][var_1][var_5] = var_6;
}

addnotetrack_detach_gun( var_0, var_1, var_2, var_3 )
{
    var_1 = tolower( var_1 );
    var_2 = get_generic_anime( var_2 );
    var_4 = add_notetrack_and_get_index( var_0, var_1, var_2 );
    var_5 = [];
    var_5["detach gun"] = 1;
    var_5["tag"] = "tag_weapon_right";

    if ( isdefined( var_3 ) )
        var_5["suspend"] = var_3;

    level.scr_notetrack[var_0][var_2][var_1][var_4] = var_5;
}

addnotetrack_customfunction( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 = tolower( var_1 );
    var_3 = get_generic_anime( var_3 );
    var_5 = add_notetrack_and_get_index( var_0, var_1, var_3 );
    var_6 = [];
    var_6["function"] = var_2;
    var_6["function_args"] = var_4;
    level.scr_notetrack[var_0][var_3][var_1][var_5] = var_6;
}

addnotetrack_startfxontag( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    common_scripts\utility::getfx( var_3 );
    var_1 = tolower( var_1 );
    var_2 = get_generic_anime( var_2 );
    var_6 = add_notetrack_and_get_index( var_0, var_1, var_2 );
    var_7 = [];
    var_7["effect"] = var_3;
    var_7["selftag"] = var_4;

    if ( isdefined( var_5 ) )
        var_7["moreThanThreeHack"] = var_5;

    level.scr_notetrack[var_0][var_2][var_1][var_6] = var_7;
}

addnotetrack_stopfxontag( var_0, var_1, var_2, var_3, var_4 )
{
    common_scripts\utility::getfx( var_3 );
    var_1 = tolower( var_1 );
    var_2 = get_generic_anime( var_2 );
    var_5 = add_notetrack_and_get_index( var_0, var_1, var_2 );
    var_6 = [];
    var_6["stop_effect"] = var_3;
    var_6["selftag"] = var_4;
    level.scr_notetrack[var_0][var_2][var_1][var_5] = var_6;
}

note_track_swap_to_efx( var_0, var_1, var_2 )
{
    var_3 = get_datascene();
    common_scripts\utility::add_fx( var_1, var_1 );
    addnotetrack_swapparttoefx( var_3.animname, var_0, var_3.animsequence, var_1, var_2 );
}

note_track_stop_efx_on_tag( var_0, var_1, var_2 )
{
    var_3 = get_datascene();
    common_scripts\utility::add_fx( var_1, var_1 );
    addnotetrack_stopfxontag( var_3.animname, var_0, var_3.animsequence, var_1, var_2 );
}

addnotetrack_swapparttoefx( var_0, var_1, var_2, var_3, var_4 )
{
    common_scripts\utility::getfx( var_3 );
    var_1 = tolower( var_1 );
    var_2 = get_generic_anime( var_2 );
    var_5 = add_notetrack_and_get_index( var_0, var_1, var_2 );
    var_6 = [];
    var_6["swap_part_to_efx"] = var_3;
    var_6["selftag"] = var_4;
    level.scr_notetrack[var_0][var_2][var_1][var_5] = var_6;
}

note_track_trace_to_efx( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = get_datascene();

    if ( var_0 != "start" && !animhasnotetrack( var_6 maps\_utility::getanim( var_6.anim_sequence ), var_0 ) )
        return;

    common_scripts\utility::add_fx( var_3, var_3 );

    if ( isdefined( var_4 ) )
        common_scripts\utility::add_fx( var_4, var_4 );

    addnotetrack_tracepartforefx( var_6.animname, var_0, var_1, var_6.anim_sequence, var_2, var_3, var_4, var_5 );
}

note_track_start_fx_on_tag( var_0, var_1, var_2 )
{
    var_3 = get_datascene();

    if ( var_0 != "start" && !animhasnotetrack( var_3 maps\_utility::getanim( var_3.anim_sequence ), var_0 ) )
        return;

    common_scripts\utility::add_fx( var_2, var_2 );
    addnotetrack_startfxontag( var_3.animname, var_0, var_3.anim_sequence, var_2, var_1, 1 );
}

get_datascene()
{
    var_0 = level.current_anim_data_scene;
    return var_0;
}

addnotetrack_tracepartforefx( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    common_scripts\utility::getfx( var_5 );
    var_1 = tolower( var_1 );
    var_3 = get_generic_anime( var_3 );
    var_8 = add_notetrack_and_get_index( var_0, var_1, var_3 );
    var_9 = [];
    var_9["trace_part_for_efx"] = var_5;
    var_9["trace_part_for_efx_water"] = var_6;
    var_9["trace_part_for_efx_cancel"] = var_2;
    var_9["trace_part_for_efx_delete_depth"] = var_7;
    var_9["selftag"] = var_4;
    level.scr_notetrack[var_0][var_3][var_1][var_8] = var_9;

    if ( isdefined( var_2 ) )
    {
        var_9 = [];
        var_9["trace_part_for_efx_canceling"] = var_2;
        var_9["selftag"] = var_4;
        var_8 = add_notetrack_and_get_index( var_0, var_2, var_3 );
        level.scr_notetrack[var_0][var_3][var_2][var_8] = var_9;
    }
}

addnotetrack_flag( var_0, var_1, var_2, var_3 )
{
    var_1 = tolower( var_1 );
    var_3 = get_generic_anime( var_3 );
    var_4 = add_notetrack_and_get_index( var_0, var_1, var_3 );
    var_5 = [];
    var_5["flag"] = var_2;
    level.scr_notetrack[var_0][var_3][var_1][var_4] = var_5;

    if ( !isdefined( level.flag ) || !isdefined( level.flag[var_2] ) )
        common_scripts\utility::flag_init( var_2 );
}

addnotetrack_flag_clear( var_0, var_1, var_2, var_3 )
{
    var_1 = tolower( var_1 );
    var_3 = get_generic_anime( var_3 );
    var_4 = add_notetrack_and_get_index( var_0, var_1, var_3 );
    var_5 = [];
    var_5["flag_clear"] = var_2;
    level.scr_notetrack[var_0][var_3][var_1][var_4] = var_5;

    if ( !isdefined( level.flag ) || !isdefined( level.flag[var_2] ) )
        common_scripts\utility::flag_init( var_2 );
}

addnotetrack_notify( var_0, var_1, var_2, var_3 )
{
    var_1 = tolower( var_1 );
    var_3 = get_generic_anime( var_3 );
    var_4 = add_notetrack_and_get_index( var_0, var_1, var_3 );
    var_5 = [];
    var_5["notify"] = var_2;
    level.scr_notetrack[var_0][var_3][var_1][var_4] = var_5;
}

addnotetrack_lui_notify( var_0, var_1, var_2, var_3 )
{
    var_1 = tolower( var_1 );
    var_3 = get_generic_anime( var_3 );
    var_4 = add_notetrack_and_get_index( var_0, var_1, var_3 );
    var_5 = [];
    var_5["lui_notify"] = var_2;
    level.scr_notetrack[var_0][var_3][var_1][var_4] = var_5;
}

addnotetrack_set_omnvar( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 = tolower( var_1 );
    var_4 = get_generic_anime( var_4 );
    var_5 = add_notetrack_and_get_index( var_0, var_1, var_4 );
    var_6 = [];
    var_6["omnvar"] = var_2;
    var_6["value"] = var_3;
    level.scr_notetrack[var_0][var_4][var_1][var_5] = var_6;
}

#using_animtree("generic_human");

disabledefaultfacialanims( var_0 )
{
    if ( !isdefined( var_0 ) || var_0 )
    {
        self.bdisabledefaultfacialanims = 1;
        self _meth_8142( %head, 0.2 );
        self.facialidx = undefined;
    }
    else
        self.bdisabledefaultfacialanims = undefined;
}

anim_facialanim( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    self endon( var_1 );
    var_3 = 0.05;
    var_0 notify( "newLookTarget" );
    waittillframeend;
    disabledefaultfacialanims();
    var_0 _meth_814B( %scripted_talking, 5, 0.2 );
    var_0 _meth_810D( "face_done_" + var_1, var_2, 1, 0, 1 );
    thread force_face_anim_to_play( var_0, var_1, var_2 );
    thread clearfaceanimonanimdone( var_0, "face_done_" + var_1, var_1 );
}

force_face_anim_to_play( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    var_0 endon( "stop_loop" );
    self endon( var_1 );

    for (;;)
    {
        disabledefaultfacialanims();
        var_0 _meth_814B( %scripted_talking, 5, 0.4 );
        var_0 _meth_8153( "face_done_" + var_1, var_2, 1, 0, 1 );
        wait 0.05;
    }
}

anim_facialfiller( var_0, var_1 )
{
    self endon( "death" );

    if ( isai( self ) && !isalive( self ) )
        return;

    var_2 = 0.05;
    self notify( "newLookTarget" );
    self endon( "newLookTarget" );
    waittillframeend;

    if ( !isdefined( var_1 ) && isdefined( self.looktarget ) )
        var_1 = self.looktarget;

    if ( self _meth_84F3() )
        var_3 = %generic_talker_blend;
    else
    {
        var_4 = self _meth_8442( "jnt_lips_L" );

        if ( var_4 != -1 )
            var_3 = %generic_talker_bs;
        else if ( self _meth_813D() )
            var_3 = %generic_talker_axis;
        else
            var_3 = %generic_talker_allies;
    }

    self _meth_8146( var_3, 1, 0, 1 );
    self _meth_814B( %scripted_talking, 5, 0.4 );
    disabledefaultfacialanims();
    set_talker_until_msg( var_0, var_3 );
    var_2 = 0.3;
    self _meth_8142( %scripted_talking, 0.2 );
    disabledefaultfacialanims( 0 );
}

set_talker_until_msg( var_0, var_1 )
{
    self endon( var_0 );

    for (;;)
    {
        wait 0.2;
        self _meth_8144( var_1, 1, 0, 1 );
        self _meth_814B( %scripted_talking, 5, 0.4 );
        disabledefaultfacialanims();
    }
}

talk_for_time( var_0 )
{
    self endon( "death" );
    var_1 = %generic_talker_allies;

    if ( self _meth_813D() )
        var_1 = %generic_talker_axis;

    self _meth_8146( var_1, 1, 0, 1 );
    self _meth_814B( %scripted_talking, 5, 0.4 );
    disabledefaultfacialanims();
    wait(var_0);
    var_2 = 0.3;
    self _meth_8142( %scripted_talking, 0.2 );
    disabledefaultfacialanims( 0 );
}

getyawangles( var_0, var_1 )
{
    var_2 = var_0[1] - var_1[1];
    var_2 = angleclamp180( var_2 );
    return var_2;
}

lookline( var_0, var_1 )
{
    self notify( "lookline" );
    self endon( "lookline" );
    self endon( var_1 );
    self endon( "death" );

    for (;;)
        wait 0.05;
}

anim_reach_idle( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.count = var_0.size;

    foreach ( var_5 in var_0 )
        thread reachidle( var_5, var_1, var_2, var_3 );

    while ( var_3.count )
        var_3 waittill( "reached_goal" );

    self notify( "stopReachIdle" );
}

reachidle( var_0, var_1, var_2, var_3 )
{
    anim_reach_solo( var_0, var_1 );
    var_3.count--;
    var_3 notify( "reached_goal" );

    if ( var_3.count > 0 )
        anim_loop_solo( var_0, var_2, "stopReachIdle" );
}

delayeddialogue( var_0, var_1, var_2, var_3 )
{
    if ( animhasnotetrack( var_3, "dialog" ) )
        self waittillmatch( "face_done_" + var_0, "dialog" );

    if ( var_1 )
        animscripts\face::sayspecificdialogue( undefined, var_2, 1.0 );
    else
        animscripts\face::sayspecificdialogue( undefined, var_2, 1.0, "single dialogue" );
}

clearfaceanimonanimdone( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    var_0 waittillmatch( var_1, "end" );
    var_3 = 0.3;
    var_0 _meth_8142( %scripted_talking, 0.2 );
    disabledefaultfacialanims( 0 );
}

anim_start_pos( var_0, var_1, var_2 )
{
    var_3 = get_anim_position( var_2 );
    var_4 = var_3["origin"];
    var_5 = var_3["angles"];
    common_scripts\utility::array_thread( var_0, ::set_start_pos, var_1, var_4, var_5 );
}

anim_start_pos_solo( var_0, var_1, var_2 )
{
    var_3[0] = var_0;
    anim_start_pos( var_3, var_1, var_2 );
}

set_start_pos( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = undefined;

    if ( isdefined( var_3 ) )
        var_5 = var_3;
    else
        var_5 = self.animname;

    if ( isdefined( var_4 ) && var_4 )
        var_6 = level.scr_anim[var_5][var_0][0];
    else if ( isarray( level.scr_anim[var_5][var_0] ) )
        var_6 = common_scripts\utility::random( level.scr_anim[var_5][var_0] );
    else
        var_6 = level.scr_anim[var_5][var_0];

    if ( isai( self ) )
    {
        var_7 = getstartorigin( var_1, var_2, var_6 );
        var_8 = getstartangles( var_1, var_2, var_6 );

        if ( isdefined( self.anim_start_at_groundpos ) )
            var_7 = maps\_utility::groundpos( var_7 );

        self _meth_81C6( var_7, var_8 );
    }
    else if ( self.code_classname == "script_vehicle" )
        self _meth_827C( getstartorigin( var_1, var_2, var_6 ), getstartangles( var_1, var_2, var_6 ) );
    else
    {
        self.origin = getstartorigin( var_1, var_2, var_6 );
        self.angles = getstartangles( var_1, var_2, var_6 );
    }
}

anim_at_self( var_0, var_1 )
{
    var_2 = [];
    var_2["guy"] = self;
    var_2["entity"] = self;
    return var_2;
}

anim_at_entity( var_0, var_1 )
{
    var_2 = [];
    var_2["guy"] = self;
    var_2["entity"] = var_0;
    var_2["tag"] = var_1;
    return var_2;
}

add_to_animsound()
{
    if ( !isdefined( self.animsounds ) )
        self.animsounds = [];

    var_0 = 0;

    for ( var_1 = 0; var_1 < level.animsounds.size; var_1++ )
    {
        if ( self == level.animsounds[var_1] )
        {
            var_0 = 1;
            break;
        }
    }

    if ( !var_0 )
        level.animsounds[level.animsounds.size] = self;
}

anim_set_rate_single( var_0, var_1, var_2 )
{
    var_0 thread anim_set_rate_internal( var_1, var_2 );
}

anim_set_rate( var_0, var_1, var_2 )
{
    common_scripts\utility::array_thread( var_0, ::anim_set_rate_internal, var_1, var_2 );
}

anim_set_rate_internal( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( isdefined( var_2 ) )
        var_3 = var_2;
    else
        var_3 = self.animname;

    var_4 = maps\_utility::getanim_from_animname( var_0, var_3 );

    if ( isarray( var_4 ) )
        var_4 = var_4[0];

    self _meth_8111( "single anim", var_4, 1, 0, var_1 );
}

anim_set_time( var_0, var_1, var_2 )
{
    common_scripts\utility::array_thread( var_0, ::anim_self_set_time, var_1, var_2 );
}

anim_self_set_time( var_0, var_1 )
{
    var_2 = maps\_utility::getanim( var_0 );
    self _meth_8117( var_2, var_1 );
}

last_anim_time_check( var_0, var_1 )
{
    if ( !isdefined( self.last_anim_time ) )
    {
        self.last_anim_time = gettime();
        return;
    }

    var_2 = gettime();

    if ( self.last_anim_time == var_2 )
    {
        self endon( "death" );
        wait 0.05;
    }

    self.last_anim_time = var_2;
}

set_custom_move_start_transition( var_0, var_1 )
{
    var_0.custommovetransition = animscripts\cover_arrival::custommovetransitionfunc;
    var_0.startmovetransitionanim = level.scr_anim[var_0.animname][var_1];
}

create_anim_scene( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_3 ) )
        var_3 = "generic";
    else
        level.scr_animtree[var_3] = var_0;

    var_5 = spawnstruct();
    var_5.animtree = var_0;
    var_5.model = var_4;

    if ( isdefined( var_4 ) )
        level.scr_model[var_3] = var_4;

    if ( isdefined( var_2 ) )
        level.scr_anim[var_3][var_1] = var_2;

    var_5.animname = var_3;
    var_5.anim_sequence = var_1;
    level.current_anim_data_scene = var_5;
}
