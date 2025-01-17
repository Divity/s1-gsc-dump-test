// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precache_stuff()
{
    precache_fx();
    load_scripted_anims();
}

precache_fx()
{
    level._effect["warbird_harpoon_spiral"] = loadfx( "vfx/vehicle/warbird_harpoon_spiral" );
    level._effect["warbird_zip_rope_glow"] = loadfx( "vfx/vehicle/warbird_zip_rope_glow" );
    level._effect["dust_harpoon_impact"] = loadfx( "vfx/dust/dust_harpoon_impact" );
}

load_scripted_anims()
{
    load_generic_human_anims();
    load_script_model_anims();
    precachemodel( "npc_zipline_rope_left" );
}

#using_animtree("generic_human");

load_generic_human_anims()
{
    level.scr_anim["generic"]["npc_inverted_zipline_launch_1"] = %npc_inverted_zipline_launch_1;
    level.scr_anim["generic"]["npc_inverted_zipline_launch_2"] = %npc_inverted_zipline_launch_2;
    level.scr_anim["generic"]["npc_inverted_zipline_launch_3"] = %npc_inverted_zipline_launch_3;
    level.scr_anim["generic"]["npc_inverted_zipline_launch_4"] = %npc_inverted_zipline_launch_4;
    level.scr_anim["generic"]["zipline_land_spc_1"] = %npc_inverted_zipline_spc_1;
    level.scr_anim["generic"]["zipline_land_spc_2"] = %npc_inverted_zipline_spc_2;
    level.scr_anim["generic"]["zipline_land_spc_3"] = %npc_inverted_zipline_spc_3;
    level.scr_anim["generic"]["zipline_land_spc_4"] = %npc_inverted_zipline_spc_4;
    level.scr_anim["generic"]["zipline_land_1"] = %npc_inverted_zipline_1;
    level.scr_anim["generic"]["zipline_land_2"] = %npc_inverted_zipline_2;
    level.scr_anim["generic"]["zipline_land_3"] = %npc_inverted_zipline_3;
    level.scr_anim["generic"]["zipline_land_4"] = %npc_inverted_zipline_4;
    level.scr_anim["generic"]["zipline_land_6"] = %npc_inverted_zipline_6;
    level.scr_anim["generic"]["zipline_land_7"] = %npc_inverted_zipline_7;
    level.scr_anim["generic"]["zipline_land_8"] = %npc_inverted_zipline_8;
    level.scr_anim["generic"]["zipline_land_9"] = %npc_inverted_zipline_9;
    level.scr_anim["generic"]["zipline_ground_land_ra"] = %zipline_right_land_guy_a;
    level.scr_anim["generic"]["zipline_ground_land_rb"] = %zipline_right_land_guy_b;
    level.scr_anim["generic"]["zipline_ground_land_la"] = %zipline_left_landing_guy_a;
    level.scr_anim["generic"]["zipline_ground_land_lb"] = %zipline_left_landing_guy_b;
    level.scr_anim["generic"]["zipline_idleloop_ra"][0] = %zipline_right_slidedown_guy_a;
    level.scr_anim["generic"]["zipline_idleloop_rb"][0] = %zipline_right_slidedown_guy_b;
    level.scr_anim["generic"]["zipline_idleloop_la"][0] = %zipline_left_slidedown_guy_a;
    level.scr_anim["generic"]["zipline_idleloop_lb"][0] = %zipline_left_slidedown_guy_b;
}

#using_animtree("script_model");

load_script_model_anims()
{
    level.scr_animtree["_zipline_rope_fl"] = #animtree;
    level.scr_model["_zipline_rope_fl"] = "npc_zipline_rope_left";
    level.scr_anim["_zipline_rope_fl"]["fastzip_fire"] = %fastzip_launcher_fire_left_npc;
    level.scr_anim["_zipline_rope_fl"]["fastzip_slide"] = %fastzip_launcher_slidedown_left_npc;
    level.scr_anim["_zipline_rope_fl"]["retract_rope"] = %fastzip_launcher_retract_left;
    maps\_anim::addnotetrack_customfunction( "_zipline_rope_fl", "fx_harpoon_launch", ::harpoon_launch_effects, "fastzip_fire" );
}

harpoon_launch_effects( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "warbird_harpoon_spiral" ), var_0, "jnt_harpoon" );
    playfxontag( common_scripts\utility::getfx( "warbird_zip_rope_glow" ), var_0, "harpooncablebend" );
}

