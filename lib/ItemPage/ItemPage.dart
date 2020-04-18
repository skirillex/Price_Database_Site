import 'dart:convert';

import 'package:colliecolliecollie/Api/ItemData.dart';
import 'package:colliecolliecollie/Api/ItemPriceData.dart';
import 'package:colliecolliecollie/Widgets/Linkbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'ChartCard.dart';
import 'DescriptionColumn.dart';
import 'PriceColumn.dart';
import 'PriceWatch.dart';

class ItemPage extends StatefulWidget {
  String itemId;

  ItemPage(this.itemId);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
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

  @override
  Widget build(BuildContext context) {
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
              height: 286,
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
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image.network(snapshot.data
                                      .img_url); //Text(snapshot.data.name);
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.deepOrange),
                                );
                              },
                            ))),
                    Flexible(
                        flex: 2,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 100,
                                alignment: Alignment.center,
                              ),
                              DescriptionColumn(futureItem)
                            ])),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 202,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 2, 0),
                            child: PriceColumn("2020-03-09", futureItemPrice),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 20,
            color: Colors.white,
          ),
          PriceWatch(widget.itemId),
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
