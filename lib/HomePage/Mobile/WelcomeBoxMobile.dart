import 'package:flutter/material.dart';

class WelcomeBoxMobile extends StatelessWidget{

  double fontsizeconverter(BuildContext context, double size)
  {
    if (MediaQuery.of(context).size.width < 400)
      {
        return size-3;
      }
    else
      {
        return size;
      }
  }

  List<Widget> generateItems(){

    List<Widget> content = new List<Widget> ();

    //content.add(Widget());
    //content.add(FeaturesItems(headerValue: "Price Drop Notifications", expandedValue: "A big feature to ensure a user will not be aware of when a price for an item goes below a set threshold. \n \nThis feature can be found in the top bar of every page upon clicking where it says 'Get notified'. From this dialogue email, the superdry URL for the item and the price need to be specified. This feature is also available within the item page where the item URL does not need to be specified. ", id: 2));
    //content.add(FeaturesItems(headerValue: "Quick Price Search From Browsing Superdry", expandedValue: "One of the most useful features of this site. A user can find the price history chart of any item while browsing Superdry.com. \n \nAll they have to do is replace the URL where is says 'superdry.com' with this sites url and the user will be directed to the price history chart of that item", id: 3));
    //content.add(FeaturesItems(headerValue: "Superdry Item Search by URL", expandedValue: "This search bar is available on every page at the very top of the screen, denoted by a seach icon and text. \n \nA full Superdry URL needs to be copy/pasted into the search bar. Pressing enter or clicking the search icon will transport the user to the specified item page", id: 4));
    return content;
  }


  @override
  Widget build(BuildContext context) {
    double phonesize = MediaQuery.of(context).size.width;
    //var devicePhysicalPixelWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    return Center(
        child: SizedBox(
          height: phonesize < 376 ? 285 : 300, // 300,
          width: 900,
          child: Card(
            elevation: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Divider(color: Colors.white),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Welcome to the SuperDry Price History Database!",textAlign: TextAlign.left, style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: fontsizeconverter(context, 20))),),
                  ),
                ),
                Divider(color: Colors.white),
                /*Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  This price tracker monitors every single item that SuperDry offers so you can be a more informed consumer.", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 15)) /*style: TextStyle(fontSize: 18)*/,),
                ),

                 */

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  How to use this site: ", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: fontsizeconverter(context, 17))), /*TextStyle(fontSize: 24)*/),
                ),
                Divider(color: Colors.white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("  1. Find the item on Superdry.com  (US site) \n  2. Copy the URL of the item  \n  3. Paste the link in the search bar above \n      and hit enter", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: fontsizeconverter(context, 15))) /*TextStyle(fontSize: 18)*/,),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(" OR ", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: fontsizeconverter(context, 20), fontWeight: FontWeight.bold))),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  1. While Browsing www.superdry.com \n  2. Change the domain of the URL   \n  3. from: www.superdry.com/us/mens/jackets/details/.../ \n  4. to: www.colliecolliecollie.com/us/mens/jackets/.../ ", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: fontsizeconverter(context, 15))) /*TextStyle(fontSize: 18)*/,),
                ),
                Divider(color: Colors.white)],
            ),
          ),
        ));
  }


}