import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/models/languages_model.dart';

import 'package:programming_hacks/modules/home/bloc/home_bloc.dart';
import 'package:programming_hacks/widgets/home_screen_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LanguagesModel> languagesList = [];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HomeBloc>(context).add(GetLanguagesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is GetLanguagesState && state.isCompleted) {
            languagesList = state.languagesModel ?? [];
          }
        },
        builder: (context, state) {
          return state is GetLanguagesState && state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.black,
                      floating: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: const Text(
                          "Programming Hacks",
                          style: TextStyle(color: Colors.white),
                        ),
                        centerTitle: true,
                        background: Image.asset(
                          'assets/images/appbar_img.jpg',
                          fit: BoxFit.cover,
                        ),
                        stretchModes: const [
                          StretchMode.blurBackground,
                          StretchMode.zoomBackground,
                        ],
                      ),
                      expandedHeight: 200,
                      stretch: true,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: languagesList.length,
                        addAutomaticKeepAlives: true,
                        (context, index) {
                          return LanguageListItem(
                            imageUrl: languages[index].imageUrl,
                            name: languagesList[index].name ?? "",
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

class Language {
  const Language({
    required this.name,
    required this.imageUrl,
  });

  final String name;

  final String imageUrl;
}

const languages = [
  Language(
    name: 'D A R T',
    imageUrl: 'assets/images/img1.jpg',
  ),
  Language(
    name: 'F L U T T E R',
    imageUrl: 'assets/images/img2.jpg',
  ),
  Language(
    name: 'J A V A',
    imageUrl: 'assets/images/img3.jpg',
  ),
  Language(
    name: 'J A V A S C R I P T',
    imageUrl: 'assets/images/img4.jpg',
  ),
  Language(
    name: 'K O T L I N',
    imageUrl: 'assets/images/img5.jpg',
  ),
];
