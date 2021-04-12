<?php

namespace ClosePacket;

require_once "clas.packet.php";

use Packet\Packet;

class ClosePacket extends Packet
{

    function __construct($kill)
    {
        parent::__construct("ClosePacket", array($kill));
    }

}