package edu.araustin.firebridge.commands.verify;

import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.database.utilities.Pair;
import com.google.firestore.v1.Write;
import edu.araustin.firebridge.FireRunner;
import edu.araustin.firebridge.commands.CommandExecutor;
import edu.araustin.firebridge.packets.OrganizationPacket;

import java.util.Map;

public class VerifyCmd implements CommandExecutor {

    @Override
    public boolean onExecute(String[] args) {
        if (args[1].equals("organization")) {
            String org_name = args[3];
            if (args[2].equals("accept")) {
                Map<String, Object> data = FireRunner.getBridge().getDocument("pending organizations", org_name).getData();
                WriteResult result = FireRunner.getBridge().removeDocument("pending organizations", org_name);
                if(data == null) {
                    return false;
                }

                FireRunner.getBridge().setValue("organizations", org_name, data);
                FireRunner.getBridge().updateFields("users", (String) data.get("ownerId"), new Pair<>("organization", org_name));
                FireRunner.getCommunication().sendData(org_name);
            } else if (args[2].equals("reject")) {
                WriteResult result = FireRunner.getBridge().removeDocument("pending organizations", org_name);
            }
        }
        return false;
    }
}
