import 'dart:convert';

import 'package:colliecolliecollie/Api/ItemData.dart';
import 'package:colliecolliecollie/Widgets/Hyperlink.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class TpdGetItemNameAndLinkHelperClass extends StatelessWidget {

  int itemId;
  Future<ItemData> futureItemData;

  TpdGetItemNameAndLinkHelperClass(itemId){
    this.itemId = itemId;
    this.futureItemData = fetchItem();

  }

  Future<ItemData> fetchItem() async {
    final response = await http.get("http://3.222.198.201:5000/api/v1/resources/items/?id=$itemId");

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
          return Container(
            height: 40,
            child: Hyperlink("https://www.superdry.com"+snapshot.data.url, snapshot.data.name)
          );
        } else if (snapshot.hasError){
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
      },
    );
  }


}