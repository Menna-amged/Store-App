import 'package:flutter_application_2/helper/api.dart';
import 'package:flutter_application_2/models/product_modle.dart';

class UpdateProducts {
  Future<ProductModle> updateProducts({
    required String title,
    required String price,
    required String desc,
    required String image,
    required int id,
    required String category,
  }) async {
    print('product id = $id');
    Map<String, dynamic> data = await Api().put(
      url: 'https://fakestoreapi.com/products/$id',
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
