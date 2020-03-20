import 'dart:convert';

import 'package:colliecolliecollie/LayoutTemplate.dart';
import 'package:colliecolliecollie/Views.dart';
import 'package:colliecolliecollie/undefined_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:charts_flutter/flutter.dart' as charts;

import 'package:intl/intl.dart';

import 'package:colliecolliecollie/fluro_router.dart';



void main() {
  FluroRouter.setupRouter();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: "Superdry Price DB",
      //onGenerateRoute: router.generateRoute,
        initialRoute: '/home',
        onGenerateRoute: FluroRouter.router.generator,
        onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => UndefinedView(
              name: settings.name,
            )
        ),



      /*
      builder: (context, child) => LayoutTemplate(
          child: child,
      ),
      \
       */


      theme: ThemeData(
        //brightness: Brightness.dark,
       // primaryColor: Colors.blueGrey
       primaryColor: Colors.deepOrange,
           inputDecorationTheme: const InputDecorationTheme(
             labelStyle: TextStyle(color: Colors.black87),
             //hintStyle: TextStyle(color: Colors.black)
           )
      ),

      home: HomeView()//LayoutTemplate()

      /*Scaffold(
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
                        child: FutureBuilder<ItemData>(
                          future: futureItem,
                          builder: (context, snapshot){
                            if (snapshot.hasData){
                              return Image.network(snapshot.data.img_url);  //Text(snapshot.data.name);
                            } else if (snapshot.hasError){
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        )
                    )
                  ),
                  Flexible(
                    flex: 2,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Container(
                      height: 100,
                      ),
                      DescriptionColumn(futureItem)
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
                        PriceColumn("2020-03-09",futureItemPrice),
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
                child: ChartCard(futureItemPrice),
              ),
              Row(
                children: <Widget>[
                  //Text(fetchItem()),
                  FutureBuilder<ItemPriceData>(
                    future: futureItemPrice,
                    builder: (context, snapshot){
                      if (snapshot.hasData){
                        print(snapshot.data.item_price);
                        return Text("printed");
                      } else if (snapshot.hasError){
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  )
                ],
              )
              ]
          )
        ),*/
      
    );
  }
}



class ChartCard extends StatefulWidget{
  Future<ItemPriceData> futureItemPrice;

