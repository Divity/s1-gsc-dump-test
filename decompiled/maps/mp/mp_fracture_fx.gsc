// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level._effect["mp_cgo_iceberg_foam_1"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_iceberg_foam_1" );
    level._effect["dust_ambient_interior"] = loadfx( "vfx/map/greece/dust_ambient_interior" );
    level._effect["mp_cgo_falling_object_splash"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_falling_object_splash" );
    level._effect["mp_cgo_lrg_ice_break_splash"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_lrg_ice_break_splash" );
    level._effect["mp_cgo_ice_break_splash"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_ice_break_splash" );
    level._effect["mp_cgo_ocean_wave_01"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_ocean_wave_01" );
    level._effect["mp_cgo_snow_geyser_blast"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_snow_geyser_blast" );
    level._effect["mp_cgo_falling_snow_chunks_2"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_falling_snow_chunks_2" );
    level._effect["mp_cgo_falling_snow_chunks_1"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_falling_snow_chunks_1" );
    level._effect["mp_cgo_snow_wind_gust_runner"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_snow_wind_gust_runner" );
    level._effect["mp_cgo_godray_hazy_lrg"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_godray_hazy_lrg" );
    level._effect["mp_cgo_floodlight_flare_01"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_floodlight_flare_01" );
    level._effect["mp_cgo_floodlight_flare_02"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_floodlight_flare_02" );
    level._effect["mp_cgo_heat_lamp_01"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_heat_lamp_01" );
    level._effect["mp_cgo_fluorescent_flare_01"] = loadfx( "vfx/map/mp_cargoship/mp_cgo_fluorescent_flare_01" );
    level._effect["electrical_sparks_runner_no_impact_spawn"] = loadfx( "vfx/explosion/electrical_sparks_runner_no_impact_spawn" );
    level._effect["test_effect"] = loadfx( "vfx/test/test_fx" );
    level._effect["fx_sunflare_cargoship2"] = loadfx( "vfx/lensflare/fx_sunflare_cargoship2" );
}

ice_cracking_fx()
{
    wait 0.1;
    _func_222( 1 );
    wait 1.3;
    _func_222( 2 );
    wait 0.6;
    _func_222( 3 );
}
