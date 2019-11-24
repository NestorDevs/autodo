import 'package:flutter/material.dart';
import 'package:autodo/sharedmodels/sliverfooter.dart';
import 'package:autodo/blocs/userauth.dart';
import 'dart:math';

class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => NavDrawerState();
}

class NavDrawerState extends State<NavDrawer> {
  static const List<Color> userBadgeColors = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.indigo,
    Colors.purple
  ];
  static Random rand = Random();

  Widget userHeader(String username) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              child: Material(
                elevation: 2.0,
                shape: CircleBorder(),
                color:
                    userBadgeColors[rand.nextInt(userBadgeColors.length - 1)],
                child: Center(
                  child: Text(username[0].toUpperCase()),
                ),
              ),
            ),
          ),
          Text(username),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      FlatButton(
        child: Text(
          'Home Page',
          style: Theme.of(context).primaryTextTheme.button,
        ),
        onPressed: () => Navigator.popAndPushNamed(context, '/'),
      ),
      FlatButton(
        child: Text(
          'Refueling History',
          style: Theme.of(context).primaryTextTheme.button,
        ),
        onPressed: () => Navigator.popAndPushNamed(context, '/refuelinghistory'),
      ),
      FlatButton(
        child: Text(
          'Statistics',
          style: Theme.of(context).primaryTextTheme.button,
        ),
        onPressed: () => Navigator.popAndPushNamed(context, '/statistics'),
      ),
      Divider(),
      FlatButton(
        child: Text(
          'Edit Repeating ToDos',
          style: Theme.of(context).primaryTextTheme.button,
        ),
        onPressed: () => Navigator.popAndPushNamed(context, '/editrepeats'),
      ),
      FlatButton(
        child: Text(
          'Edit Car List',
          style: Theme.of(context).primaryTextTheme.button,
        ),
        onPressed: () => Navigator.popAndPushNamed(context, '/editcarlist'),
      ),
      FlatButton(
        child: Text(
          'Settings',
          style: Theme.of(context).primaryTextTheme.button,
        ),
        onPressed: () => Navigator.popAndPushNamed(context, '/settings'),
      ),
    ];

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withAlpha(200),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFixedExtentList(
              itemExtent: 140.0,
              delegate: SliverChildBuilderDelegate((context, index) {
                return SizedBox.expand(
                  child: DrawerHeader(
                    child: FutureBuilder<String>(
                      future: Auth().fetchUser(), // TODO: this returns the uuid, not email
                      builder:
                          (BuildContext context, AsyncSnapshot<String> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return Text('...');
                          case ConnectionState.done:
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            return userHeader('${snapshot.data}');
                          default:
                            return Container();
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              }, childCount: 1),
            ),
            SliverFixedExtentList(
              itemExtent: 35.0,
              delegate: SliverChildBuilderDelegate((context, index) {
                return SizedBox.expand(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: buttons[index],
                  ),
                );
              }, childCount: buttons.length),
            ),
            SliverFooter(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                        child: Text('Sign Out'),
                        onPressed: () {
                          Auth userAuth = Auth();
                          userAuth.signOut();
                          Navigator.popAndPushNamed(context, '/welcomepage');
                        },
                      ),
                    ),
                    // TODO: replace this with a flat button too.
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AboutListTile(
                        applicationIcon: Icon(Icons.access_alarm),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
