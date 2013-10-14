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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" xml:lang="es">
	<head>
		<title>Hello, Doctor</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
		<style>
			.alineador {
				position:relative;
				text-align:center;
			}
			.alineador img {
			
			}
			.alineador form,.alineador input {
				
				border: 0!important;
				border-shadow: none!important;
			}
.alineador form {
top: 429px;
position: relative;
margin-left: 252px;
margin-top: -29px;
}
			.alineador input {

			}
			.inputA {
height: 66px;
font-size: 47px;
font-family: arial,futura;
font-weight: bold;
color: #686868;
padding: 0 10px;
text-align: center;
width: 192px;
border-radius:6px;
			}
.boton {
width: 125px;
height: 50px;
font-weight: bold;
text-transform: uppercase;
font-family: arial,futura,helvetica;
font-size: 25px;
margin-top: 7px;
background-color: #e46767;
color: white;
border-radius: 6px;
cursor:pointer;
}
		</style>
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