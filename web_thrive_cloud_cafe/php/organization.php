<?php

require_once "clas.firebridgedriver.php";
require_once "packets/clas.commandpacket.php";
require_once "packets/clas.organizationpacket.php";

use FirebridgeSocketDriver\FirebridgeSocketDriver;
use CommandPacket\CommandPacket;
use OrganizationPacket\OrganizationPacket;

session_start();
$driver = new FirebridgeSocketDriver();

if (array_key_exists("prep", $_POST)) {
    $prep = $_POST["prep"];
    if ($prep === "collect") {
        $packet = new CommandPacket(array("get_organization", $prep));
        $driver->send($packet);

        $out = $driver->waitForResponse();
        $driver->close();
        echo $out;
    } elseif ($prep === "get") {
        $packet = new CommandPacket(array("get_organization", $prep, $_SESSION["organization"]));
        $driver->send($packet);

        $out = $driver->waitForResponse();
        $driver->close();
        echo $out;
    } elseif ($prep === "register") {
        $packet = new OrganizationPacket($_POST["name"], $_SESSION["user_id"], $_POST["address"], $_POST["city"], $_POST["zip"], $_POST["capacity"], $_POST["types"], $_POST["refrigeration"]);
        $driver->send($packet);

        $_SESSION["organization"] = "pending"; // this is only temporary (for demonstration purposes) 

        $out = $driver->waitForResponse();
        if ($out == null) {
            echo json_encode($out);
            return;
        }
        $driver->close();
        echo $out;
    }
} elseif (array_key_exists("prep", $_GET)) {
    $secret = "304rI@veR-.1991B#!#$.";
    $prep = $_GET['prep'];
    $organization = $_GET["organization"];
    $hash = $_GET["hash"];
    if (md5($organization.$secret) == $hash) {
        if ($prep === "accept") {
            $packet = new CommandPacket(array("verify", "organization", "accept", $organization));
            $driver->send($packet);
            $out = $driver->waitForResponse();
            $driver->close();
            echo json_encode($out);
        }
        elseif ($prep === "reject") {
            $packet = new CommandPacket(array("verify", "organization", "reject", $organization));
            $driver->send($packet);
            $out = $driver->waitForResponse();
            $driver->close();
            echo json_encode($out);
        }
    } else {
        echo json_encode(null);
    }

}



?>