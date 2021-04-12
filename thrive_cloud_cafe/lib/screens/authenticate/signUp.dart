import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:thrive_cloud_cafe/components/custom_form_button.dart';
import 'package:thrive_cloud_cafe/components/custom_suffix_icon.dart';
import 'package:thrive_cloud_cafe/services/auth.dart';
import 'dart:convert';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String emailId = '';
  String displayName = '';
  int storageSpace = 0;
  List<String> foodTypes;
  String userType = '';
  String pwd = '';
  String error = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Thrive Cloud Cafe'), actions: <Widget>[
          TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Sign In"))
        ]),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey, // for validation, keep track of the form's state
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      suffixIcon:
                          CustomSuffixIcon(chosenIcon: Icons.mail_outline),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => emailId = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your display name',
                      labelText: 'Username',
                      suffixIcon: CustomSuffixIcon(chosenIcon: Icons.person),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    validator: (val) => val.isEmpty ? 'Enter a username' : null,
                    onChanged: (val) {
                      setState(() => displayName = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter the storage space',
                      labelText: 'Storage Space',
                      suffixIcon:
                          CustomSuffixIcon(chosenIcon: Icons.work_outline),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    validator: (val) => val.isEmpty
                        ? 'Enter storage space in your organization'
                        : null,
                    onChanged: (val) {
                      setState(() => storageSpace = int.parse(val));
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFieldTags(
                      textFieldStyler: TextFieldStyler(
                          hintText: 'Enter Tags', helperText: 'More Tags?'),
                      tagsStyler: TagsStyler(),
                      onTag: (tag) {
                        print('The tag that was entered: ' + tag);
                        foodTypes.add(tag);
                      },
                      onDelete: (tag) {
                        print('The tag that was deleted' + tag);
                        foodTypes.remove(tag);
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      suffixIcon:
                          CustomSuffixIcon(chosenIcon: Icons.lock_outline),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    validator: (val) => val.length < 6
                        ? 'Enter a password 6 + characters long'
                        : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => pwd = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomFormButton(
                    label: "Sign up",
                    onPress: () async {
                      // valid form
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.signUpWithEmailAndPass(
                            emailId, pwd, displayName, storageSpace, foodTypes);
                        if (result == null)
                          setState(
                              () => error = 'Please provide a valid email!');
                      }
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ),
            )));
  }
}

//await and state
