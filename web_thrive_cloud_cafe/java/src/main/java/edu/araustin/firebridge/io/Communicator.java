package edu.araustin.firebridge.io;

public interface Communicator {

    void sendData(Object data);

    void closeConnection();

    SessionProfile getCurrentSession();

}
