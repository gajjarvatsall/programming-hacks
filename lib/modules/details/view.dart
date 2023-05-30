import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/widgets/rounded_blur_container.dart';
import 'package:screenshot/screenshot.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with TickerProviderStateMixin {
  late AnimationController lottieController;
  PageController controller = PageController(viewportFraction: 0.9, keepPage: true);
  ScreenshotController screenshotController = ScreenshotController();
  bool isBookmarked = false;

  @override
  void initState() {
    lottieController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

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
            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
            child: Center(
              child: Container(
                height: 500,
                width: 500,
                child: BlocConsumer<HacksBloc, HacksState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is HacksLoadingState) {
                      return Center(
                        child: Lottie.asset(
                          'assets/lottie/loading.json',
                          height: 100,
                          width: 100,
                        ),
                      );
                    }
                    if (state is HacksLoadedState) {
                      return PageView.builder(
                        controller: controller,
                        itemCount: state.hacksModel?.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GlassmorphicContainer(
                                width: 400,
                                height: 600,
                                borderRadius: 20,
                                blur: 5,
                                alignment: Alignment.bottomCenter,
                                linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFffffff).withOpacity(0.1),
                                    const Color(0xFFFFFFFF).withOpacity(0.1),
                                  ],
                                  stops: const [
                                    0.1,
                                    1,
                                  ],
                                ),
                                borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFffffff).withOpacity(0.1),
                                    const Color((0xFFFFFFFF)).withOpacity(0.01),
                                  ],
                                ),
                                border: 3,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${state.hacksModel?[index].hackDetails}',
                                          style: CustomTextTheme.headingNameText,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print(state.hacksModel?[index].userId?[0]);
                                            // BlocProvider.of<HacksBloc>(context).add(AddUserIdEvent(userId: , documentId: documentId))
                                            if (isBookmarked == false) {
                                              isBookmarked = true;
                                              lottieController.forward();
                                            } else {
                                              isBookmarked = false;
                                              lottieController.reverse();
                                            }
                                          },
                                          child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Lottie.asset('assets/images/bookmarked.json',
                                                  height: 45, controller: lottieController)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Text(
                      "Data Not Found",
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<HacksBloc>().add(
                            ShareHacksEvent(
                              controller: screenshotController,
                            ),
                          );
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
