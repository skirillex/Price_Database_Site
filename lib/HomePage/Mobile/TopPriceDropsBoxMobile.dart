
import 'package:flutter/material.dart';

import 'TopPriceDropItemsMobile.dart';





class TopPriceDropsBoxMobile extends StatefulWidget{
  //Future<ItemPriceData> futureItemPrice;

  //TopPriceDropsBox(this.futureItemPrice);

  @override
  _TopPriceDropsBoxMobileState createState() => _TopPriceDropsBoxMobileState();
}

class _TopPriceDropsBoxMobileState extends State<TopPriceDropsBoxMobile> with SingleTickerProviderStateMixin {

  TabController _tabController;
  ScrollController _controller;
  String message = "";
   final itemSize = 200.0;

  _moveLeft(){
    _controller.animateTo(_controller.offset - itemSize, duration: Duration(milliseconds: 500), curve: Curves.linear);

  }

  _moveRight(){
    _controller.animateTo(_controller.offset + itemSize, duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);


    _controller = ScrollController();


    //_controller.addListener(_scrollListener);

    super.initState();
  }

  void printscreensize(BuildContext context)
  {
    //print(MediaQuery.of(context).size.width);

    print(MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio);
  }
  @override
  Widget build(BuildContext context) {

    //var devicePhysicalPixelWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;

    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            width: 900,
            child:  Card(
                elevation: 4,
                color: Colors.deepOrange,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Text("Top Price Drops", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 26, color: Colors.white))),
                ),
              ),

          ),
          Divider(
            color: Colors.white,
          ),
          Center(
            child: Row(

              children: <Widget>[
                GestureDetector( onTap: () {_moveLeft();}, child: Icon(Icons.arrow_back_ios, color: Colors.deepOrange,size: 30,) ),
                Container(
                  width: MediaQuery.of(context).size.width -60,
                ),
                GestureDetector( onTap: () {_moveRight();}, child: Icon(Icons.arrow_forward_ios, color: Colors.deepOrange,size: 30,) )

              ],
            ),
          ),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*
                IconButton(
                  //child: Text("left"),
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: _moveLeft,
                  color: Colors.deepOrange,
                  iconSize: 25,

                ),

                 */

                  //size: 25
                SizedBox(
                  height: 450,
                  //width: 345,
                  width: MediaQuery.of(context).size.width,// - 60,
                  child: Card(
                    elevation: 4,
                    child: Scrollbar(
                          child: ListView.builder(
                            controller: _controller,
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                            itemExtent: itemSize,  // this controls the width of the list
                            itemBuilder: (context, index){
                                // return  Container( width: 600, child: Text("Index: $index"+" $message"));
                              return TopPriceDropItems(index);
                            },
                    ),) ,
                  ),
                ),


                 //size 25
              ],
            ),
          ),
        ],
      ),
    );
  }
}