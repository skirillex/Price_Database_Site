
import 'package:colliecolliecollie/FeaturesPage/FeaturesPage.dart';
import 'package:colliecolliecollie/FeaturesPage/Mobile/FeaturesPageMobile.dart';
import 'package:colliecolliecollie/HomePage/HomeView.dart';
import 'package:colliecolliecollie/HomePage/Mobile/HomeViewMobile.dart';
import 'package:colliecolliecollie/ItemPage/ItemPage.dart';
import 'package:colliecolliecollie/ItemPage/LayoutTemplate.dart';
import 'package:colliecolliecollie/ItemPage/Mobile/LayoutTemplateMobile.dart';
import 'package:colliecolliecollie/Widgets/ResponsiveWidget.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:colliecolliecollie/ItemPage/Mobile/ItemPageMobile.dart';


class FluroRouter {

  // this handles all routing and passing parameters through URL
  static Router router = Router();

  static void setupRouter(){
    router.define("item/:itemId", handler: _itemHandler);
    router.define("/home", handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define("/login", handler: _loginHandler, );
    router.define("us/:gender/:itemcategory/:details/:id/:itemdesc", handler: _itemUrlHandler, transitionType: TransitionType.fadeIn);
    router.define("/features", handler: _featuresHandler, transitionType: TransitionType.fadeIn);

  }

  static Handler _itemHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => ResponsiveWidget(
      largeScreen: ItemPage(params['itemId'][0]),
      smallScreen: ItemPageMobile(params['itemId'][0]),
      mediumScreen: ItemPageMobile(params['itemId'][0])
    )
  );

  static Handler _itemUrlHandler = Handler (
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => ResponsiveWidget(
      largeScreen: LayoutTemplate(params['id'][0]),
      smallScreen: LayoutTemplateMobile(params['id'][0]),
      mediumScreen: LayoutTemplate(params['id'][0])
    )
  );

  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => ResponsiveWidget(
      largeScreen: HomeView(),
      smallScreen:  HomeViewMobile(),
      mediumScreen: HomeViewMobile())
  );

  static Handler _loginHandler = Handler (
    //handlerFunc: (BuildContext context, Map<String, dynamic> params) => LoginView()
  );

  static Handler _featuresHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => ResponsiveWidget(
    largeScreen: FeaturesPage(),
      smallScreen: FeaturesPageMobile(),
      mediumScreen: FeaturesPageMobile(),
    )
  );


}

