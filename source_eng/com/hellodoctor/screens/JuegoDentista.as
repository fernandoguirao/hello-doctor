package com.hellodoctor.screens
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.hellodoctor.Constants;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;

	public class JuegoDentista extends MovieClip
	{
		private var _controller:Object;

		public function JuegoDentista()
		{
			// constructor code
			super();
			trace("Ficha");
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(MouseEvent.CLICK, onMouse);
		}
		
		public function init( screenData:Object ):void
		{
			_controller = screenData.controller;
			
			TweenMax.to(this, 1, {alpha: 1});
		}
		
		private function onMouse( e:MouseEvent ):void
		{
			_controller._sintoma = 0;
			_controller.onTweenScreen(Constants.REQUEST_RECEPCION);
		}
		
		private function onAddedToStage( event:Event ):void
		{
			// GAME CODE
			trace("onAddedToStage");
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onRemovedFromStage( event:Event ):void
		{
			trace("onRemovedFromStage");
			removeEventListener(Event.ADDED_TO_STAGE, onRemovedFromStage);
		}

	}

}