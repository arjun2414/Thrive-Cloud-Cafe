<?php

require_once "clas.firebridgedriver.php";
require_once "packets/clas.sessionpacket.php";

use FirebridgeSocketDriver\FirebridgeSocketDriver;
use \SessionPacket\SessionPacket;

session_start();

$update = $_POST["update"];
$field = $_POST["types"];

$out = array();

if ($update) {
    $driver = new FirebridgeSocketDriver();
    $driver->send(new SessionPacket());
    $response = $driver->waitForResponse();

    $json_resp = json_decode($response, true);

    $_SESSION["permission"] = $json_resp["level"];
    if(isset($json_resp["organization"])) {
        $_SESSION["organization"] = $json_resp["organization"];
    } else {
        $_SESSION["organization"] = null;
    }
}

foreach ($field as $f) {
    $r = null;
    if (isset($_SESSION[$f])) {
        $r = $_SESSION[$f];
    }
    $out[$f] = $r;
}

echo json_encode($out);

?>