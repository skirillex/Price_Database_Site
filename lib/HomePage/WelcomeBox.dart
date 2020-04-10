import 'package:flutter/material.dart';

class WelcomeBox extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          height: 300,
          width: 900,
          child: Card(
            elevation: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Divider(color: Colors.white),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(" Welcome to the SuperDry Price History Database!",textAlign: TextAlign.left, style: Theme.of(context).textTheme.display1,),
                ),
                Divider(color: Colors.white),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  This price tracker monitors every single item that SuperDry offers so you can be a more informed consumer.", style: Theme.of(context).textTheme.display1, textScaleFactor: .55 /*style: TextStyle(fontSize: 18)*/,),
                ),
                Expanded(
                  child: Divider(color: Colors.white),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  How to use this site: ", style: Theme.of(context).textTheme.display1, textScaleFactor: .7, /*TextStyle(fontSize: 24)*/),
                ),
                Divider(color: Colors.white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("  1. Find the item on Superdry.com  (US site) \n  2. Copy the URL of the item  \n  3. Paste the link in the search bar above \n      and hit enter", style: Theme.of(context).textTheme.display1, textScaleFactor: .55 /*TextStyle(fontSize: 18)*/,),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(" OR ", style: Theme.of(context).textTheme.display1,),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("  1. While Browsing www.superdry.com \n  2. Change the domain of the URL   \n  3. from: www.superdry.com/us/mens/jackets/details/.../ \n  4. to: www.colliecolliecollie.com/us/mens/jackets/details/.../ ", style: Theme.of(context).textTheme.display1, textScaleFactor: .50 /*TextStyle(fontSize: 18)*/,),
                    ),
                  ],
                ),
                Divider(color: Colors.white)],
            ),
          ),
        ));
  }


}