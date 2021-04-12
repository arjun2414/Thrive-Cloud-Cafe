package edu.araustin.firebridge.io;

import java.net.InetAddress;
import java.net.Socket;

public class SessionProfile {

    private final String uid;
    private final InetAddress addr;
    private final int port;

    public SessionProfile(String uid, Socket socket) {
        this.uid = uid;
        addr = socket.getInetAddress();
        port = 3557;
    }

    public String getUID() {
        return uid;
    }

    public InetAddress getAddress() {
        return addr;
    }

    public int getPort() {
        return port;
    }

}
