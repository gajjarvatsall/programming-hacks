import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/widgets/circular_pacticles.dart';
import 'package:screenshot/screenshot.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final CardSwiperController cardSwipeController = CardSwiperController();

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[300],
        leading: BackButton(color: Colors.white),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => context.read<HacksBloc>().add(
                    ShareHacksEvent(
                      controller: screenshotController,
                    ),
                  ),
              child: Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const CustomCircularParticle(),
          Container(
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
                  if (state.hacksModel?.isEmpty ?? true) {
                    return CardSwiper(
                      isLoop: true,
                      cardsCount: 1,
                      controller: cardSwipeController,
                      numberOfCardsDisplayed: 1,
                      cardBuilder: (context, index) {
                        return Center(
                          child: Screenshot(
                            controller: screenshotController,
                            child: GlassmorphicContainer(
                              width: 400,
                              height: 500,
                              borderRadius: 20,
                              blur: 10,
                              alignment: Alignment.bottomCenter,
                              linearGradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFffffff).withOpacity(0.3),
                                  const Color(0xFFFFFFFF).withOpacity(0.10),
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
                                  const Color(0xFFffffff).withOpacity(0.3),
                                  const Color((0xFFFFFFFF)).withOpacity(0.05),
                                ],
                              ),
                              border: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/no-connection.png",
                                      width: 100,
                                      height: 100,
                                    ),
                                    SizedBox(
                                      height: sSizedBoxHeight,
                                    ),
                                    Text(
                                      "OOPS!",
                                      style: CustomTextTheme.headingNameText.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      "Data Not Found",
                                      style: CustomTextTheme.headingNameText.copyWith(color: Colors.black),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        );
                      },
                    ).animate().fadeIn(duration: 500.ms);
                  } else {
                    return CardSwiper(
                      isLoop: true,
                      cardsCount: state.hacksModel?.length ?? 0,
                      controller: cardSwipeController,
                      numberOfCardsDisplayed: 1,
                      cardBuilder: (context, index) {
                        return Center(
                          child: Screenshot(
                            controller: screenshotController,
                            child: RepaintBoundary(
                              child: GradientContainer(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Center(
                                    child: Text(
                                      "${state.hacksModel?[index].hackDetails}",
                                      style: CustomTextTheme.captionText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).animate().fadeIn(duration: 100.ms).scale(
                          duration: 250.ms,
                          curve: Curves.easeOutExpo,
                        );
                  }
                }
                return Center(
                  child: Lottie.asset(
                    'assets/lottie/loading.json',
                    height: 100,
                    width: 100,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GradientContainer extends StatelessWidget {
  final Widget child;
  const GradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: 400,
      height: 500,
      borderRadius: 20,
      blur: 10,
      alignment: Alignment.bottomCenter,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.3),
          const Color(0xFFFFFFFF).withOpacity(0.10),
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
          const Color(0xFFffffff).withOpacity(0.3),
          const Color((0xFFFFFFFF)).withOpacity(0.05),
        ],
      ),
      border: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: child,
      ),
    );
  }
}
