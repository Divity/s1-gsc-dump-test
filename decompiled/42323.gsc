// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{

}

setup_names()
{
    if ( isdefined( level.names ) )
        return;

    var_0 = [];
    var_0[var_0.size] = "american";
    var_0[var_0.size] = "seal";
    var_0[var_0.size] = "taskforce";
    var_0[var_0.size] = "secretservice";
    var_0[var_0.size] = "british";
    var_0[var_0.size] = "arab";
    var_0[var_0.size] = "russian";
    var_0[var_0.size] = "multilingual";
    var_0[var_0.size] = "portuguese";
    var_0[var_0.size] = "shadowcompany";
    var_0[var_0.size] = "delta";
    var_0[var_0.size] = "french";
    var_0[var_0.size] = "african";
    var_0[var_0.size] = "czech";
    var_0[var_0.size] = "czech_surnames";
    var_0[var_0.size] = "pmc";
    var_0[var_0.size] = "xslice";
    var_0[var_0.size] = "kva";
    var_0[var_0.size] = "atlas";
    var_0[var_0.size] = "sentinel";
    var_0[var_0.size] = "squad";
    var_0[var_0.size] = "northkorea";

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        level.names[var_0[var_1]] = [];

    add_name( "american", "Smith" );
    add_name( "american", "Johnson" );
    add_name( "american", "Williams" );
    add_name( "american", "Jones" );
    add_name( "american", "Brown" );
    add_name( "american", "Davis" );
    add_name( "american", "Miller" );
    add_name( "american", "Wilson" );
    add_name( "american", "Moore" );
    add_name( "american", "Taylor" );
    add_name( "american", "Anderson" );
    add_name( "american", "Thomas" );
    add_name( "american", "Jackson" );
    add_name( "american", "White" );
    add_name( "american", "Harris" );
    add_name( "american", "Martin" );
    add_name( "american", "Garcia" );
    add_name( "american", "Martinez" );
    add_name( "american", "Robinson" );
    add_name( "american", "Clark" );
    add_name( "american", "Rodriguez" );
    add_name( "american", "Lewis" );
    add_name( "american", "Lee" );
    add_name( "american", "Hall" );
    add_name( "american", "Allen" );
    add_name( "american", "Young" );
    add_name( "american", "Hernandez" );
    add_name( "american", "King" );
    add_name( "seal", "Angel" );
    add_name( "seal", "Apex" );
    add_name( "seal", "Bearcat" );
    add_name( "seal", "Bishop" );
    add_name( "seal", "Boomer" );
    add_name( "seal", "Boxer" );
    add_name( "seal", "Canine" );
    add_name( "seal", "Chemist" );
    add_name( "seal", "Chemo" );
    add_name( "seal", "Cherub" );
    add_name( "seal", "Chino" );
    add_name( "seal", "Coffin" );
    add_name( "seal", "Coma" );
    add_name( "seal", "Cyclops" );
    add_name( "seal", "Cypher" );
    add_name( "seal", "Doc" );
    add_name( "seal", "Druid" );
    add_name( "seal", "Gator" );
    add_name( "seal", "Hannibal" );
    add_name( "seal", "Hazard" );
    add_name( "seal", "Hitman" );
    add_name( "seal", "Jayhawk" );
    add_name( "seal", "Jester" );
    add_name( "seal", "Justice" );
    add_name( "seal", "Klepto" );
    add_name( "seal", "Kojak" );
    add_name( "seal", "Langley" );
    add_name( "seal", "Neptune" );
    add_name( "seal", "Mamba" );
    add_name( "seal", "Midnight" );
    add_name( "seal", "Neon" );
    add_name( "seal", "Nomad" );
    add_name( "seal", "Ogre" );
    add_name( "seal", "Ozone" );
    add_name( "seal", "Patron" );
    add_name( "seal", "Pharaoh" );
    add_name( "seal", "Pieces" );
    add_name( "seal", "Poet" );
    add_name( "seal", "Preacher" );
    add_name( "seal", "Reaper" );
    add_name( "seal", "Redcell" );
    add_name( "seal", "Roadie" );
    add_name( "seal", "Robot" );
    add_name( "seal", "Rocket" );
    add_name( "seal", "Rooster" );
    add_name( "seal", "Sparrow" );
    add_name( "seal", "Taco" );
    add_name( "seal", "Thumper" );
    add_name( "seal", "Trojan" );
    add_name( "seal", "Twister" );
    add_name( "seal", "Undertone" );
    add_name( "seal", "Utah" );
    add_name( "seal", "Whiskey" );
    add_name( "seal", "Worm" );
    add_name( "seal", "Yankee" );
    add_name( "seal", "Zero" );
    copy_names( "taskforce", "seal" );
    add_name( "xslice", "Wolfman" );
    add_name( "xslice", "Rodriguez" );
    add_name( "xslice", "Boone" );
    add_name( "xslice", "Junger" );
    add_name( "xslice", "Miggs" );
    add_name( "xslice", "Arturro" );
    add_name( "xslice", "Sidewinder" );
    add_name( "xslice", "Capp" );
    add_name( "xslice", "Jackson" );
    add_name( "xslice", "Vickers" );
    add_name( "xslice", "Krakauer" );
    add_name( "xslice", "Daniels" );
    add_name( "xslice", "Walker" );
    add_name( "xslice", "Flatline" );
    add_name( "xslice", "Vasquez" );
    add_name( "xslice", "Jackal" );
    add_name( "xslice", "Anderson" );
    add_name( "xslice", "Monster" );
    add_name( "xslice", "Chan" );
    add_name( "xslice", "Jones" );
    add_name( "xslice", "Breaker" );
    add_name( "xslice", "Doc" );
    add_name( "xslice", "Booker" );
    add_name( "xslice", "Dunn" );
    add_name( "xslice", "Williams" );
    add_name( "xslice", "Davis" );
    add_name( "xslice", "McReady" );
    add_name( "xslice", "Childs" );
    copy_names( "delta", "xslice" );
    add_name( "secretservice", "Smith" );
    add_name( "secretservice", "Jones" );
    add_name( "british", "Abbot" );
    add_name( "british", "Adams" );
    add_name( "british", "Bartlett" );
    add_name( "british", "Boyd" );
    add_name( "russian", "Sasha Ivanov" );
    add_name( "russian", "Aleksei Vyshinskiy" );
    add_name( "russian", "Boris Ryzhkov" );
    add_name( "russian", "Dima Tikhonov" );
    add_name( "russian", "Oleg Kosygin" );
    add_name( "arab", "Abdulaziz" );
    add_name( "arab", "Abdullah" );
    add_name( "arab", "Ali" );
    add_name( "portuguese", "Carlitos" );
    add_name( "portuguese", "Antonio" );
    add_name( "portuguese", "Gervasio" );
    add_name( "portuguese", "Lois" );
    add_name( "portuguese", "Xesus" );
    add_name( "shadowcompany", "Lestat" );
    add_name( "shadowcompany", "Nosferatu" );
    add_name( "shadowcompany", "Lecter" );
    add_name( "multilingual", "Kugelschreiber" );
    add_name( "multilingual", "Flughafen" );
    add_name( "french", "Astor" );
    add_name( "french", "Beliveau" );
    add_name( "african", "Sulaiman" );
    add_name( "african", "Camara" );
    add_name( "african", "Mustapha" );
    add_name( "african", "Abubakarr" );
    add_name( "czech", "Andrej" );
    add_name( "czech", "Anton" );
    add_name( "czech_surnames", "Blumel" );
    add_name( "czech_surnames", "Maly" );
    add_name( "czech_surnames", "Pospisil" );
    add_name( "atlas", "Abeles" );
    add_name( "atlas", "Angeles" );
    add_name( "atlas", "Anjos" );
    add_name( "atlas", "Baker" );
    add_name( "atlas", "Beahm" );
    add_name( "atlas", "Bein" );
    add_name( "atlas", "Betka" );
    add_name( "atlas", "Bilodeau" );
    add_name( "atlas", "Bingham" );
    add_name( "atlas", "Blair" );
    add_name( "atlas", "Blake" );
    add_name( "atlas", "Blizard" );
    add_name( "atlas", "Brown" );
    add_name( "atlas", "Bryner" );
    add_name( "atlas", "Bullock " );
    add_name( "atlas", "Carter" );
    add_name( "atlas", "Chan" );
    add_name( "atlas", "Chang" );
    add_name( "atlas", "Chavez" );
    add_name( "atlas", "Chen" );
    add_name( "atlas", "Cinquegrano" );
    add_name( "atlas", "Cooper" );
    add_name( "atlas", "Coucoules" );
    add_name( "atlas", "Cox" );
    add_name( "atlas", "Cumings" );
    add_name( "atlas", "Davenport" );
    add_name( "atlas", "Davis" );
    add_name( "atlas", "DeRosa" );
    add_name( "atlas", "Desmarais" );
    add_name( "atlas", "Dolin" );
    add_name( "atlas", "Durham" );
    add_name( "atlas", "Erck" );
    add_name( "atlas", "Ettenberger" );
    add_name( "atlas", "Farahani" );
    add_name( "atlas", "Felker" );
    add_name( "atlas", "Forsyth" );
    add_name( "atlas", "Gaugy" );
    add_name( "atlas", "Gavazza" );
    add_name( "atlas", "Ghiglieri" );
    add_name( "atlas", "Gonzales" );
    add_name( "atlas", "Gray" );
    add_name( "atlas", "Guaman" );
    add_name( "atlas", "Gudihal" );
    add_name( "atlas", "Herrera" );
    add_name( "atlas", "Hook" );
    add_name( "atlas", "Hort" );
    add_name( "atlas", "Imai" );
    add_name( "atlas", "Jessup" );
    add_name( "atlas", "Katz" );
    add_name( "atlas", "Kendall" );
    add_name( "atlas", "Krotenberg" );
    add_name( "atlas", "Kuo" );
    add_name( "atlas", "Lamperski" );
    add_name( "atlas", "Leal" );
    add_name( "atlas", "Lin-Chiang" );
    add_name( "atlas", "Lopez-Centellas" );
    add_name( "atlas", "Louie" );
    add_name( "atlas", "Madden" );
    add_name( "atlas", "Magbag" );
    add_name( "atlas", "Mangan" );
    add_name( "atlas", "Matulac" );
    add_name( "atlas", "Maurer" );
    add_name( "atlas", "Mekala" );
    add_name( "atlas", "Menghini" );
    add_name( "atlas", "Mermelstein" );
    add_name( "atlas", "Miggels" );
    add_name( "atlas", "Molina" );
    add_name( "atlas", "Morgan" );
    add_name( "atlas", "Naas" );
    add_name( "atlas", "O'Connor" );
    add_name( "atlas", "Olazabal" );
    add_name( "atlas", "Pena" );
    add_name( "atlas", "Pham" );
    add_name( "atlas", "Rausch" );
    add_name( "atlas", "Rente" );
    add_name( "atlas", "Robbins" );
    add_name( "atlas", "Rodgers" );
    add_name( "atlas", "Roozbeh" );
    add_name( "atlas", "Salud" );
    add_name( "atlas", "Sani" );
    add_name( "atlas", "Schmidt" );
    add_name( "atlas", "Schofield" );
    add_name( "atlas", "Shande" );
    add_name( "atlas", "Sheffield" );
    add_name( "atlas", "Simas" );
    add_name( "atlas", "Sontag" );
    add_name( "atlas", "Soukkampha" );
    add_name( "atlas", "Stephanus" );
    add_name( "atlas", "Stoddard" );
    add_name( "atlas", "Strickland" );
    add_name( "atlas", "Tang" );
    add_name( "atlas", "Todd" );
    add_name( "atlas", "Tucker" );
    add_name( "atlas", "Veca" );
    add_name( "atlas", "Vuong" );
    add_name( "atlas", "Warnke" );
    add_name( "atlas", "Waters" );
    add_name( "atlas", "Wells" );
    add_name( "atlas", "West" );
    add_name( "atlas", "Whitfield" );
    add_name( "atlas", "Whitney" );
    add_name( "atlas", "Wojick" );
    add_name( "atlas", "Wong" );
    add_name( "atlas", "Ytuarte" );
    add_name( "atlas", "Zhang" );
    add_name( "atlas", "Arditti" );
    add_name( "atlas", "Campbell" );
    add_name( "atlas", "Christie" );
    add_name( "atlas", "Couturier" );
    add_name( "atlas", "Della Penna" );
    add_name( "atlas", "Ecker" );
    add_name( "atlas", "Evans" );
    add_name( "atlas", "Johnson" );
    add_name( "atlas", "Kaplow" );
    add_name( "atlas", "Kit" );
    add_name( "atlas", "Krystek" );
    add_name( "atlas", "Lim" );
    add_name( "atlas", "Marinov" );
    add_name( "atlas", "Mika" );
    add_name( "atlas", "Nguyen" );
    add_name( "atlas", "Pasetto" );
    add_name( "atlas", "Prescott" );
    add_name( "atlas", "Rigby" );
    add_name( "atlas", "Sakanai" );
    add_name( "atlas", "Shields" );
    add_name( "atlas", "Stebbing" );
    add_name( "atlas", "Szentirmay" );
    add_name( "atlas", "Villar" );
    add_name( "atlas", "Yager" );
    add_name( "atlas", "Adelmeyer" );
    add_name( "atlas", "Carontenuto" );
    add_name( "atlas", "Dickinson" );
    add_name( "atlas", "DiMeo" );
    add_name( "atlas", "Egert" );
    add_name( "atlas", "Friedrich" );
    add_name( "atlas", "Georgescu" );
    add_name( "atlas", "Keele" );
    add_name( "atlas", "Kimoto" );
    add_name( "atlas", "Ko" );
    add_name( "atlas", "Kutcher" );
    add_name( "atlas", "Lord" );
    add_name( "atlas", "Maynard" );
    add_name( "atlas", "McDonald" );
    add_name( "atlas", "Micciulla" );
    add_name( "atlas", "Myers" );
    add_name( "atlas", "Ojomo" );
    add_name( "atlas", "Raymond" );
    add_name( "atlas", "Reinhardt" );
    add_name( "atlas", "Rogers" );
    add_name( "atlas", "Smith" );
    add_name( "atlas", "St. Laurent" );
    add_name( "atlas", "Swenty" );
    add_name( "atlas", "Velaquez" );
    add_name( "atlas", "Apilado" );
    add_name( "atlas", "Barnett" );
    add_name( "atlas", "Beese" );
    add_name( "atlas", "Biessman" );
    add_name( "atlas", "Blumel" );
    add_name( "atlas", "Burnett" );
    add_name( "atlas", "Butts" );
    add_name( "atlas", "Carani" );
    add_name( "atlas", "Cork" );
    add_name( "atlas", "Curd" );
    add_name( "atlas", "Dariano" );
    add_name( "atlas", "Devenero" );
    add_name( "atlas", "Dusette" );
    add_name( "atlas", "Ekberg" );
    add_name( "atlas", "Fifield" );
    add_name( "atlas", "Gilardi" );
    add_name( "atlas", "Gulisano" );
    add_name( "atlas", "Hackbarth" );
    add_name( "atlas", "Hartmann" );
    add_name( "atlas", "Hiley" );
    add_name( "atlas", "Hodge" );
    add_name( "atlas", "Hummer" );
    add_name( "atlas", "Jorgenson" );
    add_name( "atlas", "Koberstein" );
    add_name( "atlas", "Kornkven" );
    add_name( "atlas", "Kramer" );
    add_name( "atlas", "Kreimeier" );
    add_name( "atlas", "Larson" );
    add_name( "atlas", "Li" );
    add_name( "atlas", "Loane" );
    add_name( "atlas", "Long" );
    add_name( "atlas", "Luetscher" );
    add_name( "atlas", "Magro" );
    add_name( "atlas", "Marty" );
    add_name( "atlas", "Mathews" );
    add_name( "atlas", "McCool" );
    add_name( "atlas", "Menard" );
    add_name( "atlas", "Middleton" );
    add_name( "atlas", "Monroe" );
    add_name( "atlas", "Negrete" );
    add_name( "atlas", "Nigl" );
    add_name( "atlas", "Nuniyants" );
    add_name( "atlas", "Olson" );
    add_name( "atlas", "Osei" );
    add_name( "atlas", "Parent" );
    add_name( "atlas", "Parkinson" );
    add_name( "atlas", "Peeples" );
    add_name( "atlas", "Petrosky" );
    add_name( "atlas", "Raffel" );
    add_name( "atlas", "Renner" );
    add_name( "atlas", "Schlautman" );
    add_name( "atlas", "Seaman" );
    add_name( "atlas", "Sherman" );
    add_name( "atlas", "Sierra" );
    add_name( "atlas", "Singer" );
    add_name( "atlas", "Smith" );
    add_name( "atlas", "Stampfli" );
    add_name( "atlas", "Stevenson" );
    add_name( "atlas", "Superty" );
    add_name( "atlas", "Tafaro" );
    add_name( "atlas", "Thelen" );
    add_name( "atlas", "Tiran" );
    add_name( "atlas", "Tomplait" );
    add_name( "atlas", "Vondrak" );
    add_name( "atlas", "Weiss" );
    add_name( "atlas", "Widner" );
    add_name( "atlas", "Williams" );
    add_name( "atlas", "Zuk" );
    add_name( "sentinel", "Abbott" );
    add_name( "sentinel", "Andaya" );
    add_name( "sentinel", "Anderson" );
    add_name( "sentinel", "Arcovitch" );
    add_name( "sentinel", "Bailey" );
    add_name( "sentinel", "Beaver" );
    add_name( "sentinel", "Bell" );
    add_name( "sentinel", "Benhamou" );
    add_name( "sentinel", "Benko" );
    add_name( "sentinel", "Bianchi" );
    add_name( "sentinel", "Blackwell" );
    add_name( "sentinel", "Bolak" );
    add_name( "sentinel", "Bolton" );
    add_name( "sentinel", "Caisley" );
    add_name( "sentinel", "Centkowski" );
    add_name( "sentinel", "Cervantes" );
    add_name( "sentinel", "Charles" );
    add_name( "sentinel", "Chu" );
    add_name( "sentinel", "Clayton" );
    add_name( "sentinel", "Condrey" );
    add_name( "sentinel", "Dai" );
    add_name( "sentinel", "Daley" );
    add_name( "sentinel", "David" );
    add_name( "sentinel", "Debolt" );
    add_name( "sentinel", "DeMartini" );
    add_name( "sentinel", "Dolan" );
    add_name( "sentinel", "Doron" );
    add_name( "sentinel", "Drinkward" );
    add_name( "sentinel", "Feiss" );
    add_name( "sentinel", "Fong" );
    add_name( "sentinel", "Garza" );
    add_name( "sentinel", "Gebhart" );
    add_name( "sentinel", "Gil" );
    add_name( "sentinel", "Graham" );
    add_name( "sentinel", "Grasshoff" );
    add_name( "sentinel", "Gu" );
    add_name( "sentinel", "Halon" );
    add_name( "sentinel", "Henchey" );
    add_name( "sentinel", "Hipple" );
    add_name( "sentinel", "Hosticka" );
    add_name( "sentinel", "Jackson" );
    add_name( "sentinel", "Kart" );
    add_name( "sentinel", "Kato" );
    add_name( "sentinel", "Klein" );
    add_name( "sentinel", "Koehler" );
    add_name( "sentinel", "Lacey" );
    add_name( "sentinel", "Lai" );
    add_name( "sentinel", "Lane" );
    add_name( "sentinel", "Lao" );
    add_name( "sentinel", "Lee" );
    add_name( "sentinel", "Longland" );
    add_name( "sentinel", "Lothian" );
    add_name( "sentinel", "Ly" );
    add_name( "sentinel", "Mai" );
    add_name( "sentinel", "Marino" );
    add_name( "sentinel", "Martinez" );
    add_name( "sentinel", "McNeal" );
    add_name( "sentinel", "McSweeney" );
    add_name( "sentinel", "Mejia" );
    add_name( "sentinel", "Miller" );
    add_name( "sentinel", "Minor" );
    add_name( "sentinel", "Mohsini" );
    add_name( "sentinel", "Munson" );
    add_name( "sentinel", "Navidad" );
    add_name( "sentinel", "Och" );
    add_name( "sentinel", "Owens" );
    add_name( "sentinel", "Pavey" );
    add_name( "sentinel", "Pennya" );
    add_name( "sentinel", "Phan" );
    add_name( "sentinel", "Pitts" );
    add_name( "sentinel", "Reisdorf" );
    add_name( "sentinel", "Reyes" );
    add_name( "sentinel", "Reyna" );
    add_name( "sentinel", "Rodriguez" );
    add_name( "sentinel", "Romel" );
    add_name( "sentinel", "Ryu" );
    add_name( "sentinel", "Schmill" );
    add_name( "sentinel", "Seo" );
    add_name( "sentinel", "Shaughnessy" );
    add_name( "sentinel", "Shimomura" );
    add_name( "sentinel", "Sidey" );
    add_name( "sentinel", "Soto" );
    add_name( "sentinel", "Soucy" );
    add_name( "sentinel", "Steamer" );
    add_name( "sentinel", "Steele" );
    add_name( "sentinel", "Stone" );
    add_name( "sentinel", "Swenson" );
    add_name( "sentinel", "Syrnyk" );
    add_name( "sentinel", "Tardy" );
    add_name( "sentinel", "Thibodeaux" );
    add_name( "sentinel", "Turner" );
    add_name( "sentinel", "Vitalone" );
    add_name( "sentinel", "Waterman" );
    add_name( "sentinel", "Webb" );
    add_name( "sentinel", "Weise" );
    add_name( "sentinel", "White" );
    add_name( "sentinel", "Whitten" );
    add_name( "sentinel", "Winkelman" );
    add_name( "sentinel", "Wrede" );
    add_name( "sentinel", "Biglang-Awa" );
    add_name( "sentinel", "Callahan" );
    add_name( "sentinel", "Carbonero" );
    add_name( "sentinel", "Cole" );
    add_name( "sentinel", "Cravens" );
    add_name( "sentinel", "Diaz" );
    add_name( "sentinel", "Etienne" );
    add_name( "sentinel", "Froehlich" );
    add_name( "sentinel", "Haekkinen" );
    add_name( "sentinel", "Johnston" );
    add_name( "sentinel", "Kersey" );
    add_name( "sentinel", "Krolak" );
    add_name( "sentinel", "Kwak" );
    add_name( "sentinel", "Loperfido" );
    add_name( "sentinel", "Midlil" );
    add_name( "sentinel", "Mulkiewicz" );
    add_name( "sentinel", "Ott II" );
    add_name( "sentinel", "Power" );
    add_name( "sentinel", "Przybyla" );
    add_name( "sentinel", "Ruiz" );
    add_name( "sentinel", "Sheets" );
    add_name( "sentinel", "Staines" );
    add_name( "sentinel", "Stockholm" );
    add_name( "sentinel", "Tieger" );
    add_name( "sentinel", "Wilson Hart" );
    add_name( "sentinel", "Zaferakis" );
    add_name( "sentinel", "Barnes" );
    add_name( "sentinel", "Bibbo" );
    add_name( "sentinel", "Chung" );
    add_name( "sentinel", "Curry" );
    add_name( "sentinel", "Day" );
    add_name( "sentinel", "Delalla" );
    add_name( "sentinel", "Elenes" );
    add_name( "sentinel", "Espinoza" );
    add_name( "sentinel", "Esposito" );
    add_name( "sentinel", "Feldman" );
    add_name( "sentinel", "Gersant" );
    add_name( "sentinel", "Le-Roche" );
    add_name( "sentinel", "Marvin" );
    add_name( "sentinel", "Ow" );
    add_name( "sentinel", "Palser" );
    add_name( "sentinel", "Rodriguez" );
    add_name( "sentinel", "Son" );
    add_name( "sentinel", "Tawarotip" );
    add_name( "sentinel", "Valdivia" );
    add_name( "sentinel", "Wen" );
    add_name( "sentinel", "Williams" );
    add_name( "sentinel", "Achrekar" );
    add_name( "sentinel", "Bayless" );
    add_name( "sentinel", "Bernstein" );
    add_name( "sentinel", "Blondin" );
    add_name( "sentinel", "Bradford" );
    add_name( "sentinel", "Button" );
    add_name( "sentinel", "Bychowski" );
    add_name( "sentinel", "Christopher" );
    add_name( "sentinel", "Corona" );
    add_name( "sentinel", "Danz" );
    add_name( "sentinel", "Degenhardt" );
    add_name( "sentinel", "Donatelli" );
    add_name( "sentinel", "Edwards" );
    add_name( "sentinel", "Fetter" );
    add_name( "sentinel", "Foster" );
    add_name( "sentinel", "Giombi" );
    add_name( "sentinel", "Griebel" );
    add_name( "sentinel", "Gummelt" );
    add_name( "sentinel", "Hamilton" );
    add_name( "sentinel", "Hauptman" );
    add_name( "sentinel", "Hill" );
    add_name( "sentinel", "Holt" );
    add_name( "sentinel", "Jenkins" );
    add_name( "sentinel", "Kilborn" );
    add_name( "sentinel", "Koenig" );
    add_name( "sentinel", "Kraft" );
    add_name( "sentinel", "Kreeger" );
    add_name( "sentinel", "Lara" );
    add_name( "sentinel", "Linn" );
    add_name( "sentinel", "Lohman" );
    add_name( "sentinel", "Love" );
    add_name( "sentinel", "Lynch" );
    add_name( "sentinel", "Majernik" );
    add_name( "sentinel", "Matejka" );
    add_name( "sentinel", "McBain" );
    add_name( "sentinel", "McDaniel" );
    add_name( "sentinel", "Merboth" );
    add_name( "sentinel", "Morrow" );
    add_name( "sentinel", "Newquist" );
    add_name( "sentinel", "Noti" );
    add_name( "sentinel", "Olsen" );
    add_name( "sentinel", "Parker" );
    add_name( "sentinel", "Peekna" );
    add_name( "sentinel", "Petersen" );
    add_name( "sentinel", "Plesha" );
    add_name( "sentinel", "Reed" );
    add_name( "sentinel", "Sabin" );
    add_name( "sentinel", "Serio" );
    add_name( "sentinel", "Shockey" );
    add_name( "sentinel", "Sinclair" );
    add_name( "sentinel", "Skubal" );
    add_name( "sentinel", "Spray" );
    add_name( "sentinel", "Stephens" );
    add_name( "sentinel", "Swekel" );
    add_name( "sentinel", "Terry" );
    add_name( "sentinel", "Thurler" );
    add_name( "sentinel", "Uttech" );
    add_name( "sentinel", "Wagner" );
    add_name( "sentinel", "Wiegert" );
    add_name( "sentinel", "Zart" );
    add_name( "kva", "Soho" );
    add_name( "kva", "Soap" );
    add_name( "kva", "Motoko" );
    add_name( "squad", "Sarge" );
    add_name( "squad", "LT" );
    add_name( "squad", "McSweeney" );
    add_name( "northkorea", "Shima" );
    add_name( "northkorea", "Hikomori" );
    add_name( "northkorea", "Masamura" );
    copy_names( "pmc", "czech_surnames" );
    init_script_friendnames();

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        remove_script_friendnames_from_list( var_0[var_1] );
        randomize_name_list( var_0[var_1] );
        level.nameindex[var_0[var_1]] = 0;
    }
}

