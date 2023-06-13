import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/models/saved_hacks_model.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/widgets/rounded_blur_container.dart';
import 'package:swipable_stack/swipable_stack.dart';

class SaveHacksScreen extends StatefulWidget {
  const SaveHacksScreen({super.key});

  @override
  State<SaveHacksScreen> createState() => _SaveHacksScreenState();
}

class _SaveHacksScreenState extends State<SaveHacksScreen> {
  late final SwipableStackController _controller;
  List<SavedHacksModel> savedHacks = [];

  void _listenController() => setState(() {});

  @override
  void initState() {
    _controller = SwipableStackController()..addListener(_listenController);
    super.initState();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_listenController)
      ..dispose();
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
            child: BlocConsumer<HacksBloc, HacksState>(
              listener: (context, state) {
                if (state is GetSavedHackLoadedState) {
                  savedHacks = state.savedData;
                }
              },
              builder: (context, state) {
                if (state is GetSavedHackLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is GetSavedHackLoadedState) {
                  return savedHacks.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GlassmorphicContainer(
                              width: 400,
                              height: 500,
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
                                  child: Text(
                                    "Data Not Found",
                                    style: CustomTextTheme.headingNameText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SwipableStack(
                          detectableSwipeDirections: const {
                            SwipeDirection.right,
                            SwipeDirection.left,
                          },
                          controller: _controller,
                          stackClipBehaviour: Clip.none,
                          onSwipeCompleted: (index, direction) {
                            if (kDebugMode) {
                              print('$index, $direction');
                            }
                          },
                          horizontalSwipeThreshold: 0.8,
                          verticalSwipeThreshold: 0.8,
                          builder: (context, properties) {
                            final index = properties.index % savedHacks.length;
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GlassmorphicContainer(
                                  width: 400,
                                  height: 500,
                                  borderRadius: 20,
                                  blur: 60,
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
                                      child: Text(
                                        savedHacks[index].hackDetails,
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
                return Center(
                  child: Text("Data Not Found"),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context); // Handle back button press
                },
              ),
              title: Text(
                "Saved Hacks",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              centerTitle: true,
            ),
          ),
        ],
      ),
    );
  }
}
