import 'package:flutter/material.dart';
import 'package:ngtapp/screens/bottomTab/bottomTabScreen.dart';
import 'package:ngtapp/screens/login/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  var warningMessage =
      "Kindly input your sign-in credentials. Please contact your account manager if you need any assistance.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 24.0,
              ),
              appBar(context),
              SizedBox(
                height: 50.0,
              ),
              Text(
                "Sign In",
                style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Spacer(),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(warningMessage,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SignForm(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget appBar(context) {
    return Container(
      width: 1000.0,
      height: 70.0,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Center(
        child: Text(
          "User Authentication",
          style: TextStyle(
              color: Theme.of(context).backgroundColor, fontSize: 20.0),
        ),
      ),
    );
  }
}
