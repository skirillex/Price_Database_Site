

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';


class TopPriceDropItems extends StatefulWidget{
  String itemId;

  TopPriceDropItems(this.itemId);

  @override
  _TopPriceDropItemsState createState() => _TopPriceDropItemsState();
}

class _TopPriceDropItemsState extends State<TopPriceDropItems>{


  Future<ItemData> futureItem;
  Future<ItemPriceData> futureItemPrice;

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}