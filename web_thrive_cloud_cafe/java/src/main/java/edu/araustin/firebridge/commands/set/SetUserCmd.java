package edu.araustin.firebridge.commands.set;

import edu.araustin.firebridge.FireRunner;
import edu.araustin.firebridge.commands.CommandExecutor;
import edu.araustin.firebridge.user.PermissionLevel;
import edu.araustin.firebridge.user.User;

import java.util.Arrays;
import java.util.Locale;

public class SetUserCmd implements CommandExecutor {

    /**
     * Command Format: !user create
     *
     * @param args
     * @return
     */
    @Override
    public boolean onExecute(String[] args) {
        String prep = args[1];
        System.out.println("#onExecute" + Arrays.asList(args));
        if (prep.equals("create")) {
            String email = args[2];
            String uid = args[3];
            String permission = args[4];
            User user = new User(email, uid);
            user.setPermission(PermissionLevel.valueOf(permission.toUpperCase(Locale.ROOT)));
            return FireRunner.getBridge().setValue("users", uid, user);
        }
        return false;
    }
}
