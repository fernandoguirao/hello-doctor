/**
 *  Version : 2.00 
 *  Last Updated : 12/11/2009
 *  ActionScript : 3.0
 *  Author : @braitsch
 *  Documentation : http://www.quietless.com/kitchen/upload-bitmapdata-snapshot-to-server-in-as3
**/

package com.quietless.bitmap
{
	import com.natuchips.Constants;

	import com.adobe.images.*;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	import flash.external.ExternalInterface;

	import com.facebook.graph.Facebook;
	import com.facebook.graph.data.FacebookSession;
	import com.facebook.graph.net.FacebookRequest;
	import flash.net.URLVariables;

	public class BitmapSnapshot extends EventDispatcher
	{
		private var FB_ID:String;

		private var _controller:Object;
		public var _dest:String;
		public var _bmp:String;

		public var debug:Boolean = true;// trace to the output console //
		private var _name:String;// name to give the newly created image //
		private var _image:ByteArray;// image data represented as a byte array //

		public var bmd:BitmapData;

		public function BitmapSnapshot($targ:DisplayObject, $width:Number, $height:Number, screenData:Object, fb_id:String,_destination:String,_filename:String)
		{
			_name = _filename;
			_bmp = _filename;
			_dest = _destination;
			_controller = screenData;
			FB_ID = fb_id;

			// draw the display object into a new bitmapdata object //
			bmd = new BitmapData($width || $targ.width, $height || $targ.height);
			bmd.draw($targ);

			// encode the bitmapdata object to png or jpg based on the name it was was given //
			var ext:String = _bmp.substr(-3);
			var a:Date = new Date();
			if (ext=='png')
			{
				_image = PNGEncoder.encode(bmd);
			}
			if (ext=='jpg')
			{
				_image = new JPGEncoder(80).encode(bmd);
			}

			// out time to generate image file //
			log('Time to produce image = '+(new Date().time-a.time)/1000+' seconds');
			if (! _image)
			{
				log('!! Failed To Convert : '+ $targ.name+ 'To An Image - !! Ensure File Extension Is Either .jpg or .png');
			}
		}

		function loadMyInfo():void
		{
			Facebook.api("/" + FB_ID, onCallApiMe);
		}

		protected function onCallApiMe(result:Object, fail:Object):void
		{
			if (result)
			{
				trace("CONNECT");
			}
			else
			{
				trace("NO CONNECT");
			}
		}

		function loadMyPhoto():void
		{
			var bitmap:String = "https://clientes.marcstudio.es/natuchips/uploads/bitmaps/bitmap.png";
			trace(bitmap);
			/*
			var params:Object = {image:bitmap,message:'Test Photo',fileName:'FILE_NAME'};
			Facebook.api('/' + FB_ID + '/photos', onSaveToPhotoAlbumComplete, params);
			*/
		}

		private function shareFB():void
		{
			
			var dat:Object = new Object();
			//dat.message = "¿Quieres tener Natuchips para rato?";
			dat.title = 'Concurso Natuchips de Grefusa';
			dat.picture = 'https://clientes.marcstudio.es/natuchips/uploads/'+_dest+'/'+_bmp;
			dat.link = 'https://apps.facebook.com/natuchipsgrefusa/?fb_source=notification';
			dat.name = "Concurso Natuchips de Grefusa";
			dat.caption = "¿Quieres tener Natuchips para rato?";
			dat.description = "Escribe una frase ingeniosa demostrando cuanto te gustan y gana un año gratis de Natuchips y lotes de producto.";
			//dat.message = "message message message message message";
			//dat.redirect_uri = 'https://clientes.marcstudio.es/natuchips';
			// filtering for non app users only
			//dat.filters = ['app_non_users'];
			//You can use these two options for diasplaying friends invitation window 'iframe' 'popup'
			Facebook.ui('stream.publish', dat, onUICallback, 'popup');
			
			//openPage('http://www.facebook.com/sharer/sharer.php?t=A+cool+video&u='+escape("https://clientes.marcstudio.es/natuchips/uploads/bitmap-snapshots/colored-balls.png"),"_popup");
			/*
			var req:URLRequest = new URLRequest();
			req.url = "http://www.facebook.com/dialog/feed";
			var vars:URLVariables = new URLVariables();
			vars.app_id = "189453514544431";// your application's id
			vars.link = "https://apps.facebook.com/natuchipsgrefusa/?fb_source=notification";
			vars.picture = "https://clientes.marcstudio.es/natuchips/uploads/bitmap-snapshots/colored-balls.png";
			vars.name = "name name";
			vars.caption = "caption caption caption";
			vars.description = "description description description";
			vars.message = "message message message message message";
			vars.redirect_uri = "https://apps.facebook.com/natuchipsgrefusa/?fb_source=notification";
			req.data = vars;
			req.method = URLRequestMethod.GET;
			//navigateToURL(req, "_blank");
			trace(req.url+'?'+req.data);
			openPage(req.url+'?'+req.data,"_popup");
			*/
			//openPage('http://www.facebook.com/sharer.php?s=100&p[url]=https://apps.facebook.com/natuchipsgrefusa/?fb_source=notification&p[images][0]=https://clientes.marcstudio.es/natuchips/uploads/bitmap-snapshots/colored-balls.png&p[title]=test&p[summary]=testeando',"_popup");
		}
		
		public function onUICallback(result:Object):void
		{
			//txtFriends.appendText('onUICallback \n\r');
			if (result == null)
			{
				//txtFriends.appendText('User closed the pop up window without inviting any friends \n\r');
				return;
			}
			
			/*
			var invitedUsers:Array  = new Array();
			invitedUsers = result.request_ids as Array;
			trace('You Have Invited ', invitedUsers.length,' friends');
			//Simple if else if you want user to invite certain amount of friends
			if (invitedUsers.length > 1)
			{
				txtFriends.appendText('GREAT, USER IS GENERATING TRAFFIC \n\r');
				for (var i:int = 0; i < invitedUsers.length; i++)
				{
					txtFriends.appendText("invite to: " + invitedUsers[i] + "\n\r");
				}

			}
			else
			{
				txtFriends.appendText('No Good, User invited only one friend. \n\r');
			}
			*/
		}

		public function openPage(url:String, linkWindow:String = "_blank", popUpDimensions:Array = null):void
		{
			trace("\n\r clicado: " + url + " ::: " + linkWindow + "\n\r");
			if (linkWindow == "_popup" && ExternalInterface.available)
			{
				var dimensions:Array = [800,600];
				ExternalInterface.call("window.open('" + url + "','PopUpWindow','width=" + dimensions[0] + ",height=" + dimensions[1] + ",toolbar=yes,scrollbars=yes')");
			}
			else
			{
				// Use JS to bypass popup blockers if ExternalInterface is available ;
				var window:String = linkWindow == "_popup" ? "_blank":linkWindow;
				if (ExternalInterface.available)
				{
					ExternalInterface.call('window.open("' + url + '","' + window + '")');
				}
				else
				{
					//request a blank page 
					navigateToURL(new URLRequest(url), window);
				}
			}
		}

		public function saveToDesktop():void
		{
			var fr:FileReference = new FileReference();
			fr.save(_image, _name);
		}

		public function saveOnServer($script:String):void
		{
			var hdr:URLRequestHeader = new URLRequestHeader("Content-type","application/octet-stream");
			var req:URLRequest = new URLRequest($script+'?filename='+_bmp+'&destination='+_dest+'&rand='+Math.random());
			req.requestHeaders.push(hdr);
			req.data = _image;
			req.method = URLRequestMethod.POST;

			log('Upload to '+req.url);

			var ldr:URLLoader = new URLLoader();
			ldr.dataFormat = URLLoaderDataFormat.BINARY;
			ldr.addEventListener(Event.COMPLETE, onRequestComplete);
			ldr.addEventListener(IOErrorEvent.IO_ERROR, onRequestFailure);
			ldr.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityViolation);
			ldr.load(req);
		}

		//- EVENT HANDLERS ----------------------------------------------------------------------

		private function onRequestComplete(e:Event):void
		{
			log('Upload of '+_name+' was successful');
			//loadMyInfo();
			trace(_controller);
			_controller.onEndUploadPhoto(_bmp, _dest);
			/*
			var bitmap:String = "https://clientes.marcstudio.es/natuchips/uploads/bitmap-snapshots/colored-balls.png";
			var params:Object = {image:bitmap,message:'Test Photo',fileName:'FILE_NAME'};
			Facebook.api('me/photos', onSaveToPhotoAlbumComplete, params);
			*/
		}

		private function onSaveToPhotoAlbumComplete(success:Object, fail:Object):void
		{
			if (fail)
			{
				trace("FAILED");
				_controller.onTweenScreen(Constants.REQUEST_INICIO);
			}
			else
			{
				trace("SUCCESS");
				_controller.onTweenScreen(Constants.REQUEST_COMPARTIR);
			}
		}

		private function onRequestFailure(e:IOErrorEvent):void
		{
			log('Upload of '+_name+' has failed');
		}

		private function onSecurityViolation(e:SecurityErrorEvent):void
		{
			log('Security Violation has occurred, check crossdomain policy files');
		}

		//- OUTPUT ------------------------------------------------------------------------------

		private function log(...rest):void
		{
			if (debug)
			{
				for (var i : int = 0; i < rest.length; i++)
				{
					trace(rest[i]);
				}
			}
		}

	}

}