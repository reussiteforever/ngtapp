import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Theme.of(context).dividerColor,
          //     blurRadius: 8,
          //     offset: Offset(4, 4),
          //   ),
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 48,
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(38)),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => SearchScreen(),
                  //       fullscreenDialog: true),
                  // );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        enabled: true,
                        onChanged: (String txt) {},
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: new InputDecoration(
                          fillColor: Theme.of(context).backgroundColor,
                          errorText: null,
                          border: InputBorder.none,
                          hintText: "Search here",
                          hintStyle:
                              TextStyle(color: Theme.of(context).disabledColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
