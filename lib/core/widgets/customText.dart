import 'package:flutter/material.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';

class CustomTextTitle1 extends StatelessWidget {
  final String customText;
  final double customSize;
  String titleFont = 'Nunito_Sans';
  String titleFont2 = 'Raleway';

  CustomTextTitle1({
    super.key,
    required this.customText,
    required this.customSize,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    screenUtil.init(context);

    return Container(
      alignment: Alignment.center,
      width: screenUtil.setWidth(1000), // 190px width
      height: screenUtil.setHeight(200), // 61px height
      // margin: EdgeInsets.only(
      //   top: screenUtil.setHeight(30), // 390px from the top
      //   //  left: screenUtil.setWidth(93), // 93px from the left
      // ),
      child: Text(
        customText,
        style: TextStyle(
          color: Color(0xFF202020),
          fontSize: customSize,
          letterSpacing: -0.52,
          fontWeight: FontWeight.w700,
          fontFamily: titleFont2, // should be parameter insted of static
        ),
        // Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}

class CustomTextTitle2 extends StatelessWidget {
  final String customText;
  final double customSize;
  String titleFont = 'Nunito_Sans';
  String titleFont2 = 'Raleway';

  CustomTextTitle2({
    super.key,
    required this.customText,
    required this.customSize,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    screenUtil.init(context);

    return Container(
      alignment: Alignment.center,
      width: screenUtil.setWidth(700), // 190px width
      height: screenUtil.setHeight(200), // 61px height
      // margin: EdgeInsets.only(
      //   top: screenUtil.setHeight(30), // 390px from the top
      //   //  left: screenUtil.setWidth(93), // 93px from the left
      // ),
      child: Text(
        textAlign: TextAlign.center,
        customText,
        style: TextStyle(
          color: Color(0xFF202020),
          fontSize: customSize,
          letterSpacing: -0.52,
          fontWeight: FontWeight.w700,
          fontFamily: titleFont, // should be parameter insted of static
        ),
        // Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}
