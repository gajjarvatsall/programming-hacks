import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/widgets/glassmorphic_container.dart';
import 'package:programming_hacks/widgets/rounded_blur_container.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();

  List<Map<String, String>> onBoardingScreenData = [
    {
      'title': 'Welcome\nTo ProHacks',
      'lottieUrl': 'assets/lottie/welcome.json',
      'data':
          'Explore hacks across different technology domains, including Flutter, Kotlin, Java, React and Many more.',
    },
    {
      'title': 'Save\nYour Favorites',
      'lottieUrl': 'assets/lottie/welcome.json',
      'data': 'Found a hack you love? Save it to your Favorites for quick access whenever you need it.',
    },
    {
      'title': 'Stay Updated\nwith the Latest Trends',
      'lottieUrl': 'assets/lottie/welcome.json',
      'data': 'Stay informed about the newest technologies, software updates, and security vulnerabilities.',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          RoundedBlurContainer(
            right: 30,
            top: 50,
            color: Colors.greenAccent.withOpacity(0.4),
          ),
          RoundedBlurContainer(
            left: -100,
            bottom: 300,
            color: Colors.pinkAccent.withOpacity(0.4),
          ),
          RoundedBlurContainer(
            right: -100,
            bottom: -50,
            color: Colors.greenAccent.withOpacity(0.4),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 70, sigmaX: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 600,
                    width: 500,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: onBoardingScreenData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GlassMorphismContainer(
                            width: 400,
                            height: 600,
                            blur: 5,
                            child: OnBoardingContainer(
                              title: onBoardingScreenData[index]['title'],
                              lottieUrl: onBoardingScreenData[index]['lottieUrl'],
                              data: onBoardingScreenData[index]['data'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: mSizedBoxHeight,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                      ),
                      onPressed: () {
                        controller.animateToPage(
                          2,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.ease,
                        );
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: controller,
                      count: onBoardingScreenData.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: Colors.greenAccent,
                        dotWidth: 8,
                        dotHeight: 8,
                      ),
                      onDotClicked: (index) {
                        controller.animateToPage(index, duration: Duration(milliseconds: 1000), curve: Curves.ease);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        controller.nextPage(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.ease,
                        );
                        if (controller.page == onBoardingScreenData.length - 1) {
                          Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
                        }
                      },
                      child: Text("Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingContainer extends StatelessWidget {
  OnBoardingContainer({
    required this.title,
    required this.lottieUrl,
    required this.data,
    super.key,
  });

  final String? title;
  final String? lottieUrl;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title!, textAlign: TextAlign.center, style: CustomTextTheme.titleText),
          Lottie.asset(
            lottieUrl!,
            height: 300,
            width: 300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              data!,
              textAlign: TextAlign.center,
              style: CustomTextTheme.welcomeText.copyWith(color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}
