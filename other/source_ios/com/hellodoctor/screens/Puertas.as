package com.hellodoctor.screens
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import com.hellodoctor.Constants;

	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;

	public class Puertas extends MovieClip
	{
		private var _controller:Object;
		private var _main:Object;
		private var _sintoma:int;
		
		public var puerta:MovieClip;
		public var cerrada:MovieClip;
		
		//public var _nom:String;
		//public var _titulo:String;
		
		private var snd:Sound = new Sound();
		private var channel:SoundChannel = new SoundChannel();

		public function Puertas()
		{
			// constructor code
			super();
			trace("Puertas");
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(MouseEvent.CLICK, onMouse);
			cerrada.addEventListener(MouseEvent.CLICK, onMouse);
		}

		public function init( screenData:Object ):void
		{
			puerta.visible = false;
			puerta.alpha = 0;
			
			_controller = screenData.controller;
			_main = screenData._mainroot;
			_sintoma = screenData.sintoma;
			//_nom = screenData.nom;
			//_titulo = screenData.titulo;
			
			trace(screenData.nom, " - ", screenData.titulo);
			
			cerrada.tit.text = String(screenData.titulo);
			cerrada.nombre.text = String(screenData.nom);
			
			puerta.tit.text = String(screenData.titulo);
			puerta.nombre.text = String(screenData.nom);

			TweenMax.to(this, 1, {alpha: 1});
		}

		private function onMouse( e:MouseEvent ):void
		{
			channel = _main.effects.puerta.play(0, 1);
			puerta.visible = true;
			TweenMax.to(puerta, .5, {alpha: 1});
			TweenMax.to(cerrada, .5, {alpha: 0, delay:.6, onComplete:goConsulta});
			removeEventListener(MouseEvent.CLICK, onMouse);
			cerrada.removeEventListener(MouseEvent.CLICK, onMouse);
		}
		
		private function goConsulta():void
		{
			switch ( _sintoma )
			{
				case 1 :
					_controller.onTweenScreen(Constants.REQUEST_CONSULTA_ANDREA);

					break;

				case 2 :
					_controller.onTweenScreen(Constants.REQUEST_CONSULTA_DENTISTA);

					break;

				case 3 :
					_controller.onTweenScreen(Constants.REQUEST_CONSULTA_ANDREA);

					break;

				case 4 :
					_controller.onTweenScreen(Constants.REQUEST_CONSULTA_OCULISTA);

					break;

				case 5 :
					_controller.onTweenScreen(Constants.REQUEST_CONSULTA_ANDREA);

					break;

				case 6 :
					_controller.onTweenScreen(Constants.REQUEST_CONSULTA_ANDREA);

					break;

				case 7 :
					_controller.onTweenScreen(Constants.REQUEST_CONSULTA_ANDREA);

					break;

				case 8 :
					_controller.onTweenScreen(Constants.REQUEST_CONSULTA_ANDREA);

					break;

				default :
					break;

			}
			
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