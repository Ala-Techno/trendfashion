import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendfashion/core/AppTheme.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';
import 'package:trendfashion/core/widgets/customContainer.dart';
import 'package:trendfashion/core/widgets/customText.dart';

class Firstpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    screenUtil.init(context);
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Add spacing at the top (220px)
          SizedBox(height: screenUtil.setHeight(500)),

          // Calling the Custom Text
          CustomcontainerIntro(),

          // Spacing
          SizedBox(height: 20),

          // Text
          CustomTextTitle1(
            customText: 'Shoppe',
            customSize: 52,
          ),
          CustomTextTitle2(
            customText: 'Beautiful eCommerce UI Kit for your online store',
            customSize: 19,
          ),
          // Spacing
          SizedBox(height: 20),

          // Row with Text and Circular Container
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text
              Text(
                'Bottom Text',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              // Spacing
              SizedBox(width: 10),

              // Circular Container
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
