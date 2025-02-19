import 'package:flutter/material.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';

class CustomTextTitle1 extends StatelessWidget {
  final String customText;
  final double customSize;
  final String titleFont = 'Nunito_Sans';
  final String titleFont2 = 'Raleway';

  CustomTextTitle1({
    super.key,
    required this.customText,
    required this.customSize,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    screenUtil.init(context);

    return Text(
      customText,
      style: TextStyle(
        color: Color(0xFF202020),
        fontSize: customSize,
        letterSpacing: -0.52,
        fontWeight: FontWeight.w700,
        fontFamily: titleFont2, // should be parameter insted of static
      ),
      // Theme.of(context).textTheme.displayLarge,
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

    return Text(
      textAlign: TextAlign.center,
      customText,
      style: TextStyle(
        color: Color(0xFF202020),
        fontSize: customSize,
        letterSpacing: -0.52,
        fontWeight: FontWeight.w700,
        fontFamily: titleFont,
      ),
      // Theme.of(context).textTheme.displayLarge,
    );
  }
}
