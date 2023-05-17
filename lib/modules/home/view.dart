import 'package:flutter/material.dart';
import 'package:programming_hacks/models/language_model.dart';
import 'package:programming_hacks/widgets/parallax_effect.dart';
import 'package:programming_hacks/widgets/language_list_item.dart';

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
