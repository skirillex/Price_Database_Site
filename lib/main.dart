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
        //brightness: Brightness.dark,
       // primaryColor: Colors.blueGrey
       primaryColor: Colors.deepOrange,
           inputDecorationTheme: const InputDecorationTheme(
             labelStyle: TextStyle(color: Colors.black87),
             //hintStyle: TextStyle(color: Colors.black)
           )
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
                        hoverColor: Colors.deepOrangeAccent,
                        onPressed: () {print("pressed sign up");},
                        child: Text("Sign Up",
                        style: TextStyle(color: Colors.white),),
                      ),
                      FlatButton(
                        hoverColor: Colors.deepOrangeAccent,
                        onPressed: () {print("pressed log in");},
                        child: Text("Log in",
                        style: TextStyle(color: Colors.white),),
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

            children: <Widget>[
              Column( // this column and container builds and holds the links bar underneath the appbar
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
                  Container(
                    height: 10,
                  )
                ],
              ),
              Container( // this container creates some padding between link bar above and content below
                height: 30,
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
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Container(
                      height: 100,
                      ),
                      DescriptionColumn("Lightweight Leather Track Jacket", "Jackets")
                      ]
                    )
                  ),
                  Flexible(
                    flex: 0,
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
              Divider(
                height: 20,
                color: Colors.black,
              ),
              Align(
                alignment: Alignment.center,
                child: ChartCard(),
              )
              ]
          )
        ),
      
    );
  }
}

class ChartCard extends StatefulWidget{
  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> with SingleTickerProviderStateMixin{

  TabController _tabController;
  @override
  void initState(){
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 700,
      width: 800,
      child: Card(
        elevation: 4,  //supported: 6, 8, 16, 24
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              color: Colors.deepOrangeAccent,
              child: Align(
                alignment: Alignment.center,
                child: Text("SuperDry Price History",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                 letterSpacing: 1
                ),),
              ),
            ),
            Container(
              color: Colors.deepOrangeAccent,
              child: TabBar(
                labelColor: Colors.deepOrangeAccent,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,

                indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ),
                  color: Colors.white
                ),
                tabs: <Widget>[
                  Tab( icon: Icon(Icons.calendar_today),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("1 Month",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              letterSpacing: 1),),
                    ),
                  ),
                  Tab( icon: Icon(Icons.calendar_today),
                    child: Align(
                    alignment: Alignment.center,
                    child: Text("3 Months",
                    style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),),
                  ),),
                  Tab(icon: Icon(Icons.calendar_today),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("6 Months",
                          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),),
                  //Tab(text: "All", icon: Icon(Icons.access_time),)
                  Tab(
                    icon: Icon(Icons.access_time),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("ALL",
                          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                  )
                ],
                controller: _tabController,
              ),),

            Expanded(
              child:TabBarView(
              children: <Widget>[
                Image.asset("img/camelchart.png", fit: BoxFit.fitWidth,),
                Text("this is a chart"),
                Text("test tab 3"),
                Text("Test tab 4")
              ],
              controller: _tabController,
            ),
            )
          ],
        ),
      ),
    );
  }
}


// this class creates the description column in the center of the item row
class DescriptionColumn extends StatelessWidget{
  String itemname;
  String categoryname;
  
  DescriptionColumn(String item, String category)
  {
    this.itemname = item;
    this.categoryname = category;
  }
  
  Widget build(BuildContext context){
    return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SelectableText("Lightweight Leather Track Jacket",
                  style: TextStyle(fontSize: 25.0),),
                Container(
                  height: 65,
                  alignment: Alignment(-1, 0),
                  child:Text(categoryname, textAlign: TextAlign.left,),
                ),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[



                    Container(
                        width: 142,
                        //alignment: Alignment(-1, -0),
                        child: FlatButton(
                          color: Colors.black87,
                          hoverColor: Colors.white30,
                          onPressed: () {print("pressed View at Superdry");},
                          child: Text("View at SuperDry",
                          style: TextStyle(color: Colors.white),),)
                    ),
                  ],
                )
              ],
            )
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
            //child: Spacer(flex: 1,),
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
           //child: Spacer(flex: 1,),
          ),

      ]
    );
  }

}