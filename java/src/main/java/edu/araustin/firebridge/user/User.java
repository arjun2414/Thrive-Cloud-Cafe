package edu.araustin.firebridge.user;

import java.util.UUID;

public class User {

    private final String email;
    private final String id;
    private String organization;
    private PermissionLevel level;

    public User(String email, String id) {
        this.email = email;
        this.id = id;
        this.level = PermissionLevel.USER;
    }

    public void setOrganization(String name) {
        this.organization = name;
    }

    /**
     * Get associated organization that user is in
     * @return Organization name
     */
    public String getOrganization() {
        return organization;
    }

    public void setPermission(PermissionLevel level) {
        this.level = level;
    }

    public PermissionLevel getLevel() {
        return level;
    }

    public String getEmail() {
        return email;
    }


    public String getUserId() {
        return id;
    }

}
