package edu.araustin.firebridge.commands;

import edu.araustin.firebridge.FireRunner;

import java.util.*;

public class CommandManager {

    private final Map<String, Command> commandMap = new HashMap<>();

    public CommandManager() {
    }

    public Command getCommand(String alias) {
        Command command = null;
        if (!commandMap.containsKey(alias)) {
            command = new Command(alias);
            commandMap.put(alias, command);
        } else {
            command = commandMap.get(alias);
        }
        return command;
    }

    public void execute(String[] arguments) {
        Command c = commandMap.get(arguments[0]);
        if (c == null) {
            System.out.println("Command is null");
            return;
        }
        boolean response = c.execute(arguments); //TODO Handle bool results (send error report back)
        if(!response) {
            FireRunner.getCommunication().sendData(null);
        }
    }

}
