import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrive_cloud_cafe/components/loading.dart';
import 'package:thrive_cloud_cafe/components/organization_tile.dart';
import 'package:thrive_cloud_cafe/models/user_profile.dart';
import 'package:thrive_cloud_cafe/screens/home/current_status.dart';
import 'package:thrive_cloud_cafe/screens/home/organization_list.dart';

import 'package:thrive_cloud_cafe/services/auth.dart';
import 'package:thrive_cloud_cafe/services/database_service.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = AuthService();

  UserProfile userProfile = UserProfile();

  String displayName = '';

  @override
  Widget build(BuildContext context) {
    // The current user accessing the app.
    final user = Provider.of<User>(context);

    return StreamBuilder<UserProfile>(
        stream: Database_Service(uid: user.uid).userProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userProfile = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: Text('Dashboard'),
              ),
              endDrawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                        child: Text(
                      'Hey ${userProfile.getDisplayName()} !' ?? '',
                      style: TextStyle(color: Colors.black),
                    )),
                    ListTile(
                      title: Text('Periodic Reports'),
                      onTap: () => {
                        Toast.show("Periodic Reports", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM),
//                        Navigator.push(context, route)
                      },
                    ),
                    ListTile(
                      title: Text('Today\'s status'),
                      onTap: () => {
                        Toast.show("Today\'s status", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM),
                        Navigator.pushNamed(context, '/status')
                      },
                    ),
                    ListTile(
                      title: Text('Fund Requests'),
                      onTap: () => {
                        Toast.show("Fund Requests", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM),
                        Navigator.pushNamed(context, '/funds')
                      },
                    ),
                    ListTile(
                      title: Text('Sign Out'),
                      onTap: () async {
                        await _auth.signOut();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              body: OrganizationList(),
            );
          } else {
            //TODO: Loading Page
            return Loading();
          }
        });
  }
}
