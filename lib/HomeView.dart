


import 'package:colliecolliecollie/TopPriceDropsBox.dart';
import 'package:colliecolliecollie/WelcomeBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(// becase materialApp is used appBar is created here.
          title: //Text("SuperDry Price Database"),
          FlatButton(
            hoverColor: Colors.deepOrangeAccent,
            onPressed: () {
              Navigator.pushNamed(context, "/home");
            },
            child: Text("SuperDry Price Database",
              style: TextStyle(color: Colors.white, fontSize: 19),),),// title
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
                          Navigator.pushNamed(context, urlString.substring(urlString.indexOf("us")));
                          //print(urlString.substring(urlString.indexOf("us")));
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
      body: ListView(
        //padding: const EdgeInsets.only(left: 30, right: 30),
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black38)  // need to change this to fit theme
                )
            ),
            height: 35,
            alignment: Alignment(-0.95, -0.8),
            child: Text("Top Price Drops Link",
              style: TextStyle(fontSize: 20),),
          ),

          WelcomeBox(),
          Divider(),
          TopPriceDropsBox(),
        ],
      )
    );
  }
}