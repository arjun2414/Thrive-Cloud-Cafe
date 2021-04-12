package edu.araustin.firebridge.packets;

import com.google.common.base.Preconditions;

public class ClosePacket extends PacketAbstract {

    private final boolean kill; // kill session?

    public ClosePacket(Object... objects) {
        Preconditions.checkArgument(objects.length == 1, "Invalid number of arguments provided.");
        this.kill = (boolean) objects[0];
    }

    public ClosePacket(boolean kill) {
        this.kill = kill;
    }

    public boolean kill() {
        return kill;
    }

}
