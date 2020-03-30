import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomePage/HomeView.dart';
import 'Router/fluro_router.dart';
import 'Router/undefined_view.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: "Superdry Price DB",
      //onGenerateRoute: router.generateRoute,
        initialRoute: '/home',
        onGenerateRoute: FluroRouter.router.generator,
        onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => UndefinedView(
              name: settings.name,
            )
        ),
      theme: ThemeData(
        //brightness: Brightness.dark,
       // primaryColor: Colors.blueGrey
       primaryColor: Colors.deepOrange,
           inputDecorationTheme: const InputDecorationTheme(
             labelStyle: TextStyle(color: Colors.black87),
             //hintStyle: TextStyle(color: Colors.black)
           )
      ),

      home: HomeView()//LayoutTemplate()

    );
  }
}
















