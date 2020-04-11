import 'package:colliecolliecollie/ItemPage/LayoutTemplate.dart';
import 'package:flutter/material.dart';

import 'NotificationFormAnimatedContainer.dart';



// ideally this class would serve as a single appbar but the class needs to call a sibling method.

class CollieBar extends StatefulWidget implements PreferredSizeWidget {
  AppBar appBar;
  final VoidCallback onSelect;

  CollieBar({Key key, this.onSelect}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  _CollieBarState createState() => _CollieBarState();
  @override
  final Size preferredSize;

}

class _CollieBarState extends State<CollieBar> {
  final GlobalKey<NotificationFormAnimatedContainerState>
  _notificationFormAnimatedContainerState =
  GlobalKey<NotificationFormAnimatedContainerState>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: //Text("SuperDry Price Database"),
        FlatButton(
          hoverColor: Colors.deepOrangeAccent,
          onPressed: () {
            Navigator.pushNamed(context, "/home");
          },
          child: Text(
            "CollieCollieCollie",
            style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 19, color: Colors.white)),
          ),
        ),
        // title
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start,
              // does nothing so far
              children: [
                Align(
                  alignment: Alignment.center,
                  child:
                  Container(
                    //alignment: Alignment(0.0, 0.0),
                    width: 500,
                    // stretches out to the left middle of screen so far
                    child: TextField(
                        cursorColor: Colors.white,
                        maxLines: 1,
                        obscureText: false,
                        onTap: () {},
                        onSubmitted: (String urlString) {
                          Navigator.pushNamed(context,
                              urlString.substring(urlString.indexOf("us")));
                        },
                        // get the value
                        decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 19, color: Colors.white)),
                            labelText: 'Enter SuperDry URL to find product',
                            suffixIcon: Icon(Icons.search, color: Colors.white,))),
                  ),
                ),
                Container(
                  width: 100,
                ),
                Container(
                  // container to hold the signup and login buttons
                  width: 200,
                  //margin: EdgeInsets.all(10),
                  child: ButtonBar(
                    buttonMinWidth: 300,
                    children: <Widget>[
                      FlatButton(
                          child: Text(
                            "Get Notified",
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .merge(TextStyle(
                              color: Colors.white,
                            )),
                            textScaleFactor: .6,
                          ),
                          hoverColor: Colors.deepOrangeAccent,
                          onPressed: () {
                            print("pressed Get Notified");

                            _notificationFormAnimatedContainerState
                                .currentState
                                .opencloseform();
                            setState(
                                  () {},
                            );
                          })
                    ],
                  ),
                ),
                Container(
                  width: 50,
                ),
              ])
        ]);
  }

}