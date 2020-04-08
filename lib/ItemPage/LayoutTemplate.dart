import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
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
        appBar: AppBar(
            // becase materialApp is used appBar is created here.
            title: //Text("SuperDry Price Database"),
                FlatButton(
              hoverColor: Colors.deepOrangeAccent,
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
              child: Text(
                "SuperDry Price Database",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
            // title
            actions: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.start,
                  // does nothing so far
                  children: [
                    Container(
                      alignment: Alignment(0.0, 0.0),
                      width: 500,
                      // stretches out to the left middle of screen so far
                      child: TextField(
                          maxLines: 1,
                          obscureText: false,
                          onTap: () {},
                          onSubmitted: (String urlString) {
                            Navigator.pushNamed(context,
                                urlString.substring(urlString.indexOf("us")));
                            //print(urlString.substring(urlString.indexOf("us")));
                          },
                          // get the value
                          decoration: InputDecoration(
                              labelText: 'Enter SuperDry URL to find product',
                              suffixIcon: Icon(Icons.search))),
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
            ]),
        body: Stack(
          children: <Widget>[
            ItemPage(widget.item),
            Align(
              alignment: Alignment.topRight,
              child: NotificationFormAnimatedContainer(
                key: _notificationFormAnimatedContainerState,
              ),
            )
          ],
        ) //child
        );
  }
}
