import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget{

  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;

  const ResponsiveWidget(
      {Key key, this.largeScreen, this.mediumScreen, this.smallScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Returns the widget which is more appropriate for the screen size
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return largeScreen;
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
        //if medium screen not available, then return large screen
        return mediumScreen ?? largeScreen;
      } else {
        //if small screen implementation not available, then return large screen
        return smallScreen ?? largeScreen;
      }
    });
  }



  // large screen more than 1200 pixels
  static bool isLargeScreen(BuildContext context)
  {
    return MediaQuery.of(context).size.width > 1000;
  }

  // small screen width less than 800 pixels

  static bool isSmallScreen(BuildContext context)
  {
    return MediaQuery.of(context).size.width < 700;
  }

  // medium screen between 1200 and 800 pixels

  static bool isMediumScreen(BuildContext context)
  {
    return MediaQuery.of(context).size.width > 700 && MediaQuery.of(context).size.width < 1200;
  }

}