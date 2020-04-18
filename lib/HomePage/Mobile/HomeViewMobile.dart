import 'package:colliecolliecollie/Widgets/Linkbar.dart';
import 'package:colliecolliecollie/Widgets/NotificationFormAnimatedContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TopPriceDropsBoxMobile.dart';
import 'WelcomeBoxMobile.dart';

import 'dart:html' as html;

class HomeViewMobile extends StatefulWidget {
  @override
  HomeViewMobileState createState() => HomeViewMobileState();




}

bool smallscreen(context) {
  return MediaQuery
      .of(context)
      .size
      .width < 400;
}

class HomeViewMobileState extends State<HomeViewMobile> {
  final GlobalKey<NotificationFormAnimatedContainerState>
  _notificationFormAnimatedContainerState =
  GlobalKey<NotificationFormAnimatedContainerState>();

  @override
  void initState() {
    super.initState();
    html.window.history.pushState(null, "/", " ");
  }

  @override
  Widget build(BuildContext context) {

    double phonesize = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,

          title: FlatButton(
            hoverColor: Colors.deepOrangeAccent,
            onPressed: () {
              Navigator.pushNamed(context, "/home");
            },
            child: Text(
              "CollieCollieCollie",
              style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start,
                // does nothing so far
                children: [
                  Align(
                    alignment: Alignment.center,
                    child:
                    Container(
                      //alignment: Alignment(0.0, 0.0),
                        width: phonesize < 376 ? 275 : 290, //280,
                        // stretches out to the left middle of screen so far
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(phonesize < 376 ? 5 : 10,
                              2, 0, 2),
                          child: TextField(
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white),
                              cursorColor: Colors.white,
                              //maxLines: 1,
                              obscureText: false,
                              onTap: () {},
                              onSubmitted: (String urlString) {
                                Navigator.pushNamed(context,
                                    urlString.substring(
                                        urlString.indexOf("us")));
                              },
                              // get the value
                              decoration: InputDecoration(

                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepOrange
                                    ),
                                  ),
                                  labelStyle: Theme
                                      .of(context)
                                      .textTheme
                                      .display1
                                      .merge(TextStyle(
                                      fontSize: 14, color: Colors.white)),
                                  labelText: 'Enter SuperDry URL to find product',
                                  suffixIcon: Icon(
                                    Icons.search, color: Colors.white,))),
                        )
                    ),
                  ),

                  Container(
                    // container to hold the signup and login buttons
                    width: phonesize < 376 ? 105 : 120, //105,
                    //margin: EdgeInsets.all(10),
                    child: ButtonBar(
                      buttonMinWidth: 120,
                      children: <Widget>[
                        FlatButton(
                            child: Text(
                              "Get Notified",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .display1
                                  .merge(TextStyle(
                                color: Colors.white,
                              )),
                              textScaleFactor: phonesize < 376
                                  ? .40
                                  : .45, //.40,
                            ),
                            hoverColor: Colors.deepOrangeAccent,
                            onPressed: () {
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
                ])
          ]),
      body: GestureDetector(
          onTapDown: (tpd) {
            FocusScope.of(context).unfocus();
          },
          child: RefreshIndicator(
            onRefresh: () {
              return Navigator.pushNamed(context, "/home");
            },
            color: Colors.deepOrange,
            child: Stack(children: <Widget>[
              GestureDetector(
               onTapUp: (tpu) {_notificationFormAnimatedContainerState.currentState.closeform();},
                child: ListView(
                  //padding: const EdgeInsets.only(left: 30, right: 30),
                  children: <Widget>[
                    Linkbar(),
                    WelcomeBoxMobile(),
                    Divider(color: Colors.white),
                    TopPriceDropsBoxMobile(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: NotificationFormAnimatedContainer(0,
                    key: _notificationFormAnimatedContainerState),
              ),
            ]),
          ),
      ),
    );
  }
}
