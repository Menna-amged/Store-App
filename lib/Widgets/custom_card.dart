import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/product_modle.dart';
import 'package:flutter_application_2/screens/update_product_page.dart';
import 'package:flutter_application_2/services/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCard extends StatelessWidget {
  CustomCard({required this.product, super.key});
  final ProductModle product;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'ProductDetailsPage', arguments: product);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 40,
                  color: Colors.grey.withOpacity(.2),
                  spreadRadius: 0,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title.split(' ').take(3).join(' '),
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          r'$' '${product.price.toString()}',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(FontAwesomeIcons.cartPlus, 
                                color: const Color.fromARGB(255, 244, 113, 73),
                                size: 20,
                              ),
                              onPressed: () {
                                final cartService = context.read<CartService>();
                                cartService.addToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to cart'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: const Color.fromARGB(255, 244, 113, 73),
                                  ),
                                );
                              },
                            ),
                            Icon(Icons.favorite, color: Colors.black),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -67,
            right: 20,
            child: Image.network(product.image, height: 130, width: 130),
          ),
        ],
      ),
    );
  }
}
