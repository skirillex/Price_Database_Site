import 'dart:convert';

import 'package:colliecolliecollie/ItemPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget child;
  final String item;
  const LayoutTemplate(this.item, {Key key, this.child}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(// becase materialApp is used appBar is created here.
            title: Text("SuperDry Price Database"),// title
            actions: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                              print(urlString);
                            }, // get the value
                            decoration: InputDecoration(
                                labelText: 'Enter SuperDry URL to find product',
                                suffixIcon: Icon(Icons.search)
                            )
                        ),
                    ),
                    Container( // container to hold the signup and login buttons
                      width: 200,
                      //margin: EdgeInsets.all(10),
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            hoverColor: Colors.deepOrangeAccent,
                            onPressed: () {
                              print("pressed sign up");
                            },
                            child: Text("Sign Up",
                              style: TextStyle(color: Colors.white),),
                          ),
                          FlatButton(
                            hoverColor: Colors.deepOrangeAccent,
                            onPressed: () {
                              print("pressed log in");
                            },
                            child: Text("Log in",
                              style: TextStyle(color: Colors.white),),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                    ),
                  ]
              )
            ]
        ),
        body: ItemPage(item) //child
    );
  }
}