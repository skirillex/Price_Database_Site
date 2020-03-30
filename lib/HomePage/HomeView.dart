
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TopPriceDropsBox.dart';
import 'WelcomeBox.dart';

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
            height: 50,
            alignment: Alignment(-0.95, -0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Spacer(
                  //flex: 5,
                  //flex: 2,
                  // width: 80,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/home");
                  },
                  color: Colors.black,
                  hoverColor: Colors.deepOrangeAccent,
                  child: Text("Top Price Drops",
                    style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
                Spacer(),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/home");
                  },
                  color: Colors.black,
                  hoverColor: Colors.deepOrangeAccent,
                  child: Text("Features",
                    style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
                Spacer(),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/home");
                  },
                  color: Colors.black,
                  hoverColor: Colors.deepOrangeAccent,
                  child: Text("About",
                    style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
                Spacer(flex: 100,),
                Spacer(),

              ],
            )
          ),

          WelcomeBox(),
          Divider(),
          TopPriceDropsBox(),
        ],
      )
    );
  }
}