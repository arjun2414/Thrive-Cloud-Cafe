package edu.araustin.firebridge.packets;

import com.google.common.base.Preconditions;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

public class SessionPacket extends PacketAbstract {

    public SessionPacket(Object... objects) {
        Preconditions.checkArgument(objects.length == 0, "Invalid number of arguments provided.");
    }

    public SessionPacket() {
    }

}
