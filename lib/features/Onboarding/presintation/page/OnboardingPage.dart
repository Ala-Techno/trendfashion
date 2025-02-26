import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:trendfashion/features/Home/presintation/page/HomePage.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // @override
  // final ScrollController _scrollController = ScrollController();
  final _introKey = GlobalKey<IntroductionScreenState>();

  Widget CategoriesWidget = Container();

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
                fontFamily: 'Poppins',
              ),
              bodyTextStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontFamily: 'Poppins',
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
                fontFamily: 'Poppins',
              ),
              bodyTextStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontFamily: 'Poppins',
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
                fontFamily: 'Poppins',
              ),
              bodyTextStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontFamily: 'Poppins',
              ),
              imageFlex: 4, // Gives more space to the image
              bodyFlex: 3,
              titlePadding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        next: Icon(
          Icons.arrow_forward_ios,
          color: Colors.blue,
          size: 24,
        ),
        done: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Start',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        dotsDecorator: DotsDecorator(
          size: Size(10, 10),
          activeSize: Size(22, 10),
          activeColor: Colors.blue,
          color: Colors.grey[300]!,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        isProgress: true,
        safeAreaList: [true, false, false, false],
        //  isTopSafe: true,
        controlsMargin: EdgeInsets.all(16),
        controlsPadding: EdgeInsets.only(bottom: 50),
        curve: Curves.easeInOut,
        onDone: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  HomePage(),
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
