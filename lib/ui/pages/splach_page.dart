import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_api1/providers/myprovider.dart';
import 'package:flutter_app_api1/ui/pages/home_page.dart';
import 'package:provider/provider.dart';

class SplachPage extends StatefulWidget{
  @override
  _SplachPageState createState() => _SplachPageState();
}

class _SplachPageState extends State<SplachPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeProvider>(context,listen: false).getAllCategories();
    Provider.of<HomeProvider>(context,listen: false).getAllProducts();
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return HomePage();
      }));
    });

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}