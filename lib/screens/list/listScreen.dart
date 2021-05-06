import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ngtapp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  dynamic uid;
  dynamic token;
  dynamic data;
  List<dynamic> assets;
  Future<void> getTokenAndUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      uid = preferences.getString("uid");
      print(token);
      print(uid);
    });
  }

  Future<void> getAssetsList(token, uid) async {
    Map<String, String> headers = {
      "key": "Content-Type",
      "name": "Content-Type",
      "value": "application/json",
      "type": "text",
      "Content-Type": "application/json"
    };
    Map body = {"token": token.toString(), "uid": uid.toString()};
    setState(() {
      var url = Uri.parse(GET_ASSETS);
      http.post(url, headers: headers, body: jsonEncode(body)).then((value) {
        if (value.statusCode == 200) {
          data = json.decode(value.body);
          assets = data["assets"];
          print(data);
        } else {
          print("connection échoué");
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTokenAndUid().then((value) => getAssetsList(token, uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: data != null
            ? ListView.builder(
                itemBuilder: (_, index) =>
                    assetView(assets[index]["a_name"], assets[index]["a_loc"]),
                itemCount: assets?.length ?? 0,
              )
            : Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
      ),
    );
  }

// assetsCategoryView("category"),
//               assetView("name", "description"),
//               assetView("name", "description"),
//               assetView("name", "description"),
//               assetView("name", "description"),
//               SizedBox(height: 10),
//               assetsCategoryView("category"),
//               assetView("name", "description"),
//               assetView("name", "description"),
//               assetView("name", "description"),
//               assetView("name", "description"),
//               SizedBox(height: 10),
//               assetsCategoryView("category"),
//               assetView("name", "description"),
//               assetView("name", "description"),
//               assetView("name", "description"),
//               assetView("name", "description"),
  Widget assetView(String name, String description) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          Divider(),
        ],
      ),
    );
  }

  Widget assetsCategoryView(String categoryName) {
    return Container(
      color: Theme.of(context).dividerColor,
      height: 20,
      width: 500,
      child: Text(categoryName),
    );
  }
}
