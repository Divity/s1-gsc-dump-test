// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

initextractionwarbird()
{
    precacheitem( "warbird_remote_turret_mp" );
    map_restart( "zom_civ_extraction_air_warbird" );
    map_restart( "zom_civ_extraction_air_rope" );
    precachemodel( "vehicle_xh9_warbird_pulley" );
    maps\mp\zombies\_civilians::registerextractioninitevent( "warbird", ::warbirdextractioninit );
    maps\mp\zombies\_civilians::registerextractionescortevent( "warbird", ::warbirdextractionescort );
    maps\mp\zombies\_civilians::registerextractionevent( "warbird", ::warbirdextraction );
}

warbirdextractioninit()
{

}

warbirdextractionescort()
{

}

warbirdextraction()
{
    var_0 = common_scripts\utility::getstruct( self.targetextractpoint.target, "targetname" );
    var_1 = spawnhelicopter( level.players[0], var_0.origin, var_0.angles, "warbird_player_mp", "vehicle_xh9_warbird_low_cloaked_in_out_mp_cloak" );
    var_1.warbirdturret = var_1 spawn_warbird_turret( "warbird_remote_turret_mp", "vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak", "tag_player_mp", 0 );
    thread warbirdfire( var_1 );
    var_1 _meth_828B();
    var_1 _meth_8075( "veh_warbird_fly_over_civ_extract" );
    var_2 = var_0;
    var_3 = 40;

    while ( isdefined( var_2.target ) )
    {
        var_2 = common_scripts\utility::getstruct( var_2.target, "targetname" );

        if ( isdefined( var_2.script_count ) )
            var_3 = var_2.script_count;

        warbirdmovetoattackpoint( var_1, var_2, var_3 );
    }

    level notify( "extraction_sequence_complete" );
    waitframe();
    var_1.warbirdturret delete();
    var_1.rope delete();
    var_1 delete();
    level.warbirdextraction = 0;
    var_1 notify( "warbirdExtractionComplete" );
}

spawn_warbird_turret( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnturret( "misc_turret", self gettagorigin( var_2 ), var_0, 0 );
    var_4.angles = self gettagangles( var_2 );
    var_4 _meth_80B1( var_1 );
    var_4 _meth_815A( 55.0 );
    var_4 _meth_804D( self, var_2, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_4.owner = self.owner;
    var_4.health = 99999;
    var_4.maxhealth = 1000;
    var_4.damagetaken = 0;
    var_4.stunned = 0;
    var_4.stunnedtime = 0.0;
    var_4 _meth_82C0( 0 );
    var_4 _meth_82C1( 0 );
    var_4.team = level.players[0].team;
    var_4.pers["team"] = level.players[0].team;
    var_4 _meth_8065( "auto_nonai" );
    var_4 _meth_8103( self.owner );
    var_4 _meth_8105( 0 );
    var_4.chopper = self;
    return var_4;
}

warbirdfire( var_0 )
{
    var_0 endon( "warbirdExtractionComplete" );
    var_0.picknewtarget = 1;

    for (;;)
    {
        wait 0.05;

        if ( var_0.picknewtarget )
        {
            var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype( "all" );
            var_2 = [];

            foreach ( var_4 in var_1 )
            {
                if ( var_4.team == level.playerteam )
                    continue;

                foreach ( var_6 in level.players )
                {
                    if ( distance( var_6.origin, var_4.origin ) > 300 )
                        var_2 = common_scripts\utility::array_add( var_2, var_4 );
                }
            }

            if ( var_2.size < 0 )
                continue;

            var_2 = sortbydistance( var_2, var_0.origin );
            var_9 = undefined;

            foreach ( var_11 in var_2 )
            {
                if ( !isdefined( var_11 ) )
                    continue;

                if ( !isalive( var_11 ) )
                    continue;

                var_9 = var_11;
                var_0.enemy_target = var_9;
                checkwarbirdtargetlos( var_0 );
                break;
            }
        }
    }
}

fireatzombie( var_0 )
{
    var_0 endon( "warbirdExtractionComplete" );
    var_0 endon( "pickNewTarget" );
    var_0.warbirdturret _meth_8065( "manual" );
    var_0.warbirdturret _meth_8106( var_0.enemy_target );
    var_1 = 0;
    var_2 = randomfloatrange( 2, 3 );
    wait(randomfloatrange( 3, 5 ));

    while ( var_1 < var_2 )
    {
        if ( !isdefined( var_0.enemy_target ) || !isalive( var_0.enemy_target ) )
            break;

        var_0.warbirdturret _meth_80EA();
        wait(randomfloatrange( 0.15, 0.25 ));
        var_1 += 0.15;
    }

    var_0.enemy_target = undefined;
    var_0.picknewtarget = 1;
    var_0 notify( "pickNewTarget" );
}

checkwarbirdtargetlos( var_0 )
{
    var_0 endon( "warbirdExtractionComplete" );
    var_0 endon( "pickNewTarget" );
    var_0.enemy_target endon( "death" );
    var_0.enemy_target endon( "disconnect" );
    var_1 = var_0 gettagorigin( "TAG_FLASH1" );
    var_2 = var_0.enemy_target _meth_80A8();
    var_3 = vectornormalize( var_2 - var_1 );
    var_4 = var_1 + var_3 * 20;
    var_5 = bullettrace( var_4, var_2, 0, var_0, 0, 0, 0, 0, 0 );

    if ( !checktargetisinvision( var_0 ) && var_5["fraction"] < 1 && !checktargetnearplayer( var_0 ) )
    {
        wait 5;
        var_0.lineofsight = 0;
        var_0.picknewtarget = 1;
        var_0.enemy_target = undefined;
        var_0 notify( "pickNewTarget" );
        return;
    }

    var_0.lineofsight = 1;
    fireatzombie( var_0 );
}

checktargetnearplayer( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( distance( var_2.origin, var_0.enemy_target.origin ) < 300 )
            return 0;
    }

    return 1;
}

