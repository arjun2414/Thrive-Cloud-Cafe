import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrive_cloud_cafe/colors.dart';
import 'package:thrive_cloud_cafe/components/food_Row.dart';
import 'package:thrive_cloud_cafe/models/organization_profile.dart';

class OrganizationTile extends StatelessWidget {
  final OrganizationProfile orgProfile;
  OrganizationTile({this.orgProfile});

  // Overflow color cannot be updated here, the tiles are just listeners

  Color getOverflowColor() {
    return orgProfile.getOverflowStatus() ? Colors.red : Colors.green;
  }

  Color getPercentColor(double status) {
    if (status < orgProfile.getStorageSpace() * 0.5) {
      return Colors.green;
    }

    if (status < orgProfile.getStorageSpace() * 0.75) {
      return Colors.orangeAccent;
    }

    if (status >= orgProfile.getStorageSpace() * 0.75) {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> foodTypes = orgProfile.getFoodTypes();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTileCard(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(5),
                height: 40,
                width: 40,
                color: getOverflowColor(),
                child: Text(
                  '!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            expandedTextColor: Colors.black,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${orgProfile.getDisplayName()}'),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.food_bank_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                    '${orgProfile.getStorageStatus()}/${orgProfile.getStorageSpace()}'),
              ],
            ),
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                    decoration: BoxDecoration(
                      color: tcc_color.TertiaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Clients served per day'),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
                    child: Text(': \t ${orgProfile.getClientsServed()}'),
                  )
                ],
              ),
              Container(
                height: 55.0 * foodTypes.length,
                child: new ListView.builder(
                    itemCount: foodTypes.length,
                    itemBuilder: (context, index) {
                      String key = foodTypes.keys.elementAt(index);
                      print('This is the key: $key');
                      return FoodRow(
                        foodName: key,
                        foodQuantity: foodTypes[key],
                      );
                    }),
              ),
            ]

//            <Widget>[
//              Row(
//                children: [
//                  Container(
//                    padding: EdgeInsets.all(8),
//                    margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
//                    decoration: BoxDecoration(
//                      color: tcc_color.SecondaryColor,
//                      borderRadius: BorderRadius.circular(20),
//                    ),
//                    child: Text('Burrito'),
//                  ),
//                  Container(
//                    padding: EdgeInsets.all(8),
//                    margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
//                    child: Text(': \t 20'),
//                  )
//                ],
//              ),
//              Row(
//                children: [
//                  Container(
//                      padding: EdgeInsets.all(8),
//                      margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
//                      decoration: BoxDecoration(
//                        color: tcc_color.SecondaryColor,
//                        borderRadius: BorderRadius.circular(20),
//                      ),
//                      child: Text('Sandwiches')),
//                  Container(
//                    padding: EdgeInsets.all(8),
//                    margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
//                    child: Text(': \t 20'),
//                  )
//                ],
//              ),
//              Row(
//                children: [
//                  Container(
//                      padding: EdgeInsets.all(8),
//                      margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
//                      decoration: BoxDecoration(
//                        color: tcc_color.SecondaryColor,
//                        borderRadius: BorderRadius.circular(20),
//                      ),
//                      child: Text('Pizza')),
//                  Container(
//                    padding: EdgeInsets.all(8),
//                    margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
//                    child: Text(': \t 20'),
//                  )
//                ],
//              ),
//            ]
            ));
  }
}
