import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
            ),
            // ParallaxBackground(backgroundImageKey: _backgroundImageKey, imageUrl: widget.imageUrl, context: context),
            // const Gradient(),
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
