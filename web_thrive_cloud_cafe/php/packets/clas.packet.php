<?php

namespace Packet;

class Packet
{

    public $identifier;
    public $objects = array();

    function __construct($identifier, array $objects)
    {
        $this->identifier = $identifier;
        $this->objects = $objects;
    }

    function getId() {
        return $this->identifier;
    }

    function getObjects() {
        return $this->objects;
    }
}