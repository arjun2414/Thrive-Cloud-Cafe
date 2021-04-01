package edu.araustin.firebridge.packets;

import com.google.common.base.Preconditions;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

public class OrganizationPacket extends PacketAbstract {

    private String name;
    private String owner_uid;
    private String address;
    private String city;
    private String zip;
    private int capacity;
    private List<String> types;
    private boolean refrigeration;

    public OrganizationPacket(Object... objects) {
        Preconditions.checkArgument(objects.length == 8, "Invalid number of arguments provided.");
        this.name = (String) objects[0];
        this.owner_uid = (String) objects[1];
        this.address = (String) objects[2];
        this.city = (String) objects[3];
        this.zip = (String) objects[4];
        this.capacity = Integer.parseInt((String) objects[5]);
        this.types = (ArrayList<String>) objects[6];
        this.refrigeration = Boolean.parseBoolean((String) objects[7]);
    }

    public OrganizationPacket(String name, String owner_uid, String address, String city,  String zip, int capacity, String[] types, boolean refrigeration) {
        this.name = name;
        this.owner_uid = owner_uid;
        this.address = address;
        this.city = city;
        this.zip = zip;
        this.capacity = capacity;
        this.types = new ArrayList<>(Arrays.asList(types));
        this.refrigeration = refrigeration;
    }


    public String getOrganizationName() {
        return name;
    }

    public String getStreetAddress() {
        return address;
    }

    public String getCity() {
        return city;
    }

    public String getZip() {
        return zip;
    }

    public int getCapacity() {
        return capacity;
    }

    public Collection<String> getTypes() {
        return types;
    }

    public boolean hasRefrigeration() {
        return refrigeration;
    }

    public String getOwnerId() {
        return owner_uid;
    }

}
