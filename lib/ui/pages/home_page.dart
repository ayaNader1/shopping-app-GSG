import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_api1/data/api_helper.dart';
import 'package:flutter_app_api1/models/product_response.dart';
import 'package:flutter_app_api1/providers/myprovider.dart';
import 'package:flutter_app_api1/ui/pages/product_details.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Consumer<HomeProvider>(
          builder: (context, provider, x) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                provider.allProducts == null
                    ? Container(
                        color: Colors.white,
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        height: 200,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CarouselSlider(
                            items: provider.allProducts
                                .map((e) =>
                                    CachedNetworkImage(imageUrl: e.image))
                                .toList(),
                            options: CarouselOptions(
                              height: 400,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                            )),
                      ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    'All Categories',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: provider.allCategories
                        .map((e) => GestureDetector(
                              onTap: () {
                                provider.getCategoryProducts(e);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                decoration: BoxDecoration(
                                  color: provider.selectedCategory == e
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(e[0].toUpperCase() + e.substring(1),
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white)),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: provider.categoryProducts == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: provider.categoryProducts == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10),
                                  itemCount: provider.categoryProducts.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        provider.getSpecificProduct(provider
                                            .categoryProducts[index].id);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ProductDetails();
                                        }));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: CachedNetworkImage(
                                                imageUrl: provider
                                                    .categoryProducts[index]
                                                    .image,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(provider
                                                    .categoryProducts[index]
                                                    .title),
                                                Text('Price: ' +
                                                    provider
                                                        .categoryProducts[index]
                                                        .price
                                                        .toString() +
                                                    '\$'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )),
                )
              ],
            );
          },
        ));
  }
}
