package com.hellodoctor.screens
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.SimpleButton;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	import com.hellodoctor.Constants;
	
	import com.logosware.event.QRdecoderEvent;
	import com.logosware.event.QRreaderEvent;
	import com.logosware.utils.QRcode.QRdecode;
	import com.logosware.utils.QRcode.GetQRimage;

	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;

	public class ConsultaDentista extends MovieClip
	{
		private var _controller:Object;
		private var _main:Object;
		private var _isFirstTime:Boolean;
		private var _sintoma:int;
		
		private var _qrlectura:String;
		private var _tentativa:int;
		private var _totaltime:int;
		private var _cheat:Boolean;
		private var isCheatable:Boolean;
		private var _conseguido:Boolean;
		private var _juego:Boolean;
		private var cheatTimer:Timer = new Timer(1000);

		private const SRC_SIZE:int = 320;
		
		public var vistacamara:MovieClip;
		public var maskcamara:MovieClip;
		public var botonpasar:MovieClip;
		private var getQRimage:GetQRimage;
		private var qrDecode:QRdecode = new QRdecode();
		private var cameraView:Sprite;
		private var camera:Camera;
		private var video:Video = new Video(SRC_SIZE,SRC_SIZE);
		private var freezeImage:Bitmap;
		private var blue:Sprite = new Sprite();
		private var red:Sprite = new Sprite();
		private var cameraTimer:Timer = new Timer(5000);
		private var textArray:Array = ["","",""];
		private var redTimer:Timer = new Timer(400,1);
		
		public var videoHolder:Sprite;

		private var _obj:Object;
		private var _audios:Object;
		private var i:int;

		private var snd:Sound = new Sound();
		private var _loc:Sound = new Sound();
		private var _opt:Sound = new Sound();
		private var channel:SoundChannel = new SoundChannel();
		private var channeleff:SoundChannel = new SoundChannel();
		private var botonclick:SoundChannel = new SoundChannel();
		
		public var _xml:XML;
		public var _xmlpre:XML;
		public var _xmlok:XML;

		private var endPlay:Number;
		private var pausas:Array;
		private var pausa:Number;
		private var stopPausa:Number;
		private var pausado:Boolean;
		private var count:int;
		private var paradas:Array;
		private var parada:Number;
		private var retoma:Number;
		private var countParadas:int;
		
		private var retomaPose:int;
		public var pose:MovieClip;
		
		private var charlas:Array;
		private var countCharlas:int;
		private var stopSound:Number;
		private var _tutor:String;
		private var typeSexOption:String;
		private var typeDoctorOption:String;
		private var typeSintomaOption:String;
		
		private var effStart:Number;
		private var effEnd:Number;

		private var req:URLRequest;

		public var globalUrl:String;

		public var boca:MovieClip;
		public var ojos:MovieClip;
		public var countsecs:int = 0;
		
		private var _stopped:Boolean;
		private var soundPoint:Number;
		
		public var llamada:MovieClip;

		public function ConsultaDentista()
		{
			// constructor code
			super();
			//trace("Recepcion");
			alpha = 0;
			boca.gotoAndStop(boca.totalFrames);
			
			vistacamara.visible = false;
			maskcamara.visible = false;
			//botonpasar.visible = false;
			_stopped = false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//addEventListener(MouseEvent.CLICK, onMouse);
			//botonpasar.addEventListener(MouseEvent.CLICK, eliminarQR);
		}

		private function eliminarQR( e:MouseEvent ):void
		{
			//ayudaQR.visible = false;
			_conseguido = true;
			
			trace("conseguido fin");
			
			montaCharlas(_xmlok,null);
			vistacamara.removeChild( videoHolder );
			vistacamara.removeChild( red );
			vistacamara.removeChild( blue );
			
			removeChild( cameraView );
			
			//botonpasar.visible = false;
			
			getQRimage.removeEventListener(QRreaderEvent.QR_IMAGE_READ_COMPLETE, onQrImageReadComplete);
			qrDecode.removeEventListener(QRdecoderEvent.QR_DECODE_COMPLETE, onQrDecodeComplete);
			removeEventListener(MouseEvent.CLICK, eliminarQR);
			//botonpasar.removeEventListener(MouseEvent.CLICK, eliminarQR);
		}


		public function init( screenData:Object ):void
		{
			llamada.visible = false;
			/*
			controller:this
			isFirstTime:_nuevo
			sintoma:_sintoma
			loc:_audios.marta
			opt:_audios.marta_opts
			_xml:_xmlSection
			_xmlok:_xmlOKSection
			*/
			_controller = screenData.controller;
			_main = screenData._mainroot;
			_isFirstTime = screenData.isFirstTime;
			_sintoma = screenData.sintoma;
			//_sintoma = 1;
			_tutor = screenData.tutor;
			_loc = screenData.loc;
			_opt = screenData.opt;
			_xml = screenData._xml;
			_xmlpre = screenData._xmlpre;
			_xmlok = screenData._xmlok;
			
			_controller.numAudio = 1;
			_controller.fondoFin = false;
			_controller.soundaudio(1);
			
			_tentativa = 0;
			_totaltime = 20;
			_cheat = true;
			isCheatable = true;
			_conseguido = false;
			
			_juego = screenData.juego;
			
			if (_juego)
			{
				montaCharlas(_xmlok,null);
				_controller._juego = false;
				_conseguido = true;
				pose.gotoAndStop(2);
				boca.visible = true;
				ojos.visible = false;
			}
			else
			{
				montaCharlas(_xml,_xmlpre);
			}
			
			_controller._loadingClip.mc.txt.text = "IN THE DENTIST";
			_controller._loadingClip.alpha = 0;
			
			if (_controller._primeraDentista)
			{
				_controller._primeraDentista = false;
				_controller._loadingClip.visible = true;
				TweenMax.to(_controller._loadingClip, 1, {alpha: 1, onComplete: showSection});
				_controller._loadingClip.mc.mc.play();
			}
			else
			{
				showSection();
			}

			//fondo = audiosfondo[fondos[0][0]].play();
			_controller.numAudio = 1;
			_controller.soundaudio(1);
			
			_qrlectura = _controller._sintomas[_controller._sintoma];
			
			_main.mySo.data.dentista = false;
			_controller._nuevoDentista = false;
			_main.saveValue();
			//TweenMax.to(this, 1, {alpha: 1});
		}
		
		private function montaCharlas(xml:XML,xmlpre:XML):void
		{
			typeSexOption = _tutor.toLowerCase();
			switch (_sintoma)
			{
				case 0 :
					typeDoctorOption = null;
					typeSintomaOption = null;
					break;
					
				case 1 :
					typeDoctorOption = "andrea";
					typeSintomaOption = "fiebre";
					break;
					
				case 2 :
					typeDoctorOption = "adrian";
					typeSintomaOption = null;
					break;
					
				case 3 :
					typeDoctorOption = "andrea";
					typeSintomaOption = "tripa";
					break;
					
				case 4 :
					typeDoctorOption = "pablo";
					typeSintomaOption = null;
					break;
					
				case 5 :
					typeDoctorOption = null;
					typeSintomaOption = null;
					break;
					
				case 6 :
					typeDoctorOption = "andrea";
					typeSintomaOption = "tos";
					break;
					
				case 7 :
					typeDoctorOption = "andrea";
					typeSintomaOption = "caida";
					break;
					
				case 8 :
					typeDoctorOption = "andrea";
					typeSintomaOption = null;
					break;
					
				default :
					break;
			}
			
			//trace(_xml.children().length());
			//trace(_xmlok);
			charlas = new Array();
			if (xmlpre != null)
			{
				
				
				for (i = 0; i < xmlpre.children().length(); i++)
				{
					if (xmlpre.children()[i].name() == "locucion")
					{
						charlas.push([xmlpre.children()[i].name(), Number(xmlpre.children()[i].@iniciar) * 1000, Number(xmlpre.children()[i].@parar) * 1000]);
					}
					if (xmlpre.children()[i].name() == "pausa")
					{
						charlas.push([xmlpre.children()[i].name(), null, null]);
					}
					if (xmlpre.children()[i].name() == typeSexOption)
					{
						charlas.push([xmlpre.children()[i].name(), Number(xmlpre.children()[i].@iniciar) * 1000, Number(xmlpre.children()[i].@parar) * 1000]);
					}
					if (xmlpre.children()[i].name() == typeDoctorOption)
					{
						charlas.push([xmlpre.children()[i].name(), Number(xmlpre.children()[i].@iniciar) * 1000, Number(xmlpre.children()[i].@parar) * 1000]);
					}
					if (xmlpre.children()[i].name() == typeSintomaOption)
					{
						charlas.push([xmlpre.children()[i].name(), Number(xmlpre.children()[i].@iniciar) * 1000, Number(xmlpre.children()[i].@parar) * 1000]);
					}
				}
			}
			retomaPose = Number(xml.children()[0].@iniciar) * 1000 + 2500;
			for (i = 0; i < xml.children().length(); i++)
			{
				if (xml.children()[i].name() == "locucion")
				{
					charlas.push([xml.children()[i].name(), Number(xml.children()[i].@iniciar) * 1000, Number(xml.children()[i].@parar) * 1000]);
				}
				if (xml.children()[i].name() == "pausa")
				{
					charlas.push([xml.children()[i].name(), null, null]);
				}
				if (xml.children()[i].name() == typeSexOption)
				{
					charlas.push([xml.children()[i].name(), Number(xml.children()[i].@iniciar) * 1000, Number(xml.children()[i].@parar) * 1000]);
				}
				if (xml.children()[i].name() == typeDoctorOption)
				{
					charlas.push([xml.children()[i].name(), Number(xml.children()[i].@iniciar) * 1000, Number(xml.children()[i].@parar) * 1000]);
				}
				if (xml.children()[i].name() == typeSintomaOption)
				{
					charlas.push([xml.children()[i].name(), Number(xml.children()[i].@iniciar) * 1000, Number(xml.children()[i].@parar) * 1000]);
				}
			}
			countCharlas = 0;
			
			if (_conseguido)
			{
				_main.mySo.data.diente = true;
				_sintoma = 99;
				reproduce();
				boca.play();
			}
			//channel = snd.play(100000);
		}
		
		private function reproduce():void
		{
			var esperaModal:Boolean = false;
			if (charlas[countCharlas][0] == "locucion")
			{
				snd = _loc;
			}
			else if (charlas[countCharlas][0] == "pausa")
			{
				removeEventListener(Event.ENTER_FRAME, controllerSound);
				boca.gotoAndStop(boca.totalFrames);
				esperaModal = true;
				//snd = _opt;
				//_controller._pausaTodo = true;
				countCharlas++;
				// funcion muestra modal
				addEventListener(MouseEvent.CLICK, onModal);
				return;
			}
			else
			{
				snd = _opt;
			}
			if (!esperaModal)
			{
				stopSound = charlas[countCharlas][2];
				addEventListener(Event.ENTER_FRAME, controllerSound);
				channel = snd.play(charlas[countCharlas][1]);
				countCharlas++;
			}
		}
		
		private function onModal( e:MouseEvent ):void
		{
			botonclick = _main.effects.boton.play(0, 1);
			reproduce();
			removeEventListener(MouseEvent.CLICK, onModal);
		}
		
		private function controllerSound(event:Event):void
		{
			if (!_controller._pausaTodo)
			{
				if (_stopped)
				{
					channel = snd.play(soundPoint);
					_stopped = false;
				}
				var loadTime:Number = snd.bytesLoaded / snd.bytesTotal;
				var loadPercent:uint = Math.round(100 * loadTime);
				var estimatedLength:int = Math.ceil(snd.length / (loadTime));
				var playbackPercent:uint = Math.round(100 * (channel.position / estimatedLength));
				
				// new pausas
				if (channel.leftPeak == 0 && channel.rightPeak == 0)
				{
					////trace("silencio");
					boca.gotoAndStop(boca.totalFrames);
					pausado = true;
				}
				else
				{
					if (pausado)
					{
						//pausado = false;
						if ( _sintoma != 0 && _sintoma != 5 && _sintoma != 99 && countsecs > 0)
						{
							countsecs--;
							if (countsecs == 0)
							{
								pausado = false;
								boca.play();
							}
						}
						else
						{
							pausado = false;
							boca.play();
							//boca.nextFrame();
						}
					}
				}
				
				if (channel.position > retomaPose)
				{
					pose.gotoAndStop(1);
					boca.visible = true;
					ojos.visible = true;
				}
				
				// end audio
				if (channel.position > stopSound)
				{
					channel.stop();
					boca.gotoAndStop(boca.totalFrames);
					
					if (countCharlas < charlas.length)
					{
						reproduce();
						boca.play();
					}
					else
					{
						if (_sintoma == 99)
						{
							
							_controller._sintoma = 0;
							_controller._menuApp.endModal.visible = true;
							/*
							if (_main.estaTodo())
							{
								_controller._menuApp.endModal.visible = true;
							}
							else
							{
								_controller._menuApp.visible = false;
								_controller.onTweenScreen(Constants.REQUEST_INICIO);
							}
							*/
							//_controller.onTweenScreen(Constants.REQUEST_INICIO);
						}
						/*
						else if (_sintoma == 2)
						{
							_controller.onTweenScreen(Constants.REQUEST_INICIO);
						}
						*/
						else
						{
							llamada.visible = true;
							llamada.addEventListener(MouseEvent.CLICK, onMouse);
						}
						
						removeEventListener(Event.ENTER_FRAME, controllerSound);
					}
				}
			}
			else
			{
				_stopped = true;
				soundPoint = channel.position;
				channel.stop();
				boca.gotoAndStop(boca.totalFrames);
			}
		}
		
		private function showSection():void
		{
			if (_sintoma < 1)
			{
				TweenMax.to(_controller._loadingClip, 1, {alpha: 0, delay:2});
				TweenMax.to(this, 1, {alpha: 1, delay:3, onComplete:startComplete});
			}
			else
			{
				TweenMax.to(this, 1, {alpha: 1, onComplete:startComplete});
			}
			//_controller._loadingClip.visible = false;
		}
		/*
		private function completeHandler(event:Event):void
		{
			if (_sintoma < 1)
			{
				TweenMax.to(_controller._loadingClip, 1, {alpha: 0, delay:2});
				TweenMax.to(this, 1, {alpha: 1, delay:3, onComplete:startComplete});
			}
			else
			{
				TweenMax.to(this, 1, {alpha: 1, onComplete:startComplete});
			}
			//_controller._loadingClip.visible = false;
		}
		*/
		private function startComplete():void
		{
			_controller._loadingClip.visible = false;
			_controller._loadingClip.mc.mc.gotoAndStop(1);
			//addEventListener(Event.ENTER_FRAME, controllerSound);
			//channel = snd.play(Number(_obj.iniciar) * 1000);
			/*
			var transform:SoundTransform = channel.soundTransform;
			//transform.volume = 0;
			channel.soundTransform = transform;
			//channel.soundTransform.volume = 0;
			*/
			if (_conseguido)
			{
				_sintoma = 99;
			}
			reproduce();
			boca.play();
		}
		/*
		private function errorHandler(errorEvent:IOErrorEvent):void
		{
			//
		}
		*/
		private function onMouse( e:MouseEvent ):void
		{
			botonclick = _main.effects.boton.play(0, 1);
			//_controller._sintoma = 0;
			//_controller.onTweenScreen(Constants.REQUEST_INICIO);
			if (_sintoma == 99)
			{
				_controller._menuApp.visible = false;
				_controller._sintoma = 0;
				_controller.onTweenScreen(Constants.REQUEST_INICIO);
			}
			else if (_sintoma == 2)
			{
				llamada.visible = false;
				//_controller.onTweenScreen(Constants.REQUEST_INICIO);
				//_controller.onTweenScreen(Constants.REQUEST_JUEGO_DENTISTA);
				_conseguido = true;
				// respuesta
				trace("conseguido fin");
				//_sintoma = 99;
				montaCharlas(_xmlok,null);
			}
			llamada.removeEventListener(MouseEvent.CLICK, onMouse);
		}
		
		private function ReadQrCodeInit():void
		{
			cameraTimer.addEventListener(TimerEvent.TIMER, getCamera);
			cameraTimer.start();
			getCamera();
		}
		
		private function getCamera(e:TimerEvent = null):void
		{
			camera = Camera.getCamera();
			this.graphics.clear();

			if ( camera == null )
			{
				//this.addChild( errorView );
			}
			else
			{
				cameraTimer.stop();
				/*
				if (errorView.parent == this)
				{
				//this.removeChild(errorView);
				}
				*/
				onStart();
				cameraTimer.removeEventListener(TimerEvent.TIMER, getCamera);
			}
		}

		private function onStart():void
		{
			trace("onStart");
			cameraView = buildCameraView();
			//resultView = buildResultView();

			addChild( cameraView );
			//this.addChild( resultView );
			//this.removeChild( startView );
			//resultView.visible = false;

			getQRimage = new GetQRimage(video);
			getQRimage.addEventListener(QRreaderEvent.QR_IMAGE_READ_COMPLETE, onQrImageReadComplete);
			qrDecode.addEventListener(QRdecoderEvent.QR_DECODE_COMPLETE, onQrDecodeComplete);
			redTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onRedTimer );
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function buildCameraView():Sprite
		{
			camera.setQuality(0, 80);
			camera.setMode(SRC_SIZE, SRC_SIZE, 6, true );
			video.attachCamera( camera );
			/*
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginGradientFill(GradientType.LINEAR, [0xCCCCCC, 0x999999], [1.0, 1.0], [0, 255], new Matrix(0, 0.1, -0.1, 0, 0, 150));
			sprite.graphics.drawRoundRect(0, 0, SRC_SIZE+30, SRC_SIZE+30, 20);
			*/
			videoHolder = new Sprite();
			videoHolder.addChild( video );
			videoHolder.x = videoHolder.y = 15;

			freezeImage = new Bitmap(new BitmapData(SRC_SIZE,SRC_SIZE));
			videoHolder.addChild( freezeImage );
			freezeImage.visible = false;

			red.graphics.lineStyle(2, 0xFF0000);
			red.graphics.drawPath(Vector.<int>([1,2,2,1,2,2,1,2,2,1,2,2]), Vector.<Number>([30,60,30,30,60,30,290,60,290,30,260,30,30,260,30,290,60,290,290,260,290,290,260,290]));
			blue.graphics.lineStyle(2, 0x0000FF);
			blue.graphics.drawPath(Vector.<int>([1,2,2,1,2,2,1,2,2,1,2,2]), Vector.<Number>([30,60,30,30,60,30,290,60,290,30,260,30,30,260,30,290,60,290,290,260,290,290,260,290]));

			vistacamara.addChild( videoHolder );
			vistacamara.addChild( red );
			vistacamara.addChild( blue );
			vistacamara.mask = maskcamara;
			blue.alpha = 0;
			red.x = red.y = 15;
			blue.x = blue.y = 15;
			return vistacamara;
		}

		private function getCheat(e:TimerEvent = null):void
		{
			if (isCheatable)
			{
				if (! _conseguido)
				{
					_totaltime--;
					//trace("_totaltime:", _totaltime);

					if (_totaltime < 0)
					{
						vistacamara.visible = false;
						maskcamara.visible = false;
						//_tentativa--;
						//_totaltime = 100;
						if (_tentativa > 0)
						{
							_tentativa--;
							_totaltime = 10;
							// respuesta
							trace("otra vez por cheat");
							/*
							channel = snd.play(_obj.respuestas.resko. @ iniciar);
							channel.soundTransform.volume = 0;
							endPlay = _obj.respuestas.resko. @ parar;
							*/
							boca.play();
							//addEventListener(Event.ENTER_FRAME, controllerEndSound);
							//btnCura.visible = true;
							cheatTimer.stop();
							_cheat = true;
						}
						else
						{
							_conseguido = true;
							// respuesta
							trace("conseguido por cheat");
							/*
							channel = snd.play(_obj.respuestas.resok. @ iniciar);
							channel.soundTransform.volume = 0;
							endPlay = _obj.respuestas.resok. @ parar;
							*/
							boca.play();
							//addEventListener(Event.ENTER_FRAME, controllerEndSound);
							//addEventListener(MouseEvent.CLICK, onMouse);
						}

						removeEventListener(Event.ENTER_FRAME, onEnterFrame);

						//addEventListener(Event.ENTER_FRAME, controllerEndSound);

						getQRimage.removeEventListener(QRreaderEvent.QR_IMAGE_READ_COMPLETE, onQrImageReadComplete);
						qrDecode.removeEventListener(QRdecoderEvent.QR_DECODE_COMPLETE, onQrDecodeComplete);
						
						vistacamara.removeChild( videoHolder );
						vistacamara.removeChild( red );
						vistacamara.removeChild( blue );
			
						removeChild( cameraView );

						cheatTimer.removeEventListener(TimerEvent.TIMER, getCheat);
					}
				}
			}
		}

		private function onEnterFrame(e: Event):void
		{
			if (camera.currentFPS > 0)
			{
				getQRimage.process();
				if (_cheat)
				{
					trace("cheat");
					_cheat = false;
					cheatTimer.addEventListener(TimerEvent.TIMER, getCheat);
					cheatTimer.start();
				}
			}
			/*
			_totaltime--;
			//trace("_totaltime:", _totaltime);
			
			if (_totaltime < 0)
			{
			vistacamara.visible = false;
			maskcamara.visible = false;
			//_tentativa--;
			//_totaltime = 100;
			if (_tentativa > 0)
			{
			_tentativa--;
			_totaltime = 100;
			btnCura.visible = true;
			}
			else
			{
			addEventListener(MouseEvent.CLICK, onMouse);
			}
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			*/
		}

		private function onQrImageReadComplete(e: QRreaderEvent):void
		{
			//trace("onQrImageReadComplete");
			qrDecode.setQR(e.data);
			qrDecode.startDecode();
		}

		private function onQrDecodeComplete(e: QRdecoderEvent):void
		{
			trace("onQrDecodeComplete");
			blue.alpha = 1.0;
			redTimer.reset();
			redTimer.start();
			textArray.shift();
			textArray.push( e.data );
			if (textArray[0] == textArray[1] && textArray[1] == textArray[2])
			{
				//textArea.htmlText = e.data;
				//cameraView.filters = [blurFilter];
				redTimer.stop();
				freezeImage.bitmapData.draw(video);
				freezeImage.visible = true;
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				//resultView.visible = true;
				// TESTS MÍOS
				//cameraView.visible = false;
				trace("resultado:", e.data);

				cheatTimer.stop();
				//_cheat = true;
				cheatTimer.removeEventListener(TimerEvent.TIMER, getCheat);

				removeEventListener(Event.ENTER_FRAME, onEnterFrame);

				vistacamara.visible = false;
				maskcamara.visible = false;

				if (e.data == _qrlectura)
				{
					_conseguido = true;
					// respuesta
					trace("conseguido ok");
					//_sintoma = 99;
					montaCharlas(_xmlok,null);
					/*
					channel = snd.play(_obj.respuestas.resok. @ iniciar);
					endPlay = _obj.respuestas.resok. @ parar;
					boca.play();
					*/
					//addEventListener(Event.ENTER_FRAME, controllerEndSound);
					//addEventListener(MouseEvent.CLICK, onMouse);

				}
				else
				{
					if (_tentativa > 0)
					{
						_tentativa--;
						_totaltime = 10;
						// respuesta
						trace("otra vez");
						/*
						channel = snd.play(_obj.respuestas.resko. @ iniciar);
						endPlay = _obj.respuestas.resko. @ parar;
						boca.play();
						*/
						//addEventListener(Event.ENTER_FRAME, controllerEndSound);
						//btnCura.visible = true;
					}
					else
					{
						_conseguido = true;
						// respuesta
						trace("conseguido fin");
						//_sintoma = 99;
						montaCharlas(_xmlok,null);
						/*
						channel = snd.play(_obj.respuestas.resok. @ iniciar);
						endPlay = _obj.respuestas.resok. @ parar;
						boca.play();
						*/
						//addEventListener(Event.ENTER_FRAME, controllerEndSound);
						//addEventListener(MouseEvent.CLICK, onMouse);
					}
				}

				//addEventListener(Event.ENTER_FRAME, controllerEndSound);

				//getQRimage = null;
				vistacamara.removeChild( videoHolder );
				vistacamara.removeChild( red );
				vistacamara.removeChild( blue );
						
				removeChild( cameraView );
				
				getQRimage.removeEventListener(QRreaderEvent.QR_IMAGE_READ_COMPLETE, onQrImageReadComplete);
				qrDecode.removeEventListener(QRdecoderEvent.QR_DECODE_COMPLETE, onQrDecodeComplete);
			}
		}

		private function onRedTimer(e:TimerEvent):void
		{
			blue.alpha = 0;
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
			removeEventListener(Event.ENTER_FRAME, controllerSound);
			removeEventListener(Event.ADDED_TO_STAGE, onRemovedFromStage);
		}

	}

}