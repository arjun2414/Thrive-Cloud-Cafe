import 'package:flutter/material.dart';
import 'package:thrive_cloud_cafe/screens/home/current_status.dart';
import 'package:thrive_cloud_cafe/screens/home/fund_request.dart';

import '../../theme.dart';
import 'home.dart';

class HomeRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.originalTheme,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => Home(),
        '/status': (context) => CurrentStatus(),
        '/funds': (context) => FundRequest(),
      },
    );
  }
}
