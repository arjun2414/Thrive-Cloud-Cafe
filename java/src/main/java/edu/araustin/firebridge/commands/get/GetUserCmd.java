package edu.araustin.firebridge.commands.get;

import com.google.cloud.firestore.DocumentSnapshot;
import edu.araustin.firebridge.FireRunner;
import edu.araustin.firebridge.commands.CommandExecutor;

import java.util.Map;

public class GetUserCmd implements CommandExecutor {

    /**
     * Command Format: !user create
     *
     * @param args
     * @return
     */
    @Override
    public boolean onExecute(String[] args) {
        String uid = args[1];
        DocumentSnapshot snapshot = FireRunner.getBridge().getDocument("users", uid);
        if (snapshot == null) {
            System.out.println("Failed to return data for uid: " + uid);
            FireRunner.getCommunication().sendData("\\0");
            return false;
        }

        if (args.length == 2) {
            FireRunner.getCommunication().sendData(snapshot.getData());
            return true;
        }

        String field = args[2];
        FireRunner.getCommunication().sendData(snapshot.get(field));
        return true;
    }

}
