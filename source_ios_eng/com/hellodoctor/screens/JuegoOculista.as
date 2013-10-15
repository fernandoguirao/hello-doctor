package com.hellodoctor.screens
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.hellodoctor.Constants;

	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;

	public class JuegoOculista extends MovieClip
	{
		private var _objAll:Object;
		private var _controller:Object;
		private var _main:Object;
		
		private var manoPos:Array;
		private var secuencia:Array;
		private var secuenciaJuego:Array;
		private var resultadoJuego:Array;
		private var resuelto:Boolean;
		
		public var res:MovieClip;
		
		private var count:int;
		private var countErrors:int;
		
		private var i:int;
		
		public var mano:MovieClip;

		public var explicacion:MovieClip;

		public function JuegoOculista()
		{
			// constructor code
			super();
			trace("Ficha");
			alpha = 0;

			manoPos = new Array([78,227],[378,227],[693,227],[78,430],[380,430],[690,430]);
			secuencia = new Array(0,1,2,3,4,5);
			
			explicacion.alpha = 0;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//addEventListener(MouseEvent.CLICK, onMouse);
		}

		public function init( screenData:Object ):void
		{
			_objAll = screenData;
			
			secuenciaJuego = new Array();
			secuenciaJuego = shuffleArray(secuencia);
			//secuenciaJuego.pop();
			//secuenciaJuego.pop();
			
			count = 0;
			
			res.visible = false;
			
			for (i = 0; i < secuencia.length; i++)
			{
				this["c" + i].alpha = 0;
				this["b" + i].alpha = 0;
				this["b" + i]._id = i;
			}
			
			_controller = screenData.controller;
			_main = screenData._mainroot;
			
			_controller.numAudio = 2;
			_controller.fondoFin = false;
			_controller.soundaudio(2);

			TweenMax.to(this, 1, {alpha: 1});
			
			mueveMano();
		}
		
		private function shuffleArray(arr:Array):Array
		{
			var len:int = arr.length;
			var temp:*;
			var i:int = len;

			while (i--)
			{
				var rand:int = Math.floor(Math.random() * len);
				temp = arr[i];
				arr[i] = arr[rand];
				arr[rand] = temp;
			}
			return arr;
		}
		
		private function mueveMano():void
		{
			// manoPos[secuenciaJuego[count]][0]
			TweenMax.to(mano, 2, {x: manoPos[secuenciaJuego[count]][0], y: manoPos[secuenciaJuego[count]][1], delay:1, onComplete:moveComplete});
		}
		
		private function moveComplete():void
		{
			this["c" + secuenciaJuego[count]].alpha = 1;
			
			TweenMax.to(this["c" + secuenciaJuego[count]], 1, {alpha: 0, delay:1});
			if (count < secuenciaJuego.length - 3)
			{
				count++;
				mueveMano();
			}
			else
			{
				TweenMax.to(mano, 2, {x: 0, y: 800, delay:1, onComplete:moveEndComplete});
				count = 0;
			}
		}
		
		private function moveEndComplete():void
		{
			explicacion.alpha = 1;
			resultadoJuego = new Array();
			//trace("A jugar!!!");
			for (i = 0; i < secuencia.length; i++)
			{
				this["b" + i].mouseChildren = false;
				this["b" + i].addEventListener(MouseEvent.CLICK, onJuego);
			}
		}
		
		private function onJuego( e:MouseEvent ):void
		{
			var clip:MovieClip = MovieClip(e.target);
			
			trace("clip._id", clip._id, " - secuenciaJuego[count]", secuenciaJuego[count]);
			/*
			// UNO A UNO
			if (clip._id == secuenciaJuego[count])
			{
				clip.alpha = 1;
				TweenMax.to(clip, 1, {alpha: 0, delay:1});
				
				if (count < secuenciaJuego.length - 1)
				{
					trace("otro");
					resultadoJuego.push(clip._id);
					count++;
				}
				else
				{
					trace("Fin juego!!!");
					comparaResultado();
				}
			}
			*/
			
			// TODOS A LA VEZ
			clip.alpha = 1;
			TweenMax.to(clip, 1, {alpha: 0, delay:1});
			
			if (count < secuenciaJuego.length - 3)
			{
				trace("otro");
				resultadoJuego.push(clip._id);
				count++;
			}
			else
			{
				resultadoJuego.push(clip._id);
				trace("Fin juego!!!", secuenciaJuego, " - ", resultadoJuego);
				comparaResultado();
			}
		}
		
		private function comparaResultado():void
		{
			resuelto = true;
			countErrors = 0;
			
			for (i = 0; i < secuencia.length - 2; i++)
			{
				if (secuenciaJuego[i] != resultadoJuego[i])
				{
					//resuelto = false;
					countErrors++;
				}
			}
			if (countErrors > 2)
			{
				resuelto = false;
			}
			trace("resuelto: ", resuelto);
			if (resuelto)
			{
				res.txt.gotoAndStop(1);
			}
			else
			{
				res.txt.gotoAndStop(2);
			}
			res.visible = true;
			res.mouseChildren = false;
			res.addEventListener(MouseEvent.CLICK, onMouse);
		}

		private function onMouse( e:MouseEvent ):void
		{
			if (resuelto)
			{
				_controller._juego = true;
				_controller._juegoOculista = true;
				_main.mySo.data.ojosrojos = true;
				
			}
			else
			{
				_controller._juego = false;
				_controller._juegoOculista = false;
				_main.mySo.data.ojosrojos = false;
				//init(_objAll);
			}
			_controller.onTweenScreen(Constants.REQUEST_CONSULTA_OCULISTA);
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