checktargetisinvision( var_0 )
{
    var_1 = anglestoforward( var_0.angles );
    var_2 = var_0.enemy_target.origin - var_0.origin;
    var_3 = vectordot( var_1, var_2 );
    return var_3 < 0;
}

warbirdmovetoattackpoint( var_0, var_1, var_2 )
{
    var_0 _meth_83F3( 1 );

    if ( !isdefined( var_0.rope ) )
    {
        var_0.rope = spawn( "script_model", ( 0, 0, 0 ) );
        var_0.rope _meth_80B1( "vehicle_xh9_warbird_pulley" );
        var_0.rope _meth_8446( var_0, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var_0.rope hide();
    }

    var_0 _meth_8283( var_2, var_2 / 4, var_2 / 4 );
    var_0 _meth_825A( 100 );

    if ( isdefined( var_1.target ) && var_1.target == "ExtractionHoverPosition" )
        var_0 _meth_825A( 10 );

    var_0 _meth_825B( var_1.origin, isdefined( var_1.script_parameters ) );
    var_0 waittill( "near_goal" );

    if ( isdefined( var_1.script_parameters ) )
    {
        if ( _func_2D9( self ) && isalive( self ) )
        {
            self notify( "extraction_started" );
            self.agentname = undefined;
            self.ignoreme = 1;
            self _meth_83FB();
            self.extractionsuccessful = 1;
            self _meth_839D( 1 );
            maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 1, "SynchronizedAnim" );
            self _meth_8398( "noclip" );
            var_0.rope show();
            var_0.rope _meth_8279( "zom_civ_extraction_air_rope", "dummy" );
            self _meth_8561( 1, 0.2, var_0.rope, "tag_attach", "tag_weapon_left" );
            maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe( "zom_civ_extraction_air_civ", 0, "synchronized" );
            thread civilianplayidleoutroanim();
            maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 0, "SynchronizedAnim" );
        }

        wait 3;

        if ( level.numberofalivecivilians > 0 )
            level notify( "extraction_complete" );
    }

    var_0 _meth_83F3( 0 );
}

civilianplayidleoutroanim()
{
    while ( _func_2D9( self ) && isalive( self ) )
        maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe( "zom_civ_extraction_air_civ_idle", 0, "synchronized" );
}

warbirdlookatenemy( var_0 )
{
    for (;;)
    {
        if ( isdefined( var_0.enemy_target ) )
        {
            monitorlookatent( var_0 );
            var_0.warbirdturret _meth_8108();
        }

        waitframe();
    }
}

monitorlookatent( var_0 )
{
    var_0 endon( "pickNewTarget" );
    var_0 _meth_8265( var_0.enemy_target );
    var_0.warbirdturret _meth_8106( var_0.enemy_target );
    var_0.enemy_target common_scripts\utility::waittill_either( "death", "disconnect" );
    var_0.picknewtarget = 1;
    var_0.lineofsight = 0;
}

executemultistageextractevent( var_0 )
{
    if ( !isdefined( var_0.groupname ) )
        return;

    switch ( var_0.groupname )
    {
        case "repairDrone":
            repairdroneevent();
            break;
    }
}

repairdroneevent()
{
    iprintlnbold( "RELEASE DRONE" );
    wait 5;

    foreach ( var_1 in level.players )
    {
        var_2 = [];
        var_3 = var_1 maps\mp\zombies\killstreaks\_zombie_drone_assault::tryuseassaultdrone( -1, var_2 );

        if ( var_3 == 1 )
            return;
    }
}
