package edu.araustin.firebridge.io;

import edu.araustin.firebridge.packets.PacketAbstract;

public interface BridgeListener {

    void onReceiveInput(Communicator communicator, PacketAbstract packet);

}
