<?php
require_once "clas.firelistener.php";

use FireListener\FireListener;

//session_start();

//if (!isset($_SESSION["listener"])) {
$listener = new FireListener();
//$_SESSION["listener"] = $listener;
//session_write_close();
$listener->start();
//}
?>