package edu.araustin.firebridge.packets;

public class PacketDeserializer {

    public static PacketAbstract getPacketObject(Packet data) {
        if(data.getId().equals(OrganizationPacket.class.getSimpleName())) {
            return new OrganizationPacket(data.getObjects());
        } else if(data.getId().equals(CommandPacket.class.getSimpleName())) {
            return new CommandPacket(data.getObjects());
        } else {
            return null;
        }
    }

}
