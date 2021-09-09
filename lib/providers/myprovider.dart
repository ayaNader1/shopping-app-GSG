import 'package:flutter/material.dart';
import 'package:flutter_app_api1/data/api_helper.dart';
import 'package:flutter_app_api1/data/db_helper.dart';
import 'package:flutter_app_api1/models/product_response.dart';

class HomeProvider extends ChangeNotifier {
  List<String> allCategories;
  List<String> spaceficCategories;
  List<ProductResponse> allProducts;
  List<ProductResponse> categoryProducts;
  List<ProductResponse> isFavProducts;
  ProductResponse selectedProduct;
  String selectedCategory = '';
  getAllCategories([String cat]) async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    notifyListeners();
    getCategoryProducts(allCategories.first);
  }


  getCategoryProducts(String category) async {
    categoryProducts = null;
    this.selectedCategory = category;
    notifyListeners();
    List<dynamic> products =
        await ApiHelper.apiHelper.getCategoryProducts(category);
    categoryProducts =
        products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  getAllProducts() async {
    List<dynamic> products = await ApiHelper.apiHelper.getAllProducts();
    allProducts = products.map((e) => ProductResponse.fromJson(e)).toList();
    this.isFavProducts = allProducts.where((element) => element.isFav).toList();
    notifyListeners();
  }

  getSpecificProduct(int id) async {
    selectedProduct = null;
    notifyListeners();
    dynamic response = await ApiHelper.apiHelper.getSpecificProduct(id);
    selectedProduct = ProductResponse.fromJson(response);
    notifyListeners();
  }

  updateProduct(ProductResponse productModel) async {
    await DbHelper.dbHelper.updateProduct(productModel);
    getAllProducts();
  }
}
