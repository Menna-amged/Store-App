import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/home_page.dart';
import 'package:flutter_application_2/screens/update_product_page.dart';
import 'package:flutter_application_2/screens/login_page.dart';
import 'package:flutter_application_2/screens/sign_up_page.dart';
import 'package:flutter_application_2/screens/product_details_page.dart';
import 'package:flutter_application_2/screens/categories_page.dart';
import 'package:flutter_application_2/screens/cart_page.dart';
import 'package:flutter_application_2/services/cart_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartService(),
      child: const StoreApp(),
    ),
  );
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      routes: {
        HomePage.id :(context) => HomePage(),
        UpdateProductPage.id : (context)=> UpdateProductPage(),
        LoginPage.id: (context) => LoginPage(),
        SignUpPage.id: (context) => SignUpPage(),
        ProductDetailsPage.id: (context) => ProductDetailsPage(),
        CategoriesPage.id: (context) => CategoriesPage(),
        CartPage.id: (context) => CartPage(),
      },
      initialRoute:LoginPage.id ,
    );
  }
}