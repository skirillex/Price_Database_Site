import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeBoxMobile extends StatefulWidget {
  @override
  WelcomeBoxMobileState createState() => WelcomeBoxMobileState();
}

class WelcomeBoxMobileState extends State<WelcomeBoxMobile>{
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

  List<Widget> generateItems(BuildContext context){

    List<Widget> content = new List<Widget> ();

    content.add(Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
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
          child: Text("  1. While Browsing www.superdry.com \n  2. Change the domain of the URL   \n  3. from: www.superdry.com/us/mens/jackets/details/.../ \n  4. to: www.colliecolliecollie.com/#/us/mens/jackets/.../ ", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: fontsizeconverter(context, 15))) /*TextStyle(fontSize: 18)*/,),
        ),
        Divider(color: Colors.white)],
    ),);
    return content;
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    List<Widget> _data = generateItems(context);

    double phonesize = MediaQuery.of(context).size.width;

    //var devicePhysicalPixelWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;


    return Center(
        child: SizedBox(
          //height: phonesize < 376 ? 285 : 300, // 300,
          width: 900,
          child: Card(
            elevation: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                ExpansionPanelList.radio(

                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      //_data[index].isExpanded = !isExpanded;
                      isExpanded = !isExpanded;
                    });
                  },
                  children: _data.map<ExpansionPanel>((Widget item){
                    return ExpansionPanelRadio(
                      value: 1,//item.id,
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded)
                      {
                        return ListTile(
                          title: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Welcome to the SuperDry Price History Database!",textAlign: TextAlign.left, style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: fontsizeconverter(context, 20))),),
                                ),
                              ),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(" How to use this site: ",textAlign: TextAlign.left, style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: fontsizeconverter(context, 17))) //Text(item.headerValue, style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 20))),
                                ),
                              )
                            ],
                          ));
                      },
                      body: ListTile(
                        title: _data[0]//Text(item.expandedValue, style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 16, color: Colors.black)),),
                      ),
                      //isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ),
                ],
            ),
          ),
        ));
  }


}