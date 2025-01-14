// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init_selfiebooth()
{
    var_0 = getent( "selfie_player_pos", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    var_1 = getent( var_0.target, "targetname" );
    var_2 = getent( var_1.target, "targetname" );
    level.selfiebooth = spawnstruct();
    level.selfiebooth.player_pos = var_0;
    level.selfiebooth.camera_pos = var_2;
    setdvarifuninitialized( "scr_vlobby_selfie_correction_y", 32.0 );
    setdvarifuninitialized( "scr_vlobby_selfie_collision_z", 10.0 );
    level thread run_selfiebooth();
}

run_selfiebooth()
{
    while ( !isdefined( level.player ) )
        waitframe();

    level.player spawnselfieavatar();
    wait 5;

    for (;;)
    {
        waitframe();

        if ( _func_2BC() || !_func_2BB() || getdvarint( "practiceroundgame" ) )
            continue;

        if ( !should_take_selfie() )
            continue;

        take_selfie();
    }
}

spawnselfieavatar()
{
    while ( !isdefined( level.player.spawned_avatar ) || !isdefined( level.player.spawned_avatar.costume ) )
        waitframe();

    var_0 = level.selfiebooth.player_pos.origin;
    var_1 = getdvarfloat( "scr_vlobby_selfie_collision_z", 0.0 );
    var_2 = getdvarfloat( "scr_vlobby_selfie_correction_y", 0.0 );
    var_3 = ( 0, var_2, var_1 );
    var_0 += var_3;
    var_4 = level.selfiebooth.player_pos.angles;
    var_5 = maps\mp\agents\_agent_utility::getfreeagent( "selfie_clone" );
    var_5.isactive = 1;
    var_5 _meth_838A( var_0, var_4, undefined, undefined, undefined, undefined, 1 );
    var_6 = level.player _meth_8297();
    _func_2D4( var_5, var_6 );
    var_5 _meth_83D1( 1 );
    var_5 _meth_83D0( "vlobby_animclass" );
    var_5 _meth_83D2( "lobby_idle", "selfie_01", 1.0 );
    var_5 _meth_84BA( level.player.spawned_avatar.costume );
    var_5 _meth_804D( level.selfiebooth.player_pos );
    level.selfiebooth.clone = var_5;
    self.selfie_clone = var_5;
}

should_take_selfie()
{
    if ( !isdefined( level.player ) )
        return 0;

    if ( !isdefined( level.player.spawned_avatar ) || !isdefined( level.player.spawned_avatar.costume ) )
        return 0;

    if ( !level.player _meth_84FE() )
        return 0;

    if ( level.player _meth_84FD() )
        return 0;

    return 1;
}

take_selfie()
{
    if ( !isdefined( level.selfiebooth.clone ) )
        return;

    if ( !isdefined( level.player ) )
        return;

    if ( !isdefined( level.player.spawned_avatar ) )
        return;

    if ( !isdefined( level.player.spawned_avatar.costume ) )
        return;

    var_0 = level.selfiebooth.clone.origin;
    var_1 = level.selfiebooth.clone _meth_80A8();
    level.selfiebooth.clone _meth_84BA( level.player.spawned_avatar.costume );
    waitframe();

    if ( !level.player _meth_853A( level.selfiebooth.camera_pos.origin, var_0, var_1[2] - var_0[2], 0, 0 ) )
        return;

    while ( isdefined( level.player ) && !level.player _meth_8501() )
        waitframe();
}
