import 'package:cl3_t6nn_rodriguez_leon_mitchell/src/pages/home_page.dart';
import 'package:cl3_t6nn_rodriguez_leon_mitchell/src/pages/list_page.dart';
import 'package:cl3_t6nn_rodriguez_leon_mitchell/src/pages/register_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder> {
    '/' : (BuildContext context) => HomePage(),
    'list' : (BuildContext context) => ListPage(),
    'create' : (BuildContext context) => RegisterPage()
  };
}