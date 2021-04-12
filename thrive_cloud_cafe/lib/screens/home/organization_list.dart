import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrive_cloud_cafe/components/organization_tile.dart';
import 'package:thrive_cloud_cafe/models/organization_profile.dart';
import 'package:thrive_cloud_cafe/services/database_service.dart';

class OrganizationList extends StatefulWidget {
  @override
  _OrganizationListState createState() => _OrganizationListState();
}

class _OrganizationListState extends State<OrganizationList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OrganizationProfile>>(
        stream: Database_Service().organizationProfiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final organization = snapshot.data;
            print(
                'The length of the organization collection is ${organization.length}');
            return ListView.builder(
              itemCount: organization.length,
              itemBuilder: (context, index) {
                return OrganizationTile(orgProfile: organization[index]);
              },
            );
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Organization List: Database snapshot has error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Organization List: Loading');
          }

          return Text('Organization List: Loading');
        });
  }
}
