import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/models/hacks_model.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/repository/hacks_repo.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<HacksModel> hacksList = [];

  @override
  void initState() {
    // TODO: implement initState
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
            return state is GetHacksState && state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: SizedBox(
                      height: 400,
                      width: 400,
                      child: PageView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(5),
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
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