spawn_npc_and_use_scripted_zipline( var_0, var_1, var_2 )
{
    if ( isstring( var_0 ) )
        var_3 = getent( var_0, "targetname" );
    else
        var_3 = var_0;

    var_3.count = 1;
    var_4 = var_3 maps\_utility::spawn_ai( 1 );
    maps\_utility::spawn_failed( var_4 );
    waitframe();
    var_4.animname = "generic";
    level notify( "zipline_guys_spawned", var_4 );
    var_4 thread seoul_zipline_scripted( var_1, var_2 );
    return var_4;
}

seoul_zipline_scripted( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;

    if ( isstring( var_0 ) )
        var_4 = maps\_utility::getent_or_struct_or_node( var_0, "targetname" );
    else
        var_4 = var_0;

    var_6 = var_4.origin;

    if ( isdefined( var_4.target ) )
        var_5 = maps\_utility::getent_or_struct_or_node( var_4.target, "targetname" );
    else if ( isdefined( var_4.script_noteworthy ) )
        var_5 = maps\_utility::getent_or_struct_or_node( var_4.script_noteworthy, "targetname" );
    else
        return;

    var_7 = var_5.origin;
    self.zipline_end_org = var_7;
    var_8 = vectortoangles( var_7 - var_6 );
    var_9 = maps\_utility::spawn_anim_model( "_zipline_rope_fl", var_6, var_8 );
    var_9 _meth_80B1( "npc_zipline_rope_left" );
    var_10 = randomfloat( 100.0 );

    if ( var_10 < 25.0 )
        var_11 = "zipline_idleloop_ra";
    else if ( var_10 < 50.0 )
        var_11 = "zipline_idleloop_rb";
    else if ( var_10 < 75.0 )
        var_11 = "zipline_idleloop_la";
    else
        var_11 = "zipline_idleloop_la";

    if ( var_7[2] > var_6[2] )
        var_3 = get_launch_anim( var_5, 1 );

    if ( !isdefined( var_1 ) )
    {
        if ( var_7[2] > var_6[2] )
            var_1 = "zipline_land_8";
        else
        {
            var_10 = randomfloat( 100.0 );

            if ( var_10 < 25.0 )
                var_1 = "zipline_ground_land_ra";
            else if ( var_10 < 50.0 )
                var_1 = "zipline_ground_land_rb";
            else if ( var_10 < 50.0 )
                var_1 = "zipline_ground_land_la";
            else
                var_1 = "zipline_ground_land_lb";
        }
    }

    seoul_zipline_scripted_custom( var_6, var_7, var_9, "fastzip_fire", "fastzip_slide", var_11, var_3, var_1, var_2 );
}

seoul_zipline_scripted_custom( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self endon( "death" );
    var_2 do_reposition_zipline_compensation( var_2, var_0, var_1, var_3 );
    var_2 do_rotate_zipline_compensation( var_2, var_0, var_1, var_3, var_4 );
    var_9 = var_1[2] > var_0[2];
    [var_11, var_12, var_13] = var_2 fire_rope( var_0, var_1, var_3 );
    var_2 thread remove_zipline_on_death( var_8, var_11, self );

    if ( !isdefined( self ) || !isalive( self ) )
        return 1;

    if ( isdefined( self ) && isalive( self ) )
    {
        var_14 = get_uncliip_zipline_waittime( var_7, var_9 );
        self.is_using_zipline = 1;
        thread allow_death_during_zipline();
        fastzip_slide( var_2, var_5, var_4, var_12, var_14 );
        fastzip_launch( var_6, var_9 );
        fastzip_land( var_7, var_9, var_14 );
        self notify( "end_allow_death_during_zipline" );
        self.is_using_zipline = undefined;
    }

    if ( !isdefined( var_8 ) || !var_8 )
    {
        var_2 retract_rope( var_11 );
        var_2 delete();
    }

    return 1;
}

remove_zipline_on_death( var_0, var_1, var_2 )
{
    var_2 waittill( "death" );

    if ( isdefined( self ) && ( !isdefined( var_0 ) || !var_0 ) )
    {
        retract_rope( var_1 );
        self delete();
    }
}

