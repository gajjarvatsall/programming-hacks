import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/models/hacks_model.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<HacksModel> hacksList = [];
  final CardSwiperController controller = CardSwiperController();

  @override
  void initState() {
    BlocProvider.of<HacksBloc>(context).add(GetHacksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
      body: SafeArea(
        child: BlocConsumer<HacksBloc, HacksState>(
          listener: (context, state) {
            if (state is GetHacksState && state.isCompleted) {
              hacksList = state.hacksModel ?? [];
            }
          },
          builder: (context, state) {
            if (state is GetHacksState && state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetHacksState && state.isCompleted) {
              hacksList = state.hacksModel ?? [];
              return CardSwiper(
                isLoop: true,
                cardsCount: hacksList.length,
                controller: controller,
                onSwipe: _onSwipe,
                // onUndo: _onUndo,
                numberOfCardsDisplayed: 3,
                cardBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orangeAccent.shade200,
                    ),
                    child: Center(
                      child: Text(
                        "${hacksList[index].hackDetails}",
                        style: CustomTextTheme.titleText.copyWith(color: Colors.black),
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
