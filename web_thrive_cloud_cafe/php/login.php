<?php

require_once "clas.firebridgedriver.php";
require_once "packets/clas.commandpacket.php";

use FirebridgeSocketDriver\FirebridgeSocketDriver;
use CommandPacket\CommandPacket;

session_start();

$email = $_POST['email'];
$user_id = $_POST['userid'];
$name = $_POST['displayname'];

$driver = new FirebridgeSocketDriver();

$packet = new CommandPacket(array("get_user", $user_id));
$driver->send($packet);

$out = $driver->waitForResponse();
$driver->close();

if(!isset($out) || empty($out) || $out === "null") {
    echo $out;
    return;
}

$_SESSION['user_id'] = $user_id;
$_SESSION['email'] = $email;
$_SESSION['displayname'] = $name;

$jsonObj = json_decode($out, true);

foreach($jsonObj as $key => $value) {
    if(empty($value)) {
        $_SESSION[$key] = null;
        continue;
    }
    $_SESSION[$key] = $value;
}

echo $out;
?>