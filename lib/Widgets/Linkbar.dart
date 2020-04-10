import 'package:flutter/material.dart';

class Linkbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0,
                    color: Colors
                        .black38) // need to change this to fit theme
            )),
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
              child: Text(
                "Top Price Drops",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Spacer(),
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "/features");
              },
              color: Colors.black,
              hoverColor: Colors.deepOrangeAccent,
              child: Text(
                "Features",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Spacer(),
            /*
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
              color: Colors.black,
              hoverColor: Colors.deepOrangeAccent,
              child: Text(
                "About",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),

             */
            Spacer(
              flex: 100,
            ),
            Spacer(),
          ],
        ));


  }


}