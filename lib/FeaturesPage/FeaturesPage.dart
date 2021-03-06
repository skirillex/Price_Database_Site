import 'package:colliecolliecollie/Widgets/CollieBar.dart';
import 'package:colliecolliecollie/Widgets/Linkbar.dart';
import 'package:colliecolliecollie/Widgets/NotificationFormAnimatedContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FeaturesItems.dart';

class FeaturesPage extends StatefulWidget {
  @override
  FeaturesPageState createState() => FeaturesPageState();
}

List<FeaturesItems> generateItems(){

  List<FeaturesItems> content = new List<FeaturesItems> ();

  content.add(FeaturesItems(headerValue: "Price History Charts", expandedValue: "The main feature of this site. All product pages contain a chart that plots prices for that item over a certain period of time. \n \nIt highlights the high and low prices. And the charts support four time periods: 1 month ago, 3 months ago, 6 months ago and entire history since this site started tracking prices.", id: 1));
  content.add(FeaturesItems(headerValue: "Price Drop Notifications", expandedValue: "A big feature to ensure a user will not be aware of when a price for an item goes below a set threshold. \n \nThis feature can be found in the top bar of every page upon clicking where it says 'Get notified'. From this dialogue email, the superdry URL for the item and the price need to be specified. This feature is also available within the item page where the item URL does not need to be specified. ", id: 2));
  content.add(FeaturesItems(headerValue: "Quick Price Search From Browsing Superdry", expandedValue: "One of the most useful features of this site. A user can find the price history chart of any item while browsing Superdry.com. \n \nAll they have to do is replace the URL where is says 'superdry.com' with this sites url and the user will be directed to the price history chart of that item", id: 3));
  content.add(FeaturesItems(headerValue: "Superdry Item Search by URL", expandedValue: "This search bar is available on every page at the very top of the screen, denoted by a seach icon and text. \n \nA full Superdry URL needs to be copy/pasted into the search bar. Pressing enter or clicking the search icon will transport the user to the specified item page", id: 4));
  return content;
}

class FeaturesPageState extends State<FeaturesPage> {
  final GlobalKey<NotificationFormAnimatedContainerState>
      _notificationFormAnimatedContainerState =
      GlobalKey<NotificationFormAnimatedContainerState>();




List<FeaturesItems> _data = generateItems();

  @override
  Widget build(BuildContext context) {
    String buttonTextClosed = "Get Notified";
    String buttonTextOpen = "Close";
    bool openFlag = false;

    String buttonText = buttonTextClosed;

    return Scaffold(
      appBar:  AppBar(
          automaticallyImplyLeading: false,
          title: //Text("SuperDry Price Database"),
          FlatButton(
            hoverColor: Colors.deepOrangeAccent,
            onPressed: () {
              Navigator.pushNamed(context, "/home");
            },
            child: Text(
              "CollieCollieCollie",
              style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
          // title
          actions: <Widget>[
            Flexible(
              flex: 1,

              child: Padding(
                  padding: EdgeInsets.fromLTRB(1, 3, 1, 3),
                  child: Container(
                    width: 0,
                  )
              ),
            ),
            Flexible(
              flex: 2,
              //width: screensize * .8,
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  // does nothing so far
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child:
                      Container(
                        //alignment: Alignment(0.0, 0.0),
                        width: 400,
                        // stretches out to the left middle of screen so far
                        child: TextField(
                            style: TextStyle(fontSize: 10, color: Colors.white),
                            cursorColor: Colors.white,
                            maxLines: 1,
                            obscureText: false,
                            onTap: () {},
                            onSubmitted: (String urlString) {
                              Navigator.pushNamed(context,
                                  urlString.substring(urlString.indexOf("us")));
                            },
                            // get the value
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.deepOrange
                                  ),
                                ),
                                labelStyle: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 19, color: Colors.white)),
                                labelText: 'Enter SuperDry URL to find product',
                                suffixIcon: Icon(Icons.search, color: Colors.white,))),
                      ),
                    ),
                  ]),
            ),
            Flexible(
              flex: 1,
              child: Container(
                // container to hold the signup and login buttons
                width: 200,
                //margin: EdgeInsets.all(10),
                child: ButtonBar(
                  buttonMinWidth: 300,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 30, 3),
                      child: FlatButton(
                          child: Text(
                            "Get Notified",
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .merge(TextStyle(
                              color: Colors.white,
                            )),
                            textScaleFactor: .6,
                          ),
                          hoverColor: Colors.deepOrangeAccent,
                          onPressed: () {

                            _notificationFormAnimatedContainerState
                                .currentState
                                .opencloseform();
                            setState(
                                  () {},
                            );
                          }),
                    )
                  ],
                ),
              ),
            )
          ]),
      body: Stack(
        children: <Widget>[
         GestureDetector(

           onTap: () {_notificationFormAnimatedContainerState.currentState.closeform();},
           child:  ListView(
             //padding: const EdgeInsets.only(left: 30, right: 30),
             children: <Widget>[
               Linkbar(),
               Divider(
                 height: 20,
                 color: Colors.white,
               ),
               Center(
                   child: SizedBox(
                     height: 50,
                     width: 900,
                     child: Card(
                       elevation: 4,
                       color: Colors.deepOrange,
                       child: Align(
                         alignment: Alignment.centerLeft,
                         child: Text("   Site Features", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 25, color: Colors.white)),),
                       ),
                     ),
                   )
               ),
               Center(
                 child: Container(
                   width: 900,
                   child: Card(
                     elevation: 4,
                     child: ExpansionPanelList.radio(
                       expansionCallback: (int index, bool isExpanded) {
                         setState(() {
                           _data[index].isExpanded = !isExpanded;
                         });
                       },
                       children: _data.map<ExpansionPanel>((FeaturesItems item){
                         return ExpansionPanelRadio(
                           value: item.id,
                           canTapOnHeader: true,
                           headerBuilder: (BuildContext context, bool isExpanded)
                           {
                             return ListTile(
                               title: Text(item.headerValue, style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 20))),
                             );
                           },
                           body: ListTile(
                             title: Text(item.expandedValue, style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 16, color: Colors.black)),),
                             //subtitle: Text("this is subtitle text"),
                             //trailing: Icon(Icons.arrow_drop_up),
                           ),
                           //isExpanded: item.isExpanded,
                         );
                       }).toList(),
                     ),
                   ),
                 ),
               )
             ],
           ),
         ),
          Align(
            alignment: Alignment.topRight,
            child: NotificationFormAnimatedContainer(30,
                key: _notificationFormAnimatedContainerState),
          ),
        ],
      ),
    );
  }
}
