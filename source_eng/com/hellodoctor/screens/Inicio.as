package com.hellodoctor.screens
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import com.hellodoctor.Constants;

	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;
	import com.greensock.easing.Linear;

	public class Inicio extends MovieClip
	{
		private var _controller:Object;
		private var _main:Object;

		public var cartel:MovieClip;
		public var nube0:MovieClip;
		public var nube1:MovieClip;
		public var nube2:MovieClip;
		public var nube3:MovieClip;
		public var nube4:MovieClip;
		public var ambulancia:MovieClip;
		private var parada:Boolean;
		
		public var cielo:MovieClip;
		public var luna:MovieClip;
		public var noche:MovieClip;
		
		private var dianoche:Boolean;
		
		public var my_timer:Timer;
		
		public var empezarBtn:MovieClip;
		
		private var botonclick:SoundChannel = new SoundChannel();

		public function Inicio()
		{
			// constructor code
			super();
			//trace("Inicio");
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, floatAnimation);
			addEventListener(MouseEvent.CLICK, onMouse);
		}

		public function init( screenData:Object ):void
		{
			_controller = screenData.controller;
			_main = screenData._mainroot;
			
			//_controller._nuevoAndrea = true;
			//_controller._nuevoDentista = true;
			//_controller._nuevoOculista = true;
			
			_controller.numAudio = 0;
			_controller.fondoFin = false;
			_controller.soundaudio(0);
			
			parada = false;
			dianoche = true;
			
			cielo.alpha = 0;
			luna.alpha = 0;
			noche.alpha = 0;

			TweenMax.to(this, 1, {alpha: 1});

			ambulancia.ruedas.stop();
			TweenMax.to(ambulancia, 6, {x: -250, delay:4, ease:Linear.easeNone, onComplete:ambulanciaAnim, onStart:onRuedas});
			//ambulancia.ruedas.play();
			//ambulancia.addEventListener(Event.ENTER_FRAME, onRuedas);
			my_timer = new Timer(7000);
			my_timer.addEventListener(TimerEvent.TIMER, onDiaNoche);
			my_timer.start();
		}
		
		private function onDiaNoche(e:TimerEvent):void
		{
			trace("onDiaNoche");
			if (dianoche)
			{
				TweenMax.to(cielo, 2, {alpha: 1});
				TweenMax.to(luna, 2, {alpha: 1});
				TweenMax.to(noche, 2, {alpha: 1});
			}
			else
			{
				TweenMax.to(cielo, 2, {alpha: 0});
				TweenMax.to(luna, 2, {alpha: 0});
				TweenMax.to(noche, 2, {alpha: 0});
			}
			dianoche = !dianoche;
		}
		
		private function onRuedas():void
		{
			trace("ruedas");
			ambulancia.ruedas.play();
		}
		
		private function ambulanciaAnim():void
		{
			ambulancia.ruedas.stop();
			if (parada)
			{
				TweenMax.to(ambulancia, 6, {x: -250, delay:4, ease:Linear.easeNone, onComplete:ambulanciaAnim, onStart:onRuedas});
				parada = false;
			}
			else
			{
				ambulancia.x = 1050;
				TweenMax.to(ambulancia, 2, {x: 733, delay:4, ease:Linear.easeNone, onComplete:ambulanciaAnim, onStart:onRuedas});
				parada = true;
			}
		}

		private function floatAnimation(event:Event):void
		{
			var currentDate:Date = new Date();
			cartel.y = 131 + (Math.cos(currentDate.getTime() * 0.003) * 6);

			nube0.x = nube0.x - 0.8;
			nube1.x = nube1.x - 1;
			nube2.x = nube2.x - 0.4;
			nube3.x = nube3.x - 0.2;
			nube4.x = nube4.x - 0.6;

			if (nube0.x < -330)
			{
				nube0.x = 1150;
			}
			if (nube1.x < 80)
			{
				nube1.x = 1350;
			}
			if (nube2.x < -300)
			{
				nube2.x = 1250;
			}
			if (nube3.x < -300)
			{
				nube3.x = 1250;
			}
			if (nube4.x < -300)
			{
				nube4.x = 1250;
			}
		}

		private function onMouse( e:MouseEvent ):void
		{
			botonclick = _main.effects.boton.play(0, 1);
			_controller.onTweenScreen(Constants.REQUEST_RECEPCION);
		}

		private function onAddedToStage( event:Event ):void
		{
			// GAME CODE
			//trace("onAddedToStage");
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onRemovedFromStage( event:Event ):void
		{
			//trace("onRemovedFromStage");
			TweenMax.killAll(false, true, true);
			my_timer.stop();
			my_timer.removeEventListener(TimerEvent.TIMER, onDiaNoche);
			
			removeEventListener(Event.ENTER_FRAME, floatAnimation);
			removeEventListener(Event.ADDED_TO_STAGE, onRemovedFromStage);
		}

	}

}