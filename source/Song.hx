package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var events:Array<Dynamic>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var gfVersion:String;
	var stage:String;
	var healthdrainKill:Bool;

	var arrowSkin:String;
	var splashSkin:String;
	var validScore:Bool;
	var characterTrails:Bool;
	var bfTrails:Bool;
	var cameraMoveOnNotes:Bool;
	var healthdrain:Float;
	var songInstVolume:Float;
	var disableAntiMash:Bool;
	var disableDebugButtons:Bool;
	var swapStrumLines:Bool;
}

class Song
{
	public static var lastLoadFailed:Bool = false;
	public static var lastLoadError:String = '';
	public var song:String;
	public var notes:Array<SwagSection>;
	public var events:Array<Dynamic>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var cameraMoveOnNotes:Bool = false;
	public var arrowSkin:String;
	public var splashSkin:String;
	public var speed:Float = 1;
	public var healthdrain:Float = 0;
	public var stage:String;
	public var healthdrainKill:Bool = false;
	public var characterTrails:Bool = false;
	public var bfTrails:Bool = false;
	public var disableAntiMash:Bool = false;
	public var disableDebugButtons:Bool = false;
	public var swapStrumLines:Bool = false;

	public var player1:String = 'bf';
	public var player2:String = 'dad';
	public var gfVersion:String = 'gf';
	public var songInstVolume:Float = 1;

	private static function onLoadJson(songJson:Dynamic) // Convert old charts to newest format
	{
		if(songJson.gfVersion == null)
		{
			songJson.gfVersion = songJson.player3;
			songJson.player3 = null;
		}

		if(songJson.events == null)
		{
			songJson.events = [];
			for (secNum in 0...songJson.notes.length)
			{
				var sec:SwagSection = songJson.notes[secNum];

				var i:Int = 0;
				var notes:Array<Dynamic> = sec.sectionNotes;
				var len:Int = notes.length;
				while(i < len)
				{
					var note:Array<Dynamic> = notes[i];
					if(note[1] < 0)
					{
						songJson.events.push([note[0], [[note[2], note[3], note[4]]]]);
						notes.remove(note);
						len = notes.length;
					}
					else i++;
				}
			}
		}
	}

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
	{
		lastLoadFailed = false;
		lastLoadError = '';

		var formattedSong:String = Paths.formatToSongPath(jsonInput == null ? '' : jsonInput);
		var formattedFolder:String = (folder == null || folder.trim().length == 0) ? formattedSong : Paths.formatToSongPath(folder);

		try
		{
			var rawJson:String = null;

			#if MODS_ALLOWED
			var moddyFile:String = Paths.modsJson(formattedFolder + '/' + formattedSong);
			if(FileSystem.exists(moddyFile))
			{
				rawJson = File.getContent(moddyFile).trim();
			}
			#end

			if(rawJson == null)
			{
				#if sys
				var songPath:String = Paths.json(formattedFolder + '/' + formattedSong);
				if(FileSystem.exists(songPath))
				{
					rawJson = File.getContent(songPath).trim();
				}
				else if(folder == null || folder.trim().length == 0)
				{
					var directPath:String = Paths.json(formattedSong);
					if(FileSystem.exists(directPath))
						rawJson = File.getContent(directPath).trim();
				}
				#else
				var assetPath:String = Paths.json(formattedFolder + '/' + formattedSong);
				if(Assets.exists(assetPath))
				{
					rawJson = Assets.getText(assetPath).trim();
				}
				else if(folder == null || folder.trim().length == 0)
				{
					var directAssetPath:String = Paths.json(formattedSong);
					if(Assets.exists(directAssetPath))
						rawJson = Assets.getText(directAssetPath).trim();
				}
				#end
			}

			if(rawJson == null || rawJson.length == 0)
				throw 'Missing song data for ' + formattedFolder + '/' + formattedSong;

			var songJson:Dynamic = parseJSONshit(rawJson);
			if(jsonInput != 'events')
				StageData.loadDirectory(songJson);
			onLoadJson(songJson);
			return songJson;
		}
		catch(e:Dynamic)
		{
			lastLoadFailed = true;
			lastLoadError = Std.string(e);
			StageData.forceNextDirectory = null;
			trace('Song load failed for ' + formattedFolder + '/' + formattedSong + ': ' + lastLoadError);
			return createFallbackSong(formattedFolder.length > 0 ? formattedFolder : formattedSong, lastLoadError);
		}
	}

	public static function createFallbackSong(songName:String, reason:String):SwagSong
	{
		return {
			song: songName,
			notes: [],
			events: [],
			bpm: 100,
			needsVoices: false,
			speed: 1,
			player1: 'bf',
			player2: 'dad',
			gfVersion: 'gf',
			stage: 'stage',
			healthdrainKill: false,
			arrowSkin: null,
			splashSkin: null,
			validScore: false,
			characterTrails: false,
			bfTrails: false,
			cameraMoveOnNotes: false,
			healthdrain: 0,
			songInstVolume: 0,
			disableAntiMash: false,
			disableDebugButtons: false,
			swapStrumLines: false
		};
	}
	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		swagShit.validScore = true;
		return swagShit;
	}
}
