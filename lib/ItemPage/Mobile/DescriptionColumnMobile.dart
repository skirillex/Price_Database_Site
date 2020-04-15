// this class creates the description column in the center of the item row
import 'package:colliecolliecollie/Api/ItemData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class DescriptionColumnMobile extends StatelessWidget{
  String categoryname;

  Future<ItemData> futureItem;

  DescriptionColumnMobile(Future<ItemData> futureItem)
  {
    this.futureItem = futureItem;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget build(BuildContext context){

    double phonesize = MediaQuery.of(context).size.width;

    return Container(

        child: Column(
          children: <Widget>[
            SizedBox(
              width: phonesize < 376 ? 190 : 200,
              child: FutureBuilder<ItemData>(
                future: futureItem,
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return SelectableText(snapshot.data.name,
                      style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: phonesize < 376 ? 18 : 19)),);
                  } else if (snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
                },
              ),
            ),


            /*
                        Container(
              height: 65,
              alignment: Alignment(-1, 0),
              child: FutureBuilder<ItemData>(
                future: futureItem,
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return Text("    "+capitalize(snapshot.data.url.split("\/")[3]), style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: phonesize < 376 ? 12 : 15)), textAlign: TextAlign.left,); // this returns the category of the item, found in item url
                  } else if (snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(phonesize < 376 ? 3 : 10, 0, 0, 0),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: phonesize < 376 ? 110 : 118,
                    alignment: Alignment.center,
                    //alignment: Alignment(-1, -0),
                    child: FutureBuilder<ItemData>(
                        future: futureItem,
                        builder: (context, snapshot){
                          return // this returns the category of the item, found in item url
                            RaisedButton(
                              focusColor: Colors.deepOrangeAccent,
                              color: Colors.black87,
                              hoverColor: Colors.deepOrange,
                              onPressed: () {print("pressed View at Superdry");url.launch("https://www.superdry.com"+snapshot.data.url);},
                              child: Text("View at SuperDry",
                                style: Theme.of(context).textTheme.display1.merge(TextStyle(color: Colors.white , fontSize: phonesize < 376 ? 9 : 11),),));
                        }
                    ),
                  )
                ],
              ),
            )
             */
          ],
        )
    );
  }



}