package edu.araustin.firebridge.commands;

public class Command {

    private final String alias;
    private CommandExecutor executor;

    public Command(String alias) {
        this.alias = alias;
    }

    public String getAlias() {
        return alias;
    }

    public void setExecutor(CommandExecutor executor) {
        this.executor = executor;
    }

    public boolean isExecutable() {
        return this.executor != null;
    }

    public boolean execute(String[] arguments) {
        if (!isExecutable())
            return false;
        return executor.onExecute(arguments);
    }

}
