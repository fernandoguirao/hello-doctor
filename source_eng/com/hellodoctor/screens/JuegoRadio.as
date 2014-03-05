package com.hellodoctor.screens
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.hellodoctor.Constants;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;

	public class JuegoRadio extends MovieClip
	{
		private var _controller:Object;
		private var _main:Object;
		private var _sintoma:int;
		
		public var mc:MovieClip;
		public var res:MovieClip;

		public function JuegoRadio()
		{
			// constructor code
			super();
			trace("Ficha");
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//addEventListener(MouseEvent.CLICK, onMouse);
		}
		
		public function init( screenData:Object ):void
		{
			res.visible = false;
			
			_controller = screenData.controller;
			_main = screenData._mainroot;
			_sintoma = screenData.sintoma;
			
			_controller.numAudio = 2;
			_controller.fondoFin = false;
			_controller.soundaudio(2);
			
			TweenMax.to(this, 1, {alpha: 1});
			
			switch (_sintoma)
			{
				case 3 :
					//
					mc.tripa.visible = true;
					mc.piernas.visible = false;
					mc.tripa.manzana.mouseChildren = false;
					mc.tripa.polo.mouseChildren = false;
					mc.tripa.caramelo.mouseChildren = false;
					mc.tripa.chupa.mouseChildren = false;
					mc.tripa.manzana.addEventListener(MouseEvent.CLICK, onTripa);
					mc.tripa.polo.addEventListener(MouseEvent.CLICK, onTripa);
					mc.tripa.caramelo.addEventListener(MouseEvent.CLICK, onTripa);
					mc.tripa.chupa.addEventListener(MouseEvent.CLICK, onTripa);
					break;
					
				case 7 :
					//
					mc.tripa.visible = false;
					mc.piernas.visible = true;
					
					if (Math.random() < 0.5)
					{
						mc.piernas.pierna2.visible = false;
						
						mc.piernas.pierna1.mouseChildren = false;
						mc.piernas.pierna1.addEventListener(MouseEvent.CLICK, onPiernas);
					}
					else
					{
						mc.piernas.pierna1.visible = false;
						
						mc.piernas.pierna2.mouseChildren = false;
						mc.piernas.pierna2.addEventListener(MouseEvent.CLICK, onPiernas);
					}
					
					break;
					
				default :
					break;
			}
			
			TweenMax.to(mc, 10, {y: -1126, delay:1, ease:Linear.easeNone, onComplete:mueveUp});
		}
		
		private function mueveDown():void
		{
			TweenMax.to(mc, 16, {y: -1126, ease:Linear.easeNone, onComplete:mueveUp});
		}
		
		private function mueveUp():void
		{
			TweenMax.to(mc, 16, {y: 144, ease:Linear.easeNone, onComplete:mueveDown});
		}
		
		private function onTripa( e:MouseEvent ):void
		{
			var clip:MovieClip = MovieClip(e.target);
			
			switch (clip)
			{
				case ( mc.tripa.manzana ) :
					//
					mc.tripa.manzana.visible = false;
					mc.tripa.manzana.removeEventListener(MouseEvent.CLICK, onTripa);
					break;
					
				case ( mc.tripa.polo ) :
					//
					mc.tripa.polo.visible = false;
					mc.tripa.polo.removeEventListener(MouseEvent.CLICK, onTripa);
					break;
					
				case ( mc.tripa.caramelo ) :
					//
					mc.tripa.caramelo.visible = false;
					mc.tripa.caramelo.removeEventListener(MouseEvent.CLICK, onTripa);
					break;
					
				case ( mc.tripa.chupa ) :
					//
					mc.tripa.chupa.visible = false;
					mc.tripa.chupa.removeEventListener(MouseEvent.CLICK, onTripa);
					break;
					
				default :
					break;
			}
			if (!mc.tripa.manzana.visible && !mc.tripa.polo.visible && !mc.tripa.caramelo.visible && !mc.tripa.chupa.visible)
			{
				TweenMax.killAll(false, true, true);
				res.txt.gotoAndStop(1);
				res.visible = true;
				res.mouseChildren = false;
				res.addEventListener(MouseEvent.CLICK, onMouse);
				
				_main.mySo.data.tripa = true;
				_controller._juego = true;
				/*
				_controller.onTweenScreen(Constants.REQUEST_CONSULTA_ANDREA);
				*/
			}
		}
		
		private function onPiernas( e:MouseEvent ):void
		{
			var clip:MovieClip = MovieClip(e.target);
			var clickado:Boolean = false;
			
			switch (clip)
			{
				case ( mc.piernas.pierna1 ) :
					//
					clickado = true;
					mc.piernas.pierna1.removeEventListener(MouseEvent.CLICK, onPiernas);
					break;
					
				case ( mc.piernas.pierna2 ) :
					//
					clickado = true;
					mc.piernas.pierna2.removeEventListener(MouseEvent.CLICK, onPiernas);
					break;
					
				default :
					break;
			}
			if (clickado)
			{
				TweenMax.killAll(false, true, true);
				res.txt.gotoAndStop(1);
				res.visible = true;
				res.mouseChildren = false;
				res.addEventListener(MouseEvent.CLICK, onMouse);
				
				_main.mySo.data.caida = true;
				_controller._juego = true;
				/*
				_controller.onTweenScreen(Constants.REQUEST_CONSULTA_ANDREA);
				*/
			}
		}
		
		private function onMouse( e:MouseEvent ):void
		{
			_controller._juego = true;
			_controller.onTweenScreen(Constants.REQUEST_CONSULTA_ANDREA);
			res.visible = false;
			res.removeEventListener(MouseEvent.CLICK, onMouse);
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