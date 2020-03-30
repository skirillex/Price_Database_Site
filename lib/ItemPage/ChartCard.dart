
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:colliecolliecollie/Api/ItemPriceData.dart';

import 'package:flutter/material.dart';

import 'PriceHistoryChart.dart';

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
                      return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
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
                      return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
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
                      return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
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