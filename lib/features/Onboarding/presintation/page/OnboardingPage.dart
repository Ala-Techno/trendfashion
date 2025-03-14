import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:trendfashion/core/AppTheme.dart';
import 'package:trendfashion/core/ath/auth_checker.dart';
import 'package:trendfashion/features/Onboarding/presintation/data/token_storage_Onboarding.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  Widget categoriesWidget = Container();

  // In _ProductPageState
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        key: _introKey,
        pages: [
          PageViewModel(
            title: 'Welcome to TrendFashion',
            body:
                'Browse through thousands of fashion items\nand discover your perfect style',
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                fontFamily: AppTheme.fontFamily2,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontFamily: AppTheme.fontFamily2,
              ),
              imageFlex: 4, // Gives more space to the image
              bodyFlex: 3,
              imagePadding:
                  EdgeInsets.only(top: 40, bottom: 0, left: 30, right: 30),
              pageColor: Colors.white,
              contentMargin: EdgeInsets.symmetric(horizontal: 24),
            ),
            image: SvgPicture.asset(
              'assets/images/Onboarding1.svg',
              fit: BoxFit.contain,
            ),
          ),
          PageViewModel(
            title: 'Personalized Experience',
            body:
                'Get recommendations based on your\npersonal style preferences',
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                fontFamily: AppTheme.fontFamily2,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontFamily: AppTheme.fontFamily2,
              ),
              imageFlex: 4, // Gives more space to the image
              bodyFlex: 3,
              imagePadding:
                  EdgeInsets.only(top: 40, bottom: 0, left: 30, right: 30),
              pageColor: Colors.white,
              contentMargin: EdgeInsets.symmetric(horizontal: 24),
            ),
            image: SvgPicture.asset(
              'assets/images/Onboarding2.svg',
              fit: BoxFit.contain,
            ),
          ),
          PageViewModel(
            title: 'Start Shopping Now!',
            body:
                'Enjoy secure payments and fast delivery\nstraight to your doorstep',
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                fontFamily: AppTheme.fontFamily2,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontFamily: AppTheme.fontFamily2,
              ),
              imageFlex: 4, // Gives more space to the image
              bodyFlex: 3,
              titlePadding:
                  EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 25),
              imagePadding:
                  EdgeInsets.only(top: 40, bottom: 0, left: 30, right: 30),
              pageColor: Colors.white,
              contentMargin: EdgeInsets.symmetric(horizontal: 24),
            ),
            image: SvgPicture.asset(
              'assets/images/Onboarding3.svg',
              fit: BoxFit.contain,
            ),
          ),
        ],
        showSkipButton: true,
        skip: Text(
          'Skip',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        next: Icon(
          Icons.arrow_forward_ios,
          color: AppTheme.primaryColor,
          size: 24,
        ),
        done: Container(
          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          // decoration: BoxDecoration(
          //   color: AppTheme.primaryColor,
          //   borderRadius: BorderRadius.circular(10),
          // ),
          child: Text(
            'Start',
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        dotsDecorator: DotsDecorator(
          size: Size(10, 10),
          activeSize: Size(22, 10),
          activeColor: AppTheme.primaryColor,
          color: Colors.grey[300]!,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        isProgress: true,
        //safeAreaList: [true, false, false, false],
        controlsMargin: EdgeInsets.all(16),
        controlsPadding: EdgeInsets.only(bottom: 50),
        curve: Curves.easeInOut,
        onDone: () async {
          await OnboardingStorage.markCompleted();

          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  AuthChecker(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        globalBackgroundColor: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
