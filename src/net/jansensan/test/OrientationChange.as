package net.jansensan.test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;


	public class OrientationChange extends Sprite
	{
		private	const	WIDTH	:uint = 1024;
		private	const	HEIGHT	:uint = 600;
		
		
		[Embed(source="assets/images/arrow.png")]
		private	const	ArrowImageClass	:Class;
		
		private	var	_arrow	:Sprite;


		public function OrientationChange()
		{
			initStage();
			init();
		}


		private function initStage():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.setOrientation(StageOrientation.DEFAULT);
		}


		private function init():void
		{
			var image:Bitmap = new ArrowImageClass();
			image.x = -int(image.width * 0.5);
			image.y = -int(image.height * 0.5);
			
			_arrow = new Sprite();
			_arrow.addChild(image);
			_arrow.x = WIDTH * 0.5;
			_arrow.y = HEIGHT * 0.5;
			
			addChild(_arrow);
			
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, onOrientationChanging);
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, onOrientationChanged);
			stage.addEventListener(Event.RESIZE, onStageResized);
		}


		private function onStageResized(_:Event):void
		{
			trace("\n", this, "---  onStageResized  ---");
		}


		private function onOrientationChanging(_:StageOrientationEvent):void
		{
			trace("\n", this, "---  onOrientationChanging  ---");
			
			trace("\t", "_.beforeOrientation: " + (_.beforeOrientation));
			trace("\t", "_.afterOrientation: " + (_.afterOrientation));
			
			switch(_.afterOrientation)
			{
				case StageOrientation.ROTATED_LEFT:
					trace("rotated left");
					_arrow.rotation = 90;	// arrow image is rotated, points up
					break;
				
				case StageOrientation.ROTATED_RIGHT:
					trace("rotated right");
					_arrow.rotation = -90;	// arrow image is rotated, points up
					break;
				
				case StageOrientation.UPSIDE_DOWN:
					trace("upside down");
					_arrow.rotation = 180;	// arrow image is rotated, points up
					break;
				
				case StageOrientation.DEFAULT:
					trace("normal");
					_arrow.rotation = 0;	// arrow image is unaffected
					break;
			}
			
			_.preventDefault();
//			_.stopImmediatePropagation();
//			_.stopPropagation();
		}


		private function onOrientationChanged(_:StageOrientationEvent):void
		{
			trace("\n", this, "---  onOrientationChanged  ---");
			
			trace("\t", "_.beforeOrientation: " + (_.beforeOrientation));
			trace("\t", "_.afterOrientation: " + (_.afterOrientation));
		}
	}
}
