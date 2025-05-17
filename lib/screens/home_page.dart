import 'package:flutter/material.dart';
import 'package:flutter_application_2/Widgets/custom_card.dart';
import 'package:flutter_application_2/models/product_modle.dart';
import 'package:flutter_application_2/services/all_products_service.dart';
import 'package:flutter_application_2/services/cart_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String id = 'HomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Consumer<CartService>(
              builder: (context, cartService, child) {
                int itemCount = cartService.items.fold(0, (sum, item) => sum + item.quantity);
                return Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'CartPage');
                      },
                      icon: Icon(FontAwesomeIcons.cartShopping, 
                        size: 24, 
                        color: const Color.fromARGB(255, 244, 113, 73)
                      ),
                    ),
                    if (itemCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            '$itemCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
       backgroundColor: const Color.fromARGB(255, 246, 246, 246),
    
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              child: Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Store App',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/image1.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey[300],
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'HomePage');
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                Navigator.pushNamed(context, 'CategoriesPage');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: () {
                // TODO: Clear user session if implemented
                Navigator.pushReplacementNamed(context, 'LoginPage');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 80),
        child: FutureBuilder<List<ProductModle>>(
          future: AllProductsService().getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductModle> products = snapshot.data!;
              return GridView.builder(
                itemCount: products.length,
                clipBehavior: Clip.none,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 90,
                ),
                itemBuilder: (context, index) {
                  return CustomCard(product: products[index],);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),

      
    );
  }
}
