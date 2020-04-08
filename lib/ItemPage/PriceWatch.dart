import 'package:colliecolliecollie/Api/ItemData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class PriceWatch extends StatefulWidget {

  //Future<ItemData> futureItem;

  String itemId;

  PriceWatch(String itemId)
  {
    this.itemId = itemId;
  }

  @override
  State<StatefulWidget> createState() {
    return PriceWatchState();
  }
}

class PriceWatchState extends State<PriceWatch> {
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
    String url = "http://127.0.0.1:5000/api/v1/subscriptions/alerts/";
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

  @override
  Widget build(BuildContext context) {
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
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            color: Colors.deepOrange,
                            child: Padding(
                              padding: EdgeInsets.all(6),
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
                            )),
                        Container(
                            height: 12,
                            child: Text("Successfully Created a Price Notification!", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 12, color: successColor),),
                            )
                        ),
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  width: 300,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8, top: 8, right: 8),
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
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  width: 300,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 8,
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
                            Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                      padding: EdgeInsets.only(right: 0),
                                      child: Text("Any \nPrice", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 12)),),
                                    ),
                                  ],
                                )
                            ),

                            Container(
                              height: 40,
                              width: 100,
                              margin: EdgeInsets.only(top:2,right: 12, bottom: 8, left: 12),//all(12),
                              child: RaisedButton(
                                  color: Colors.black,
                                  hoverColor: Colors.deepOrange,
                                  textColor: Colors.white,
                                  child: Text('Track!'),
                                  onPressed: _submitForm // _showWelcomeScreen
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  )))),
    );
  }
}
