package edu.araustin.firebridge.packets;

import com.google.common.base.Preconditions;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CommandPacket extends PacketAbstract {

    private final List<String> arguments;

    public CommandPacket(Object... objects) {
        Preconditions.checkArgument(objects.length == 1, "Invalid number of arguments provided.");
        this.arguments = ((ArrayList<String>) objects[0]);
    }

    public CommandPacket(String... arguments) {
        this.arguments = new ArrayList<>(Arrays.asList(arguments));
    }

    public String[] getArguments() {
        return arguments.toArray(new String[0]);
    }

}
