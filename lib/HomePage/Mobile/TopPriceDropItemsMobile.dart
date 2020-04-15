

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'TopPriceDropsDataMobile.dart';
import 'TpdGetImageHelperClassMobile.dart';
import 'TpdGetItemNameAndLinkHelperClassMobile.dart';


class TopPriceDropItems extends StatefulWidget{
  //String itemId;
  int index;
  TopPriceDropItems(this.index);  // use with widget.index

  @override
  _TopPriceDropItemsState createState() => _TopPriceDropItemsState();
}

class _TopPriceDropItemsState extends State<TopPriceDropItems>{

  Future<TopPriceDropsData> futurePriceDropItems;

  @override
  void initState() {
    super.initState();

    this.futurePriceDropItems = fetchPriceDropItems();



  }

  Future<TopPriceDropsData> fetchPriceDropItems() async {
    final response = await http.get("http://209.122.124.193:5000/api/v1/resources/topprices/");

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      return TopPriceDropsData.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load item");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
    child:
      Container(
        padding: EdgeInsets.all(5),
        width: 800,
        height: 450,
        child:
              FutureBuilder(
                future: futurePriceDropItems,
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    // DEBUG
                    // print(snapshot.data.top_price_drops[widget.index][0]);
                    int productid = snapshot.data.top_price_drops[widget.index][0];
                    // return Text("$productid");
                    List itemdataprice = snapshot.data.top_price_drops[widget.index][1];
                    return Column(
                      children: <Widget>[
                        TpdGetImageHelperClass(productid),
                        Divider(color: Colors.white),
                        TpdGetItemNameAndLinkHelperClass(productid),
                        Divider(color: Colors.white),
                        Text("\$${itemdataprice[7].toStringAsFixed(2)}", style: TextStyle(color: Colors.deepOrange, fontSize: 25, fontWeight: FontWeight.bold),),
                        Text("Previous price: \$"+itemdataprice[3].toStringAsFixed(2)),
                        Divider(color: Colors.white,),
                        RaisedButton(color: Colors.black,
                        hoverColor: Colors.deepOrange,
                        onPressed: () {
                            Navigator.pushNamed(context, "us/searching/the/price/$productid/db");
                              },
                          child: Text("See Item", style: TextStyle(color: Colors.white),),)
                      ],
                    );
                  } else if (snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
                },
              ),
        ),
    );
  }


}