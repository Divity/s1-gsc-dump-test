// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_gunSightColorEntityScale", "7" );
    setdvar( "r_gunSightColorNoneScale", "0.8" );
    thread set_lighting_values();
}

set_lighting_values()
{
    if ( _func_235() )
    {
        for (;;)
            level waittill( "connected", var_0 );
    }
}
