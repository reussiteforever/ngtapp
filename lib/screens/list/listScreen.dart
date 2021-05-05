import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            assetsCategoryView("category"),
            assetView("name", "description"),
            assetView("name", "description"),
            assetView("name", "description"),
            assetView("name", "description"),
            SizedBox(height: 10),
            assetsCategoryView("category"),
            assetView("name", "description"),
            assetView("name", "description"),
            assetView("name", "description"),
            assetView("name", "description"),
            SizedBox(height: 10),
            assetsCategoryView("category"),
            assetView("name", "description"),
            assetView("name", "description"),
            assetView("name", "description"),
            assetView("name", "description"),
          ],
        ),
      ),
    );
  }

  Widget assetView(String name, String description) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(name),
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
