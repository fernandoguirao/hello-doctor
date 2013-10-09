package 
{
	import flash.events.ProgressEvent;
	import flash.text.TextField;

	import flash.system.Capabilities;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.ContextMenu;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	/*
	import flash.desktop.SystemIdleMode;
	import flash.desktop.NativeApplication;
	*/
	/*
	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	*/
	import com.greensock.TweenMax;

	import com.hellodoctor.Main;

	public class Start extends MovieClip
	{
		public var mySo:SharedObject;
		
		public var _idioma:String;

		private var application:String;
		private var gameuser:String;
		private var fecha:String;
		private var lugar:String;
		public var edad:String;
		private var estatura:String;
		private var peso:String;
		public var tutor:String;

		public var nuevo:Boolean;

		public var loaderMain:MovieClip;
		public var bgApp:MovieClip;
		
		public var main:Main;
		//create a text field to show the progress
		private var progress_txt:TextField  = new TextField ();

		private var xmlLoader:URLLoader;
		private var _xml:XML;
		public var _xmlToMain:XML;
		private var i:int;

		public var fondos:Array;
		public var sounds:Array;
		private var countSounds:int;
		public var effect:Array;
		private var countEffects:int;
		private var countFondos:int;
		public var audiosfondo:Object;
		public var audios:Object;
		public var effects:Object;
		public var snd:Sound;
		public var fondo:SoundChannel = new SoundChannel();
		public var fondo2:SoundChannel = new SoundChannel();
		public var fondo3:SoundChannel = new SoundChannel();
		private var req:URLRequest;
		
		public var globalUrl:String;

		public function Start():void
		{
			if (stage)
			{
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.EXACT_FIT;
			}

			var swfurl:String = LoaderInfo(this.root.loaderInfo).url;
			
			if (swfurl.indexOf("file:") > -1)
			{
				globalUrl = "../";
			}
			else
			{
				globalUrl = "";
			}
			
			bgApp.alpha = 0;

			audios = new Object();
			effects = new Object();
			countSounds = 0;
			sounds = new Array();
			effect = new Array();
			
			audiosfondo = new Object();
			countFondos = 0;
			fondos = new Array();
			//sounds = new Array(["padres","../audio/padres.mp3"],["effect","../audio/effect.mp3"]);

			//trace("TU IDIOMA -> " + IdiomaUsuario());
			_idioma = IdiomaUsuario();
			
			if (_idioma != "es")
			{
				_idioma = "en";
			}

			//stop the timeline, will play when fully loaded
			stop();

			application = "hellodoctor25";
			
			mySo = SharedObject.getLocal(application);
			//trace("tutor ShOb", mySo.data.tutor);
			//trace("gameuser ShOb", mySo.data.gameuser);
			//trace("_nuevoAndrea:", mySo.data.andrea);
			if (mySo.data.gameuser != undefined)
			{
				//
				//trace("repetidor");
				nuevo = false;
			}
			else
			{
				//
				//trace("nuevo");
				mySo.data.gameuser = "BabyLove";
				nuevo = true;
			}
			/*
			if (mySo.data.ciudad == undefined)
			{
				mySo.data.ciudad = "Ciudad";
			}
			
			if (mySo.data.dia == undefined)
			{
				mySo.data.dia = "00";
			}
			if (mySo.data.mes == undefined)
			{
				mySo.data.mes = "00";
			}
			if (mySo.data.ano == undefined)
			{
				mySo.data.ano = "0000";
			}
			*/
			if (mySo.data.edad != null)
			{
				edad = mySo.data.edad;
			}
			else
			{
				edad = "9"
			}
			if (mySo.data.tutor != null)
			{
				tutor = mySo.data.tutor;
			}
			else
			{
				tutor = "Mama";
			}
			
			if (mySo.data.marta == undefined)
			{
				mySo.data.marta = true;
			}
			if (mySo.data.andrea == undefined)
			{
				mySo.data.andrea = true;
			}
			if (mySo.data.dentista == undefined)
			{
				mySo.data.dentista = true;
			}
			if (mySo.data.oculista == undefined)
			{
				mySo.data.oculista = true;
			}
			
			if (mySo.data.fiebre == undefined)
			{
				mySo.data.fiebre = false;
			}
			if (mySo.data.diente == undefined)
			{
				mySo.data.diente = false;
			}
			if (mySo.data.tripa == undefined)
			{
				mySo.data.tripa = false;
			}
			if (mySo.data.ojosrojos == undefined)
			{
				mySo.data.ojosrojos = false;
			}
			if (mySo.data.vacunado == undefined)
			{
				mySo.data.vacunado = false;
			}
			if (mySo.data.vacuna == undefined)
			{
				mySo.data.vacuna = 1;
			}
			if (mySo.data.vacuna == 3)
			{
				mySo.data.vacunado = true;
			}
			if (mySo.data.tos == undefined)
			{
				mySo.data.tos = false;
			}
			if (mySo.data.caida == undefined)
			{
				mySo.data.caida = false;
			}
			/*
			mySo.data.diente = false;
			//mySo.data.dentista = false;
			mySo.data.ojosrojos = false;
			//mySo.data.oculista = false;
			mySo.data.tos = false;
			mySo.data.andrea = false;
			*/
			//mySo.data.tripa = false;
			//mySo.data.fiebre = false;
			//mySo.data.tos = false;
			//mySo.data.ojosrojos = false;
			//mySo.data.caida = false;
			//trace("mySo.data.tripa:", mySo.data.tripa);
			//trace("tutor", tutor);
			//position text field on the centre of the stage
			progress_txt.visible = false;
			progress_txt.x = stage.stageWidth / 2 - 60;
			progress_txt.y = 600;
			addChild(progress_txt);

			//add all the necessary listeners
			loaderInfo.addEventListener(ProgressEvent .PROGRESS, onProgress);
			loaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}

		private function IdiomaUsuario()
		{
			var idioma:String = flash.system.Capabilities.language.substr(0,2);
			//var newValue:Array = ["es","en","fr","it","pt","de","ru"];
			//return (Boolean(newValue[newValue.indexOf(result)]) ? result : "en" );
			idioma = idioma.toLowerCase();
			return idioma;
		}

		/*public function saveValue(gameuser:String, fecha:String, lugar:String, edad:String, estatura:String, peso:String, tutor:String, vacuna:int, andrea:Boolean, dentista:Boolean, oculista:Boolean):void
		{*/
		public function saveValue():void
		{
			//output.appendText("saving value...\n");
			/*
			mySo.data.gameuser = gameuser;
			mySo.data.fecha = fecha;
			mySo.data.lugar = lugar;
			mySo.data.edad = edad;
			mySo.data.estatura = estatura;
			mySo.data.peso = peso;
			mySo.data.tutor = tutor;
			mySo.data.vacuna = vacuna;
			mySo.data.andrea = andrea;
			mySo.data.dentista = dentista;
			mySo.data.oculista = oculista;
			*/
			//trace(vacuna);
			
			var flushStatus:String = null;
			try
			{
				flushStatus = mySo.flush(10000);
			}
			catch (error:Error)
			{
				//output.appendText("Error...Could not write SharedObject to disk\n");
			}
			if (flushStatus != null)
			{
				switch (flushStatus)
				{
					case SharedObjectFlushStatus.PENDING :
						//output.appendText("Requesting permission to save object...\n");
						mySo.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
						break;
					case SharedObjectFlushStatus.FLUSHED :
						//output.appendText("Value flushed to disk.\n");
						break;
				}
			}
			//output.appendText("\n");
			
		}

		public function clearValue():void
		{
			//output.appendText("Cleared saved value...Reload SWF and the value should be \"undefined\".\n\n");
			/*
			delete mySo.data.gameuser;
			delete mySo.data.fecha;
			delete mySo.data.lugar;
			delete mySo.data.edad;
			delete mySo.data.estatura;
			delete mySo.data.peso;
			delete mySo.data.tutor;
			*/
			mySo.data.gameuser = "BabyLove";
			edad = mySo.data.edad;
			tutor = mySo.data.tutor;
			mySo.data.marta = true;
			mySo.data.andrea = true;
			mySo.data.dentista = true;
			mySo.data.oculista = true;
			mySo.data.fiebre = false;
			mySo.data.diente = false;
			mySo.data.tripa = false;
			mySo.data.ojosrojos = false;
			mySo.data.vacunado = false;
			mySo.data.vacuna = 1;
			mySo.data.tos = false;
			mySo.data.caida = false;
		}
		
		public function estaTodo():Boolean
		{
			var et:Boolean = false;
			/*
			mySo.data.gameuser = "BabyLove";
			edad = mySo.data.edad;
			tutor = mySo.data.tutor;
			mySo.data.andrea = true;
			mySo.data.dentista = true;
			mySo.data.oculista = true;
			*/
			if (mySo.data.fiebre && mySo.data.diente && mySo.data.tripa && mySo.data.ojosrojos && mySo.data.vacunado && mySo.data.tos && mySo.data.caida)
			{
				et = true;
			}
			/*
			mySo.data.fiebre = false;
			mySo.data.diente = false;
			mySo.data.tripa = false;
			mySo.data.ojosrojos = false;
			mySo.data.vacunado = false;
			//mySo.data.vacuna = 1;
			mySo.data.tos = false;
			mySo.data.caida = false;
			*/
			return et;
		}

		private function onFlushStatus(event:NetStatusEvent):void
		{
			//output.appendText("User closed permission dialog...\n");
			switch (event.info.code)
			{
				case "SharedObject.Flush.Success" :
					//output.appendText("User granted permission -- value saved.\n");
					break;
				case "SharedObject.Flush.Failed" :
					//output.appendText("User denied permission -- value not saved.\n");
					break;
			}
			//output.appendText("\n");

			mySo.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
		}

		public function onProgress(e:ProgressEvent ):void
		{
			//update text field with the current progress
			progress_txt.text = "Loading: " + String (Math .floor((e.bytesLoaded/e.bytesTotal)*100)) + " %";
			loaderMain.txt.text = "CARGANDO ESCENARIOS";
			loaderMain.barra.scaleX = e.bytesLoaded/e.bytesTotal;
		}

		private function cargaXML():void
		{
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, loadXMLComplete);
			//xmlLoader.load(new URLRequest("https://clientes.marcstudio.es/natuchips/lista_amigos.php?rand=" + Math.random()));
			//xmlLoader.load(new URLRequest("https://clientes.marcstudio.es/natuchips/lista_amigos.xml"));
			//xmlLoader.load(new URLRequest(globalUrl + "xml/config_" + _idioma + ".xml"));
			xmlLoader.load(new URLRequest(globalUrl + "xml/config_es.xml"));
		}

		private function loadXMLComplete(e:Event):void
		{
			XML.ignoreWhitespace = true;
			_xml = new XML(e.target.data);
			_xmlToMain = new XML(_xml.escenas);
			////trace(_xml.audios.children().length());
			/*
			////trace(_xml.escenas.recepcion);
			////trace(_xml.escenas.recepcion.children()[i].name());
			objRecepcion = new Object();
			objRecepcion.ruta = _xml.escenas.recepcion.locucion. @ ruta;
			if (_xml.escenas.recepcion.pausas)
			{
			objRecepcion.pausas = _xml.escenas.recepcion.pausas;
			}
			else
			{
			objRecepcion.pausas = null;
			}
			if (_xml.escenas.recepcion.paradas)
			{
			objRecepcion.paradas = _xml.escenas.recepcion.paradas;
			}
			else
			{
			objRecepcion.paradas = null;
			}
			//trace(objRecepcion.paradas);
			*/
			for (i = 0; i < _xml.audios.children().length(); i++)
			{
				////trace(_xml.audios.children()[i].name());
				////trace(_xml.audios.children()[i].@ruta);
				//sounds = new Array(["padres","../audio/padres.mp3"],["effect","../audio/effect.mp3"]);

				sounds.push([_xml.audios.children()[i].name(),_xml.audios.children()[i].@ruta]);
				//trace(_xml.audios.children()[i].name(),_xml.audios.children()[i].@ruta);
			}
			
			for (i = 0; i < _xml.efectos.children().length(); i++)
			{
				////trace(_xml.audios.children()[i].name());
				////trace(_xml.audios.children()[i].@ruta);
				//sounds = new Array(["padres","../audio/padres.mp3"],["effect","../audio/effect.mp3"]);

				effect.push([_xml.efectos.children()[i].name(),_xml.efectos.children()[i].@ruta]);
				//trace(_xml.audios.children()[i].name(),_xml.audios.children()[i].@ruta);
			}
			
			for (i = 0; i < _xml.fondos.children().length(); i++)
			{
				////trace(_xml.fondos.children()[i].name());
				////trace(_xml.fondos.children()[i].@ruta);
				//sounds = new Array(["padres","../audio/padres.mp3"],["effect","../audio/effect.mp3"]);

				fondos.push([_xml.fondos.children()[i].name(),_xml.fondos.children()[i].@ruta]);
			}
			////trace(sounds);
			cargaFondos();
			//cargaAudios();
			xmlLoader.removeEventListener(Event.COMPLETE, loadXMLComplete);
		}

		private function cargaFondos():void
		{
			trace("cargar fondo:", fondos[countFondos][1]);
			loaderMain.txt.text = "CARGANDO MÚSICA";
			snd = new Sound();

			req = new URLRequest(globalUrl + fondos[countFondos][1]);
			snd.load(req);

			snd.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			snd.addEventListener(Event.COMPLETE, completeHandlerFondos);

			audiosfondo[fondos[countFondos][0]] = snd;
			////trace("countFondos:", countFondos);
			countFondos++;

		}
		
		private function completeHandlerFondos(event:Event):void
		{
			loaderMain.barra.scaleX = countFondos/fondos.length;
			////trace("countFondos:", countFondos);
			if (countFondos < fondos.length)
			{
				
				//snd.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				//snd.removeEventListener(Event.COMPLETE, completeHandlerFondos);
				cargaFondos();
				//countSounds++;

			}
			else
			{
				fondo = audiosfondo[fondos[0][0]].play(0, 9999);
				fondo2 = audiosfondo[fondos[1][0]].play(0, 9999);
				fondo3 = audiosfondo[fondos[2][0]].play(0, 9999);
				setVolume(0)
				//fondo2.stop();
				////trace("audiosfondo[fondos[0][0]]", audiosfondo[fondos[0][0]]);
				//cargaAudios();
				cargaEfectos();
				snd.removeEventListener(Event.COMPLETE, completeHandlerFondos);
			}

		}
		
		public function setVolume(vol:Number)
		{
			var transform:SoundTransform = fondo2.soundTransform;
			transform.volume = vol;
			fondo2.soundTransform = transform;
			
			transform = fondo3.soundTransform;
			transform.volume = vol;
			fondo3.soundTransform = transform;
			/*
			transform = fondo.soundTransform;
			transform.volume = vol;
			fondo.soundTransform = transform;
			*/
		}
		
		private function completeEffectHandler(event:Event):void
		{
			loaderMain.barra.scaleX = countFondos/effect.length;
			////trace("countFondos:", countFondos);
			if (countEffects < effect.length)
			{
				
				//snd.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				//snd.removeEventListener(Event.COMPLETE, completeHandlerFondos);
				cargaEfectos();
				//countSounds++;

			}
			else
			{
				
				cargaAudios();
				//cargaEfectos();
				snd.removeEventListener(Event.COMPLETE, completeEffectHandler);
			}

		}
		
		private function cargaEfectos():void
		{
			trace("cargar effects:", effect[countEffects][0], effect[countEffects][1]);
			loaderMain.txt.text = "CARGANDO EFECTOS";
			snd = new Sound();

			req = new URLRequest(globalUrl + effect[countEffects][1]);
			snd.load(req);

			//snd.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			snd.addEventListener(Event.COMPLETE, completeEffectHandler);

			effects[effect[countEffects][0]] = snd;
			//audios[sounds[countSounds][0]+"_eff"] = sounds[countSounds][2];
			countEffects++;

		}
		
		private function cargaAudios():void
		{
			////trace("cargar audio:", sounds[countSounds][1]);
			loaderMain.txt.text = "CARGANDO DIÁLOGOS";
			snd = new Sound();

			req = new URLRequest(globalUrl + sounds[countSounds][1]);
			snd.load(req);

			snd.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			snd.addEventListener(Event.COMPLETE, completeHandler);

			audios[sounds[countSounds][0]] = snd;
			//audios[sounds[countSounds][0]+"_eff"] = sounds[countSounds][2];
			countSounds++;

		}

		private function completeHandler(event:Event):void
		{
			loaderMain.barra.scaleX = countSounds/sounds.length;
			////trace("countSounds:", countSounds);
			if (countSounds < sounds.length)
			{
				snd.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				snd.removeEventListener(Event.COMPLETE, completeHandler);
				cargaAudios();
				//countSounds++;

			}
			else
			{
				// start main
				//trace("AUDIOS:", audios.marta, audios.marta_opts);
				loaderMain.txt.text = "";
				
				snd.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				snd.removeEventListener(Event.COMPLETE, completeHandler);
				////trace("audios:", audios);
				TweenMax.to(bgApp, 1, {alpha: 1, delay:3});
				TweenMax.to(loaderMain, 1, {alpha: 0, delay:3, onComplete: loadingComplete});

				nextFrame();

				main = new Main();
				addChild(main);
			}

		}

		private function errorHandler(errorEvent:IOErrorEvent):void
		{
			//
		}

		public function onComplete(e:Event ):void
		{
			//trace("Fully loaded, starting the movie.");
			//removing unnecessary listeners
			loaderInfo.removeEventListener(ProgressEvent .PROGRESS, onProgress);
			loaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			//go to the second frame. ;
			//You can also add nextFrame or just play() 
			//if you have more than one frame to show (full animation)
			stage.addEventListener(Event.RESIZE, stageResized, false, int.MAX_VALUE, true);
			stage.addEventListener(Event.ACTIVATE, stageActivate, false, 0, true);
			stage.addEventListener(Event.DEACTIVATE, stageDeactivate, false, 0, true);

			cargaXML();
			//cargaAudios();
			/*
			TweenMax.to(loaderMain, 1, {alpha: 0, onComplete: loadingComplete});
			
			nextFrame();
			
			main = new Main();
			addChild(main);
			*/
		}

		private function loadingComplete():void
		{
			main.init(this);
			removeChild(progress_txt);
			removeChild(loaderMain);
		}

		private function stageResized(e:Event):void
		{
			//bg.width = this.stage.stageWidth;
			//bg.height = this.stage.stageHeight;
			/*
			starling.stage.stageWidth = this.stage.stageWidth;
			starling.stage.stageHeight = this.stage.stageHeight;
			
			const viewPort:Rectangle = starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
			starling.viewPort = viewPort;
			}
			catch(error:Error) {
			//trace("error");
			}
			*/
			//starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
		}

		private function stageDeactivate(e:Event):void
		{
			//trace("stageDeactivate");
			//saveValue("Paula","29-9-2010","VLC","9","70","8","Mama");
			var flushStatus:String = null;
			try
			{
				flushStatus = mySo.flush(10000);
			}
			catch (error:Error)
			{
				//output.appendText("Error...Could not write SharedObject to disk\n");
			}
			if (flushStatus != null)
			{
				switch (flushStatus)
				{
					case SharedObjectFlushStatus.PENDING :
						//output.appendText("Requesting permission to save object...\n");
						mySo.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
						break;
					case SharedObjectFlushStatus.FLUSHED :
						//output.appendText("Value flushed to disk.\n");
						break;
				}
			}
			//output.appendText("\n");
			//starling.stop();
			stage.addEventListener(Event.ACTIVATE, stageActivate, false, 0, true);
			stage.removeEventListener(Event.ACTIVATE, stageDeactivate);
		}

		private function stageActivate(e:Event):void
		{
			//trace("stageActivate");
			stage.addEventListener(Event.DEACTIVATE, stageDeactivate, false, 0, true);
			stage.removeEventListener(Event.ACTIVATE, stageActivate);
			//starling.start();
		}

		private function exitApp( event:Event=null ):void
		{
			//trace("exitApp");
			//starling.stop();
			/*
			_app.removeEventListener( Event.DEACTIVATE, exitApp );
			_app.exit();
			*/
		}
	}
}