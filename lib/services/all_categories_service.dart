import 'dart:convert';

import 'package:flutter_application_2/helper/api.dart';
import 'package:http/http.dart' as http;

class AllCategoriesService {
  Future<List<String>> getAllCategories() async {
    List<dynamic> data = await Api().get(url: 'https://fakestoreapi.com/products/categories');
    return data.cast<String>();
  }
}
