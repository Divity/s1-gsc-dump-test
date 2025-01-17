// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "allies";
    self.type = "human";
    self.subclass = "regular";
    self.accuracy = 0.2;
    self.health = 100;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "iw5_titan45_sp";

    if ( isai( self ) )
    {
        self _meth_816C( 256.0, 0.0 );
        self _meth_816D( 768.0, 1024.0 );
    }

    switch ( codescripts\character::get_random_weapon( 15 ) )
    {
        case 0:
            self.weapon = "iw5_sn6_sp";
            break;
        case 1:
            self.weapon = "iw5_sn6_sp_opticsacog2";
            break;
        case 2:
            self.weapon = "iw5_sn6_sp_opticsreddot";
            break;
        case 3:
            self.weapon = "iw5_sn6_sp_variablereddot";
            break;
        case 4:
            self.weapon = "iw5_sn6_sp_opticstargetenhancer";
            break;
        case 5:
            self.weapon = "iw5_asm1_sp";
            break;
        case 6:
            self.weapon = "iw5_asm1_sp_opticsacog2";
            break;
        case 7:
            self.weapon = "iw5_asm1_sp_opticsreddot";
            break;
        case 8:
            self.weapon = "iw5_asm1_sp_variablereddot";
            break;
        case 9:
            self.weapon = "iw5_asm1_sp_opticstargetenhancer";
            break;
        case 10:
            self.weapon = "iw5_hmr9_sp";
            break;
        case 11:
            self.weapon = "iw5_hmr9_sp_opticsacog2";
            break;
        case 12:
            self.weapon = "iw5_hmr9_sp_opticsreddot";
            break;
        case 13:
            self.weapon = "iw5_hmr9_sp_variablereddot";
            break;
        case 14:
            self.weapon = "iw5_hmr9_sp_opticstargetenhancer";
            break;
    }

    switch ( codescripts\character::get_random_character( 2 ) )
    {
        case 0:
            character\character_pmc_smg::main();
            break;
        case 1:
            character\character_pmc_smg_asi::main();
            break;
    }
}

spawner()
{
    self _meth_8040( "allies" );
}

precache()
{
    character\character_pmc_smg::precache();
    character\character_pmc_smg_asi::precache();
    precacheitem( "iw5_sn6_sp" );
    precacheitem( "iw5_sn6_sp_opticsacog2" );
    precacheitem( "iw5_sn6_sp_opticsreddot" );
    precacheitem( "iw5_sn6_sp_variablereddot" );
    precacheitem( "iw5_sn6_sp_opticstargetenhancer" );
    precacheitem( "iw5_asm1_sp" );
    precacheitem( "iw5_asm1_sp_opticsacog2" );
    precacheitem( "iw5_asm1_sp_opticsreddot" );
    precacheitem( "iw5_asm1_sp_variablereddot" );
    precacheitem( "iw5_asm1_sp_opticstargetenhancer" );
    precacheitem( "iw5_hmr9_sp" );
    precacheitem( "iw5_hmr9_sp_opticsacog2" );
    precacheitem( "iw5_hmr9_sp_opticsreddot" );
    precacheitem( "iw5_hmr9_sp_variablereddot" );
    precacheitem( "iw5_hmr9_sp_opticstargetenhancer" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "fraggrenade" );
}
