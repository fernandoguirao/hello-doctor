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

	public class Ficha extends MovieClip
	{
		private var _controller:Object;
		private var _main:Object;
		/*
		public var mama:MovieClip;
		public var papa:MovieClip;
		public var edad0:MovieClip;
		public var edad1:MovieClip;
		public var edad2:MovieClip;
		public var talla0:MovieClip;
		public var talla1:MovieClip;
		public var talla2:MovieClip;
		public var peso0:MovieClip;
		public var peso1:MovieClip;
		public var peso2:MovieClip;
		*/
		private var padres:Array;
		private var edades:Array;
		private var tallas:Array;
		private var pesos:Array;
		
		private var i:int;
		public var btn:MovieClip;
		public var buttonsFicha:MovieClip;
		
		private var fichaok:Boolean;
		
		public var txts:MovieClip;
		
		private var botonclick:SoundChannel = new SoundChannel();

		public function Ficha()
		{
			// constructor code
			super();
			trace("Ficha");
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, onControlFicha);
			//addEventListener(MouseEvent.CLICK, onMouse);
		}
		
		public function init( screenData:Object ):void
		{
			fichaok = false;
			
			_controller = screenData.controller;
			_main = screenData._mainroot;
			/*
			nombre.text = _main.mySo.data.gameuser;
			if (nombre.text == "Nombre")
			{
				nombre.alpha = .5;
			}
			ciudad.text = _main.mySo.data.ciudad;
			if (ciudad.text == "Ciudad")
			{
				ciudad.alpha = .5;
			}
			dia.text = _main.mySo.data.dia;
			mes.text = _main.mySo.data.mes;
			ano.text = _main.mySo.data.ano;
			if (dia.text == "00")
			{
				dia.alpha = .5;
			}
			if (mes.text == "00")
			{
				mes.alpha = .5;
			}
			if (ano.text == "0000")
			{
				ano.alpha = .5;
			}
			*/
			padres = new Array("mama", "papa");
			edades = new Array("edad0", "edad1", "edad2");
			tallas = new Array("talla0", "talla1", "talla2");
			pesos = new Array("peso0", "peso1", "peso2");
			
			for (i = 0; i < padres.length; i++)
			{
				btn = buttonsFicha[padres[i]];
				//btn.name = padres[i];
				//btn.buttonMode = true;
				btn.mouseChildren = false;
				btn.mc.alpha = 0;
				btn.addEventListener(MouseEvent.CLICK, onPadres);
			}
			
			for (i = 0; i < edades.length; i++)
			{
				btn = buttonsFicha[edades[i]];
				//btn.name = edades[i];
				//btn.buttonMode = true;
				btn.mouseChildren = false;
				btn.mc.alpha = 0;
				btn.addEventListener(MouseEvent.CLICK, onEdades);
			}
			
			for (i = 0; i < tallas.length; i++)
			{
				btn = buttonsFicha[tallas[i]];
				//btn.name = tallas[i];
				//btn.buttonMode = true;
				btn.mouseChildren = false;
				btn.mc.alpha = 0;
				btn.addEventListener(MouseEvent.CLICK, onTallas);
			}
			
			for (i = 0; i < pesos.length; i++)
			{
				btn = buttonsFicha[pesos[i]];
				//btn.name = pesos[i];
				//btn.buttonMode = true;
				btn.mouseChildren = false;
				btn.mc.alpha = 0;
				btn.addEventListener(MouseEvent.CLICK, onPesos);
			}
			
			TweenMax.to(this, 1, {alpha: 1});
		}
		
		private function onPadres( e:MouseEvent ):void
		{
			botonclick = _main.effects.boton.play(0, 1);
			var _btn:MovieClip = MovieClip(e.target);
			//trace(e.target);
			switch (_btn)
			{
				case ( buttonsFicha.mama ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.papa.mc, .5, {alpha: 0});
					_main.mySo.data.tutor = "mama";
					//trace("mama");
					break;
					
				case ( buttonsFicha.papa ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.mama.mc, .5, {alpha: 0});
					_main.mySo.data.tutor = "papa";
					//trace("papa");
					break;
					
				default :
					break;
			}
		}
		
		private function onEdades( e:MouseEvent ):void
		{
			botonclick = _main.effects.boton.play(0, 1);
			var _btn:MovieClip = MovieClip(e.target);
			//trace(e.target);
			switch (_btn)
			{
				case ( buttonsFicha.edad0 ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.edad1.mc, .5, {alpha: 0});
					TweenMax.to(buttonsFicha.edad2.mc, .5, {alpha: 0});
					_main.mySo.data.edad = "9";
					//trace("mama");
					break;
					
				case ( buttonsFicha.edad1 ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.edad0.mc, .5, {alpha: 0});
					TweenMax.to(buttonsFicha.edad2.mc, .5, {alpha: 0});
					_main.mySo.data.edad = "12";
					//trace("papa");
					break;
					
				case ( buttonsFicha.edad2 ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.edad0.mc, .5, {alpha: 0});
					TweenMax.to(buttonsFicha.edad1.mc, .5, {alpha: 0});
					_main.mySo.data.edad = "16";
					//trace("papa");
					break;
					
				default :
					break;
			}
		}
		
		private function onTallas( e:MouseEvent ):void
		{
			botonclick = _main.effects.boton.play(0, 1);
			var _btn:MovieClip = MovieClip(e.target);
			//trace(e.target);
			switch (_btn)
			{
				case ( buttonsFicha.talla0 ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.talla1.mc, .5, {alpha: 0});
					TweenMax.to(buttonsFicha.talla2.mc, .5, {alpha: 0});
					_main.mySo.data.talla = "70";
					//trace("mama");
					break;
					
				case ( buttonsFicha.talla1 ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.talla0.mc, .5, {alpha: 0});
					TweenMax.to(buttonsFicha.talla2.mc, .5, {alpha: 0});
					_main.mySo.data.talla = "72";
					//trace("papa");
					break;
					
				case ( buttonsFicha.talla2 ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.talla0.mc, .5, {alpha: 0});
					TweenMax.to(buttonsFicha.talla1.mc, .5, {alpha: 0});
					_main.mySo.data.talla = "82";
					//trace("papa");
					break;
					
				default :
					break;
			}
		}
		
		private function onPesos( e:MouseEvent ):void
		{
			botonclick = _main.effects.boton.play(0, 1);
			var _btn:MovieClip = MovieClip(e.target);
			//trace(e.target);
			switch (_btn)
			{
				case ( buttonsFicha.peso0 ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.peso1.mc, .5, {alpha: 0});
					TweenMax.to(buttonsFicha.peso2.mc, .5, {alpha: 0});
					_main.mySo.data.peso = "8";
					//trace("mama");
					break;
					
				case ( buttonsFicha.peso1 ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.peso0.mc, .5, {alpha: 0});
					TweenMax.to(buttonsFicha.peso2.mc, .5, {alpha: 0});
					_main.mySo.data.peso = "10";
					//trace("papa");
					break;
					
				case ( buttonsFicha.peso2 ) :
					TweenMax.to(_btn.mc, .5, {alpha: .7});
					TweenMax.to(buttonsFicha.peso0.mc, .5, {alpha: 0});
					TweenMax.to(buttonsFicha.peso1.mc, .5, {alpha: 0});
					_main.mySo.data.peso = "12";
					//trace("papa");
					break;
					
				default :
					break;
			}
		}
		
		private function onControlFicha( e:Event ):void
		{
			//_main.saveValue("Paula","29-9-2010","VLC","9","70","8","Mama",1, true, true, true);
			
			/*
			if (nombre.text != "Nombre" && ciudad.text != "Ciudad" && dia.text != "00" && mes.text != "00" && ano.text != "0000")
			{
				_main.mySo.data.gameuser = nombre.text;
				_main.mySo.data.ciudad = ciudad.text;
				_main.mySo.data.dia = dia.text;
				_main.mySo.data.mes = mes.text;
				_main.mySo.data.ano = ano.text;
				if (_main.mySo.data.peso != undefined && _main.mySo.data.talla != undefined && _main.mySo.data.edad != undefined && _main.mySo.data.tutor != undefined)
				{
					fichaok = true;
				}
				
			}
			*/
			if (_main.mySo.data.peso != undefined && _main.mySo.data.talla != undefined && _main.mySo.data.edad != undefined && _main.mySo.data.tutor != undefined)
			{
				fichaok = true;
			}
			
			if (fichaok)
			{
				_main.nuevo = false;
				_controller._nuevo = false;
				_controller._tutor = _main.mySo.data.tutor;
				_main.saveValue();
				_controller.onTweenScreen(Constants.REQUEST_RECEPCION);
				removeEventListener(Event.ENTER_FRAME, onControlFicha);
			}
			
		}
		
		private function onMouse( e:MouseEvent ):void
		{
			/*
			//_controller.saveValue("Paula","29-9-2010","VLC","9","70","8","Mama",1, true, true, true);
			var fichaok:Boolean = false;
			
			if (nombre.text != "Nombre" && ciudad.text != "Ciudad" && dia.text != "00" && mes.text != "00" && ano.text != "0000")
			{
				_main.mySo.data.gameuser = nombre.text;
				_main.mySo.data.ciudad = ciudad.text;
				_main.mySo.data.dia = dia.text;
				_main.mySo.data.mes = mes.text;
				_main.mySo.data.ano = ano.text;
				if (_main.mySo.data.peso != undefined && _main.mySo.data.talla != undefined && _main.mySo.data.edad != undefined && _main.mySo.data.tutor != undefined)
				{
					fichaok = true;
				}
				
			}
			
			if (fichaok)
			{
				_controller.onTweenScreen(Constants.REQUEST_RECEPCION);
			}
			*/
			
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