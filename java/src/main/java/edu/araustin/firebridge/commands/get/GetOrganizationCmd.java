package edu.araustin.firebridge.commands.get;

import com.google.cloud.firestore.DocumentSnapshot;
import com.google.gson.Gson;
import edu.araustin.firebridge.FireRunner;
import edu.araustin.firebridge.commands.CommandExecutor;

import java.util.*;

public class GetOrganizationCmd implements CommandExecutor {

    /**
     * Command Format: !user create
     *
     * @param args
     * @return
     */
    @Override
    public boolean onExecute(String[] args) {
        String prep = args[1];

        if(prep.equals("get")) {
            String uid = args[2];
            DocumentSnapshot snapshot = FireRunner.getBridge().getDocument("organizations", uid);
            if (snapshot == null) {
                System.out.println("Failed to return data for uid: " + uid);
                FireRunner.getCommunication().sendData("\\0");
                return false;
            }

            FireRunner.getCommunication().sendData(snapshot.getData());
            return true;
        } else if(prep.equals("collect")) {
            List<Map<String, Object>> components = new ArrayList<>();

            Collection<? extends DocumentSnapshot> documents = FireRunner.getBridge().getDocuments("organizations");

            for(DocumentSnapshot document : documents) {
                components.add(document.getData());
            }

            FireRunner.getCommunication().sendData(components);
            return true;
        }
        return false;
    }

}
