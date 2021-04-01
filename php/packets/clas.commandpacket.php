<?php

namespace CommandPacket;

require_once "clas.packet.php";

use Packet\Packet;

class CommandPacket extends Packet
{

    function __construct(array $arguments)
    {
        parent::__construct("CommandPacket", array($arguments));
    }
}