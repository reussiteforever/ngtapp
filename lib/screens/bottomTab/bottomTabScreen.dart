import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngtapp/screens/bottomTab/components/searchBar.dart';
import 'package:ngtapp/screens/list/listScreen.dart';
import 'package:ngtapp/screens/map/mapScreen.dart';
import 'package:ngtapp/screens/notifications/notificationsScreen.dart';

class BottomTabScreen extends StatefulWidget {
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  bool isFirstTime = true;
  Widget indexView = Container();
  BottomBarType bottomBarType = BottomBarType.List;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    indexView = Container();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startLoadScreen());
    super.initState();
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      isFirstTime = false;
      indexView = ListScreen(
          // animationController: animationController,
          );
    });
    animationController..forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: new Container(),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: SearchBar(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                "lib/images/filter.svg",
                height: 47,
                width: 47,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: Container(
            height: 58 + MediaQuery.of(context).padding.bottom,
            child: getBottomBarUI(bottomBarType)),
        body: isFirstTime
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : indexView,
      ),
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      animationController.reverse().then((f) {
        if (tabType == BottomBarType.List) {
          setState(() {
            indexView = ListScreen(
                // animationController: animationController,
                );
          });
        } else if (tabType == BottomBarType.Map) {
          setState(() {
            indexView = MapScreen(
                // animationController: animationController,
                );
          });
        } else if (tabType == BottomBarType.Notifications) {
          setState(() {
            indexView = NotificationsScreen(
                // animationController: animationController,
                );
          });
        } else if (tabType == BottomBarType.Settings) {
          setState(() {
            indexView = NotificationsScreen(
                // animationController: animationController,
                );
          });
        }
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).dividerColor,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              //LIST TAB
              Expanded(
                child: Material(
                  color: tabType == BottomBarType.List
                      ? Theme.of(context).bottomAppBarColor
                      : Theme.of(context).backgroundColor,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    // splashColor: Colors.black,
                    onTap: () {
                      tabClick(BottomBarType.List);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 40,
                          height: 32,
                          child: Icon(
                            Icons.list,
                            size: 26,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "List",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                            // : Theme.of(context).disabledColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //MAP TAB
              Expanded(
                child: Material(
                  color: tabType == BottomBarType.Map
                      ? Theme.of(context).bottomAppBarColor
                      : Theme.of(context).backgroundColor,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    onTap: () {
                      tabClick(BottomBarType.Map);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 40,
                          height: 32,
                          child: Icon(
                            Icons.map,
                            size: 26,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Map",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //NOTIFICATIONS TAB
              Expanded(
                child: Material(
                  color: tabType == BottomBarType.Notifications
                      ? Theme.of(context).bottomAppBarColor
                      : Theme.of(context).backgroundColor,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    onTap: () {
                      tabClick(BottomBarType.Notifications);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 40,
                          height: 32,
                          child: Icon(
                            Icons.notifications,
                            size: 26,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Notifications",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // SETTINGS
              Expanded(
                child: Material(
                  color: tabType == BottomBarType.Settings
                      ? Theme.of(context).bottomAppBarColor
                      : Theme.of(context).backgroundColor,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    // splashColor:
                    //     Theme.of(context).primaryColor.withOpacity(0.2),
                    onTap: () {
                      tabClick(BottomBarType.Settings);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 40,
                          height: 32,
                          child: Icon(
                            Icons.menu,
                            size: 26,
                            // size: 26,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}

enum BottomBarType { List, Map, Notifications, Settings }
