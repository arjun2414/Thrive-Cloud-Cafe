package edu.araustin.firebridge.packets;

import com.google.common.base.Preconditions;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class HandshakePacket extends PacketAbstract {

    private final String uid;

    public HandshakePacket(Object... objects) {
        Preconditions.checkArgument(objects.length == 1, "Invalid number of arguments provided.");
        this.uid = (String) objects[0];
    }

    public HandshakePacket(String uid) {
        this.uid = uid;
    }

    public String getUID() {
        return uid;
    }

}
