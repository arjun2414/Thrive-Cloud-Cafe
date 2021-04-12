import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thrive_cloud_cafe/components/custom_text_field.dart';
import 'package:thrive_cloud_cafe/models/organization_profile.dart';
import 'package:thrive_cloud_cafe/services/database_service.dart';

class CurrentStatus extends StatefulWidget {
  @override
  _CurrentStatusState createState() => _CurrentStatusState();
}

class _CurrentStatusState extends State<CurrentStatus> {
  TextEditingController _clientsServed, _foodQuantity;
  String foodTypeSelected;
  FoodItem foodItemSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodQuantity = TextEditingController(text: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _clientsServed.dispose();
    _foodQuantity.dispose();
    super.dispose();
    print('disposed');
  }

  @override
  Widget build(BuildContext context) {
    // The current user accessing the app.
    final user = Provider.of<User>(context);
    Database_Service _db = Database_Service(uid: user.uid);

    return StreamBuilder<OrganizationProfile>(
        stream: Database_Service(uid: user.uid).organizationProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final organization = snapshot.data;
            _clientsServed = new TextEditingController(
                text: '${organization.getClientsServed()}');
            return Scaffold(
              appBar: AppBar(
                title: Text('Today\'s List'),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 10, 0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Storage Status',
                          style: statusTextStyle(true),
                        ),
                        Expanded(
                            child: Text(
                                '${organization.getStorageStatus()} / ${organization.getStorageSpace()}',
                                textAlign: TextAlign.right,
                                style: statusTextStyle(false)))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: DropdownButton<String>(
                            hint: Text('Food Type'),
                            value: foodTypeSelected != null
                                ? foodTypeSelected
                                : null,
                            items:
                                organization.getFoodTypes().map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                foodTypeSelected = newValue;
                                print(newValue);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: DropdownButton(
                            hint: Text('Food Item'),
                            value: foodItemSelected != null
                                ? foodItemSelected
                                : null,
                            items: organization
                                .getFoodItemsWithKey(foodTypeSelected)
                                .map((item) {
                              return new DropdownMenuItem(
                                value: item,
                                child: new Text(item.name),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                foodItemSelected = newValue;
                                _foodQuantity = new TextEditingController(
                                    text: '${foodItemSelected.quantity}');
                                print(newValue);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: <Widget>[
                      Spacer(
                        flex: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          controller: _foodQuantity,
                          onSubmit: (value) async {
                            if (value != null) {
                              foodItemSelected.quantity = int.parse(value);
                              organization.updateFoodItem(foodItemSelected);
                              await _db.addOrganizationData(organization);
                              print(value);
                            }
                          },
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              'Clients served per week ',
                              style: statusTextStyle(true),
                            )),
                        Expanded(
                            flex: 1,
                            child: CustomTextField(
                              controller: _clientsServed,
                              onSubmit: (value) async {
                                organization.setClientsServed(value);
                                await _db.addOrganizationData(organization);
                                print(value);
                              },
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Database snapshot has error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }

          return Text('Loading');
        });
  }

  TextStyle statusTextStyle(bool label) {
    return TextStyle(
      fontSize: 18.0,
      color: label == false ? Colors.black : Colors.white,
    );
  }
}
