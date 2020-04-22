import 'package:colliecolliecollie/Api/ItemData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:colliecolliecollie/Widgets/custom_expansion_panel.dart' as custom;

class PriceWatchMobile extends StatefulWidget {

  //Future<ItemData> futureItem;

  String itemId;

  PriceWatchMobile(String itemId)
  {
    this.itemId = itemId;
  }

  @override
  State<StatefulWidget> createState() {
    return PriceWatchMobileState();
  }
}

class PriceWatchMobileState extends State<PriceWatchMobile> {
  static const EdgeInsets padding = EdgeInsets.all(8);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController itemUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var successColor = Colors.white;

  List<TextEditingController> get controllers =>
      [emailController, itemUrlController, priceController];

  void initState() {
    super.initState();
  }


  List<Widget> generateItems(BuildContext context){
    double phonesize = MediaQuery.of(context).size.width;

    List<Widget> content = new List<Widget> ();

    content.add(Column(
      children: <Widget>[
        Container(
            height: 12,
            child: Text("Successfully Created a Price Notification!", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 12, color: successColor),),
            )
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 80,
                  width: phonesize < 376 ? 250 : 280,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, top: 8, right: 2),
                    child: TextFormField(
                      validator: (val) => isValidEmail(val)
                          ? null
                          : 'Please enter a valid email address',
                      decoration: InputDecoration(
                          hintText: 'Send an E-mail to',
                          icon: Icon(Icons.email)),
                      controller: emailController,
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: phonesize < 376 ? 250 : 280,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 0,
                      right: 2,
                      top: 8,
                    ),
                    child: TextFormField(
                      enabled: !isSwitched,
                      style: TextStyle(
                          color: isSwitched
                              ? Colors.white
                              : Colors.black),
                      validator: (val) => isValidPrice(val)
                          ? 'Please enter a price'
                          : null,
                      decoration: InputDecoration(
                          hintText: "Price to notify",
                          icon: Icon(Icons.attach_money)),
                      controller: priceController,
                      inputFormatters: [
                        WhitelistingTextInputFormatter
                            .digitsOnly
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 72,
                  margin: EdgeInsets.only(top:20,right: 0, bottom: 35, left: 6),//all(12),
                  child: RaisedButton(
                      color: Colors.black,
                      hoverColor: Colors.deepOrange,
                      textColor: Colors.white,
                      child: Text('Track!'),
                      onPressed: _submitForm // _showWelcomeScreen
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        SizedBox(
                          width: 30,
                          child: Checkbox(
                            activeColor: Colors.deepOrange,
                            value: isSwitched,
                            onChanged: (value){
                              setState(() {
                                isSwitched = value;
                                if (isSwitched == true)
                                {
                                  priceController.text = "0000";
                                }
                                else
                                {
                                  priceController.text = "";
                                }
                              });
                            },

                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 2),
                            child: Container(
                              width: 40,
                              child: Text("Any \nPrice", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 14)),),
                            )
                        ),
                      ],
                    )
                ),
              ],
            ),




          ],
        ),],
    ),);
    return content;
  }

  void _submitForm() {

    final FormState form = _formKey.currentState;


    if (!form.validate()) {
      print('Form is not valid!  Please review and correct.');
      setState(() {
        //errormessage = "Form is not valid!  Please review and correct.";
      });
    } else {
      //form.save(); //This invokes each onSaved event
      _makePostRequest(
          emailController.text,
          widget.itemId,
          priceController.text);
      setState(() {
        //isVisible = !isVisible;
        successColor = Colors.green;
      });
      print('========================================');
      print('Submitting to back end...');

    }
  }
  _makePostRequest(email, itemurl, pricethresh) async {
    //String url = "http://209.122.124.193:5000/api/v1/subscriptions/alerts/";
    String url = "http://3.222.198.201:5000/api/v1/subscriptions/alerts/";
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"email":"${email}", "itemId":"${itemurl}", "price":"${pricethresh}"}';

    Response response = await post(url, headers: headers, body: json);

    int statusCode = response.statusCode;
    print(statusCode);

    String body = response.body;
    print(body);
  }

  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }

  bool isValidPrice(String input) {
    final RegExp regex = new RegExp(r'^\d{1,6}$');
    return !regex.hasMatch(input);
  }

  bool isSwitched = false;
  bool isExpandedPriceWatch = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> _data = generateItems(context);
    double phonesize = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
          width: 800,
          child: Card(
              elevation: 4,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 2.0, color: Colors.deepOrange),
                          left:
                              BorderSide(width: 2.0, color: Colors.deepOrange),
                          right:
                              BorderSide(width: 2.0, color: Colors.deepOrange),
                          bottom: BorderSide(
                              width: 2.0, color: Colors.deepOrange))),
                  child: Form(
                    key: _formKey,
                    autovalidate: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          //child: Theme(
                            //data: Theme.of(context).copyWith(cardColor: Colors.deepOrange),
                            child: custom.ExpansionPanelList.radio(

                              expansionCallback: (int index, bool isExpandedPriceWatch) {
                                setState(() {
                                  //_data[index].isExpanded = !isExpanded;
                                  isExpandedPriceWatch = !isExpandedPriceWatch;
                                });
                              },
                              children: _data.map<custom.ExpansionPanel>((Widget item){
                                return custom.ExpansionPanelRadio(
                                  value: 1,//item.id,
                                  canTapOnHeader: true,
                                  headerBuilder: (BuildContext context, bool isExpandedPriceWatch)
                                  {
                                    return Container(
                                      //decoration: BoxDecoration(color: Colors.deepOrange),
                                      color: Colors.deepOrange,
                                      alignment: Alignment.topLeft,
                                      //margin: EdgeInsets.all(0),
                                      child: ListTile(
                                        title:  Container(
                                            width: 100,//double.infinity,
                                            height: 50,
                                            //color: Colors.deepOrange,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              child: Text(
                                                "Create Superdry Price Watch",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1
                                                    .merge(TextStyle(
                                                  color: Colors.white,
                                                )),
                                                textScaleFactor: .6,
                                              ),
                                            )),)
                                    );
                                  },
                                  body: ListTile(
                                      title: _data[0]//Text(item.expandedValue, style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 16, color: Colors.black)),),
                                  ),
                                  //isExpanded: item.isExpanded,
                                );
                              }).toList(),
                            ),
                          //),
                        ),

                      ],
                    ),
                  )))),
    );
  }
}
