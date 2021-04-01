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
$packet = new CommandPacket(array("set_user", "create", $email, $user_id, "user"));

$_SESSION["user_id"] = $user_id;
$_SESSION["email"] = $email;
$_SESSION['displayname'] = $name;
$_SESSION["organization"] = null;

$driver->send($packet);
$driver->close();

echo json_encode("");
?>