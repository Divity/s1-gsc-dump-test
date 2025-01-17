// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

credits_start()
{
    level.used_credits_data1 = [];
    level.used_credits_data2 = [];
    level.used_credits = [];
    level.credits_alpha = 0.85;
    var_0 = 16;

    if ( level.console )
        var_1 = [ 33, 110, var_0 + 2, "left", "middle", "left", "middle" ];
    else
        var_1 = [ 76, 110, var_0 + 2, "left", "middle", "left", "middle" ];

    var_2 = [ -350, -110, var_0, "left", "middle" ];
    var_3 = [ 300, -110, var_0, "right", "middle" ];
    var_4 = [ -350, 150, var_0, "left", "middle" ];
    var_5 = [ 300, 150, var_0, "right", "middle" ];
    show_shg_title_credits( var_1 );
}

credits_display_think( var_0 )
{
    for ( var_1 = 1; !common_scripts\utility::flag( "kill_credits" ); var_0 = common_scripts\utility::array_randomize( var_0 ) )
    {
        while ( common_scripts\utility::flag( "pause_credits" ) )
        {
            level.credits_alpha = 0.55;
            waitframe();
        }

        if ( var_1 )
        {
            var_2 = [ var_0[0], var_0[1] ];
            common_scripts\utility::flag_set( "pause_credits" );
        }
        else
            var_2 = var_0;

        var_1 = 0;

        foreach ( var_5, var_4 in var_2 )
        {
            if ( !common_scripts\utility::flag( "kill_credits" ) )
            {
                thread quadrant_display( var_4 );
                wait 6.25;
            }
        }
    }
}

show_shg_title_credits( var_0 )
{
    wait 2;
    var_1 = get_title_credit( var_0, &"SEOUL_CREDITS_SHG_DEVELOPMENT", 3 );
    maps\_utility::delaythread( 3, ::text_glow_adjust, var_1, 0.2 );
    thread maps\_utility::delaythread( 4.5, ::fade_name_random, var_1, 0, 1, 4 );
    wait 5;
    var_2 = get_title_credit( var_0, &"SEOUL_CREDITS_ASSOCIATION_WITH", 2 );
    thread maps\_utility::delaythread( 6.5, ::fade_name_random, var_2, 0, 1 );
    wait 2;
    var_3 = get_title_credit( var_0, &"SEOUL_CREDITS_RAVEN_SOFT", 1 );
    thread maps\_utility::delaythread( 3.5, ::fade_name_random, var_3, 0, 1 );
    wait 1.25;
    var_4 = get_title_credit( var_0, &"SEOUL_CREDITS_HIGHMOON", 0 );
    thread maps\_utility::delaythread( 3.5, ::fade_name_random, var_4, 0, 1 );
    wait 3.7;
    var_5 = get_title_credit( var_0, &"SEOUL_CREDITS_COD_AW", 3, 1 );
    wait 4;
}

show_exec_title_credits( var_0 )
{
    var_1 = [ var_0[0], var_0[1], var_0[2] + 3, var_0[3], var_0[4] ];
    var_2 = get_title_credit( var_1, &"SEOUL_CREDITS_DIRECTED_BY", 3, 1 );
    thread maps\_utility::delaythread( 8, ::fade_name_random, var_2, 0, 1 );
    wait 2;
    var_3 = get_title_credit( var_1, &"SEOUL_CREDITS_GLEN_SCHOFIELD", 2 );
    maps\_utility::delaythread( 1, ::text_glow_adjust, var_3, 0.2 );
    thread maps\_utility::delaythread( 3.5, ::fade_name_random, var_3, 0, 1 );
    wait 2;
    var_4 = get_title_credit( var_1, &"SEOUL_CREDITS_MICHAEL_CONDREY", 1 );
    maps\_utility::delaythread( 1, ::text_glow_adjust, var_4, 0.2 );
    thread maps\_utility::delaythread( 3.5, ::fade_name_random, var_4, 0, 1 );
    wait 4;
}

get_title_credit( var_0, var_1, var_2, var_3 )
{
    var_4 = 18;
    var_5 = maps\_shg_design_tools::get_standard_glow_text( var_0[0], var_0[1], var_0[2], var_0[3], var_0[4], var_2 * -1, ( 0.75, 0.85, 0.87 ), ( 0.25, 0.25, 0.3 ), var_0[5], var_0[6] );
    var_5.textstring = var_1;
    var_5.alpha = 0;
    var_5 fadeovertime( 1.25 );
    var_5.alpha = level.credits_alpha;
    var_5.fontscale = 1.85;
    var_5 settext( var_1 );

    if ( isdefined( var_3 ) && var_3 )
        var_5 setpulsefx( 50, 6000, 700 );

    return var_5;
}

