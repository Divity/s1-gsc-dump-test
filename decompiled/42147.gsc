// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_hero_will_marine" );
    self attach( "head_hero_will_marines", "", 1 );
    self.headmodel = "head_hero_will_marines";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_hero_will_marine" );
    precachemodel( "head_hero_will_marines" );
}