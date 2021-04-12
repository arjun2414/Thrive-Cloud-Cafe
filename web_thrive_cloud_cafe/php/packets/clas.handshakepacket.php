<?php

namespace HandshakePacket;

require_once "clas.packet.php";

use Packet\Packet;

class HandshakePacket extends Packet
{

    function __construct()
    {
        if(session_status() != PHP_SESSION_ACTIVE) {
            session_start();
        }
        parent::__construct("HandshakePacket", array($_SESSION["user_id"]));
    }
}