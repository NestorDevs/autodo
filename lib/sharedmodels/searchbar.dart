import 'package:flutter/material.dart';
import 'package:autodo/theme.dart';
import 'package:autodo/sharedmodels/carfilters.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(70.0);

  @override 
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> with TickerProviderStateMixin {
  AnimationController slideCtrl;
  var slideCurve;

  @override 
  void initState() {
    slideCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    )..addListener(() => setState(() {}));
    slideCurve = Tween(  
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(  
      parent: slideCtrl,
      curve: Curves.easeOutCubic
    ));
    super.initState();
  }

  @override 
  void dispose() {
    slideCtrl.dispose();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width, 
      height: widget.preferredSize.height,
      color: Colors.transparent,
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(  
              children: <Widget>[
                IconButton(  
                  icon: Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                // Container is used to pad the left side and force 
                // the title to the center
                Container(
                  width: 48 // normal Material Tap Target Size is 48px
                ),
              ],
            ),
            Text(
              'auToDo',
              style: logoStyle,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(  
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(  
                  icon: Icon(Icons.filter_list),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => CarFilters(() => setState(() {})),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}