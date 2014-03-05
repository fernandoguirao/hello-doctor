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

	public class Sintomas extends MovieClip
	{
		private var _controller:Object;
		private var _main:Object;

		private var _buttons:Array;
		private var i:int;

		public var btn0:MovieClip;
		public var btn1:MovieClip;
		public var btn2:MovieClip;
		public var btn3:MovieClip;
		public var btn4:MovieClip;
		public var btn5:MovieClip;
		public var btn6:MovieClip;
		
		public var txts:MovieClip;

		public var enfermedades:Array;
		
		private var botonclick:SoundChannel = new SoundChannel();

		public function Sintomas()
		{
			// constructor code
			super();
			//trace("Sintomas");
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//addEventListener(MouseEvent.CLICK, onMouse);
		}

		public function init( screenData:Object ):void
		{
			_controller = screenData.controller;
			_main = screenData._mainroot;

			_buttons = new Array(btn0,btn1,btn2,btn3,btn4,btn5,btn6);
			enfermedades = new Array(_main.mySo.data.fiebre,_main.mySo.data.diente,_main.mySo.data.tripa,_main.mySo.data.ojosrojos,_main.mySo.data.vacunado,_main.mySo.data.tos,_main.mySo.data.caida);

			for (i = 0; i < _buttons.length; i++)
			{
				var btn:MovieClip = _buttons[i];
				var curado:Boolean = enfermedades[i];
				btn.sintoma = i + 1;
				if (!curado)
				{
					btn.mc.alpha = 0;
					btn.hecho.visible = false;
					//btn.buttonMode = true;
					btn.mouseChildren = false;
					btn.addEventListener(MouseEvent.CLICK, onMouse);
					btn.addEventListener(MouseEvent.MOUSE_OVER, onMouse);
					btn.addEventListener(MouseEvent.MOUSE_OUT, onMouse);
				}
				else
				{
					btn.hecho.alpha = 0.7;
					btn.mc.visible = false;
				}
			}
			
			btn3.mc.alpha = 0;
			//btn.hecho.visible = false;
			//btn.buttonMode = true;
			btn3.mouseChildren = false;
			btn3.addEventListener(MouseEvent.CLICK, onMouse);
			btn3.addEventListener(MouseEvent.MOUSE_OVER, onMouse);
			btn3.addEventListener(MouseEvent.MOUSE_OUT, onMouse);

			TweenMax.to(this, 1, {alpha: 1});
		}

		private function onMouse( e:MouseEvent ):void
		{
			botonclick = _main.effects.boton.play(0, 1);
			var _btn:MovieClip = MovieClip(e.target);
			
			switch (e.type)
			{
				case "mouseOver" :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					break;
					
				case "mouseOut" :
					TweenMax.to(_btn.mc, .5, {alpha: 0});
					break;
					
				case "click" :
					_controller._sintoma = _btn.sintoma;
					if (_controller._sintoma == 4)
					{
						_controller._juego = false;
						_controller._juegoOculista = true;
					}
					_controller.onTweenScreen(Constants.REQUEST_RECEPCION);
					break;
					
				default :
					break;
			}
			
			
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
			removeEventListener(Event.ADDED_TO_STAGE, onRemovedFromStage);
		}

	}

}