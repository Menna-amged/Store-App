import 'package:flutter_application_2/helper/api.dart';
import 'package:flutter_application_2/models/product_modle.dart';

class AddProduct {
  Future<ProductModle> addProduct({
    required String title,
    required String price,
    required String desc,
    required String image,
    required String category,
  }) async {
    Map<String, dynamic> data = await Api().post(
      url: 'https://fakestoreapi.com/products',
      body: {
        'title': title,
        'price': price,
        'description': desc,
        'image': image,
        'category': category,
      },
    );
    return ProductModle.fromJson(data);
  }
}
