import 'package:flutter/material.dart';
import 'package:ngtapp/screens/login/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  SignForm(),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
