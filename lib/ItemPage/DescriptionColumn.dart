// this class creates the description column in the center of the item row
import 'package:colliecolliecollie/Api/ItemData.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class DescriptionColumn extends StatelessWidget{
  String categoryname;

  Future<ItemData> futureItem;

  DescriptionColumn(Future<ItemData> futureItem)
  {
    this.futureItem = futureItem;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget build(BuildContext context){
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<ItemData>(
              future: futureItem,
              builder: (context, snapshot){
                if (snapshot.hasData){
                  return SelectableText("  "+snapshot.data.name,
                    style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 25)),);
                } else if (snapshot.hasError){
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),

            Container(
              height: 65,
              alignment: Alignment(-1, 0),
              child: FutureBuilder<ItemData>(
                future: futureItem,
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return Text("    "+capitalize(snapshot.data.url.split("\/")[3]), style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 15)), textAlign: TextAlign.left,); // this returns the category of the item, found in item url
                  } else if (snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
                },
              ),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 142,
                  alignment: Alignment.center,
                  //alignment: Alignment(-1, -0),
                  child: FutureBuilder<ItemData>(
                      future: futureItem,
                      builder: (context, snapshot){
                        return // this returns the category of the item, found in item url
                          RaisedButton(
                            color: Colors.black87,
                            hoverColor: Colors.deepOrange,
                            onPressed: () {print("pressed View at Superdry");url.launch("https://www.superdry.com"+snapshot.data.url);},
                            child: Text("View at SuperDry",
                              style: TextStyle(color: Colors.white),),);
                      }
                  ),
                )
              ],
            )
          ],
        )
    );
  }



}