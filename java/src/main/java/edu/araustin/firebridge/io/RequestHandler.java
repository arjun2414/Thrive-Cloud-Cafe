package edu.araustin.firebridge.io;

import com.google.firebase.database.utilities.Pair;
import edu.araustin.firebridge.FireBridge;
import edu.araustin.firebridge.FireRunner;
import edu.araustin.firebridge.commands.CommandManager;
import edu.araustin.firebridge.packets.CommandPacket;
import edu.araustin.firebridge.packets.OrganizationPacket;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class RequestHandler {

    private final Communicator communicator;
    private final CommandManager manager;

    public RequestHandler(CommandManager manager) {
        this.manager = manager;
        this.communicator = BridgeIO.open((communicator, input) -> {
            if (input instanceof CommandPacket) {
                handleCommand((CommandPacket) input);
            } else if (input instanceof OrganizationPacket) {
                handleOrganization((OrganizationPacket) input);
            }
        });
    }

    private void handleOrganization(OrganizationPacket packet) {
        System.out.println("#handleOrganization");
        FireRunner.getBridge().setValue("pending organizations", packet.getOrganizationName(), packet);
        communicator.closeConnection();
    }

    private void handleCommand(CommandPacket packet) {
        System.out.println("#handleCommand");
        if (packet == null || packet.getArguments() == null || packet.getArguments().length == 0) {
            System.out.println("Packet error!");
            communicator.closeConnection();
            return;
        }
        String[] args = packet.getArguments();
        System.out.println(Arrays.asList(packet.getArguments()));
        manager.execute(args);
        communicator.closeConnection();
    }

    public Communicator getCommunicator() {
        return communicator;
    }

}
