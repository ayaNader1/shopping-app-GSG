import 'package:flutter/material.dart';
import 'package:flutter_app_api1/models/product_response.dart';
import 'package:flutter_app_api1/providers/myprovider.dart';
import 'package:flutter_app_api1/ui/pages/cart_page.dart';
import 'package:flutter_app_api1/ui/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'fav_page.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Shopping App'),
          bottom: TabBar(isScrollable: true, tabs: [
            Tab(
              text: 'Home',
            ),
            Tab(
              text: 'Favorite',
            ),
            Tab(
              text: 'Cart',
            ),
          ]),
        ),
        body: Provider.of<HomeProvider>(context).allProducts == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : TabBarView(children: [
          HomePage(),
          FavoritePage(),
          CartPage(),
        ]),
      ),
    );
  }
}