allow_death_during_zipline()
{
    self endon( "end_allow_death_during_zipline" );
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self.delayeddeath ) && self.delayeddeath )
        {
            stop_zip_idle_anim();
            var_0 = self _meth_83EC();

            if ( isdefined( var_0 ) )
                self _meth_804F();

            self _meth_818E( "gravity" );
        }

        waitframe();
    }
}

#using_animtree("generic_human");

get_launch_anim( var_0, var_1 )
{
    if ( 1 )
    {
        var_2 = randomfloat( 100.0 );

        if ( var_1 )
        {
            if ( var_2 < 25.0 )
            {
                return "npc_inverted_zipline_launch_1";
                return;
            }

            if ( var_2 < 50.0 )
            {
                return "npc_inverted_zipline_launch_2";
                return;
            }

            if ( var_2 < 75.0 )
            {
                return "npc_inverted_zipline_launch_3";
                return;
            }

            return "npc_inverted_zipline_launch_4";
            return;
            return;
            return;
            return;
        }

        if ( var_2 < 25.0 )
        {
            return %npc_inverted_zipline_launch_1;
            return;
        }

        if ( var_2 < 50.0 )
        {
            return %npc_inverted_zipline_launch_2;
            return;
        }

        if ( var_2 < 75.0 )
        {
            return %npc_inverted_zipline_launch_3;
            return;
        }

        return %npc_inverted_zipline_launch_4;
        return;
        return;
        return;
        return;
    }
    else if ( var_1 )
        return var_0.animation;
    else
        return maps\_utility::getanim( var_0.animation );
}

get_uncliip_zipline_waittime( var_0, var_1 )
{
    if ( !var_1 )
        return 0.4329;
    else
        return 0;
}

main()
{

}

fastzip_launch( var_0, var_1 )
{
    self endon( "death" );

    if ( isalive( self ) )
    {
        if ( isdefined( var_0 ) )
        {
            unlink_from_zip();
            stop_zip_idle_anim();
            common_scripts\utility::delay_script_call( 0.2, ::set_post_slide_blend_time, 0.2 );

            if ( isstring( var_0 ) )
            {
                level.scr_goaltime[self.animname][var_0] = self.anim_blend_time_override;
                thread maps\_anim::anim_single_solo( self, var_0 );
                var_2 = getanimlength( maps\_utility::getanim( var_0 ) );
                wait(truncate_time_ms( var_2 ));
                return;
            }

            self _meth_8110( "traverseAnim", var_0, %body, 1, 0.2, 1 );
            var_2 = getanimlength( var_0 );
            wait(var_2);
            return;
        }
        else
            set_post_slide_blend_time( 0.2 );
    }
}

truncate_time_ms( var_0 )
{
    var_1 = var_0 * 20.0;
    var_1 = int( var_1 );
    return var_1 * 0.05;
}

set_post_slide_blend_time( var_0 )
{
    self.anim_blend_time_override = var_0;
}

stop_zip_idle_anim()
{
    self notify( "stop_loop" );
    self _meth_8141();
}

unlink_from_zip()
{
    if ( !isdefined( self ) )
        return;

    var_0 = self _meth_83EC();

    if ( isdefined( var_0 ) )
        self _meth_804F();
}

fastzip_land( var_0, var_1, var_2 )
{
    self endon( "death" );

    if ( isalive( self ) )
    {
        common_scripts\utility::delay_script_call( var_2, ::unlink_from_zip );
        stop_zip_idle_anim();
        var_3 = undefined;

        if ( isstring( var_0 ) )
            var_3 = maps\_utility::getanim( var_0 );
        else
            var_3 = var_0;

        var_4 = getanimlength( var_3 );
        var_5 = 0;
        var_6 = 0;
        var_7 = 0;

        if ( animhasnotetrack( var_3, "finish" ) )
            var_5 = var_4 * getnotetracktimes( var_3, "finish" )[0];
        else
            var_5 = var_4;

        if ( animhasnotetrack( var_3, "land" ) )
        {
            var_6 = var_4 * getnotetracktimes( var_3, "land" )[0];
            var_7 = 1;
        }

        level.scr_goaltime[self.animname][var_0] = self.anim_blend_time_override;
        soundscripts\_snd::snd_message( "seo_zipline_rappel_land", self );

        if ( var_1 )
            thread maps\_anim::anim_single_solo( self, var_0 );
        else
            thread maps\_anim::anim_generic_custom_animmode( self, "nogravity", var_0, undefined, undefined, 0 );

        wait(var_2);

        if ( var_7 )
        {
            wait(var_6 - var_2 - 0.05);
            self _meth_818E( "gravity" );
            wait(var_5 - ( var_6 - var_2 - 0.05 ));
        }
        else
            wait(var_5 - var_2);

        self _meth_8141();
        return;
    }

    self.istraversing = undefined;
    self _meth_818E( "none" );
    self notify( "zipline_done" );
}

