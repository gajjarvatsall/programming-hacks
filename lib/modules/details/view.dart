import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/widgets/glassmorphic_container.dart';
import 'package:programming_hacks/widgets/rounded_blur_container.dart';
import 'package:screenshot/screenshot.dart';
import 'package:showcaseview/showcaseview.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  PageController controller = PageController(viewportFraction: 0.9, keepPage: true);
  ScreenshotController screenshotController = ScreenshotController();
  final shareButton = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    controller;
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
      body: ShowCaseWidget(
        builder: Builder(
          builder: (BuildContext context) {
            return Stack(
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
                                    child: GlassMorphismContainer(
                                      width: 400,
                                      height: 550,
                                      blur: 5,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            '${state.hacksModel?[index].hackDetails}',
                                            style: CustomTextTheme.headingNameText,
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
            );
          },
        ),
      ),
    );
  }
}
