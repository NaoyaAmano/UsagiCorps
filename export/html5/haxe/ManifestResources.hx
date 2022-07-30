package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy22:assets%2Fdata%2F01.tmxy4:sizei9641y4:typey4:TEXTy2:idR1y7:preloadtgoR0y22:assets%2Fdata%2F02.tmxR2i15445R3R4R5R7R6tgoR0y22:assets%2Fdata%2F03.tmxR2i18972R3R4R5R8R6tgoR0y22:assets%2Fdata%2F04.tmxR2i18990R3R4R5R9R6tgoR0y22:assets%2Fdata%2F08.tmxR2i51337R3R4R5R10R6tgoR0y31:assets%2Fdata%2Fbackgrounds.tsxR2i325R3R4R5R11R6tgoR0y35:assets%2Fdata%2Fbackgroundtiles.tsxR2i253R3R4R5R12R6tgoR0y26:assets%2Fdata%2Fbutton.pngR2i136R3y5:IMAGER5R13R6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R15R6tgoR0y25:assets%2Fdata%2Fdeath.pngR2i143R3R14R5R16R6tgoR0y25:assets%2Fdata%2Fdebug.tmxR2i1466R3R4R5R17R6tgoR0y32:assets%2Fdata%2Fdebugtileset.tsxR2i244R3R4R5R18R6tgoR0y24:assets%2Fdata%2Fdoor.pngR2i161R3R14R5R19R6tgoR0y31:assets%2Fdata%2FdoorTrigger.pngR2i160R3R14R5R20R6tgoR0y35:assets%2Fdata%2Fforegroundtiles.tsxR2i253R3R4R5R21R6tgoR0y39:assets%2Fdata%2FhaxeJamTilesetDebug.tsxR2i251R3R4R5R22R6tgoR0y25:assets%2Fdata%2Flaser.pngR2i148R3R14R5R23R6tgoR0y32:assets%2Fdata%2Fplaceholders.tsxR2i897R3R4R5R24R6tgoR0y33:assets%2Fdata%2Fp_placeholder.pngR2i157R3R14R5R25R6tgoR0y24:assets%2Fdata%2Ftest.tmxR2i10343R3R4R5R26R6tgoR0y26:assets%2Fdata%2Fturret.pngR2i615R3R14R5R27R6tgoR0y26:assets%2Fimages%2Fbase.pngR2i860R3R14R5R28R6tgoR0y30:assets%2Fimages%2Fbbnuyhud.aseR2i1922R3y6:BINARYR5R29R6tgoR0y28:assets%2Fimages%2Fbullet.pngR2i222R3R14R5R31R6tgoR0y29:assets%2Fimages%2Fbuttons.pngR2i938R3R14R5R32R6tgoR0y27:assets%2Fimages%2Fcover.pngR2i239727R3R14R5R33R6tgoR0y32:assets%2Fimages%2Fdead-sheet.pngR2i2165R3R14R5R34R6tgoR0y26:assets%2Fimages%2Fdead.aseR2i2819R3R30R5R35R6tgoR0y27:assets%2Fimages%2Fdoors.pngR2i3800R3R14R5R36R6tgoR0y29:assets%2Fimages%2Fexplode.pngR2i2764R3R14R5R37R6tgoR0y33:assets%2Fimages%2Fexplodedoor.aseR2i1174R3R30R5R38R6tgoR0y33:assets%2Fimages%2Fexplodedoor.pngR2i499R3R14R5R39R6tgoR0y31:assets%2Fimages%2Fexplosion.pngR2i2764R3R14R5R40R6tgoR0y37:assets%2Fimages%2Fforegroundtiles.pngR2i8163R3R14R5R41R6tgoR0y27:assets%2Fimages%2Fgates.pngR2i2482R3R14R5R42R6tgoR0y32:assets%2Fimages%2FhudBunnies.pngR2i909R3R14R5R43R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R44R6tgoR0y27:assets%2Fimages%2Flaser.pngR2i438R3R14R5R45R6tgoR0y31:assets%2Fimages%2FlaserBase.pngR2i1639R3R14R5R46R6tgoR0y34:assets%2Fimages%2FleftClearing.pngR2i2764R3R14R5R47R6tgoR0y36:assets%2Fimages%2FmenuBackground.pngR2i93598R3R14R5R48R6tgoR0y37:assets%2Fimages%2Fmenu_background.pngR2i15433R3R14R5R49R6tgoR0y31:assets%2Fimages%2Fmenu_door.pngR2i4176R3R14R5R50R6tgoR0y28:assets%2Fimages%2Fmuzzle.pngR2i946R3R14R5R51R6tgoR0y29:assets%2Fimages%2Freactor.pngR2i1936R3R14R5R52R6tgoR0y35:assets%2Fimages%2FrightClearing.pngR2i2729R3R14R5R53R6tgoR0y28:assets%2Fimages%2Fskybox.pngR2i25293R3R14R5R54R6tgoR0y29:assets%2Fimages%2Fspawner.pngR2i1511R3R14R5R55R6tgoR0y28:assets%2Fimages%2Fturret.pngR2i879R3R14R5R56R6tgoR0y32:assets%2Fimages%2FturretBase.pngR2i1030R3R14R5R57R6tgoR0y33:assets%2Fimages%2Fusagi-sheet.pngR2i8087R3R14R5R58R6tgoR0y27:assets%2Fimages%2Fusagi.aseR2i12399R3R30R5R59R6tgoR0y26:assets%2Fmusic%2Fboors.pngR2i55873R3R14R5R60R6tgoR0y28:assets%2Fmusic%2Fbuttons.pngR2i26456R3R14R5R61R6tgoR2i655528R3y5:SOUNDR5y26:assets%2Fmusic%2Fclimb.wavy9:pathGroupaR63hR6tgoR2i1225178R3R62R5y30:assets%2Fmusic%2Fexplosion.wavR64aR65hR6tgoR2i649616R3R62R5y24:assets%2Fmusic%2Ffly.wavR64aR66hR6tgoR2i1624488R3R62R5y29:assets%2Fmusic%2Fjet_dead.wavR64aR67hR6tgoR2i350768R3R62R5y25:assets%2Fmusic%2Fjump.wavR64aR68hR6tgoR2i652852R3R62R5y25:assets%2Fmusic%2Fland.wavR64aR69hR6tgoR2i6891172R3y5:MUSICR5y26:assets%2Fmusic%2Flevel.mp3R64aR71hR6tgoR2i473122R3R62R5y26:assets%2Fmusic%2Fmenu1.wavR64aR72hR6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R73R6tgoR2i445516R3R62R5y25:assets%2Fmusic%2Fopen.wavR64aR74hR6tgoR2i3153572R3R70R5y26:assets%2Fmusic%2Ftheme.mp3R64aR75hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R76R6tgoR0y42:assets%2Ftiled%2Fbackgroundtiles-sheet.pngR2i6130R3R14R5R77R6tgoR0y36:assets%2Ftiled%2Fbackgroundtiles.pngR2i6150R3R14R5R78R6tgoR0y33:assets%2Ftiled%2Fdebugtileset.pngR2i1036R3R14R5R79R6tgoR0y36:assets%2Ftiled%2Fforegroundtiles.pngR2i8192R3R14R5R80R6tgoR2i2114R3R70R5y26:flixel%2Fsounds%2Fbeep.mp3R64aR81y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R70R5y28:flixel%2Fsounds%2Fflixel.mp3R64aR83y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R62R5R82R64aR81R82hgoR2i33629R3R62R5R84R64aR83R84hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R85R86y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R14R5R91R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R14R5R92R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_01_tmx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_02_tmx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_03_tmx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_04_tmx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_08_tmx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_backgrounds_tsx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_backgroundtiles_tsx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_death_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_debug_tmx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_debugtileset_tsx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_door_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_doortrigger_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_foregroundtiles_tsx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_haxejamtilesetdebug_tsx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_laser_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_placeholders_tsx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_p_placeholder_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_test_tmx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_turret_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_base_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bbnuyhud_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_buttons_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cover_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dead_sheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dead_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_doors_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explode_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explodedoor_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explodedoor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explosion_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_foregroundtiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_gates_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_hudbunnies_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_laser_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_laserbase_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_leftclearing_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubackground_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_door_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_muzzle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_reactor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rightclearing_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_skybox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spawner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_turret_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_turretbase_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_usagi_sheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_usagi_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_boors_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_buttons_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_climb_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_explosion_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_fly_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_jet_dead_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_jump_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_land_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_level_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_menu1_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_open_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_theme_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_tiled_backgroundtiles_sheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_tiled_backgroundtiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_tiled_debugtileset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_tiled_foregroundtiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/01.tmx") @:noCompletion #if display private #end class __ASSET__assets_data_01_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/02.tmx") @:noCompletion #if display private #end class __ASSET__assets_data_02_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/03.tmx") @:noCompletion #if display private #end class __ASSET__assets_data_03_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/04.tmx") @:noCompletion #if display private #end class __ASSET__assets_data_04_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/08.tmx") @:noCompletion #if display private #end class __ASSET__assets_data_08_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/backgrounds.tsx") @:noCompletion #if display private #end class __ASSET__assets_data_backgrounds_tsx extends haxe.io.Bytes {}
@:keep @:file("assets/data/backgroundtiles.tsx") @:noCompletion #if display private #end class __ASSET__assets_data_backgroundtiles_tsx extends haxe.io.Bytes {}
@:keep @:image("assets/data/button.png") @:noCompletion #if display private #end class __ASSET__assets_data_button_png extends lime.graphics.Image {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/data/death.png") @:noCompletion #if display private #end class __ASSET__assets_data_death_png extends lime.graphics.Image {}
@:keep @:file("assets/data/debug.tmx") @:noCompletion #if display private #end class __ASSET__assets_data_debug_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/debugtileset.tsx") @:noCompletion #if display private #end class __ASSET__assets_data_debugtileset_tsx extends haxe.io.Bytes {}
@:keep @:image("assets/data/door.png") @:noCompletion #if display private #end class __ASSET__assets_data_door_png extends lime.graphics.Image {}
@:keep @:image("assets/data/doorTrigger.png") @:noCompletion #if display private #end class __ASSET__assets_data_doortrigger_png extends lime.graphics.Image {}
@:keep @:file("assets/data/foregroundtiles.tsx") @:noCompletion #if display private #end class __ASSET__assets_data_foregroundtiles_tsx extends haxe.io.Bytes {}
@:keep @:file("assets/data/haxeJamTilesetDebug.tsx") @:noCompletion #if display private #end class __ASSET__assets_data_haxejamtilesetdebug_tsx extends haxe.io.Bytes {}
@:keep @:image("assets/data/laser.png") @:noCompletion #if display private #end class __ASSET__assets_data_laser_png extends lime.graphics.Image {}
@:keep @:file("assets/data/placeholders.tsx") @:noCompletion #if display private #end class __ASSET__assets_data_placeholders_tsx extends haxe.io.Bytes {}
@:keep @:image("assets/data/p_placeholder.png") @:noCompletion #if display private #end class __ASSET__assets_data_p_placeholder_png extends lime.graphics.Image {}
@:keep @:file("assets/data/test.tmx") @:noCompletion #if display private #end class __ASSET__assets_data_test_tmx extends haxe.io.Bytes {}
@:keep @:image("assets/data/turret.png") @:noCompletion #if display private #end class __ASSET__assets_data_turret_png extends lime.graphics.Image {}
@:keep @:image("assets/images/base.png") @:noCompletion #if display private #end class __ASSET__assets_images_base_png extends lime.graphics.Image {}
@:keep @:file("assets/images/bbnuyhud.ase") @:noCompletion #if display private #end class __ASSET__assets_images_bbnuyhud_ase extends haxe.io.Bytes {}
@:keep @:image("assets/images/bullet.png") @:noCompletion #if display private #end class __ASSET__assets_images_bullet_png extends lime.graphics.Image {}
@:keep @:image("assets/images/buttons.png") @:noCompletion #if display private #end class __ASSET__assets_images_buttons_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cover.png") @:noCompletion #if display private #end class __ASSET__assets_images_cover_png extends lime.graphics.Image {}
@:keep @:image("assets/images/dead-sheet.png") @:noCompletion #if display private #end class __ASSET__assets_images_dead_sheet_png extends lime.graphics.Image {}
@:keep @:file("assets/images/dead.ase") @:noCompletion #if display private #end class __ASSET__assets_images_dead_ase extends haxe.io.Bytes {}
@:keep @:image("assets/images/doors.png") @:noCompletion #if display private #end class __ASSET__assets_images_doors_png extends lime.graphics.Image {}
@:keep @:image("assets/images/explode.png") @:noCompletion #if display private #end class __ASSET__assets_images_explode_png extends lime.graphics.Image {}
@:keep @:file("assets/images/explodedoor.ase") @:noCompletion #if display private #end class __ASSET__assets_images_explodedoor_ase extends haxe.io.Bytes {}
@:keep @:image("assets/images/explodedoor.png") @:noCompletion #if display private #end class __ASSET__assets_images_explodedoor_png extends lime.graphics.Image {}
@:keep @:image("assets/images/explosion.png") @:noCompletion #if display private #end class __ASSET__assets_images_explosion_png extends lime.graphics.Image {}
@:keep @:image("assets/images/foregroundtiles.png") @:noCompletion #if display private #end class __ASSET__assets_images_foregroundtiles_png extends lime.graphics.Image {}
@:keep @:image("assets/images/gates.png") @:noCompletion #if display private #end class __ASSET__assets_images_gates_png extends lime.graphics.Image {}
@:keep @:image("assets/images/hudBunnies.png") @:noCompletion #if display private #end class __ASSET__assets_images_hudbunnies_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/laser.png") @:noCompletion #if display private #end class __ASSET__assets_images_laser_png extends lime.graphics.Image {}
@:keep @:image("assets/images/laserBase.png") @:noCompletion #if display private #end class __ASSET__assets_images_laserbase_png extends lime.graphics.Image {}
@:keep @:image("assets/images/leftClearing.png") @:noCompletion #if display private #end class __ASSET__assets_images_leftclearing_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menuBackground.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubackground_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu_background.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_background_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu_door.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_door_png extends lime.graphics.Image {}
@:keep @:image("assets/images/muzzle.png") @:noCompletion #if display private #end class __ASSET__assets_images_muzzle_png extends lime.graphics.Image {}
@:keep @:image("assets/images/reactor.png") @:noCompletion #if display private #end class __ASSET__assets_images_reactor_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rightClearing.png") @:noCompletion #if display private #end class __ASSET__assets_images_rightclearing_png extends lime.graphics.Image {}
@:keep @:image("assets/images/skybox.png") @:noCompletion #if display private #end class __ASSET__assets_images_skybox_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spawner.png") @:noCompletion #if display private #end class __ASSET__assets_images_spawner_png extends lime.graphics.Image {}
@:keep @:image("assets/images/turret.png") @:noCompletion #if display private #end class __ASSET__assets_images_turret_png extends lime.graphics.Image {}
@:keep @:image("assets/images/turretBase.png") @:noCompletion #if display private #end class __ASSET__assets_images_turretbase_png extends lime.graphics.Image {}
@:keep @:image("assets/images/usagi-sheet.png") @:noCompletion #if display private #end class __ASSET__assets_images_usagi_sheet_png extends lime.graphics.Image {}
@:keep @:file("assets/images/usagi.ase") @:noCompletion #if display private #end class __ASSET__assets_images_usagi_ase extends haxe.io.Bytes {}
@:keep @:image("assets/music/boors.png") @:noCompletion #if display private #end class __ASSET__assets_music_boors_png extends lime.graphics.Image {}
@:keep @:image("assets/music/buttons.png") @:noCompletion #if display private #end class __ASSET__assets_music_buttons_png extends lime.graphics.Image {}
@:keep @:file("assets/music/climb.wav") @:noCompletion #if display private #end class __ASSET__assets_music_climb_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/explosion.wav") @:noCompletion #if display private #end class __ASSET__assets_music_explosion_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/fly.wav") @:noCompletion #if display private #end class __ASSET__assets_music_fly_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/jet_dead.wav") @:noCompletion #if display private #end class __ASSET__assets_music_jet_dead_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/jump.wav") @:noCompletion #if display private #end class __ASSET__assets_music_jump_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/land.wav") @:noCompletion #if display private #end class __ASSET__assets_music_land_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/level.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_level_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/menu1.wav") @:noCompletion #if display private #end class __ASSET__assets_music_menu1_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/music/open.wav") @:noCompletion #if display private #end class __ASSET__assets_music_open_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/theme.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_theme_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/tiled/backgroundtiles-sheet.png") @:noCompletion #if display private #end class __ASSET__assets_tiled_backgroundtiles_sheet_png extends lime.graphics.Image {}
@:keep @:image("assets/tiled/backgroundtiles.png") @:noCompletion #if display private #end class __ASSET__assets_tiled_backgroundtiles_png extends lime.graphics.Image {}
@:keep @:image("assets/tiled/debugtileset.png") @:noCompletion #if display private #end class __ASSET__assets_tiled_debugtileset_png extends lime.graphics.Image {}
@:keep @:image("assets/tiled/foregroundtiles.png") @:noCompletion #if display private #end class __ASSET__assets_tiled_foregroundtiles_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeRepo/flixel/4,8,1/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeRepo/flixel/4,8,1/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeRepo/flixel/4,8,1/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeRepo/flixel/4,8,1/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeRepo/flixel/4,8,1/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeRepo/flixel/4,8,1/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
