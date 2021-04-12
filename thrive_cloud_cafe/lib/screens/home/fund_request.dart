// import 'package:dsc_solution/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:thrive_cloud_cafe/theme.dart';

class FundRequest extends StatefulWidget {
  @override
  _FundRequestState createState() => _FundRequestState();
}

class _FundRequestState extends State<FundRequest> {
  double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Fund Requests",
            // style: TextStyle(
            //   fontSize: 30.0,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
          // centerTitle: false,
        ),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            child: Table(
              border: TableBorder(
                  horizontalInside: BorderSide(
                      width: 1, color: Colors.white, style: BorderStyle.solid)),
              columnWidths: {
                0: FractionColumnWidth(.5),
                1: FractionColumnWidth(.2),
                2: FractionColumnWidth(.3)
              },
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Available funds',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Deadline',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Emphasis Area Program',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.cloud_download_outlined,
                      size: iconSize,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'May 30, 2021',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Community Food Projects',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.cloud_download_outlined,
                      size: iconSize,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'June 30, 2021',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ])));
  }
}
