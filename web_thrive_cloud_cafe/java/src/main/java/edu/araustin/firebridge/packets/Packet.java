package edu.araustin.firebridge.packets;

public class Packet extends PacketAbstract {

    private final String identifier;
    private final Object[] objects;

    public Packet(String identifier, Object... objects) {
        this.identifier = identifier;
        this.objects = objects;
    }

    public String getId() {
        return identifier;
    }

    public Object[] getObjects() {
        return objects;
    }

}
