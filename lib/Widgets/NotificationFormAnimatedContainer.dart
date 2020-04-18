

import 'dart:math';

import 'package:colliecolliecollie/Widgets/GetNotifiedForm.dart';
import 'package:flutter/material.dart';


class NotificationFormAnimatedContainer extends StatefulWidget{
  double padding;
  NotificationFormAnimatedContainer(double this.padding, {Key  key}) : super(key:key);


  @override
  State<StatefulWidget> createState() => NotificationFormAnimatedContainerState();

}

class NotificationFormAnimatedContainerState extends State<NotificationFormAnimatedContainer>{

  double width = 300;
  double height = 0;

  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  bool open = false;


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0,0, widget.padding,0),
        child:
        Card(
          elevation: 8,
          child: GetNotifiedForm()//NotificationForm()
        ),
      ),
    );


  }

  void opencloseform()
  {
    double phonesize = MediaQuery.of(context).size.width;

    setState(() {

      if ( open == false) {
        height = phonesize < 501 ? 416 : 460;
        open = true;
      }
      else
        {
          height = 0;
          open = false;
        }
    }
    );
  }

  void closeform()
  {
    setState(() {
      height = 0;
      open = false;
    });
  }

}