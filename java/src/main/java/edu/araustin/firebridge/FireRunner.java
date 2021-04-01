package edu.araustin.firebridge;

import edu.araustin.firebridge.commands.CommandManager;
import edu.araustin.firebridge.commands.get.GetOrganizationCmd;
import edu.araustin.firebridge.commands.get.GetUserCmd;
import edu.araustin.firebridge.commands.set.SetUserCmd;
import edu.araustin.firebridge.commands.verify.VerifyCmd;
import edu.araustin.firebridge.io.Communicator;
import edu.araustin.firebridge.io.RequestHandler;

public class FireRunner {

    private static CommandManager manager;
    private static FireBridge firebridge;
    private static RequestHandler handler;

    public static void main(String[] args) {
        firebridge = new FireBridge();
        manager = new CommandManager();
        manager.getCommand("set_user").setExecutor(new SetUserCmd());
        manager.getCommand("get_user").setExecutor(new GetUserCmd());

        manager.getCommand("get_organization").setExecutor(new GetOrganizationCmd());

        manager.getCommand("verify").setExecutor(new VerifyCmd());

        handler = new RequestHandler(manager);
    }

    public static FireBridge getBridge() {
        return firebridge;
    }

    public static Communicator getCommunication() {
        return handler.getCommunicator();
    }

}
