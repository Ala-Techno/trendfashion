import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomcontainerIntro extends StatelessWidget {
  const CustomcontainerIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 134,
          height: 134,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFFFFFF), // White color
            boxShadow: [
              BoxShadow(
                color: Color(0xFF000000)
                    .withOpacity(0.1608), // Black color with 16.08% opacity
                spreadRadius: 0,
                blurRadius: 8,
                offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
        ),
        // Image positioned on top of the circular container
        SvgPicture.asset(
          'assets/images/IntroPage.svg',
          // width: screenUtil.setWidth(82), // 81.4px width
          // height: screenUtil.setHeight(92), // 92px height
        ),
      ],
    );
  }
}
