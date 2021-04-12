<?php

namespace FireListener;

set_time_limit(0);

/**
 * TODO: Remove this (PhP does not support asynchronous listeners)
 * Class FireListener
 * @package FireListener
 */
class FireListener
{
    private static $ADDRESS = "127.0.0.1";
    private static $PORT = 3557;

    private $socket;
    private $cancelled = false;

    function __construct()
    {
        if (($this->socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP)) === false) {
            echo "socket_create() failed: reason: " . socket_strerror(socket_last_error()) . "\n";
        }

        if ((socket_bind($this->socket, FireListener::$ADDRESS, FireListener::$PORT)) === false) {
            echo "socket_bind() failed: reason: " . socket_strerror(socket_last_error()) . "\n";
        }

        if (socket_listen($this->socket, SOCK_STREAM) == false) {
            echo "socket_listen() failed: reason: " . socket_strerror(socket_last_error()) . "\n";
        }
    }

    function start()
    {
        while (!$this->cancelled) {
            $client = socket_accept($this->socket);
            $input = socket_read($client, 2024);
            echo json_encode($input);
        }
    }

    function close()
    {
        $this->cancelled = true;
        socket_close($this->socket);
    }
}

?>