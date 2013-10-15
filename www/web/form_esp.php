<?php
	$pass = $_POST['pass'];
	if($pass == "12345") 
	{
		include("babylove_esp.html");
	}
	else
	{
		if(isset($_POST))
		{
?>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
  <head>
    <!-- App info -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Hello, Doctor!</title>
    <meta name="description" content="Hello, Doctor | Baby Love | ToyShock | Official Game">
    <link rel="canonical" href=" http://www.toyshock.com/" />
    <meta name="keywords" content="Hello Doctor, Games, Tablet, Augmented reality" />
    <meta name="author" content="bueninvento.es" />
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
    <META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">

    <!-- Iconos -->
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
    
    <!-- Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style_esp.css">

  </head>
	<body>
		<div class="alineador">
			<form method="POST" action="index.php">
				<input type="text" name="pass" class="inputA"></input><br/>
				<input type="submit" name="submit" value="Go" class="boton"></input>
			</form>
			<img src="img/tarjeta_esp.png">
		</div>
	</body>
</html>
<?
		}
	}
?>