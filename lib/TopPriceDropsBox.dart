import 'package:flutter/material.dart';





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
   final itemSize = 100.0;

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
            height: 30,
            width: 800,
            child: Center(
              child: Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text("left"),
                    onPressed: _moveLeft,
                  ),
                  RaisedButton(
                    child: Text("right"),
                    onPressed: _moveRight,
                  )
                ],
              ),
            )
          ),
          SizedBox(
            height: 300,
            width: 800,
            child: Card(
              child: Scrollbar(
                    child: ListView.builder(
                      controller: _controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                      itemExtent: itemSize,
                      itemBuilder: (context, index){
                          return Container(width: 300, child: Text("Index: $index"+" $message"),);
                      },
              ),) ,
            ),
          ),
        ],
      ),
    );
  }
}