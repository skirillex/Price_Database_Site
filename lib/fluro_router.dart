import 'package:colliecolliecollie/ItemPage.dart';
import 'package:colliecolliecollie/LayoutTemplate.dart';
import 'package:colliecolliecollie/Views.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';


class FluroRouter {

  // this handles all routing and passing parameters through URL
  static Router router = Router();

  static void setupRouter(){
    router.define("item/:itemId", handler: _itemHandler);
    router.define("/home", handler: _homeHandler);
    router.define("/login", handler: _loginHandler);
    router.define("us/:gender/:itemcategory/:details/:id/:itemdesc", handler: _itemUrlHandler);

  }

  static Handler _itemHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => ItemPage(params['itemId'][0])
  );

  static Handler _itemUrlHandler = Handler (
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => LayoutTemplate(params['id'][0])
  );

  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => HomeView()
  );

  static Handler _loginHandler = Handler (
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => LoginView()
  );


/*
  static String getIdFromUrl(String urlPath)
  {
    var urlArray = urlPath.split("/");

    for (int i = 0; i < urlArray.length; i++)
      {
        if (urlArray[i] == "details")
          {
            return urlArray[i+1];
          }
      }
  }

 */

}

