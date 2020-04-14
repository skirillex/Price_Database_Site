

import 'dart:convert';

import 'package:colliecolliecollie/Api/ItemData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class TpdGetImageHelperClass extends StatelessWidget {

  int itemId;
  Future<ItemData> futureItemData;

  TpdGetImageHelperClass(itemId){
    this.itemId = itemId;
    this.futureItemData = fetchItem();

  }

  Future<ItemData> fetchItem() async {
    // final response = await http.get("http://127.0.0.1:5000/api/v1/resources/items/?id=$itemId");
    final response = await http.get("http://209.122.124.193:5000/api/v1/resources/items/?id=$itemId");

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      return ItemData.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load item");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureItemData,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return Image.network(snapshot.data.img_url);
        } else if (snapshot.hasError){
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
      },
    );
  }


}