package options;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxInputText;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using StringTools;

class HUDTextSettingsSubState extends MusicBeatSubstate
{
	var labels:Array<String> = ['Perfect judgement', 'Sick judgement', 'Good judgement', 'Bad judgement', 'Shit judgement', 'Score label', 'Combo Breaks label', 'Average label', 'Accuracy label'];
	var fields:Array<FlxInputText> = [];
	var curSelected:Int = 0;
	var preview:FlxText;

	public function new()
	{
		super();
		#if desktop
		Discord.DiscordClient.changePresence('HUD Text Settings', null);
		#end

		var bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFea71fd;
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		var title = new FlxText(0, 24, FlxG.width, 'HUD & Judgement Text', 36);
		title.setFormat(Paths.font('vcr.ttf'), 36, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(title);

		var values = [ClientPrefs.judgementPerfect, ClientPrefs.judgementSick, ClientPrefs.judgementGood, ClientPrefs.judgementBad, ClientPrefs.judgementShit, ClientPrefs.scoreLabel, ClientPrefs.comboBreaksLabel, ClientPrefs.averageLabel, ClientPrefs.accuracyLabel];
		for(i in 0...labels.length)
		{
			var y:Float = 92 + i * 52;
			var label = new FlxText(150, y + 5, 350, labels[i], 22);
			label.setFormat(Paths.font('vcr.ttf'), 22, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			add(label);

			var input = new FlxInputText(530, y, 430, values[i], 22, FlxColor.BLACK, FlxColor.WHITE);
			input.maxLength = 24;
			input.fieldBorderThickness = 2;
			input.ID = i;
			fields.push(input);
			add(input);
		}

		preview = new FlxText(40, 590, FlxG.width - 80, '', 20);
		preview.setFormat(Paths.font('vcr.ttf'), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(preview);

		var help = new FlxText(40, 660, FlxG.width - 80, 'UP/DOWN or wheel: select | ENTER: edit/finish | R: reset | ESC: back', 18);
		help.setFormat(Paths.font('vcr.ttf'), 18, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(help);

		refreshSelection();
		refreshPreview();
	}

	override function update(elapsed:Float)
	{
		for(i in 0...fields.length) if(fields[i].hasFocus) curSelected = i;
		var editing:Bool = fields[curSelected].hasFocus;

		if(editing)
		{
			if(FlxG.keys.justPressed.ENTER)
			{
				fields[curSelected].hasFocus = false;
				applyValues();
			}
		}
		else
		{
			var wheel:Int = MenuInput.wheelChange();
			if(controls.UI_UP_P || wheel < 0) { curSelected--; refreshSelection(); }
			if(controls.UI_DOWN_P || wheel > 0) { curSelected++; refreshSelection(); }
			if(controls.ACCEPT) fields[curSelected].hasFocus = true;
			if(controls.RESET) resetDefaults();
			if(controls.BACK)
			{
				applyValues();
				ClientPrefs.saveSettings();
				FlxG.sound.play(Paths.sound('cancelMenu'));
				close();
			}
		}

		refreshPreview();
		super.update(elapsed);
	}

	function refreshSelection():Void
	{
		if(curSelected < 0) curSelected = fields.length - 1;
		if(curSelected >= fields.length) curSelected = 0;
		for(i in 0...fields.length) fields[i].fieldBorderColor = (i == curSelected) ? FlxColor.YELLOW : FlxColor.BLACK;
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	}

	function clean(value:String, fallback:String):String
	{
		var out = value == null ? '' : value.trim();
		return out.length > 0 ? out : fallback;
	}

	function applyValues():Void
	{
		ClientPrefs.judgementPerfect = clean(fields[0].text, 'Perfect');
		ClientPrefs.judgementSick = clean(fields[1].text, 'Sick');
		ClientPrefs.judgementGood = clean(fields[2].text, 'Good');
		ClientPrefs.judgementBad = clean(fields[3].text, 'Bad');
		ClientPrefs.judgementShit = clean(fields[4].text, 'Shit');
		ClientPrefs.scoreLabel = clean(fields[5].text, 'Score');
		ClientPrefs.comboBreaksLabel = clean(fields[6].text, 'Combo Breaks');
		ClientPrefs.averageLabel = clean(fields[7].text, 'Average');
		ClientPrefs.accuracyLabel = clean(fields[8].text, 'Accuracy');
	}

	function resetDefaults():Void
	{
		var defaults = ['Perfect', 'Sick', 'Good', 'Bad', 'Shit', 'Score', 'Combo Breaks', 'Average', 'Accuracy'];
		for(i in 0...fields.length) fields[i].text = defaults[i];
		applyValues();
		FlxG.sound.play(Paths.sound('cancelMenu'));
	}

	function refreshPreview():Void
	{
		applyValues();
		preview.text = ClientPrefs.scoreLabel + ': 12345 | ' + ClientPrefs.comboBreaksLabel + ': 2 | ' + ClientPrefs.averageLabel + ': 12ms | ' + ClientPrefs.accuracyLabel + ': 98.76%\nJudgements: ' + ClientPrefs.judgementPerfect + ' / ' + ClientPrefs.judgementSick + ' / ' + ClientPrefs.judgementGood + ' / ' + ClientPrefs.judgementBad + ' / ' + ClientPrefs.judgementShit;
	}
}
