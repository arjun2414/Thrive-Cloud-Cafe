import 'package:firebase_auth/firebase_auth.dart';
import 'package:thrive_cloud_cafe/models/organization_profile.dart';
import 'package:thrive_cloud_cafe/models/user_profile.dart';

import 'package:thrive_cloud_cafe/services/database_service.dart';

class AuthService {
  // private member
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  // returns users on authentication changes
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  // Sign in anon
  Future<User> signInAnon() async {
    try {
      // Get user creds
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in email & pass
  Future<User> signInWithEmailAndPass(email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register in email & pass
  Future<User> signUpWithEmailAndPass(
      email, password, name, storageSpace, foodTypes) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      UserProfile userProfile = UserProfile(
        email: email,
        displayName: name,
        uid: user.uid,
      );

      Map<String, Map<String, int>> foodTypesMap = {};
      if (foodTypes != null) {
        foodTypes.forEach((foodType) => foodTypesMap[foodType] = {});
      }

      // Field for foodItems removed.
      OrganizationProfile organizationProfile =
          OrganizationProfile(displayName: name, storageSpace: storageSpace);

      await Database_Service(uid: user.uid)
          .addUserData(userProfile, organizationProfile);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
