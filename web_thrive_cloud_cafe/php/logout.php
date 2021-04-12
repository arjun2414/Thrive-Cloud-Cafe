<?php
require_once "clas.firebridgedriver.php";
require_once "packets/clas.closepacket.php";
require_once "clas.firelistener.php";

use ClosePacket\ClosePacket;
use FirebridgeSocketDriver\FirebridgeSocketDriver;
use FireListener\FireListener;

session_start();

$driver = new FirebridgeSocketDriver();
$driver->send(new ClosePacket(true));
$driver->close();

session_destroy();

echo json_encode(null);
?>