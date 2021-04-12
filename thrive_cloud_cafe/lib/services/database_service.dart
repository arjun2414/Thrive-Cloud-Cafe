import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrive_cloud_cafe/models/organization_profile.dart';
import 'package:thrive_cloud_cafe/models/user_profile.dart';

class Database_Service {
  final String uid;

  Database_Service({this.uid});

  // Collection reference to the users.
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  // Collection reference to the organizations.
  final CollectionReference organizationCollection =
      FirebaseFirestore.instance.collection('orgs');

  // Converting the DocumentSnapshot ( snapshot of the document)
  // to a user profile.
  UserProfile _userProfileFromSnapshot(DocumentSnapshot snapshot) {
    return UserProfile(
        uid: uid,
        displayName: snapshot.get("displayName"),
        email: snapshot.get("email"));
  }

  // Converting the DocumentSnapshot ( snapshot of the document)
  // to an organization profile.
  OrganizationProfile _organizationFromSnapShot(DocumentSnapshot snapshot) {
    return OrganizationProfile.fromJson(snapshot.data());
//        displayName: snapshot.get('displayName'),
//        storageSpace: snapshot.get('storageSpace'),
//        overflowStatus: snapshot.get('overflowStatus'),
//        storageStatus: snapshot.get('storageStatus'),
//        foodTypes: (snapshot.get('foodTypes') as Map<String, Map<String, int>>),
//        clientsServed: snapshot.get('clientsServed'));
  }

  // Converting the QuerySnapshot ( snapshot of the entire Collection)
  // to a list of organization profiles.
  List<OrganizationProfile> _organizationListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
//      print(doc.get('foodTypes').toString());
      return OrganizationProfile.fromJson(doc.data());
//          displayName: doc.get('displayName'),
//          storageSpace: doc.get('storageSpace'),
//          overflowStatus: doc.get('overflowStatus'),
//          storageStatus: doc.get('storageStatus'),
//          foodTypes: doc.get('foodTypes'),
//          clientsServed: doc.get('clientsServed'));
    }).toList();
  }

  // Adding user profile to the Firestore collection for users.
  Future addUserData(
      UserProfile userProfile, OrganizationProfile organizationProfile) async {
    await userCollection.doc(uid).set(userProfile.toJson());
    return await organizationCollection
        .doc(uid)
        .set(organizationProfile.toJson());
  }

  Future addOrganizationData(OrganizationProfile organizationProfile) async {
    return await organizationCollection
        .doc(uid)
        .set(organizationProfile.toJson());
  }

  // Creates a stream for accessing the user data for a unique uid.
  Stream<UserProfile> get userProfile {
    return userCollection.doc(uid).snapshots().map((_userProfileFromSnapshot));
  }

  // Creates a stream for accessing the various organization profiles.
  Stream<List<OrganizationProfile>> get organizationProfiles {
    return organizationCollection
        .snapshots()
        .map((_organizationListFromSnapshot));
  }

  // Creates a stream for accessing the organization data for a unique uid.
  Stream<OrganizationProfile> get organizationProfile {
    return organizationCollection
        .doc(uid)
        .snapshots()
        .map((_organizationFromSnapShot));
  }
}
