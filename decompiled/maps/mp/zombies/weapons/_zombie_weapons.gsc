// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.zombie_placeable_mine_types = [];
    level.onplayerspawnedweaponsfunc = ::onplayerspawnedfunc;
    maps\mp\zombies\weapons\_zombie_explosive_drone::init();
    maps\mp\zombies\weapons\_zombie_distraction_drone::init();
    maps\mp\zombies\weapons\_zombie_dna_aoe_grenade::init();

    if ( isdefined( level.zombieweaponinitfunc ) )
        [[ level.zombieweaponinitfunc ]]();
}

onplayerspawnedfunc()
{
    thread maps\mp\zombies\weapons\_zombie_explosive_drone::onplayerspawn();
    thread maps\mp\zombies\weapons\_zombie_distraction_drone::onplayerspawn();
    thread maps\mp\zombies\weapons\_zombie_dna_aoe_grenade::onplayerspawn();

    if ( isdefined( level.zombieweapononplayerspawnedfunc ) )
        [[ level.zombieweapononplayerspawnedfunc ]]();
}

addplaceableminetype( var_0 )
{
    level.zombie_placeable_mine_types[level.zombie_placeable_mine_types.size] = var_0;
}

isplaceableminetype( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    foreach ( var_2 in level.zombie_placeable_mine_types )
    {
        if ( var_2 == var_0 )
            return 1;
    }

    return 0;
}

givegrenadesafterrounds()
{
    foreach ( var_1 in level.players )
    {
        var_2 = var_1 _meth_8345();
        var_3 = var_1 _meth_831A();
        var_4 = [ var_2, var_3 ];

        foreach ( var_6 in var_4 )
        {
            if ( var_6 == "none" )
                continue;

            var_1 _meth_82F6( var_6, var_1 _meth_82F8( var_6 ) + 1 );
        }
    }
}
