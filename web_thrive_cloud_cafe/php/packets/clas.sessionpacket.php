<?php

namespace SessionPacket;

require_once "clas.packet.php";

use Packet\Packet;

class SessionPacket extends Packet
{

    function __construct()
    {
        parent::__construct("SessionPacket", array());
    }

}