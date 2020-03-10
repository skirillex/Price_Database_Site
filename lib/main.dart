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
                alignment: Alignment(0.0, 0.0),
                width: 500,  // stretches out to the left middle of screen so far
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
              Column(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.white70)  // need to change this to fit theme
                      )
                    ),
                    height: 35,
                    alignment: Alignment(-0.95, -0.8),
                    child: Text("Top Price Drops Link",
                    style: TextStyle(fontSize: 20),),
                  ),
                  Container(
                    height: 10,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Container(
                        height: 300,
                        width: 270,
                        child: Image.asset("img/superdrytestimg.jpg"))),
                  Flexible(

                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 100,
                        ),
                        Container(

                          child: SelectableText("Lightweight Leather Track Jacket",
                          style: TextStyle(fontSize: 25.0),)),
                      ],
                    )),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 165,
                        ),
                        PriceColumn(119.38, "2020-03-09"),
                      ],
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

// this class created the price column to the right of the name of item
class PriceColumn extends StatelessWidget{ //stateless because it needs to be drawn only once once page is loaded
  double price;
  String date;


  PriceColumn(double price, String date)
  {
    this.price = price;
    this.date = date;
  }
  @override
  Widget build(BuildContext context){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        SelectableText("\$$price",
        style: TextStyle(fontSize: 30,color: Colors.red),
        ),
          Container(
            height: 10,
            child: Spacer(flex: 1,),
          ),
        Container(
            //alignment: Alignment(-0.9, -0.9),
          width: 100,
          child: Text("SuperDry Price",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 10,),
            )
          ),
        Container(
          width: 100,
          child: Text("as of $date",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 10),),
        ),
          Container(
            height: 20,
            child: Spacer(flex: 1,),
          ),
          Container(
              width: 142,
              //alignment: Alignment(-1, -0),
              child: FlatButton(
                color: Colors.black87,
                hoverColor: Colors.white30,
                onPressed: () {print("pressed View at Superdry");},
                child: Text("View at SuperDry"),)
          )
      ]
    );
  }

}