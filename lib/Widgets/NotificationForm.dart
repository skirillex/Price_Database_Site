import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationForm extends StatefulWidget{

  @override
  NotificationFormState createState() {
    return NotificationFormState();
  }
}

class NotificationFormState extends State<NotificationForm>{
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
        SignUpForm()
        ],
      ),
    );
  }

}


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>
    with SingleTickerProviderStateMixin {
  // STEP 3: Add an AnimationController and add the
  // AnimatedBuilder with a LinearProgressIndicator to the Column

  AnimationController animationController;
  Animation<Color> colorAnimation;

  bool _formCompleted = false;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200)
    );

    var colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    colorAnimation = animationController.drive(colorTween);
  }








  //this below validates the data

  ///////////////////////////////////////////////////////////////
  /*

            TextFormField(
            validator: (value){
              if (value.isEmpty){
                return "please enter some text";
              }
              return null;
            }
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()){
                Scaffold
                .of(context)
                    .showSnackBar(SnackBar(content: Text("Processing data"),));
              }

            },
            child: Text("Submit"),
          )

   */


  //////////////////////////////////////////////////////////////


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child){
            return LinearProgressIndicator(
              value: animationController.value,
              valueColor: colorAnimation,
              backgroundColor: colorAnimation.value.withOpacity(0.4),
            );
          },
        ),
        SignUpFormBody(
          onProgressChanged: (progress) {

            if (!animationController.isAnimating){
              animationController.animateTo(progress);
            }
            // STEP 2: Create a _formCompleted field on this class
            // and set it here when the progress is 1
            setState((){
              //_formCompleted = progress == 1;
              if (progress == 1)
              {
                _formCompleted = true;
              }
            });

          },
        ),

      ],
    );
  }
}

class SignUpFormBody extends StatefulWidget {
  final ValueChanged<double> onProgressChanged;

  SignUpFormBody({
    @required this.onProgressChanged,
  }) : assert(onProgressChanged != null);

  @override
  _SignUpFormBodyState createState() => _SignUpFormBodyState();
}

class _SignUpFormBodyState extends State<SignUpFormBody> {
  static const EdgeInsets padding = EdgeInsets.all(8);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController itemUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<TextEditingController> get controllers =>
      [emailController, itemUrlController, priceController];

  @override
  void initState() {
    super.initState();
    controllers.forEach((c) => c.addListener(() => _updateProgress()));
  }

  double get _formProgress {
    var progress = 0.0;
    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }
    return progress;
  }

  void _updateProgress() {
    widget.onProgressChanged(_formProgress);
  }

  /*
  void _showWelcomeScreen(){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

   */

  bool isVisible = true;


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: padding,
      child:
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: isVisible
            ? Column(
                children: <Widget> [
                  Padding(
                    padding: padding,
                    child: Text('Create a Price Watch', style: Theme.of(context).textTheme.display1),
                  ),
                  SignUpField(
                    hintText: 'E-mail address',
                    controller: emailController,
                  ),
                  SignUpField(
                    hintText: 'Item url',
                    controller: itemUrlController,
                  ),
                  SignUpField(
                    hintText: 'Price to notify',
                    controller: priceController,
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    margin: EdgeInsets.all(12),
                    child: RaisedButton(
                      color: Colors.black,
                      hoverColor: Colors.deepOrange,
                      textColor: Colors.white,
                      // STEP 1: Add a callback here and navigate to
                      // the welcome screen when the button is tapped.
                      /*
            onPressed: _formCompleted ? _showWelcomeScreen : null,

             */
                      child: Text('Track!'),
                      onPressed: (){ print(emailController.text); print(itemUrlController.text); print(priceController.text);
                        setState(() {isVisible = !isVisible;});},  // _showWelcomeScreen
                    ),
                  ),
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
                    child:
                  Container(
                    height: 50,
                    child: Text("Success!", style: Theme.of(context).textTheme.display1,))
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:
                      RaisedButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        hoverColor: Colors.deepOrange,

                        child: Text("Another one"),
                        onPressed: () {setState(() {
                          isVisible = !isVisible;
                        });},
                      )
                    )
                ],
              ),
            )
          ),



    );
  }
}


class SignUpField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  SignUpField({
    @required this.hintText,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        decoration: InputDecoration(hintText: hintText),
        controller: controller,
      ),
    );
  }
}