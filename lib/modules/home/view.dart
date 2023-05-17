import 'package:flutter/material.dart';
import 'package:programming_hacks/widgets/home_screen_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
              childCount: languages.length,
              addAutomaticKeepAlives: true,
              (context, index) {
                return LanguageListItem(
                  imageUrl: languages[index].imageUrl,
                  name: languages[index].name,
                );
              },
            ),
          ),
        ],
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
  Language(
    name: 'P H P',
    imageUrl: 'assets/images/img6.jpg',
  ),
  Language(
    name: 'S W I F T',
    imageUrl: 'assets/images/img7.jpg',
  ),
];
