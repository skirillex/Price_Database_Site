
import 'package:flutter/material.dart';

import 'TopPriceDropItems.dart';





class TopPriceDropsBox extends StatefulWidget{
  //Future<ItemPriceData> futureItemPrice;

  //TopPriceDropsBox(this.futureItemPrice);

  @override
  _TopPriceDropsBoxState createState() => _TopPriceDropsBoxState();
}

class _TopPriceDropsBoxState extends State<TopPriceDropsBox> with SingleTickerProviderStateMixin {

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

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            width: 900,
            child: Center(
              child: Row(
                children: <Widget>[


                  Text("Top Price Drops", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)

                  // I personally really like these button close together on top, as this code will do
                  /*
                  RaisedButton(
                    child: Text("left"),
                    onPressed: _moveLeft,
                  ),
                  RaisedButton(
                    child: Text("right"),
                    onPressed: _moveRight,
                  )
                   */
                ],
              ),
            )
          ),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  //child: Text("left"),
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: _moveLeft,
                  color: Colors.deepOrange,
                  iconSize: 50,

                ),
                SizedBox(
                  height: 450,
                  width: 900,
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
                IconButton(
                  //child: Text("right"),
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: _moveRight,
                  color: Colors.deepOrange,
                  iconSize: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}