import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/models/hacks_model.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/widgets/circular_pacticles.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<HacksModel> hacksList = [];
  final CardSwiperController controller = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[300],
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const CustomCircularParticle(),
          Container(
            color: Colors.blueGrey[300],
            child: BlocConsumer<HacksBloc, HacksState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is HacksLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is HacksLoadedState) {
                  hacksList = state.hacksModel ?? [];
                  return hacksList.isEmpty
                      ? CardSwiper(
                          isLoop: true,
                          cardsCount: 1,
                          controller: controller,
                          // onSwipe: _onSwipe,
                          // // onUndo: _onUndo,
                          numberOfCardsDisplayed: 1,
                          cardBuilder: (context, index) {
                            return Center(
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
                                        style: CustomTextTheme.headingNameText
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                        "Data Not Found",
                                        style: CustomTextTheme.headingNameText
                                            .copyWith(color: Colors.black),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            );
                          },
                        )
                      : CardSwiper(
                          isLoop: true,
                          cardsCount: hacksList.length,
                          controller: controller,
                          // onSwipe: _onSwipe,
                          // // onUndo: _onUndo,
                          numberOfCardsDisplayed: 1,
                          cardBuilder: (context, index) {
                            return Center(
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
                                    child: Text(
                                      "${hacksList[index].hackDetails}",
                                      style: CustomTextTheme.captionText,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    if (direction.name == 'right') {
      controller.undo();
      return true;
    } else if (direction.name == 'left') {
      controller.swipeRight();
      return true;
    }
    return false;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    controller.undo();
    return true;
  }
}
