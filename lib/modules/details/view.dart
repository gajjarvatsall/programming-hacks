import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/models/hacks_model.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/widgets/rounded_blur_container.dart';
import 'package:screenshot/screenshot.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with TickerProviderStateMixin {
  late AnimationController lottieController;
  PageController controller = PageController(viewportFraction: 0.9, keepPage: true);
  ScreenshotController screenshotController = ScreenshotController();
  List<HacksModel> hacksList = [];
  Set<String> savedHackIds = {};

  @override
  void initState() {
    BlocProvider.of<HacksBloc>(context).add(GetSavedHacksEvent());
    lottieController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  getData() {
    BlocProvider.of<HacksBloc>(context).add(GetSavedHacksEvent());
  }

  @override
  void dispose() {
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
              child: StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setStateBuilder) {
                  return Container(
                    height: 500,
                    width: 500,
                    child: BlocConsumer<HacksBloc, HacksState>(
                      buildWhen: (previousState, currentState) {
                        return currentState is HacksLoadedState || currentState is HacksLoadingState;
                      },
                      listener: (context, state) {
                        if (state is HacksLoadedState) {
                          hacksList = state.hacksModel ?? [];
                        } else if (state is GetSavedHackLoadedState) {
                          savedHackIds = state.savedData;
                          setStateBuilder(() {});
                        } else if (state is SaveHacksLoadedState) {
                          getData();
                          setStateBuilder(() {});
                        }
                        if (state is SaveHackLoadingState) {
                          setStateBuilder(() {});
                        }
                      },
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
                            itemCount: hacksList.length,
                            itemBuilder: (context, index) {
                              final isHackSaved = savedHackIds.contains(hacksList[index].id);
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
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: isHackSaved
                                                  ? state is SaveHackLoadingState
                                                      ? CircularProgressIndicator()
                                                      : IconButton(
                                                          onPressed: () {
                                                            BlocProvider.of<HacksBloc>(context)
                                                                .add(UnSavedHackEvent(documentId: ''));
                                                          },
                                                          icon: Icon(
                                                            Icons.bookmark,
                                                            color: Colors.white,
                                                            size: 40,
                                                          ),
                                                        )
                                                  : state is SaveHackLoadingState
                                                      ? CircularProgressIndicator()
                                                      : IconButton(
                                                          icon: Icon(
                                                            Icons.bookmark_border,
                                                            color: Colors.white,
                                                            size: 40,
                                                          ),
                                                          onPressed: () {
                                                            BlocProvider.of<HacksBloc>(context)
                                                                .add(SaveHacksEvent(hackId: hacksList[index].id ?? ""));
                                                          },
                                                        ),
                                            ),
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
                        return Center(
                          child: Text(
                            "Data Not Found",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  );
                },
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
