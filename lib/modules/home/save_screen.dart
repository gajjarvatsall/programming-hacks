import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/models/saved_hacks_model.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/widgets/rounded_blur_container.dart';

class SaveHacksScreen extends StatefulWidget {
  const SaveHacksScreen({super.key});

  @override
  State<SaveHacksScreen> createState() => _SaveHacksScreenState();
}

class _SaveHacksScreenState extends State<SaveHacksScreen> {
  PageController controller = PageController(viewportFraction: 0.9, keepPage: true);
  List<SavedHacksModel> savedHacks = [];

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
                      : PageView.builder(
                          controller: controller,
                          itemCount: savedHacks.length,
                          itemBuilder: (context, index) {
                            return Center(
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: mSizedBoxHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