get_adjusted_anim_rate( var_0, var_1, var_2 )
{
    var_3 = getmovedelta( var_0, 0.0, 1.0 );
    var_3 = rotatevector( var_3, self.angles );
    var_4 = ( self.origin[0] + var_3[0], self.origin[1] + var_3[1], self.origin[2] ) + ( 0, 0, 70 );
    var_5 = physicstrace( var_4, self.origin + ( 0, 0, -5120 ), self );
    var_6 = var_5[2] - self.origin[2];
    var_7 = animscripts\utility::get_trajectory_time_given_x( 0, var_6, -1 * self.velocity[2], -1 * getdvarint( "g_gravity" ) );
    var_7 -= var_2;
    var_8 = var_2 / var_7;

    if ( var_6 >= var_3[2] )
        return 1;

    if ( var_8 <= 0 )
        return 1;

    return var_8;
}

#using_animtree("script_model");

fastzip_slide( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    var_5 = var_0 maps\_utility::getanim( var_2 );
    var_0 _meth_814C( %add_slide, 1, 0, 0 );
    var_0 _meth_814C( var_5, 1, 0, 0 );
    var_6 = anglestoforward( var_0.angles );
    var_6 = ( var_6[0], var_6[1], 0 );
    var_7 = vectortoangles( var_6 );
    [var_9, var_10] = var_0 gettagorigin_rotatecompensation( "tag_player_attach" );
    self _meth_81C6( var_9, var_7, 100000 );

    if ( isstring( var_1 ) )
        thread maps\_anim::anim_loop_solo( self, var_1, "stop_loop" );
    else
        thread play_loop_until_message( var_1, "stop_loop" );

    soundscripts\_snd::snd_message( "seo_zipline_rappel_begin" );
    wait 0.05;
    self _meth_804D( var_0, "tag_player_attach" );
    var_0 _meth_814C( %add_slide, 1, 0, 1.0 );
    var_0 _meth_814C( var_5, 1, 0, 1.0 );
    wait(var_3 - 0.1 - var_4);
    thread fastzip_slide_end( var_0, var_5, var_4 );
}

fastzip_slide_end( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_0 endon( "death" );
    wait(var_2);
    var_3 = 1;

    while ( var_3 > 0 )
    {
        var_3 -= 0.1;
        var_0 _meth_83C7( var_1, var_3 );
        waitframe();
    }

    var_0 _meth_83C7( var_1, 0 );
}

#using_animtree("generic_human");

play_loop_until_message( var_0, var_1 )
{
    self endon( "death" );
    self _meth_8110( "idle", var_0, %body, 1, 0.1, 1 );
    self waittill( var_1 );
    self _meth_8142( var_0, 0.2 );
}

gettagorigin_rotatecompensation( var_0 )
{
    var_1 = self gettagorigin( "jnt_shuttleClip" );
    var_2 = self gettagorigin( var_0 );
    var_3 = distance( var_1, var_2 );
    var_4 = var_1 + ( 0, 0, -1 ) * var_3;
    return [ var_4, var_2 - var_4 ];
}

do_rotate_zipline_compensation( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_0 gettagorigin( "jnt_winchCableBend" );
    var_6 = distance( var_2, var_1 );
    var_7 = var_2 - var_1;
    var_8 = var_6 / 2400;
    var_0 _meth_814B( var_0 maps\_utility::getanim( var_4 ), 1, 0, 0 );
    var_0 _meth_8117( var_0 maps\_utility::getanim( var_4 ), var_8 );
    waitframe();
    var_9 = var_0 gettagorigin( "jnt_shuttleRoot" );
    var_0 _meth_8117( var_0 maps\_utility::getanim( var_4 ), 0 );
    var_10 = var_9 - var_1;
    var_11 = vectortoangles( var_10 );
    var_12 = vectortoangles( var_7 );
    var_13 = combineangles( var_12, _func_24C( var_11 ) );
    var_14 = combineangles( var_13, var_12 );
    var_0.angles = var_14;
}

