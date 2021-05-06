import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngtapp/constants.dart';
import 'package:ngtapp/screens/bottomTab/bottomTabScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';
import 'package:imei_plugin/imei_plugin.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  //attribut to keep the user connected
  bool remember = false;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  dynamic androidVersion;
  dynamic deviceImei;
  String errorMsg;

  var _isLoading = false;

  TextEditingController unController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  //Function to get the OS version
  Future<void> initAndroidVersion() async {
    //Initialize Android Device Info
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    setState(() {
      androidVersion = androidInfo.version.release.toString();
      print('Running on ${androidInfo.version.release}');
    });
  }

  //Function to get the IMEI
  Future<void> getDeviceImei() async {
    var redux = androidVersion.split(".");
    //Initialize IMEI Function
    if (double.parse(redux[0]) >= 10) {
      deviceImei = await ImeiPlugin.getId();
      print("imei = $deviceImei");
    } else {
      deviceImei = await ImeiPlugin.getImei();
      print("imei = $deviceImei");
    }
    // List<String> multiImei =
    //     await ImeiPlugin.getImeiMulti(); //for double-triple SIM phones
  }

  //SIGN IN FUNCTION
  Future<dynamic> signIn(username, pass, odversion, imei) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'uid': username,
      'pwd': pass,
      'android_ver': odversion,
      'phone_id': imei,
    };
    var jsonResponse;
    var url = Uri.parse(SIGN_IN_URL);
    var response = await http.post(url, body: jsonEncode(data));
    dynamic valret;
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("json = $jsonResponse");
      print("statut = ${jsonResponse['status']}");
      if (int.parse(jsonResponse['status']) == 1) {
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("uid", username);
        setState(() {
          valret = true;
        });
      } else {
        print("connection échoué");
        setState(() {
          valret = false;
        });
      }
    } else {
      print(response.body);
    }
    return valret;
  }

  @override
  void initState() {
    super.initState();
    initAndroidVersion().then((value) => getDeviceImei());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUsernameFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                fillColor: MaterialStateProperty.all(
                    Theme.of(context).appBarTheme.backgroundColor),
                checkColor: Theme.of(context).primaryColor,
                value: remember,
                activeColor: Theme.of(context).backgroundColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text(
                "Remember me",
                style: TextStyle(color: Theme.of(context).backgroundColor),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 200),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).appBarTheme.backgroundColor)),
              child: Text("SUBMIT"),
              onPressed: unController.text == "" || pwdController.text == ""
                  ? () {
                      setState(() {
                        errorMsg = 'Please enter username and password !';
                      });

                      errorMessage(context, errorMsg);
                    }
                  : () async {
                      var valret;
                      valret = await signIn(
                          unController.text.trim(),
                          pwdController.text.trim(),
                          androidVersion,
                          deviceImei);
                      print(valret);
                      if (valret == true) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BottomTabScreen()),
                            (Route<dynamic> route) => false);
                      } else {
                        setState(() {
                          errorMsg = 'Invalid username or password !';
                        });
                        errorMessage(context, errorMsg);
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }

  errorMessage(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    ));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: pwdController,
      cursorColor: Theme.of(context).backgroundColor,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        labelStyle: TextStyle(
          color: Theme.of(context).backgroundColor,
        ),
        // If  you are using latest version of flutter then label text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).backgroundColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).backgroundColor),
        ),
      ),
      style: TextStyle(color: Theme.of(context).backgroundColor),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      controller: unController,
      cursorColor: Theme.of(context).backgroundColor,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      decoration: InputDecoration(
        labelText: "Username",
        labelStyle: TextStyle(
          color: Theme.of(context).backgroundColor,
          decorationColor: Theme.of(context).backgroundColor,
        ),
        hintText: "Enter your username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).backgroundColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).backgroundColor),
        ),
      ),
      style: TextStyle(color: Theme.of(context).backgroundColor),
    );
  }
}
