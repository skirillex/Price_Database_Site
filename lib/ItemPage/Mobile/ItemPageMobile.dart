import 'dart:convert';

import 'package:colliecolliecollie/Api/ItemData.dart';
import 'package:colliecolliecollie/Api/ItemPriceData.dart';
import 'package:colliecolliecollie/Widgets/Linkbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:colliecolliecollie/ItemPage/ChartCard.dart';
import 'DescriptionColumnMobile.dart';
import 'PriceColumnMobile.dart';
import 'PriceWatchMobile.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class ItemPageMobile extends StatefulWidget {
  String itemId;

  ItemPageMobile(this.itemId);

  @override
  _ItemPageMobileState createState() => _ItemPageMobileState();
}

class _ItemPageMobileState extends State<ItemPageMobile> {
  String getItemUrl;
  Future<ItemData> futureItem;
  Future<ItemPriceData> futureItemPrice;

  @override
  void initState() {
    super.initState();
    this.futureItem = fetchItem();
    this.futureItemPrice = fetchItemPrice();
  }

  Future<ItemData> fetchItem() async {
    final response = await http.get(
        "http://209.122.124.193:5000/api/v1/resources/items/?id=${widget.itemId}");

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      return ItemData.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load item");
    }
  }

  Future<ItemPriceData> fetchItemPrice() async {
    final response = await http.get(
        "http://209.122.124.193:5000/api/v1/resources/prices/?id=${widget.itemId}");
    // item/74443

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      return ItemPriceData.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load item");
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    double phonesize = MediaQuery.of(context).size.width;
    return ListView(
        //SingleChildScrollView(

        // padding: const EdgeInsets.all(8),
        //physics: const ScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        children: <Widget>[
          Linkbar(),
          Container(
            // this container creates some padding between link bar above and content below
            height: 30,
          ),
          Center(
            child: SizedBox(
              height: 250,
              width: 800,
              child: Card(
                elevation: 4,
                child: Row(
                  children: <Widget>[
                    Container(
                      //alignment: Alignment.centerLeft,
                      //height: 300,
                      //width: 200,
                      child: FutureBuilder<ItemData>(
                        future: futureItem,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(snapshot
                                .data.img_url); //Text(snapshot.data.name);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepOrange),
                          );
                        },
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            //height: 10,
                            alignment: Alignment.center,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: DescriptionColumnMobile(futureItem),
                          ),
                          Row(

                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 15,
                                        width: 80, //120
                                        //alignment: Alignment(-1, 0),
                                        child: FutureBuilder<ItemData>(
                                          future: futureItem,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                    capitalize(snapshot.data.url.split("\/")[3]),
                                                style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: phonesize < 376 ? 13 : 15)), textAlign: TextAlign.left,
                                              ); // this returns the category of the item, found in item url
                                            } else if (snapshot.hasError) {
                                              return Text("${snapshot.error}");
                                            }
                                            return CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.deepOrange),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    //alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          phonesize < 376 ? 0 : 5, 100, 5, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: phonesize < 376 ? 75 : 118, //118
                                            child: FutureBuilder<ItemData>(
                                                future: futureItem,
                                                builder: (context, snapshot) {
                                                  return // this returns the category of the item, found in item url
                                                      RaisedButton(
                                                          focusColor: Colors
                                                              .deepOrangeAccent,
                                                          color: Colors.black87,
                                                          hoverColor:
                                                              Colors.deepOrange,
                                                          onPressed: () {
                                                            print(
                                                                "pressed View at Superdry");
                                                            url.launch(
                                                                "https://www.superdry.com" +
                                                                    snapshot
                                                                        .data
                                                                        .url);
                                                          },
                                                          child: Text(
                                                            "View at SuperDry",
                                                            style:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .display1
                                                                    .merge(
                                                                      TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: phonesize < 376
                                                                              ? 10
                                                                              : 11),//11
                                                                    ),
                                                          ));
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          height: 110, //120
                                        ),
                                        PriceColumnMobile(
                                            "2020-03-09", futureItemPrice),

                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 20,
            color: Colors.white,
          ),
          PriceWatchMobile(widget.itemId),
          Divider(
            height: 20,
            color: Colors.white,
          ),
          Align(
            alignment: Alignment.center,
            child: ChartCard(futureItemPrice),
          )
        ]);
  }
}
