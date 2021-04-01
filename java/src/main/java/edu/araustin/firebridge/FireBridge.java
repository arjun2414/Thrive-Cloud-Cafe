package edu.araustin.firebridge;

import com.google.api.core.ApiFuture;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.*;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;
import com.google.firebase.database.utilities.Pair;

import javax.annotation.Nullable;
import java.io.*;
import java.util.Collection;
import java.util.ConcurrentModificationException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

public class FireBridge {

    private static final String DATABASE_NAME = "dsc-hunger";
    private Firestore database;

    public FireBridge() {
        InputStream stream = FireBridge.class.getResourceAsStream("/accountKey.json");
        try {
            GoogleCredentials credentials = GoogleCredentials.fromStream(stream);

            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setStorageBucket(DATABASE_NAME + ".appspot.com")
                    .setProjectId(DATABASE_NAME)
                    .setCredentials(credentials)
                    .setDatabaseUrl("https://" + DATABASE_NAME + ".firebaseapp.com/")
                    .build();

            FirebaseApp.initializeApp(options);
            this.database = FirestoreClient.getFirestore();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public boolean updateFields(String collection, String key, Pair<String, Object>... pairs) {
        HashMap<String, Object> fields = new HashMap<>();
        for(Pair<String, Object> field : pairs) {
            fields.put(field.getFirst(), field.getSecond());
        }
        ApiFuture<WriteResult> task = database.collection(collection).document(key).update(fields);
        try {
            task.get();
            return true;
        } catch (InterruptedException | ExecutionException | ConcurrentModificationException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean setValue(String collection, String key, Object value) {
        ApiFuture<WriteResult> task = database.collection(collection).document(key). set(value);
        try {
            task.get();
            return true;
        } catch (InterruptedException | ExecutionException | ConcurrentModificationException e) {
            e.printStackTrace();
        }
        return false;
    }

    public DocumentSnapshot getDocument(String collection, String key) {
        ApiFuture<DocumentSnapshot> task = database.collection(collection).document(key).get();
        try {
            return task.get();
        } catch (InterruptedException | ExecutionException | ConcurrentModificationException e) {
            e.printStackTrace();
        }
        return null;
    }

    public <T> T getDocument(String collection, String key, String field, Class<T> type) {
        return getDocument(collection, key).get(field, type);
    }

    public WriteResult removeDocument(String collection, String key) {
        ApiFuture<WriteResult> task = database.collection(collection).document(key).delete();
        try {
            return task.get();
        } catch (InterruptedException | ExecutionException | ConcurrentModificationException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Collection<? extends DocumentSnapshot> getDocuments(String collection) {
        ApiFuture<QuerySnapshot> task = database.collection(collection).get();
        try {
            return task.get().getDocuments();
        } catch (InterruptedException | ExecutionException | ConcurrentModificationException e) {
            e.printStackTrace();
        }
        return null;
    }

}
