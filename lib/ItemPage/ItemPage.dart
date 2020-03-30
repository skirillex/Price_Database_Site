

import 'dart:convert';

import 'package:colliecolliecollie/Api/ItemData.dart';
import 'package:colliecolliecollie/Api/ItemPriceData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../main.dart';
import 'ChartCard.dart';
import 'DescriptionColumn.dart';
import 'PriceColumn.dart';


class ItemPage extends StatefulWidget{
  String itemId;

  ItemPage(this.itemId);

  @override
  _ItemPageState createState() => _ItemPageState();
}



class _ItemPageState extends State<ItemPage>{

  String getItemUrl;
  Future<ItemData> futureItem;
  Future<ItemPriceData> futureItemPrice;

  @override
  void initState(){
    super.initState();
    this.futureItem = fetchItem();
    this.futureItemPrice = fetchItemPrice();

  }

  Future<ItemData> fetchItem() async {
    final response = await http.get("http://127.0.0.1:5000/api/v1/resources/items/?id=${widget.itemId}");

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      return ItemData.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load item");
    }
  }
  Future<ItemPriceData> fetchItemPrice() async {
    final response = await http.get(
        "http://127.0.0.1:5000/api/v1/resources/prices/?id=${widget.itemId}");
    // item/74443

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      return ItemPriceData.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load item");
    }
  }

  @override
  Widget build(BuildContext context){

    return ListView( //SingleChildScrollView(

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
                height: 47,
                alignment: Alignment.center,//Alignment(-0.95, -0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Spacer(
                     // flex: 5,
                      // width: 80,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/home");
                      },
                      color: Colors.black,
                      hoverColor: Colors.deepOrangeAccent,
                      child: Text("Top Price Drops",
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/home");
                      },
                      color: Colors.black,
                      hoverColor: Colors.deepOrangeAccent,
                      child: Text("Features",
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/home");
                      },
                      color: Colors.black,
                      hoverColor: Colors.deepOrangeAccent,
                      child: Text("About",
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                    ),
                    Spacer(flex: 50,),
                    Spacer(),

                  ],
                )
              ),
              Container(
                height: 10,
              )
            ],
          ),
          Container( // this container creates some padding between link bar above and content below
            height: 30,
          ),
          Center(
    child:
          SizedBox(
            height: 289,
            width: 800,

            child: Card(
              elevation: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
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
                              return CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
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
                              alignment: Alignment.center,
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
              ),),),),
          Divider(
            height: 20,
            color: Colors.black,
          ),
          Align(
            alignment: Alignment.center,
            child: ChartCard(futureItemPrice),
          )
        ]
    );
  }
}