  ChartCard(this.futureItemPrice);

  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> with SingleTickerProviderStateMixin{

  TabController _tabController;
  @override
  void initState(){
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);
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
                //Image.asset("img/camelchart.png", fit: BoxFit.fitWidth,),  // camelplaceholderimage
                FutureBuilder<ItemPriceData>(
                  future: widget.futureItemPrice,
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return PriceHistoryChart(snapshot.data.item_price,30, true);
                    } else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
                FutureBuilder<ItemPriceData>(
                  future: widget.futureItemPrice,
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return PriceHistoryChart(snapshot.data.item_price,90, true);
                    } else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
                FutureBuilder<ItemPriceData>(
                  future: widget.futureItemPrice,
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return PriceHistoryChart(snapshot.data.item_price,180, true);
                    } else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
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
  String categoryname;

  Future<ItemData> futureItem;

  DescriptionColumn(Future<ItemData> futureItem)
  {
    this.futureItem = futureItem;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  
  Widget build(BuildContext context){
    return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<ItemData>(
                  future: futureItem,
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return SelectableText(snapshot.data.name,
                        style: TextStyle(fontSize: 25.0),);
                    } else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),

                Container(
                  height: 65,
                  alignment: Alignment(-1, 0),
                  child: FutureBuilder<ItemData>(
                    future: futureItem,
                    builder: (context, snapshot){
                      if (snapshot.hasData){
                        return Text(capitalize(snapshot.data.url.split("\/")[3]), textAlign: TextAlign.left,); // this returns the category of the item, found in item url
                      } else if (snapshot.hasError){
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
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
                          onPressed: () {print("pressed View at Superdry");Navigator.pushNamed(context, '/home');},
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
  String date;
  Future<ItemPriceData> futureItemPrice;


  PriceColumn(String date, Future<ItemPriceData> futureItemPrice)
  {

    this.date = date;
    this.futureItemPrice = futureItemPrice;
  }
  @override
  Widget build(BuildContext context){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder<ItemPriceData>(
            future: futureItemPrice,
            builder: (context, snapshot){
              if (snapshot.hasData){
                //print(snapshot.data.item_price[0][0]);
                String price = snapshot.data.item_price[0][0].toStringAsFixed(2);  //gets the price and converts it to 2 decimal places
                return SelectableText("\$${price}",
                  style: TextStyle(fontSize: 30,color: Colors.red),
                );
              } else if (snapshot.hasError){
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
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
          width: 105,
          child: FutureBuilder<ItemPriceData>(
            future: futureItemPrice,
            builder: (context, snapshot){
              if (snapshot.hasData){
                String date = snapshot.data.item_price[0][1];
                date = date.substring(0,date.length -12);
                return   Text("as of $date",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 10)
                );
              } else if (snapshot.hasError){
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          )
        ),


          Container(
            height: 20,
           //child: Spacer(flex: 1,),
          ),

      ]
    );
  }

}


class PriceHistoryChart extends StatelessWidget {
  List<charts.Series> seriesList;
  bool animate;
  List prices;
  DateTime currentDate;
  int daysback;
  // PriceHistoryChart(this.seriesList, this.prices, {this.animate});
  double lowprice;
  var lowpricedate;
  double highprice;
  var highpricedate;

  PriceHistoryChart(List prices,int daysback, bool animate)
  {
    this.prices = prices;
    this.animate = animate;
    this.daysback = daysback;
    this.currentDate = DateTime.now();
    this.seriesList = _loadPriceData();
  }

/*
  factory PriceHistoryChart.withPriceData(){
    return new PriceHistoryChart(
      _loadPriceData(),
      animate: true,
    );
  }

 */

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(seriesList, animate: animate, behaviors: [
      new charts.RangeAnnotation([
        new charts.RangeAnnotationSegment(
            currentDate.subtract(Duration(days: daysback)), currentDate, //new DateTime(currentDate.year, currentDate.month,currentDate.day),
            charts.RangeAnnotationAxisType.domain),
        new charts.LineAnnotationSegment(findLowHighPrice(daysback), charts.RangeAnnotationAxisType.measure, startLabel: "\$${lowprice.toStringAsFixed(2)}", labelStyleSpec: charts.TextStyleSpec(color: charts.MaterialPalette.green.shadeDefault) ,color: charts.MaterialPalette.green.shadeDefault, dashPattern: [4, 4]),
        new charts.LineAnnotationSegment(highprice, charts.RangeAnnotationAxisType.measure, endLabel: "\$${highprice.toStringAsFixed(2)}", labelStyleSpec: charts.TextStyleSpec(color:  charts.MaterialPalette.red.shadeDefault) ,color: charts.MaterialPalette.red.shadeDefault, dashPattern: [4, 4]),
      ]),
      new charts.ChartTitle(" ",subTitle: "Lowest: \$${lowprice.toStringAsFixed(2)} (${new DateFormat.MMMd().format(lowpricedate)})                Highest: \$${highprice.toStringAsFixed(2)} (${new DateFormat.MMMd().format(highpricedate)})", subTitleStyleSpec: charts.TextStyleSpec(color: charts.MaterialPalette.gray.shadeDefault), behaviorPosition: charts.BehaviorPosition.bottom, titleOutsideJustification: charts.OutsideJustification.start),
    ]);
  }
    // TODO possibly add a selection Callback to chart to make selecting points dynamic https://google.github.io/charts/flutter/example/behaviors/selection_callback_example

    // TODO need to add functionality for showing all date ranges

    List<charts.Series<TimeSeriesPriceHistory, DateTime>> _loadPriceData() {

     List<TimeSeriesPriceHistory> data = [];

      for (var i in prices){

        var parsedDate = DateTime.parse(i[1]); // converts date string back to datetime object

        data.add(TimeSeriesPriceHistory(new DateTime( parsedDate.year, parsedDate.month, parsedDate.day), i[0]));
      }
      return [
          new charts.Series<TimeSeriesPriceHistory, DateTime>(
              id: 'Prices ',
              domainFn: (TimeSeriesPriceHistory prices, _) => prices.time,
              measureFn: (TimeSeriesPriceHistory prices, _) => prices.price,
              data: data
          )
        ];
    }

    double findLowHighPrice(int daysprev)
    {
      // helper method to find low price and high price for low and high price calculations in graph
      double lowestPrice = 99999999;
      var lowestPriceDate;
      double highestPrice = 0;
      var highestPriceDate;

      for (var i in prices)
        {
          if (DateTime.parse(i[1]).isAfter(currentDate.subtract(Duration(days: daysprev,))))
            {
              if (i[0] < lowestPrice)
                {
                  lowestPrice = i[0];
                  lowestPriceDate = DateTime.parse(i[1]);
                }
              if (i[0] > highestPrice)
                {
                  highestPrice = i[0];
                  highestPriceDate = DateTime.parse(i[1]);
                }
            }
        }
      this.lowprice = lowestPrice;
      this.lowpricedate = lowestPriceDate; //new DateFormat.MMMd(lowestPriceDate);
      this.highprice = highestPrice;
      this.highpricedate = highestPriceDate;

      return lowestPrice;
    }
  }

  class TimeSeriesPriceHistory {
  final DateTime time;
  final double price;

  TimeSeriesPriceHistory(this.time, this.price);
  }

class ItemData {
  int product_id;
  String name;
  String url;
  String img_url;

  ItemData({this.product_id, this.name, this.img_url, this.url});

  factory ItemData.fromJson(Map<String, dynamic> json)
  {
    return ItemData(
      product_id: json["item_id"],
      name: json["name"],
      url: json["url"],
      img_url: json["img_url"],
    );
  }

}
class ItemPriceData {
  List item_price;

  ItemPriceData({this.item_price});

  factory ItemPriceData.fromJson(Map<String, dynamic> json)
  {
    return ItemPriceData(
      item_price: json["item_price"]
    );
  }

}


