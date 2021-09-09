import 'package:flutter/material.dart';
import 'package:flutter_app_api1/providers/myprovider.dart';
import 'package:flutter_app_api1/ui/pages/home_page.dart';
import 'package:flutter_app_api1/ui/pages/splach_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<HomeProvider>(
    create: (context) => HomeProvider(),
    child: MaterialApp(
      home: SplachPage(),
    ),
  ));
}