quadrant_display( var_0 )
{
    var_1 = get_random_strings_and_alphabatize( 6 );
    var_2 = [];

    foreach ( var_5, var_4 in var_1 )
    {
        var_2[var_5] = maps\_shg_design_tools::get_standard_glow_text( var_0[0], var_0[1], var_0[2], var_0[3], var_0[4], var_5 * -1, ( 0.75, 0.85, 0.87 ), ( 0.25, 0.25, 0.3 ) );
        var_2[var_5] settext( var_4 );
        var_2[var_5].alpha = 0;
        var_2[var_5].textstring = var_4;
    }

    foreach ( var_5, var_7 in var_2 )
    {
        thread fade_name_random( var_7 );
        wait 0.2;
    }

    wait 3;
    var_8 = common_scripts\utility::array_randomize( var_2 );

    foreach ( var_5, var_7 in var_8 )
    {
        thread fade_name_random( var_7, 0 );
        wait(randomfloat( 0.5 ));
    }

    foreach ( var_5, var_7 in var_8 )
    {
        while ( !var_7.at_rest )
            waitframe();

        var_7 destroy();
    }
}

get_random_strings_and_alphabatize( var_0 )
{
    var_1 = [];
    var_2 = common_scripts\utility::array_combine( level.credits_data1, level.credits_data2 );
    var_3 = common_scripts\utility::array_combine( level.used_credits_data1, level.used_credits_data2 );
    var_4 = level.credits_data2;
    var_5 = var_2;

    while ( var_1.size < var_0 && level.used_credits.size < var_2.size )
    {
        var_6 = min( int( var_0 / 2 ), level.credits_data2.size - level.used_credits_data2.size );

        if ( var_1.size < var_6 )
            var_7 = common_scripts\utility::random( var_4 );
        else
            var_7 = common_scripts\utility::random( var_5 );

        if ( common_scripts\utility::array_contains( level.used_credits, var_7 ) )
            continue;

        if ( common_scripts\utility::array_contains( var_1, var_7 ) )
            continue;

        if ( common_scripts\utility::array_contains( level.credits_data1, var_7 ) )
            level.used_credits_data1[level.used_credits_data1.size] = var_7;
        else
            level.used_credits_data2[level.used_credits_data2.size] = var_7;

        var_1[var_1.size] = var_7;
        level.used_credits[level.used_credits.size] = var_7;
    }

    var_1 = common_scripts\utility::alphabetize( var_1 );
    var_1 = common_scripts\utility::array_reverse( var_1 );
    return var_1;
}

alphabetize_localized_string( var_0, var_1 )
{
    var_2 = [];
    var_3 = [];

    foreach ( var_7, var_5 in var_0 )
    {
        var_6[0] = var_5;
        var_6[1] = get_index_from_array( var_5, var_1 );
        var_3[var_3.size] = var_6;
    }

    var_8 = 0;

    foreach ( var_7, var_10 in var_3 )
        var_2[var_10[1]] = var_10[0];

    var_11 = [];

    foreach ( var_7, var_13 in var_2 )
        var_11[var_11.size] = var_13;

    return var_11;
}

get_index_from_array( var_0, var_1 )
{
    var_2 = undefined;

    foreach ( var_5, var_4 in var_1 )
    {
        if ( var_4 == var_0 )
            return var_5;
    }
}

fade_name_random( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level.credits_alpha;

    var_0.at_rest = 0;

    if ( !isdefined( var_3 ) )
        var_3 = randomfloatrange( 0.5, 1.25 );

    var_0 fadeovertime( var_3 );
    var_0.alpha = var_1;
    var_0 fadeovertime( var_3 );
    wait(var_3);

    if ( isdefined( var_0 ) )
        var_0.at_rest = 1;

    if ( isdefined( var_2 ) && isdefined( var_0 ) )
        var_0 destroy();
}

text_glow_adjust( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.85;

    var_0.at_rest = 0;

    if ( !isdefined( var_2 ) )
        var_2 = randomfloatrange( 0.5, 1.25 );

    var_3 = var_0.glowcolor;
    wait(var_2);
    var_4 = randomintrange( 30, 40 );

    for ( var_5 = 0; var_5 < var_4; var_5++ )
    {
        if ( !isdefined( var_0 ) )
            return;

        var_6 = var_0.glowcolor;

        if ( common_scripts\utility::cointoss() )
        {
            if ( common_scripts\utility::cointoss() )
                var_6 = ( var_0.glowcolor[0] / 2, var_0.glowcolor[1] / 2, var_0.glowcolor[2] / ( 2 - randomfloat( 1 ) ) );
            else if ( var_0.glowcolor[0] > 0.15 )
                var_6 = ( var_0.glowcolor[0] * 2, var_0.glowcolor[1] * 2, var_0.glowcolor[2] * ( 2 * randomfloatrange( 1, 1.5 ) ) );

            var_0.glowcolor = var_6;
            var_0.glowalpha = randomfloat( 1.0 );
        }
        else if ( common_scripts\utility::cointoss() )
        {
            if ( common_scripts\utility::cointoss() )
                var_0.alpha = level.credits_alpha * 0.7;
            else
                var_0.alpha = level.credits_alpha;
        }

        waitframe();
    }

    if ( !isdefined( var_0 ) )
        return;

    var_0.glowcolor = var_3;
    var_0.glowalpha = var_1;
    var_0.alpha = level.credits_alpha;
    var_0.at_rest = 1;
}

standard_text_list( var_0, var_1 )
{
    var_2 = newclienthudelem( level.player );
    var_2.positioninworld = 1;
    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2.foreground = 1;
    var_2.hidewheninmenu = 1;
    var_2.start_x = var_0;
    var_2.y = var_1;
    return var_2;
}
