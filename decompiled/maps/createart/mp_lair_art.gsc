// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level._id_99DA = 1;

    if ( _func_235() )
        maps\createart\mp_lair_fog_hdr::_id_8311();
    else
        maps\createart\mp_lair_fog::_id_8311();

    visionsetnaked( "mp_lair", 0 );
}
