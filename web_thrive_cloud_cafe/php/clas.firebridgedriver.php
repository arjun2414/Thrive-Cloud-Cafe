<?php

namespace FirebridgeSocketDriver;

require_once "packets/clas.handshakepacket.php";
require_once "packets/clas.closepacket.php";

// prevent timeout
use HandshakePacket\HandshakePacket;
use ClosePacket\ClosePacket;

set_time_limit(0);

ob_implicit_flush();

class FirebridgeSocketDriver
{

    private static $ADDRESS = "127.0.0.1";
    private static $PORT = 3556;
    private static $TIMEOUT = 5000;

    private $socket;

    function __construct()
    {
        if (($this->socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP)) === false) {
            echo "socket_create() failed: reason: " . socket_strerror(socket_last_error()) . "\n";
        }

        if(socket_connect($this->socket, FirebridgeSocketDriver::$ADDRESS, FirebridgeSocketDriver::$PORT) === false) {
            echo "socket_connect() failed: reason: " . socket_strerror(socket_last_error()) . "\n";
        }

        $this->send(new HandshakePacket());
    }


    function send($packet) {
        $out = json_encode($packet) . "\n";
        socket_write($this->socket, $out, strlen($out));
    }

    function close() {
        $this->send(new ClosePacket(false));
        socket_shutdown($this->socket, 2);
        socket_close($this->socket);
    }

    function waitForResponseWithTimeout($timeout) {
        $marker = round(microtime(true) * 1000);
        while(true) {
            $curr_time = round(microtime(true) * 1000);
            if($curr_time - $marker > $timeout) {
                return "";
            }

            if (false === ($buf = socket_read($this->socket, 2048, PHP_NORMAL_READ))) {
                echo "socket_read() failed: reason: " . socket_strerror(socket_last_error($this->socket)) . "\n";
                break;
            }

            if (!$buf = trim($buf)) {
                continue;
            }

            if ($buf == '\q') {
                break;
            }

            return $buf;
        }
        return json_encode(null);
    }

    function waitForResponse() {
        return $this->waitForResponseWithTimeout(FirebridgeSocketDriver::$TIMEOUT);
    }
}