// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.tweakfile = 1;

    if ( _func_235() )
        maps\createart\mp_bigben2_fog_hdr::setupfog();
    else
        maps\createart\mp_bigben2_fog::setupfog();

    visionsetnaked( "mp_bigben2", 0 );
}