copy_names( var_0, var_1 )
{
    level.names[var_0] = level.names[var_1];
}

add_name( var_0, var_1 )
{
    level.names[var_0][level.names[var_0].size] = var_1;
}

remove_name( var_0, var_1 )
{
    level.names[var_0] = common_scripts\utility::array_remove( level.names[var_0], var_1 );
}

init_script_friendnames()
{
    var_0 = [];
    var_1 = _func_0D8();
    var_2 = _func_0D6();

    foreach ( var_4 in var_1 )
    {
        if ( isdefined( var_4.script_friendname ) && var_4.script_friendname != "none" )
        {
            var_5 = normalize_script_friendname( var_4.script_friendname );
            var_0[var_0.size] = var_5;
        }
    }

    foreach ( var_8 in var_2 )
    {
        if ( isdefined( var_8.script_friendname ) && var_8.script_friendname != "none" )
        {
            var_5 = normalize_script_friendname( var_8.script_friendname );
            var_0[var_0.size] = var_5;
        }
    }

    level.script_friendnames = var_0;
}

normalize_script_friendname( var_0 )
{
    var_1 = strtok( var_0, " " );

    if ( var_1.size > 1 )
        var_0 = var_1[1];

    return var_0;
}

remove_script_friendnames_from_list( var_0 )
{
    foreach ( var_2 in level.script_friendnames )
    {
        foreach ( var_4 in level.names[var_0] )
        {
            if ( var_2 == var_4 )
                remove_name( var_0, var_4 );
        }
    }
}

