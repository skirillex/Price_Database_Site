import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class GetNotifiedForm extends StatefulWidget {
  GetNotifiedForm({Key key}) : super(key: key);



  @override
  GetNotifiedFormState createState() {
    return GetNotifiedFormState();
  }
}

class GetNotifiedFormState extends State<GetNotifiedForm>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  static const EdgeInsets padding = EdgeInsets.all(8);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController itemUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<TextEditingController> get controllers =>
      [emailController, itemUrlController, priceController];

  void initState() {
    super.initState();

  } // containts animation controller tween

  double get _formProgress {
    var progress = 0.0;
    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }
    return progress;
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

  bool isVisible = true;

  bool _formCompleted = true;

  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }

  bool isValidPrice(String input) {
    final RegExp regex = new RegExp(r'^\d{1,6}$');
    return !regex.hasMatch(input);
  }
  bool isValidWebsite(String input) {
    // this needs some tweaking to get perfect currently doesn't account for http://
    final RegExp regex = new RegExp(r'^[\d\D]+[/][\d\D]+[/][\d\D]+[/][\d\D]+[/][\d\D]+[/][\d\D]+[/][\d\D]*$');
    return regex.hasMatch(input);
  }

  String errormessage = "";

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      print('Form is not valid!  Please review and correct.');
      setState(() {
        errormessage = "Form is not valid!  Please review and correct.";
      });
    } else {
      //form.save(); //This invokes each onSaved event
      _makePostRequest(
          emailController.text,
          itemUrlController.text
              .substring(itemUrlController.text
              .indexOf("us"))
              .split("\/")[4],
          priceController.text);

      setState(() {
        isVisible = !isVisible;
      });
      print('========================================');
      print('Submitting to back end...');

    }
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidate: true,
        child: Column(children: <Widget>[
          /*AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: animationController.value,
                valueColor: colorAnimation,
                backgroundColor: colorAnimation.value.withOpacity(0.4),
              );
            },
          ),

           */
          Padding( 
              padding: padding,
              child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: isVisible
                      ? Column(children: <Widget>[
                          Padding(
                            padding: padding,
                            child: Text('Create a Price Watch',
                                style: Theme.of(context).textTheme.display1),
                          ),
                          Container(
                            height: 80,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                validator: (val) =>
                                isValidEmail(val) ? null : 'Please enter a valid email address',
                                decoration:
                                InputDecoration(hintText: 'E-mail address', icon: Icon(Icons.email)),
                                controller: emailController,
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                validator: (val) => isValidWebsite(val)
                                    ? null
                                    : 'Enter a valid Superdry URL',
                                decoration: InputDecoration(hintText: 'Item url', icon: Icon(Icons.web)),
                                controller: itemUrlController,
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                              child:
                          Padding(
                            padding: EdgeInsets.only(left: 8, right: 8, top: 8,),
                            child: TextFormField(
                              enabled: !isSwitched,
                              style: TextStyle(color: isSwitched ? Colors.white : Colors.black),
                              validator: (val) =>
                              isValidPrice(val)  ? 'Please enter a price' : null,
                              decoration:
                              InputDecoration(hintText: "Price to notify", icon: Icon(Icons.attach_money)),
                              controller: priceController,
                              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                            ),
                          ),),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 2),
                                    child: Text("Any Price Lower", style: Theme.of(context).textTheme.display1.merge(TextStyle(fontSize: 12)),),
                                  ),
                                  Switch(
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
                                ],
                              )
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              margin: EdgeInsets.only(top:2,right: 12, bottom: 12, left: 12),//all(12),
                              child: RaisedButton(
                                  color: Colors.black,
                                  hoverColor: Colors.deepOrange,
                                  textColor: Colors.white,
                                  child: Text('Track!'),
                                  onPressed: _submitForm // _showWelcomeScreen
                              ),
                            ),
                          ),
                          Container(
                            height: 10,
                            child: Text(errormessage, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.redAccent),),
                          )
                        ])
                      : Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 80,
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 50,
                                      child: Text(
                                        "Success!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1,
                                      ))),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: RaisedButton(
                                    color: Colors.black,
                                    textColor: Colors.white,
                                    hoverColor: Colors.deepOrange,
                                    child: Text("Another one"),
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                        emailController.clear();
                                        priceController.clear();
                                        itemUrlController.clear();
                                        errormessage = "";
                                      });
                                    },
                                  ))
                            ],
                          ),
                        )))
        ]));
  }
}
