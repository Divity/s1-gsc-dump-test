// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_sp_usmc_ryan" );
    self attach( "head_sp_usmc_ryan_ryan_body", "", 1 );
    self.headmodel = "head_sp_usmc_ryan_ryan_body";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_sp_usmc_ryan" );
    precachemodel( "head_sp_usmc_ryan_ryan_body" );
}