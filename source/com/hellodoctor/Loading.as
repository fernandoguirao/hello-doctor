package com.hellodoctor
{
	import flash.display.MovieClip;
	import flash.events.Event;

	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;

	public class Loading extends MovieClip
	{
		public var barra:MovieClip;

		public function Loading()
		{
			// constructor code
			//trace("Loading");
			alpha = 0;
			this.x = (stage.stageWidth - 1024) / 2;
			this.y = (stage.stageHeight - 768) / 2;
			TweenMax.to(this, 1, {alpha: 1});
			stage.addEventListener(Event.RESIZE, stageResized, false, int.MAX_VALUE, true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function stageResized(e:Event):void
		{
			//trace("stageResizedLoading");
			/*
			this.x = (stage.stageWidth - 1024) / 2;
			this.y = (stage.stageHeight - 768) / 2;
			*/
		}
		/*
		private function onAddedToStage( event:Event ):void
		{
			// GAME CODE
			//trace("onAddedToStage");
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			TweenMax.to(this, 1, {alpha: 1, delay: 1});

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		*/
		private function onRemovedFromStage( event:Event ):void
		{
			//trace("onRemovedFromStage");
			removeEventListener(Event.ADDED_TO_STAGE, onRemovedFromStage);
		}
	}

}