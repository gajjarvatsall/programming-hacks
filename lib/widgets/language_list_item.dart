import 'package:flutter/material.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/widgets/parallax_effect.dart';

class LanguageListItem extends StatefulWidget {
  const LanguageListItem({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  final String imageUrl;
  final String name;

  @override
  State<LanguageListItem> createState() => _LanguageListItemState();
}

class _LanguageListItemState extends State<LanguageListItem> {
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            ParallaxBackground(backgroundImageKey: _backgroundImageKey, imageUrl: widget.imageUrl, context: context),
            const Gradient(),
            TitleAndSubtitle(name: widget.name),
          ],
        ),
      ),
    );
  }
}

class TitleAndSubtitle extends StatelessWidget {
  const TitleAndSubtitle({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name.toUpperCase(), style: CustomTextTheme.titleText),
        ],
      ),
    );
  }
}

class Gradient extends StatelessWidget {
  const Gradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            // focalRadius: 0.2,
            radius: 0.8,
            colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
            stops: const [0.7, 0.95],
          ),
        ),
      ),
    );
  }
}
