<?php
$lang = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
switch ($lang){
    case "es":
        //echo "PAGE FR";
        include("form_esp.php");//include check session FR
        break;
    case "en":
        //echo "PAGE EN";
        include("form_eng.php");
        break;        
    default:
        //echo "PAGE EN - Setting Default";
        include("form_esp.php");//include EN in all other cases of different lang detection
        break;
}
?>