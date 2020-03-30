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
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  Welcome to the SuperDry Price History Database!",textAlign: TextAlign.left, style: TextStyle(fontSize: 20),),
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  This price tracker monitors every single item that SuperDry offers so you can be a more informed consumer.", style: TextStyle(fontSize: 18),),
                ),
                Expanded(
                  child: Divider(),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  How to use this site: ", style: TextStyle(fontSize: 24),),
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  1. Find the item on Superdry.com  (US site only at the moment) \n  2. Copy the link of the item \n  3. Paste the link in the search bar above and hit enter", style: TextStyle(fontSize: 18),),
                ),
                Divider()],
            ),
          ),
        ));
  }


}