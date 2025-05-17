import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter_application_2/helper/api.dart';
import 'package:flutter_application_2/models/product_modle.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


class AllProductsService {
  Future<List<ProductModle>> getAllProducts() async {
    List<dynamic> data = await Api().get(
      url: 'https://fakestoreapi.com/products',
    );

  List<ProductModle> productList = [];
  
      for (int i = 0; i < data.length; i++) {
        productList.add(ProductModle.fromJson(data[i]));
      }

      return productList;
  
  }
}
