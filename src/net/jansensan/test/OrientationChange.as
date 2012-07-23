package net.jansensan.test
{
	import qnx.fuse.ui.buttons.ToggleSwitch;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;


	// set framerate to 60, BB10 SDK Beta 2 sets it to 24 by default
	[SWF(backgroundColor="#ffffff", frameRate="60")]
	public class OrientationChange extends Sprite
	{
		[Embed(source="assets/images/vignette.png")]
		private	const	VignetteAsset	:Class;
		
		[Embed(source="assets/images/arrow.png")]
		private	const	ArrowAsset	:Class;
		
		private	var	_padding				:uint;
		
		private	var	_vignette				:Bitmap;
		private	var	_arrow					:Sprite;
		private	var	_toggle					:ToggleSwitch;
		
		private	var	_width					:int;
		private	var	_height					:int;
		
		private	var	_canChangeOrientation	:Boolean = true;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function OrientationChange()
		{
			super();
			init();
		}


		private function init():void
		{
			initStage();
			setDimensions();
			setPadding();
			addVignette();
			addArrow();
			addToggle();
			updateLayout();
			addStageListeners();
		}


		private function initStage():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.setOrientation(StageOrientation.DEFAULT);
		}


		private function setPadding():void
		{
			_padding = Math.min(_width, _height) * 0.05;
		}


		private function setDimensions():void
		{
			_width = stage.stageWidth;
			_height = stage.stageHeight;
		}


		private function addVignette():void
		{
			_vignette = new VignetteAsset();
			_vignette.smoothing = true;
			_vignette.alpha = 0.25;
			addChild(_vignette);
		}


		private function addArrow():void
		{
			var image:Bitmap = new ArrowAsset();
			image.x = -int(image.width * 0.5);
			image.y = -int(image.height * 0.5);

			_arrow = new Sprite();
			_arrow.addChild(image);

			addChild(_arrow);
		}


		private function addToggle():void
		{
			_toggle = new ToggleSwitch();
			_toggle.selected = _canChangeOrientation;
			_toggle.addEventListener(Event.SELECT, onToggleSelected);
			
			addChild(_toggle);
		}


		private function addStageListeners():void
		{
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, onOrientationChanging);
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, onOrientationChanged);
			stage.addEventListener(Event.RESIZE, onStageResized);
		}


		private function updateLayout():void
		{
			_vignette.width = _width;
			_vignette.height = _height;
			
			_arrow.x = int(_width * 0.5);
			_arrow.y = int(_height * 0.5);
			
			_toggle.x = int(_width - _padding - _toggle.width);
			_toggle.y = int(_height - _padding - _toggle.height);
		}


		// + ----------------------------------------
		//		[ EVENT HANDLERS ]
		// + ----------------------------------------

		private function onStageResized(_:Event):void
		{
			setDimensions();
			updateLayout();
		}


		private function onOrientationChanging(_:StageOrientationEvent):void
		{
			if(!_canChangeOrientation)
			{
				_.preventDefault();
				_.stopImmediatePropagation();
				_.stopPropagation();
			}
		}


		private function onOrientationChanged(_:StageOrientationEvent):void
		{
//			trace("\n", this, "---  onOrientationChanged  ---");
//			
//			trace("\t", "_.beforeOrientation: " + (_.beforeOrientation));
//			trace("\t", "_.afterOrientation: " + (_.afterOrientation));
		}


		private function onToggleSelected(_:Event):void
		{
			_canChangeOrientation = _toggle.selected;
		}
	}
}
