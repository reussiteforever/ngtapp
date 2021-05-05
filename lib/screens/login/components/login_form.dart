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
  signIn(username, pass, odversion, imei, phoneScreen) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Map data = {
    //   'uid': username,
    //   'pwd': pass,
    //   'android_ver': odversion,
    //   'phone_id': imei,
    //   'phone_screen': phoneScreen
    // };
    Map data = {
      "uid": "ngt.demo2",
      "pwd": "1qaz2wsx",
      "android_ver": "9.0",
      "phone_id": "12345678990",
      "phone_screen": "12",
      "phone_lat": "",
      "phone_long": "",
      "phone_dir": "",
      "phone_sp": ""
    };
    var jsonResponse;
    var url = Uri.parse(SIGN_IN_URL);
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("json = $jsonResponse");
      print("statut = ${jsonResponse['status']}");
      if (jsonResponse['status'] == 1) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => BottomTabScreen()),
            (Route<dynamic> route) => false);
      } else {
        print("connection échoué");
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
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
                  ? null
                  : () {
                      signIn(
                          unController.text.trim(),
                          pwdController.text.trim(),
                          androidVersion,
                          deviceImei,
                          "");
                    },
            ),
          ),
        ],
      ),
    );
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
