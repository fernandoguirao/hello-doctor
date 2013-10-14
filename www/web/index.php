<?php
$pass = $_POST['pass'];

if($pass == "admin")
{
        include("index.html");
}
else
{
    if(isset($_POST))
    {?>

            <form method="POST" action="secure.php">
            <input type="password" name="pass"></input><br/>
            <input type="submit" name="submit" value="Go"></input>
            </form>
    <?}
}
?>