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



  /*
  void _showWelcomeScreen(){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

   */



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
        Container(
          height: 40,
          width: double.infinity,
          margin: EdgeInsets.all(12),
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            // STEP 1: Add a callback here and navigate to
            // the welcome screen when the button is tapped.
            /*
            onPressed: _formCompleted ? _showWelcomeScreen : null,

             */
            child: Text('Sign up'),
          ),
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
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  List<TextEditingController> get controllers =>
      [emailController, phoneController, websiteController];

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            controller: phoneController,
          ),
          SignUpField(
            hintText: 'Price to notify',
            controller: websiteController,
          ),
        ],
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
