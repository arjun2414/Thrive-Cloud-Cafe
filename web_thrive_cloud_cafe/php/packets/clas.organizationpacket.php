<?php

namespace OrganizationPacket;

require_once "clas.packet.php";

use Packet\Packet;

class OrganizationPacket extends Packet
{

    function __construct($name, $user_id, $address, $city, $zip, $capacity, array $types, $refrigeration)
    {
        parent::__construct("OrganizationPacket", array($name, $user_id, $address, $city, $zip, $capacity, $types, $refrigeration));
    }
}