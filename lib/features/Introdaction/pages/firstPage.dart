import 'package:flutter/material.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';
import 'package:trendfashion/core/util/app_router.dart';
import 'package:trendfashion/core/widgets/customContainer.dart';
import 'package:trendfashion/core/widgets/customText.dart';

class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    screenUtil.init(context);
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Adding spacing at the top (220px)
                SizedBox(height: screenUtil.screenHeight * 0.25),

                // Calling the Custom Text
                CustomcontainerIntro(),

                // Spacing
                SizedBox(height: 10),

                // Text
                CustomTextTitle1(
                  customText: 'Shoppe',
                  customSize: 52,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: CustomTextTitle2(
                    customText:
                        'Beautiful eCommerce UI Kit for your online store',
                    customSize: 19,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: Column(
              children: [
                _buildSignUpButton(context),
                const SizedBox(height: 20),
                _buildLoginRow(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 55),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        onPressed: () => Navigator.pushNamed(context, AppRouter.signUp),
        child: const Text(
          "Let's get started",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, AppRouter.login),
          child: const Text('I already have an account'),
        ),
        IconButton(
          icon: const Icon(Icons.account_circle),
          color: Colors.blue,
          onPressed: () => Navigator.pushNamed(context, AppRouter.login),
        ),
      ],
    );
  }
}
