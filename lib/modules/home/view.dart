import 'package:flutter/material.dart';
import 'package:programming_hacks/widgets/home_screen_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar(
            title: Text(
              "Programming Hacks",
            ),
            centerTitle: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.blurBackground],
            ),
            stretch: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: languages.length,
              (context, index) {
                return LocationListItem(
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
    name: 'Dart',
    imageUrl: 'assets/images/dart.png',
  ),
  Language(
    name: 'Flutter',
    imageUrl: 'assets/images/flutter.png',
  ),
  Language(
    name: 'Java',
    imageUrl: 'assets/images/java.png',
  ),
  Language(
    name: 'Javascript',
    imageUrl: 'assets/images/javascript.webp',
  ),
  Language(
    name: 'Kotlin',
    imageUrl: 'assets/images/kotlin.png',
  ),
  Language(
    name: 'Php',
    imageUrl: 'assets/images/php.png',
  ),
  Language(
    name: 'Swift',
    imageUrl: 'assets/images/swift.jpeg',
  ),
];
