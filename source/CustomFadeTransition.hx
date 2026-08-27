package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	public static var nextCamera:FlxCamera;
	private var tween:FlxTween;
	private var overlay:FlxSprite;
	private var isTransIn:Bool;
	private var completed:Bool = false;

	public function new(duration:Float, isTransIn:Bool) {
		super();
		this.isTransIn = isTransIn;
		overlay = new FlxSprite(-8, -8).makeGraphic(FlxG.width + 16, FlxG.height + 16, FlxColor.BLACK);
		overlay.scrollFactor.set();
		overlay.alpha = isTransIn ? 1 : 0;
		if(nextCamera != null) overlay.cameras = [nextCamera];
		add(overlay);
		nextCamera = null;

		if(isTransIn) {
			tween = FlxTween.tween(overlay, {alpha: 0}, duration, {ease: FlxEase.quadOut, onComplete: function(_) { completed = true; close(); }});
		} else {
			tween = FlxTween.tween(overlay, {alpha: 1}, duration, {ease: FlxEase.quadInOut, onComplete: function(_) {
				completed = true;
				if(finishCallback != null) { var callback = finishCallback; finishCallback = null; callback(); }
			}});
		}
	}

	override function destroy() {
		if(tween != null) { tween.cancel(); tween.destroy(); tween = null; }
		if(!isTransIn && !completed && finishCallback != null) { var callback = finishCallback; finishCallback = null; callback(); }
		super.destroy();
	}
}
