import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:trendfashion/core/AppTheme.dart';
import 'package:trendfashion/features/Product/data/model/ProductModel.dart';
import 'package:trendfashion/features/ProductDeatils/presintation/page/ProductDeatilsPage.dart';

class Productcard extends StatelessWidget {
  ProductModel productModel;

  Productcard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDeatilsPage(id: productModel.id.toString()),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primaryColor, width: 5)),
        child: Column(
          children: [
            Image.network(productModel.image),
            Text(productModel.name),
            Text(productModel.price.toString()),
            Text(productModel.reviews.toString()),
            Icon(
              Icons.add,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
