class ProductModel {
  dynamic id, price, image, name, description, category, rating, reviews;

  // import 'package:hive/hive.dart';

// @HiveType(typeId: 0)
// class ProductModel extends HiveObject {
//    @HiveField(0)
//   final String id;

//   @HiveField(1)
//   final double price;

//   @HiveField(2)
//   final String name;

//   @HiveField(3)
//   final String image;

//   @HiveField(4)
//   final String description;

//   @HiveField(5)
//   final String category;

//   @HiveField(6)
//   final double rating;

//   @HiveField(7)
//   final int reviews;

  ProductModel(
      {required this.id,
      required this.price,
      required this.name,
      required this.reviews,
      required this.description,
      required this.category,
      required this.rating,
      required this.image});

  factory ProductModel.fromJson(Map<String, dynamic> product) {
    return ProductModel(
      id: product['id'],
      image: product['image'],
      reviews: product['reviews'],
      price: product['price'],
      name: product['name'],
      description: product['description'],
      category: product['category'],
      rating: product['rating'],
    );
  }

  //  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
  //     id: json['id'].toString(),
  //   price: json['price']?.toDouble() ?? 0.0,
  //   name: json['name'] ?? '',
  //   image: json['image'] ?? '',
  //   description: json['description'] ?? '',
  //   category: json['category'] ?? '',
  //   rating: json['rating']?.toDouble() ?? 0.0,
  //   reviews: json['reviews'] ?? 0,
  // );

  ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel.fromJson(json);
  }

  factory ProductModel.init() {
    return ProductModel(
        id: '',
        price: '',
        name: '',
        category: '',
        reviews: '',
        description: '',
        rating: '',
        image: '');
  }

  fromJsonList(List<dynamic> jsonList) {
    List<ProductModel> data = [];
    for (var post in jsonList) {
      data.add(ProductModel.fromJson(post));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'name': name,
        'reviews': reviews,
        'category': category,
        'description': description,
        'image': image
      };
}
