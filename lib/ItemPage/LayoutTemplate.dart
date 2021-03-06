
import 'package:colliecolliecollie/Widgets/CollieBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ItemPage.dart';
import 'package:colliecolliecollie/Widgets/NotificationFormAnimatedContainer.dart';

class LayoutTemplate extends StatefulWidget {
  final String item;

  const LayoutTemplate(this.item, {Key key}) : super(key: key);

  @override
  LayoutTemplateState createState() => LayoutTemplateState();
}

class LayoutTemplateState extends State<LayoutTemplate> {
  final GlobalKey<NotificationFormAnimatedContainerState>
      _notificationFormAnimatedContainerState =
      GlobalKey<NotificationFormAnimatedContainerState>();

  String urlToRoute(String url) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
            automaticallyImplyLeading: false,
            title: //Text("SuperDry Price Database"),
            FlatButton(
              hoverColor: Colors.deepOrangeAccent,
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
              child: Text(
                "CollieCollieCollie",
                style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            // title
            actions: <Widget>[
              Flexible(
                flex: 1,

                child: Padding(
                    padding: EdgeInsets.fromLTRB(1, 3, 1, 3),
                    child: Container(
                      width: 0,
                    )
                ),
              ),
              Flexible(
                flex: 2,
                //width: screensize * .8,
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    // does nothing so far
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child:
                        Container(
                          //alignment: Alignment(0.0, 0.0),
                          width: 400,
                          // stretches out to the left middle of screen so far
                          child: TextField(
                              style: TextStyle(fontSize: 10, color: Colors.white),
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
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepOrange
                                    ),
                                  ),
                                  labelStyle: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 19, color: Colors.white)),
                                  labelText: 'Enter SuperDry URL to find product',
                                  suffixIcon: Icon(Icons.search, color: Colors.white,))),
                        ),
                      ),
                    ]),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  // container to hold the signup and login buttons
                  width: 200,
                  //margin: EdgeInsets.all(10),
                  child: ButtonBar(
                    buttonMinWidth: 300,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 30, 3),
                        child: FlatButton(
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
                            }),
                      )
                    ],
                  ),
                ),
              )
            ]),
        body: Stack(
          children: <Widget>[
            GestureDetector (
              onTap: () {_notificationFormAnimatedContainerState.currentState.closeform();},
              child: ItemPage(widget.item),
            ),
            Align(
              alignment: Alignment.topRight,
              child: NotificationFormAnimatedContainer(30,
                key: _notificationFormAnimatedContainerState,
              ),
            )
          ],
        ) //child
        );
  }
}