do_reposition_zipline_compensation( var_0, var_1, var_2, var_3 )
{
    var_0 maps\_anim::anim_first_frame_solo( var_0, var_3 );
    var_4 = var_0 gettagorigin( "jnt_winchCableBend" );
    var_0.origin += var_1 - var_4;
}

fire_rope( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = undefined;
    var_5 = 1;
    var_6 = 7.0;
    var_7 = distance( var_1, var_0 ) / 12;

    if ( var_7 <= 200.0 )
        var_8 = var_7 / 200.0;
    else
    {
        var_8 = 1.0;
        var_7 = 200.0;
    }

    if ( var_5 )
    {
        var_9 = var_1 - var_0;
        var_9 = vectornormalize( var_9 );
        var_4 = var_1 + var_9 * 2400.0;
        var_10 = bullettrace( var_1, var_4, 0 );

        if ( var_10["fraction"] < 1 )
            var_4 = var_10["position"];

        var_11 = distance( var_0, var_4 ) / 12;
        var_11 -= 3.75;

        if ( var_11 <= 200.0 )
            var_3 = var_11 / 200.0;
        else
        {
            var_3 = 1.0;
            var_11 = 200.0;
        }
    }
    else
        var_3 = var_8;

    var_12 = maps\_utility::getanim( var_2 );
    var_13 = getanimlength( var_12 );
    var_14 = var_13 * var_3 / var_6 - 0.05;
    soundscripts\_snd::snd_message( "seo_zipline_harpoon_fire", var_0, var_1, var_14 );
    self _meth_8152( var_2, var_12, 1, 0.2, var_6 );
    thread maps\_anim::start_notetrack_wait( self, var_2, var_2, self.animname, var_12 );
    thread maps\_anim::animscriptdonotetracksthread( self, var_2, var_2 );

    if ( var_14 > 0.05 )
        wait(var_14);

    self _meth_814B( var_12, 1, 0, 0 );
    self _meth_8117( var_12, var_3 );
    var_15 = self gettagorigin( "jnt_harpoon" );
    var_16 = anglestoright( self gettagangles( "jnt_harpoon" ) );
    self.hit_ground_pos = physicstrace( var_15 + var_16 * -75, var_15 + var_16 * 75, self );
    playfx( common_scripts\utility::getfx( "dust_harpoon_impact" ), self.hit_ground_pos );
    soundscripts\_snd::snd_message( "seo_zipline_harpoon_impact", self.hit_ground_pos );
    level notify( "zipline_triggered", self.origin, self.hit_ground_pos );
    waitframe();
    self _meth_814B( var_12, 1, 0, 0 );
    self _meth_8117( var_12, 1.0 );
    var_17 = self gettagorigin( "jnt_harpoon" );
    var_18 = distance( var_15, var_17 );

    if ( var_18 > 0 )
    {
        var_19 = distance( var_15, self.hit_ground_pos ) - 15.0;
        var_20 = ( 1.0 - var_3 ) * var_19 / var_18;
        self _meth_814B( var_12, 1, 0, 0 );
        self _meth_8117( var_12, var_20 + var_3 );
    }

    var_21 = var_13 * var_8 / 1.0;
    return [ var_7, var_21, var_4 ];
}

sndxt_fastzip_fire( var_0 )
{
    var_1 = self;
    var_2 = randomfloatrange( 0.1, 0.2 );
    wait(var_2);
    var_1 soundscripts\_snd_playsound::snd_play( "tac_fastzip_fire" );
    wait(var_2);
    common_scripts\utility::play_sound_in_space( "tac_fastzip_proj_impact", var_0 );
}

retract_rope( var_0 )
{
    var_1 = var_0 / 200.0;
    var_1 = 1 - min( var_1, 1 );
    var_2 = 30;
    var_3 = 1;
    var_4 = maps\_utility::getanim( "retract_rope" );
    self _meth_8143( var_4, 1, 0.2, var_3 );
    self _meth_8117( var_4, var_1 );
    playfx( common_scripts\utility::getfx( "dust_harpoon_impact" ), self.hit_ground_pos );
    soundscripts\_snd::snd_message( "seo_zipline_retract_rope", self.hit_ground_pos );
    var_5 = var_2 * ( 1 - var_1 ) / 30 * var_3;
    wait(var_5 + 0.05);
}
