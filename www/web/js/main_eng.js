			<!-- Adobe recomienda a los desarrolladores utilizar SWFObject2 para la detección de Flash Player. -->
			<!-- Para obtener más información, consulte la página del objeto SWFObject en Google Code (http://code.google.com/p/swfobject/). -->
			<!-- Esta información también está disponible en Adobe Developer Connection en "Detección de versiones de Flash Player e incorporación de archivos SWF con SWFObject 2" Detecting Flash Player versions and embedding SWF files with SWFObject 2" -->
			<!-- Establézcalo en la versión mínima requerida de Flash Player o en 0 si no quiere activar la detección de la versión -->
			var swfVersionStr = "11.4.0";
			<!-- xiSwfUrlStr se puede utilizar para definir un archivo SWF de instalación rápida. -->
			var xiSwfUrlStr = "";
			var flashvars = {};
			var params = {};
			params.quality = "high";
			params.bgcolor = "#ffffff";
			params.play = "true";
			params.loop = "false";
			params.wmode = "window";
			params.scale = "showall";
			params.menu = "false";
			params.devicefont = "false";
			params.salign = "";
			params.allowscriptaccess = "always";
			params.allowFullScreen = "true";
			var attributes = {};
			attributes.id = "main";
			attributes.name = "main";
			attributes.align = "middle";
			swfobject.createCSS("html", "height:100%; background-color: #ffffff;");
			swfobject.createCSS("body", "margin:0; padding:0; overflow:hidden;");
			swfobject.embedSWF(
				"swf/main_eng.swf", "flashContent",
				"922", "690",
				swfVersionStr, xiSwfUrlStr,
				flashvars, params, attributes);