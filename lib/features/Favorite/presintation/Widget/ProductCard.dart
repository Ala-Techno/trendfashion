import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trendfashion/core/AppTheme.dart';
import 'package:trendfashion/features/Product/data/model/ProductModel.dart';
import 'package:trendfashion/features/ProductDeatils/presintation/page/ProductDeatilsPage.dart';

class Productcard extends StatelessWidget {
  final ProductModel productModel;

  Productcard({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDeatilsPage(id: productModel.id.toString()),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageUrl: productModel.image,
                  fit: BoxFit.cover,
                  height: 150,
                  width: 200,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.all(5), // Add margin for better spacing
                child: CircleAvatar(
                  radius: 14, // Adjust the radius to make it smaller
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    iconSize: 20, // Adjust icon size if needed
                    padding: EdgeInsets.zero, // Remove default padding
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Positioned(
              left: 5,
              bottom: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${productModel.price}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