randomize_name_list( var_0 )
{
    var_1 = level.names[var_0].size;

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_3 = randomint( var_1 );
        var_4 = level.names[var_0][var_2];
        level.names[var_0][var_2] = level.names[var_0][var_3];
        level.names[var_0][var_3] = var_4;
    }
}

get_name( var_0 )
{
    if ( isdefined( self.team ) && self.team == "neutral" )
        return;

    if ( isdefined( self.script_friendname ) )
    {
        if ( self.script_friendname == "none" )
            return;

        self.name = self.script_friendname;
        getrankfromname( self.name );
        self notify( "set name and rank" );
        return;
    }

    get_name_for_nationality( self.voice );
    self notify( "set name and rank" );
}

get_name_for_nationality( var_0 )
{
    level.nameindex[var_0] = ( level.nameindex[var_0] + 1 ) % level.names[var_0].size;
    var_1 = level.names[var_0][level.nameindex[var_0]];
    var_2 = randomint( 10 );

    if ( nationalityusessurnames( var_0 ) )
    {
        var_3 = var_0 + "_surnames";
        level.nameindex[var_3] = ( level.nameindex[var_3] + 1 ) % level.names[var_3].size;
        var_1 = var_1 + " " + level.names[var_3][level.nameindex[var_3]];
    }

    if ( nationalityusescallsigns( var_0 ) )
    {
        var_4 = var_1;
        self.airank = "private";
    }
    else if ( var_0 == "secretservice" )
    {
        var_4 = "Agent " + var_1;
        self.airank = "private";
    }
    else if ( var_2 > 5 )
    {
        var_4 = "Pvt. " + var_1;
        self.airank = "private";
    }
    else if ( var_2 > 2 )
    {
        var_4 = "Cpl. " + var_1;
        self.airank = "private";
    }
    else
    {
        var_4 = "Sgt. " + var_1;
        self.airank = "sergeant";
    }

    if ( isai( self ) && self _meth_813D() )
        self.ainame = var_4;
    else
        self.name = var_4;
}

getrankfromname( var_0 )
{
    if ( !isdefined( var_0 ) )
        self.airank = "private";

    var_1 = strtok( var_0, " " );
    var_2 = var_1[0];

    switch ( var_2 )
    {
        case "Pvt.":
            self.airank = "private";
            break;
        case "Pfc.":
            self.airank = "private";
            break;
        case "Agent":
            self.airank = "private";
            break;
        case "Cpl.":
            self.airank = "corporal";
            break;
        case "Sgt.":
            self.airank = "sergeant";
            break;
        case "Lt.":
            self.airank = "lieutenant";
            break;
        case "Cpt.":
            self.airank = "captain";
            break;
        default:
            self.airank = "private";
            break;
    }
}

nationalityusescallsigns( var_0 )
{
    switch ( var_0 )
    {
        case "sentinel":
        case "atlas":
        case "czech":
        case "seal":
        case "taskforce":
        case "delta":
        case "xslice":
            return 1;
    }

    return 0;
}

nationalityusessurnames( var_0 )
{
    return isdefined( level.names[var_0 + "_surnames"] );
}
