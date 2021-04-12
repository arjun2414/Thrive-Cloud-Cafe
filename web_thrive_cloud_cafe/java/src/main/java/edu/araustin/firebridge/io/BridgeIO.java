package edu.araustin.firebridge.io;

import com.google.common.base.Preconditions;
import com.google.firebase.internal.NonNull;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import edu.araustin.firebridge.packets.*;

import java.io.*;
import java.lang.ref.WeakReference;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.util.HashMap;
import java.util.Map;

public class BridgeIO extends Thread implements Communicator {

    private static final Gson JSON = new Gson();
    @Deprecated
    private static final Map<String, SessionProfile> SESSION_MAP = new HashMap<>();

    public static BridgeIO open(@NonNull BridgeListener listener) {
        Preconditions.checkArgument(listener != null, "Can not pass null listener.");
        BridgeIO io = new BridgeIO(listener);
        io.start();
        return io;
    }

    private final BridgeListener listener;
    private SessionProfile currentProfile;

    private PrintStream out;
    private BufferedReader in;

    private ServerSocket server;
    private Socket socket;

    private boolean cancelled = false;

    public BridgeIO(BridgeListener listener) {
        this.listener = listener;
        try {
            this.server = new ServerSocket(3556);
        } catch (IOException e) {
            e.printStackTrace();
        }
        reconnect();
    }

    private boolean reconnect() {
        try {
            socket = server.accept();
            if (socket == null)
                return false;
            out = new PrintStream(socket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void closeConnection() {
        sendData("\\q");
        close();
    }

    private void close() {
        try {
            socket.close();
            out.close();
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public SessionProfile getCurrentSession() {
        return currentProfile;
    }

    public static void sendData(String uid, Object data) {
        SessionProfile profile = SESSION_MAP.get(uid);
        if(profile == null)
            return;
        try {
            Socket socket = new Socket(profile.getAddress(), profile.getPort());
            OutputStream output = socket.getOutputStream();
            PrintWriter writer = new PrintWriter(output, true);
            if(data instanceof String) {
                writer.println(data);
            } else {
                writer.println(JSON.toJson(data));
            }
            System.out.println("#sendData to " + uid + " successful!");
        } catch(IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void sendData(Object data) {
        String output = "";

        if (data instanceof String) {
            output = (String) data;
        } else {
            output = JSON.toJson(data);
        }

        out.println(output);
        System.out.println(" > " + output);
    }

    private void handshake(HandshakePacket packet) {
        SessionProfile profile = SESSION_MAP.getOrDefault(packet.getUID(), null);
        if (profile == null) {
            profile = new SessionProfile(packet.getUID(), socket);
            SESSION_MAP.put(packet.getUID(), profile);
        }
        currentProfile = profile;
    }

    public void cancel() {
        this.cancelled = true;
    }

    public void run() {
        while (!cancelled) {
            long last = System.currentTimeMillis();
            outer:
            while (!socket.isClosed()) {
                try {
                    if (System.currentTimeMillis() - last > 1000 * 8) {
                        System.out.println("Connection timed out.");
                        break;
                    }
                    if (in.ready()) {
                        last = System.currentTimeMillis();
                        do {
                            String line = in.readLine();

                            System.out.println(line);
                            Packet packet = JSON.fromJson(line, Packet.class);

                            PacketAbstract pA = PacketDeserializer.getPacketObject(packet);
                            if (pA instanceof ClosePacket) {
                                ClosePacket closePacket = (ClosePacket) pA;
                                System.out.println("#close");
                                close();
                                if(closePacket.kill()) {
                                    SESSION_MAP.remove(currentProfile.getUID());
                                }
                                break outer;
                            }
                            else if (pA instanceof HandshakePacket) {
                                handshake((HandshakePacket) pA);
                                //sendData(currentProfile.getUID(),"Hello, World!");
                            } else {
                                listener.onReceiveInput(this, pA);
                            }
                        } while (!socket.isClosed() && in.ready());
                    }
                } catch (IOException | JsonSyntaxException e) {
                    if (e instanceof SocketException || e instanceof JsonSyntaxException) {
                        close();
                        break;
                    } else {
                        e.printStackTrace();
                    }
                }
            }
            System.out.println("Lost connection - waiting for reconnection..");
            while (!reconnect()) {
                try {
                    Thread.sleep(150);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}


