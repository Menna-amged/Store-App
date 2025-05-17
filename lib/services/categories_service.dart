import 'dart:convert';

import 'package:flutter_application_2/helper/api.dart';
import 'package:flutter_application_2/models/product_modle.dart';
import 'package:http/http.dart' as http;

class CategoriesService {
  Future<List<ProductModle>> GetCategoriesProducts({
    required String categoryName,
  }) async {
    List<dynamic> data = await Api().get(
      url: 'https://fakestoreapi.com/products/category/$categoryName',
    );

    List<ProductModle> productList = [];
    for (int i = 0; i < data.length; i++) {
      productList.add(ProductModle.fromJson(data[i]));
    }

    return productList;
  }
}
