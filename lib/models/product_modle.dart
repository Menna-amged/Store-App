import 'dart:convert';

class ProductModle {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;
  final Rating? rating;

  ProductModle({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    this.rating,
  });

  factory ProductModle.fromJson(jsonData) {
    return ProductModle(
      id: jsonData['id'],
      title: jsonData['title'],
      price: (jsonData['price'] as num).toDouble(),
      description: jsonData['description'],
      category: jsonData['category'],
      image: jsonData['image'],
      rating: jsonData['rating'] != null ? Rating.fromJson(jsonData['rating']) : null,
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
