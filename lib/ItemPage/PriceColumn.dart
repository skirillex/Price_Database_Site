import 'package:colliecolliecollie/Api/ItemPriceData.dart';
import 'package:flutter/material.dart';



// this class created the price column to the right of the name of item

class PriceColumn extends StatelessWidget{ //stateless because it needs to be drawn only once once page is loaded
  String date;
  Future<ItemPriceData> futureItemPrice;


  PriceColumn(String date, Future<ItemPriceData> futureItemPrice)
  {

    this.date = date;
    this.futureItemPrice = futureItemPrice;
  }
  @override
  Widget build(BuildContext context){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder<ItemPriceData>(
            future: futureItemPrice,
            builder: (context, snapshot){
              if (snapshot.hasData){
                //print(snapshot.data.item_price[0][0]);
                String price = snapshot.data.item_price[0][0].toStringAsFixed(2);  //gets the price and converts it to 2 decimal places
                return SelectableText("\$${price}",
                  style: TextStyle(fontSize: 30,color: Colors.deepOrange),
                );
              } else if (snapshot.hasError){
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
            },
          ),

          Container(
            height: 10,
            //child: Spacer(flex: 1,),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              //alignment: Alignment(-0.9, -0.9),
                width: 100,
                child: Text("SuperDry Price    ",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 10,),
                )
            ),
          ),
          Container(
              width: 105,
              child: FutureBuilder<ItemPriceData>(
                future: futureItemPrice,
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    String date = snapshot.data.item_price[0][1];
                    date = date.substring(0,date.length -12);
                    return   Text("as of $date       ",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 10)
                    );
                  } else if (snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
                },
              )
          ),


          Container(
            height: 0,
            //child: Spacer(flex: 1,),
          ),

        ]
    );
  }

}