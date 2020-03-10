import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String url = "";
    return MaterialApp(
      title: "Superdry Price DB",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey
      ),
      home: Scaffold(
        appBar: AppBar(  // becase materialApp is used appBar is created here.
          title: Text("SuperDry Price Database"), // title
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,  // does nothing so far
              children: [
              Container(
                alignment: Alignment.topLeft,
                width: 600,  // stretches out to the left middle of screen so far
                child: TextField(
                  maxLines: 1,
                  obscureText: false,
                  onSubmitted: (String urlString) {print(urlString);}, // get the value
                  decoration: InputDecoration(
                    labelText: 'Enter SuperDry URL to find product',
                    suffixIcon: Icon(Icons.search)
                )
              )
            ),
                Container( // container to hold the signup and login buttons
                  width: 200,
                  //margin: EdgeInsets.all(10),
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {print("pressed sign up");},
                        child: Text("Sign Up"),
                      ),
                      FlatButton(
                        onPressed: () {print("pressed log in");},
                        child: Text("Log in"),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 50,
                )
            ]
            )
          ]
        ),
        body: ListView(//SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            //physics: const ScrollPhysics(),
            dragStartBehavior: DragStartBehavior.down,
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Image.asset("img/superdrytestimg.jpg")),
                  Flexible(
                    flex: 2,
                    child: Container(

                      child: Text("Lightweight Leather Track Jacket",
                      style: TextStyle(fontSize: 25.0),))),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("\$119.98",
                        style: TextStyle(fontSize: 30,color: Colors.red),
                        )
                      ]
                    )
                  )
                ],
              ),
              //Flexible(
                
                //child:
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.redAccent,
                  child: Text("price History Text container",
                  style: TextStyle(fontSize: 35),),
                ),
              //),
              Row(
                children: <Widget>[
                  Text("Price History Text")  // possibly should be a container to change background
                ],
              )
            ]
          )
        ),
      
    );
  }
}