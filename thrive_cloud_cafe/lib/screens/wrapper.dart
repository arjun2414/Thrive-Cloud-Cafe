import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrive_cloud_cafe/screens/authenticate/authenticate.dart';
import 'package:thrive_cloud_cafe/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null)
      return Authenticate();
    else
      return Home();
  }
}
