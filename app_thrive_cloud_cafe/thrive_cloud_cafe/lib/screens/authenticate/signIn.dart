import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thrive_cloud_cafe/components/custom_form_button.dart';
import 'package:thrive_cloud_cafe/components/custom_suffix_icon.dart';
import 'package:thrive_cloud_cafe/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String emailId = '';
  String pwd = '';
  String error = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Thrive Cloud Cafe'),
            actions: <Widget>[
              TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    widget.toggleView();// widget here is the class SignIn
                  },
                  icon: Icon(Icons.person),
                  label: Text("Sign up")
              )
            ]
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      suffixIcon: CustomSuffixIcon(chosenIcon: Icons.mail_outline),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => emailId = val);
                    },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      suffixIcon: CustomSuffixIcon(chosenIcon: Icons.lock_outline),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    validator: (val) =>
                    val.length < 6
                        ? 'Enter a password 6 + characters long'
                        : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => pwd = val);
                    },
                  ),
                  SizedBox(height: 20.0,),
                  CustomFormButton(
                    label: "Sign In",
                    onPress: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.signInWithEmailAndPass(
                            emailId, pwd);
                        if (result == null)
                          setState(() =>
                          error = 'Email/Password is incorrect!');
                      }
                    },
                  ),
                  SizedBox(height: 12.0,),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ),
            )
        )
    );
  }
}



