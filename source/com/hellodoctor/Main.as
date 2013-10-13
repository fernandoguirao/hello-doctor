package com.hellodoctor
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	import com.hellodoctor.Constants;
	import com.hellodoctor.screens.*;

	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;
	import flash.events.MouseEvent;

	public class Main extends MovieClip
	{
		public var _pausaTodo:Boolean;
		private var _main:Object;

		private var _idioma:String;

		private var _screenActive:MovieClip;
		private var _screenRequest:String;
		private var _screenData:Object;

		private var _audios:Object;
		public var numAudio:int;
		public var fondoFin:Boolean;

		public var _loadingClip:MovieClip;
		public var _menuApp:MovieClip;
		public var _sections:MovieClip;

		private var _xml:XML;
		private var i:int;
		public var objEffects:Object;
		
		public var _primeraAndrea:Boolean;
		public var _primeraDentista:Boolean;
		public var _primeraOculista:Boolean;
		
		public var _juego:Boolean;

		public var _nuevo:Boolean;
		public var _nuevoMarta:Boolean;
		public var _nuevoAndrea:Boolean;
		public var _nuevoDentista:Boolean;
		public var _nuevoOculista:Boolean;
		public var _sintoma:int;
		public var _sintomas:Array = new Array();

		public var globalUrl:String;
		public var _xmlSection:XML;
		public var _xmlSectionPre:XML;
		public var _xmlOKSection:XML;

		public var screenInicio:Inicio;
		public var screenRecepcion:Recepcion;
		public var screenFicha:Ficha;
		public var screenSintomas:Sintomas;
		public var screenPuertas:Puertas;
		public var screenConsultaAndrea:ConsultaAndrea;
		public var screenConsultaDentista:ConsultaDentista;
		public var screenConsultaOculista:ConsultaOculista;

		public var screenJuegoRadio:JuegoRadio;
		public var screenJuegoDentista:JuegoDentista;
		public var screenJuegoOculista:JuegoOculista;

		public var _vacuna:int;
		public var _tutor:String;
		public var _edad:String;
		
		public var _tituloPuerta:String;
		public var _nombrePuerta:String;
		
		private var volGen:Number;
		public var tipoModal:int;
		public var _juegoOculista:Boolean;

		public function Main()
		{
			// constructor code
			//trace("Main");
			alpha = 0;
			_pausaTodo = false;
			//_loadingClip.alpha = 0;
			fondoFin = false;
			_loadingClip.visible = false;
			
			_primeraAndrea = true;
			_primeraDentista = true;
			_primeraOculista = true;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public function init(mainObj:Object)
		{
			_main = mainObj;
			//soundaudio(0);
			_vacuna = _main.mySo.data.vacuna;
			//_vacuna = 3;
			_tutor = _main.tutor;
			_edad = _main.edad;
			//trace(_tutor);
			_idioma = _main._idioma;
			globalUrl = _main.globalUrl;
			_xml = _main._xmlToMain;
			//_sintoma = 0;
			_audios = _main.audios;
			//_audios.effect.play();
			_nuevo = _main.nuevo;
			trace("NUEVO:", _nuevo);
			_nuevoMarta = _main.mySo.data.marta;
			_nuevoAndrea = _main.mySo.data.andrea;
			//trace("_nuevoAndrea:", _nuevoAndrea);
			_nuevoDentista = _main.mySo.data.dentista;
			_nuevoOculista = _main.mySo.data.oculista;
			
			_juego = false;
			_juegoOculista = true;

			_sintomas = ["ninguno","hola","hola","hola","hola","hola","hola","hola","hola"];
			//_sintoma = 4;
			_menuApp.visible = false;
			
			_menuApp.endModal.visible = false;
			_menuApp.endModal.mouseChildren = false;
			_menuApp.endModal.addEventListener(MouseEvent.CLICK, onMenuOpts);
			
			_menuApp.pausaModal.visible = false;
			_menuApp.pausaModal.mouseChildren = false;
			_menuApp.pausaModal.addEventListener(MouseEvent.CLICK, onMenuOpts);
			
			_menuApp.settingsModal.visible = false;
			_menuApp.settingsModal.mouseChildren = false;
			_menuApp.settingsModal.addEventListener(MouseEvent.CLICK, onMenuOpts);
			
			_menuApp.comoModal.visible = false;
			_menuApp.comoModal.mouseChildren = false;
			_menuApp.comoModal.addEventListener(MouseEvent.CLICK, onMenuOpts);
			
			_menuApp.pausaBtn.mouseChildren = false;
			_menuApp.pausaBtn.addEventListener(MouseEvent.CLICK, onMenuOpts);
			
			_menuApp.settingsBtn.mouseChildren = false;
			_menuApp.settingsBtn.addEventListener(MouseEvent.CLICK, onMenuOpts);
			
			_menuApp.comoBtn.mouseChildren = false;
			_menuApp.comoBtn.addEventListener(MouseEvent.CLICK, onMenuOpts);
			
			init_newScreen( {screenRequest:Constants.REQUEST_INICIO} );
			
			TweenMax.to(this, 1, {alpha: 1});
		}
		
		public function onMenuOpts(e:MouseEvent)
		{
			var btn:MovieClip = MovieClip(e.target);
			switch (btn)
			{
				case (_menuApp.pausaBtn) :
					_pausaTodo = true;
					_menuApp.pausaModal.visible = true;
					break;
				
				case (_menuApp.pausaModal) :
					_pausaTodo = false;
					_menuApp.pausaModal.visible = false;
					break;
				
				case (_menuApp.comoBtn) :
					_pausaTodo = true;
					_menuApp.comoModal.visible = true;
					break;
				
				case (_menuApp.comoModal) :
					_pausaTodo = false;
					_menuApp.comoModal.visible = false;
					break;
				
				case (_menuApp.settingsBtn) :
					_pausaTodo = true;
					_menuApp.settingsModal.visible = true;
					break;
				
				case (_menuApp.settingsModal) :
					_pausaTodo = false;
					_menuApp.settingsModal.visible = false;
					//init_newScreen( {screenRequest:Constants.REQUEST_INICIO} );
					_sintoma = 0;
					_nuevo = true;
					_nuevoMarta = true;
					_nuevoAndrea = true;
					_nuevoDentista = true;
					_nuevoOculista = true;
					_main.clearValue();
					_menuApp.visible = false;
					change_screen( {screenRequest:Constants.REQUEST_INICIO, _isFirstTime:_nuevo} );
					break;
				
				case (_menuApp.endModal) :
					numAudio = 0;
					fondoFin = false;
					soundaudio(1);
					
					_pausaTodo = false;
					_menuApp.endModal.visible = false;
					//init_newScreen( {screenRequest:Constants.REQUEST_INICIO} );
					if (_main.estaTodo())
					{
						_sintoma = 0;
						_main.clearValue();
					}
					_menuApp.visible = false;
					change_screen( {screenRequest:Constants.REQUEST_INICIO, _isFirstTime:_nuevo} );
					break;
				
				default :
					break;
			}
			
		}

		public function soundaudio(snd:int)
		{
			trace("numAudio: ", numAudio);
			if (! fondoFin)
			{
				switch (snd)
				{
					case 0 :
						trace("baja minimal y juego y sube principal");
						volGen = 1;
						//var transform:SoundTransform = _main.fondo2.soundTransform;
						//transform.volume = volGen;
						//_main.fondo2.soundTransform = transform;
						TweenMax.to(_main.fondo, 1, {volume:1});
						TweenMax.to(_main.fondo2, 1, {volume:0});
						TweenMax.to(_main.fondo3, 1, {volume:0});
						//addEventListener(Event.ENTER_FRAME, bajaVolA);
						break;
					
					case 1 :
						trace("baja principal y sube minimal");
						volGen = 1;
						TweenMax.to(_main.fondo, 1, {volume:0});
						TweenMax.to(_main.fondo2, 1, {volume:0.5});
						TweenMax.to(_main.fondo3, 1, {volume:0});
						//addEventListener(Event.ENTER_FRAME, bajaVolB);
						break;
					
					case 2 :
						trace("baja minimal y sube juego");
						volGen = 1;
						TweenMax.to(_main.fondo, 1, {volume:0});
						TweenMax.to(_main.fondo2, 1, {volume:0});
						TweenMax.to(_main.fondo3, 1, {volume:0.5});
						//addEventListener(Event.ENTER_FRAME, bajaVolC);
						break;
					
					default :
						break;
				}
			}
			/*
			if (! fondoFin)
			{
				trace("soundaudio");
				
				//_main.fondo.stop();
				
				fondoFin = true;
				if (snd == 0)
				{
					volGen = 1;
					_main.fondo = _main.audiosfondo[_main.fondos[snd][0]].play(0,9999);
					//setVolume(0);
				}
				if (snd == 1)
				{
					volGen = 1;
					_main.fondo2 = _main.audiosfondo[_main.fondos[snd][0]].play(0,9999);
					setVolume(0);
				}
				if (snd == 2)
				{
					volGen = 0.5;
					_main.fondo3 = _main.audiosfondo[_main.fondos[snd][0]].play(0,9999);
					setVolume(0);
				}
				
				addEventListener(Event.ENTER_FRAME, bajaVol);
			}
			*/
		}
		
		public function bajaVolA(e:Event)
		{
			volGen -= 0.02;
			trace("bajaVolA: ", volGen);
			if (volGen > 0)
			{
				//trace(volGen);
				//setDownVolume(volGen);
				var transform:SoundTransform = _main.fondo2.soundTransform;
				transform.volume = volGen;
				_main.fondo2.soundTransform = transform;
				
				var transform3:SoundTransform = _main.fondo3.soundTransform;
				transform3.volume = volGen;
				_main.fondo3.soundTransform = transform3;
				
				var transform2:SoundTransform = _main.fondo.soundTransform;
				transform2.volume = 1-volGen;
				_main.fondo.soundTransform = transform2;
				
			}
			else
			{
				//_main.fondo.stop();
				fondoFin = true;
				removeEventListener(Event.ENTER_FRAME, bajaVolA);
			}
		}
		
		public function bajaVolB(e:Event)
		{
			volGen -= 0.02;
			trace("bajaVolB: ", volGen);
			if (volGen > 0)
			{
				//trace(volGen);
				//setDownVolume(volGen);
				var transform:SoundTransform = _main.fondo.soundTransform;
				transform.volume = volGen;
				_main.fondo.soundTransform = transform;
				/*
				transform = _main.fondo3.soundTransform;
				transform.volume = volGen;
				_main.fondo3.soundTransform = transform;
				*/
				var transform2:SoundTransform = _main.fondo2.soundTransform;
				transform2.volume = (1-volGen) / 2;
				_main.fondo2.soundTransform = transform2;
				
			}
			else
			{
				//_main.fondo.stop();
				fondoFin = true;
				removeEventListener(Event.ENTER_FRAME, bajaVolB);
			}
		}
		
		public function bajaVolC(e:Event)
		{
			volGen -= 0.02;
			
			if (volGen > 0)
			{
				//trace(volGen);
				//setDownVolume(volGen);
				var transform:SoundTransform = _main.fondo2.soundTransform;
				transform.volume = volGen;
				_main.fondo2.soundTransform = transform;
				/*
				transform = _main.fondo3.soundTransform;
				transform.volume = volGen;
				_main.fondo3.soundTransform = transform;
				*/
				var transform2:SoundTransform = _main.fondo3.soundTransform;
				transform2.volume = (1-volGen) / 2;
				_main.fondo3.soundTransform = transform2;
				
			}
			else
			{
				//_main.fondo.stop();
				fondoFin = true;
				removeEventListener(Event.ENTER_FRAME, bajaVolC);
			}
		}
		/*
		public function _bajaVol(e:Event)
		{
			volGen -= 0.02;
			
			if (numAudio == 0)
			{
				_main.fondo2.stop();
				_main.fondo3.stop();
				fondoFin = true;
				removeEventListener(Event.ENTER_FRAME, bajaVol);
				
				if (volGen > 0)
				{
					//trace(volGen);
					setDownVolume(volGen);
					if (volGen > 0.5)
					{
						setVolume(0.5-volGen);
					}
				}
				else
				{
					_main.fondo2.stop();
					_main.fondo3.stop();
					fondoFin = true;
					removeEventListener(Event.ENTER_FRAME, bajaVol);
				}
				
			}
			
			if (numAudio == 1)
			{
				if (volGen > 0)
				{
					//trace(volGen);
					setDownVolume(volGen);
					if (volGen > 0.5)
					{
						setVolume(1-volGen);
					}
				}
				else
				{
					_main.fondo.stop();
					fondoFin = true;
					removeEventListener(Event.ENTER_FRAME, bajaVol);
				}
			}
			if (numAudio == 2)
			{
				if (volGen > 0)
				{
					//trace(volGen);
					setDownVolumeMinimal(volGen);
					setVolumeJuego(0.5-volGen);
					
				}
				else
				{
					_main.fondo2.stop();
					fondoFin = true;
					removeEventListener(Event.ENTER_FRAME, bajaVol);
				}
			}
		}
		*/
		public function setDownVolumeMinimal(vol:Number)
		{
			var transform:SoundTransform = _main.fondo2.soundTransform;
			transform.volume = vol;
			_main.fondo2.soundTransform = transform;
		}
		
		public function setDownVolume(vol:Number)
		{
			var transform:SoundTransform = _main.fondo.soundTransform;
			transform.volume = vol;
			_main.fondo.soundTransform = transform;
		}
		
		public function setVolumeJuego(vol:Number)
		{
			var transform:SoundTransform = _main.fondo3.soundTransform;
			transform.volume = vol;
			_main.fondo3.soundTransform = transform;
		}

		public function setVolume(vol:Number)
		{
			var transform:SoundTransform = _main.fondo2.soundTransform;
			transform.volume = vol;
			_main.fondo2.soundTransform = transform;
		}

		public function saveValue(gameuser:String, fecha:String, lugar:String, edad:String, estatura:String, peso:String, tutor:String, vacuna:int, andrea:Boolean, dentista:Boolean, oculista:Boolean):void
		{
			_nuevo = false;
			//_main.saveValue("Paula","29-9-2010","VLC","9","70","8","Mama",1, true, true, true);
		}

		public function change_screen( e:Object ):void
		{
			// remove active screen
			_sections.removeChild( _screenActive );
			_screenActive = null;
			// init requested screen
			init_newScreen( e );
		}

		public function init_newScreen( e:Object ):void
		{
			_screenRequest = e.screenRequest;
			_screenData = {};

			switch ( _screenRequest )
			{
				case Constants.REQUEST_INICIO :
					screenInicio = new Inicio();
					_sections.addChild( screenInicio );
					_screenData = {controller:this,_mainroot:_main};
					screenInicio.init( _screenData );
					_screenActive = screenInicio;
					break;

				case Constants.REQUEST_RECEPCION :
					////trace(_xml.recepcion);
					////trace(_xml.recepcion.children()[i].name());

					switch ( _sintoma )
					{
						case 0 :
							if (_nuevo)
							{
								//trace("0 y nuevo \n", _xml.marta_entrada_primeravisita_inicio);
								_xmlSection = new XML(_xml.marta_entrada_primeravisita_inicio);
								_xmlOKSection = null;
							}
							else
							{
								if (_nuevoMarta)
								{
									_xmlSection = new XML(_xml.marta_entrada_primeravisita_formulario);
								}
								else
								{
									_xmlSection = new XML(_xml.marta_entrada_siguientesvisitas_inicio);
								}
								//trace("0 y siguientes");
								
								//_xmlSection = new XML(_xml.andrea_entrada_siguientesvisitas);
								_xmlOKSection = null;
							}
							break;

						case 1 :
							_xmlSection = new XML(_xml.marta_entrada_primeravisita_pasoadoctor);
							_xmlOKSection = null;
							break;

						case 2 :
							_xmlSection = new XML(_xml.marta_entrada_primeravisita_pasoadoctor);
							_xmlOKSection = null;
							break;

						case 3 :
							_xmlSection = new XML(_xml.marta_entrada_primeravisita_pasoadoctor);
							_xmlOKSection = null;

							break;

						case 4 :
							_xmlSection = new XML(_xml.marta_entrada_primeravisita_pasoadoctor);
							_xmlOKSection = null;
							break;

						case 5 :
							// CONTROLAR GRABACIÓN DEL SHAREOBJECT PARA SABER QUÉ VACUNA LE TOCA
							//trace("vacunaaaaaaaaaas", _main.mySo.data.vacuna);
							switch (_main.mySo.data.vacuna)
							{
								case 1 :
									_xmlSection = new XML(_xml.marta_vacunas_primera);
									_xmlOKSection = new XML(_xml.marta_vacunas_primera_ok);
									break;

								case 2 :
									_xmlSection = new XML(_xml.marta_vacunas_segunda);
									_xmlOKSection = new XML(_xml.marta_vacunas_segunda_ok);
									break;

								case 3 :
									_xmlSection = new XML(_xml.marta_vacunas_tercera);
									_xmlOKSection = new XML(_xml.marta_vacunas_tercera_ok);
									break;

								default :
									break;
							}


							break;

						case 6 :
							_xmlSection = new XML(_xml.marta_entrada_primeravisita_pasoadoctor);
							_xmlOKSection = null;
							break;

						case 7 :
							_xmlSection = new XML(_xml.marta_entrada_primeravisita_pasoadoctor);
							_xmlOKSection = null;
							break;

						case 8 :
							_xmlSection = new XML(_xml.marta_entrada_primeravisita_pasoadoctor);
							_xmlOKSection = null;
							break;

						default :
							break;
					}
					
					screenRecepcion = new Recepcion();
					_sections.addChild( screenRecepcion );
					_screenData = {controller:this,isFirstTime:_nuevo,sintoma:_sintoma,tutor:_tutor,loc:_audios.marta,opt:_audios.marta_opts,_xml:_xmlSection,_xmlok:_xmlOKSection,_mainroot:_main};
					//trace(_audios.marta,_audios.marta_opts,_xmlSection);
					screenRecepcion.init( _screenData );
					_screenActive = screenRecepcion;
					break;

				case Constants.REQUEST_FICHA :
					screenFicha = new Ficha();
					_sections.addChild( screenFicha );
					_screenData = {controller:this,_mainroot:_main};
					screenFicha.init( _screenData );
					_screenActive = screenFicha;
					break;

				case Constants.REQUEST_SINTOMAS :
					screenSintomas = new Sintomas();
					_sections.addChild( screenSintomas );
					_screenData = {controller:this,_mainroot:_main};
					screenSintomas.init( _screenData );
					_screenActive = screenSintomas;
					break;

				case Constants.REQUEST_PUERTAS :
					trace("_sintoma puerta:", _sintoma);
					switch ( _sintoma )
					{
						case 1 :
							_tituloPuerta = "MEDICINA GENERAL";
							_nombrePuerta = "ANDREA";
							break;

						case 2 :
							_tituloPuerta = "DENTISTA";
							_nombrePuerta = "ADRIÁN";
							break;

						case 3 :
							_tituloPuerta = "MEDICINA GENERAL";
							_nombrePuerta = "ANDREA";
							break;

						case 4 :
							_tituloPuerta = "OCULISTA";
							_nombrePuerta = "PABLO";
							break;

						case 5 :
							_tituloPuerta = "";
							_nombrePuerta = "";
							break;

						case 6 :
							_tituloPuerta = "MEDICINA GENERAL";
							_nombrePuerta = "ANDREA";
							break;

						case 7 :
							_tituloPuerta = "MEDICINA GENERAL";
							_nombrePuerta = "ANDREA";
							break;

						default :
							break;
					}
					screenPuertas = new Puertas();
					_sections.addChild( screenPuertas );
					_screenData = {controller:this,sintoma:_sintoma, nom:_nombrePuerta, titulo:_tituloPuerta,_mainroot:_main};
					screenPuertas.init( _screenData );
					_screenActive = screenPuertas;
					break;

				case Constants.REQUEST_CONSULTA_ANDREA :
					trace("_nuevoAndrea:", _nuevoAndrea);
					if (_nuevoAndrea)
					{
						_xmlSectionPre = new XML(_xml.andrea_entrada_primeravisita);
					}
					else
					{
						_xmlSectionPre = new XML(_xml.andrea_entrada_siguientesvisitas);
					}
					switch ( _sintoma )
					{
						case 0 :
							/*
							if (_nuevoAndrea)
							{
								_xmlSection = new XML(_xml.andrea_entrada_primeravisita);
								_xmlOKSection = null;
							}
							else
							{
								_xmlSection = new XML(_xml.andrea_entrada_siguientesvisitas);
								_xmlOKSection = null;
							}
							*/
							break;

						case 1 :
							_xmlSection = new XML(_xml.andrea_otitis);
							_xmlOKSection = new XML(_xml.andrea_otitis_ok);
							tipoModal = 0;
							break;

						case 2 :
							_xmlSection = null;
							_xmlOKSection = null;
							tipoModal = -1;
							break;

						case 3 :
							_xmlSection = new XML(_xml.andrea_duele_tripa);
							_xmlOKSection = new XML(_xml.andrea_duele_tripa_ok);
							tipoModal = -1;
							break;

						case 4 :
							_xmlSection = null;
							_xmlOKSection = null;
							tipoModal = -1;
							break;

						case 5 :
							// CONTROLAR GRABACIÓN DEL SHAREOBJECT PARA SABER QUÉ VACUNA LE TOCA
							//trace("vacunaaaaaaaaaas");
							_xmlSection = null;
							_xmlOKSection = null;
							
							break;

						case 6 :
							_xmlSection = new XML(_xml.andrea_tos);
							_xmlOKSection = new XML(_xml.andrea_tos_ok);
							tipoModal = 10;
							break;

						case 7 :
							_xmlSection = new XML(_xml.andrea_se_ha_caido);
							_xmlOKSection = new XML(_xml.andrea_se_ha_caido_ok);
							tipoModal = 100;
							break;

						case 8 :
							_xmlSection = null;
							_xmlOKSection = null;
							tipoModal = -1;
							break;

						default :
							break;
					}
					
					screenConsultaAndrea = new ConsultaAndrea();
					_sections.addChild( screenConsultaAndrea );
					//_screenData = {controller:this,sintoma:_sintoma,audios:_audios,objscreen:objEffects,_globalUrl:globalUrl};
					_screenData = {controller:this,isFirstTime:_nuevo,sintoma:_sintoma,_tipoModal:tipoModal,tutor:_tutor,edad:_edad,loc:_audios.andrea,opt:_audios.andrea_opts,_xml:_xmlSection,_xmlpre:_xmlSectionPre,_xmlok:_xmlOKSection,_mainroot:_main,juego:_juego};
					trace(_audios.andrea,_audios.andrea_opts,_xmlSection);
					screenConsultaAndrea.init( _screenData );
					_screenActive = screenConsultaAndrea;
					break;

				case Constants.REQUEST_CONSULTA_OCULISTA :
					if (_nuevoOculista)
					{
						_xmlSectionPre = new XML(_xml.pablo_oftalmologo_primeravisita);
					}
					else
					{
						_xmlSectionPre = new XML(_xml.pablo_oftalmologo_siguientesvisitas);
					}
					switch ( _sintoma )
					{
						case 0 :
							/*
							if (_nuevoOculista)
							{
								_xmlSection = new XML(_xml.pablo_oftalmologo_primeravisita);
								_xmlOKSection = null;
							}
							else
							{
								_xmlSection = new XML(_xml.pablo_oftalmologo_siguientesvisitas);
								_xmlOKSection = null;
							}
							*/
							break;

						case 1 :
							_xmlSection = null;
							_xmlOKSection = null;
							break;

						case 2 :
							_xmlSection = null;
							_xmlOKSection = null;
							break;

						case 3 :
							_xmlSection = null;
							_xmlOKSection = null;

							break;

						case 4 :
							_xmlSection = new XML(_xml.pablo_oftalmologo_continuacion);
							if (_juegoOculista)
							{
								_xmlOKSection = new XML(_xml.pablo_oftalmologo_continuacion_ok);
							}
							else
							{
								_xmlOKSection = new XML(_xml.pablo_oftalmologo_continuacion_ko);
							}
							break;

						case 5 :
							// CONTROLAR GRABACIÓN DEL SHAREOBJECT PARA SABER QUÉ VACUNA LE TOCA
							//trace("vacunaaaaaaaaaas");
							_xmlSection = null;
							_xmlOKSection = null;
							
							break;

						case 6 :
							_xmlSection = null;
							_xmlOKSection = null;
							
							break;

						case 7 :
							_xmlSection = null;
							_xmlOKSection = null;
							
							break;

						case 8 :
							_xmlSection = null;
							_xmlOKSection = null;
							break;

						default :
							break;
					}

					screenConsultaOculista = new ConsultaOculista();
					_sections.addChild( screenConsultaOculista );
					//_screenData = {controller:this,sintoma:_sintoma,audios:_audios,objscreen:objEffects,_globalUrl:globalUrl};
					_screenData = {controller:this,isFirstTime:_nuevo,sintoma:_sintoma,joc:_juegoOculista,tutor:_tutor,loc:_audios.oculista,opt:_audios.oculista_opts,_xml:_xmlSection,_xmlpre:_xmlSectionPre,_xmlok:_xmlOKSection,_mainroot:_main,juego:_juego};
					//trace(_audios.andrea,_audios.andrea_opts,_xmlSection);
					screenConsultaOculista.init( _screenData );
					_screenActive = screenConsultaOculista;
					break;

				case Constants.REQUEST_CONSULTA_DENTISTA :
					if (_nuevoDentista)
					{
						_xmlSectionPre = new XML(_xml.adrian_dentista_primeravisita);
					}
					else
					{
						_xmlSectionPre = new XML(_xml.adrian_dentista_siguientesvisitas);
					}
					switch ( _sintoma )
					{
						case 0 :
							/*
							if (_nuevoDentista)
							{
								_xmlSection = new XML(_xml.adrian_dentista_primeravisita);
								_xmlOKSection = null;
							}
							else
							{
								_xmlSection = new XML(_xml.adrian_dentista_siguientesvisitas);
								_xmlOKSection = null;
							}
							*/
							break;

						case 1 :
							_xmlSection = null;
							_xmlOKSection = null;
							break;

						case 2 :
							_xmlSection = new XML(_xml.adrian_dentista_continuacion);
							_xmlOKSection = new XML(_xml.adrian_dentista_continuacion_ok);
							break;

						case 3 :
							_xmlSection = null;
							_xmlOKSection = null;

							break;

						case 4 :
							_xmlSection = null;
							_xmlOKSection = null;
							break;

						case 5 :
							// CONTROLAR GRABACIÓN DEL SHAREOBJECT PARA SABER QUÉ VACUNA LE TOCA
							//trace("vacunaaaaaaaaaas");
							_xmlSection = null;
							_xmlOKSection = null;
							
							break;

						case 6 :
							_xmlSection = null;
							_xmlOKSection = null;
							
							break;

						case 7 :
							_xmlSection = null;
							_xmlOKSection = null;
							
							break;

						case 8 :
							_xmlSection = null;
							_xmlOKSection = null;
							break;

						default :
							break;
					}

					screenConsultaDentista = new ConsultaDentista();
					_sections.addChild( screenConsultaDentista );
					//_screenData = {controller:this,sintoma:_sintoma,audios:_audios,objscreen:objEffects,_globalUrl:globalUrl};
					_screenData = {controller:this,isFirstTime:_nuevo,sintoma:_sintoma,tutor:_tutor,loc:_audios.dentista,opt:_audios.dentista_opts,_xml:_xmlSection,_xmlpre:_xmlSectionPre,_xmlok:_xmlOKSection,_mainroot:_main,juego:_juego};
					screenConsultaDentista.init( _screenData );
					_screenActive = screenConsultaDentista;
					break;

				case Constants.REQUEST_JUEGO_RADIO :
					screenJuegoRadio = new JuegoRadio();
					_sections.addChild( screenJuegoRadio );
					_screenData = {controller:this,sintoma:_sintoma,_mainroot:_main};
					screenJuegoRadio.init( _screenData );
					_screenActive = screenJuegoRadio;
					break;

				case Constants.REQUEST_JUEGO_DENTISTA :
					screenJuegoDentista = new JuegoDentista();
					_sections.addChild( screenJuegoDentista );
					_screenData = {controller:this,sintoma:_sintoma,_mainroot:_main};
					screenJuegoDentista.init( _screenData );
					_screenActive = screenJuegoDentista;
					break;

				case Constants.REQUEST_JUEGO_OCULISTA :
					screenJuegoOculista = new JuegoOculista();
					_sections.addChild( screenJuegoOculista );
					_screenData = {controller:this,sintoma:_sintoma,_mainroot:_main};
					screenJuegoOculista.init( _screenData );
					_screenActive = screenJuegoOculista;
					break;

				default :
					break;
			}
		}

		public function onTweenScreen(_nextScreen:String):void
		{
			if (_nextScreen != _screenRequest)
			{
				TweenMax.to(_screenActive, 1, {alpha: 0, onComplete:onTweenComplete, onCompleteParams:[_nextScreen]});
			}
		}

		private function onTweenComplete(_nextScreen:String):void
		{
			change_screen( {screenRequest:_nextScreen, _isFirstTime:_nuevo} );
		}

		private function stageResized(e:Event):void
		{
			//trace("stageResizedMain");
			this.x = (stage.stageWidth - 1024) / 2;
			this.y = (stage.stageHeight - 768) / 2;
		}

		private function onAddedToStage( event:Event ):void
		{
			// GAME CODE
			//trace("onAddedToStage");

			this.x = (stage.stageWidth - 1024) / 2;
			this.y = (stage.stageHeight - 768) / 2;
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			stage.addEventListener(Event.RESIZE, stageResized, false, int.MAX_VALUE, true);
			//init_newScreen( {screenRequest:Constants.REQUEST_INICIO} );
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onRemovedFromStage( event:Event ):void
		{
			//trace("onRemovedFromStage");
			removeEventListener(Event.ADDED_TO_STAGE, onRemovedFromStage);
		}

	}

}