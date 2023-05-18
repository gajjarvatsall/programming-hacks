class LanguageModel {
  const LanguageModel({
    required this.name,
    required this.imageUrl,
  });

  final String name;

  final String imageUrl;
}

const languages = [
  LanguageModel(
    name: 'Dart',
    imageUrl: 'assets/images/img1.jpg',
  ),
  LanguageModel(
    name: 'Flutter',
    imageUrl: 'assets/images/img2.jpg',
  ),
  LanguageModel(
    name: 'Java',
    imageUrl: 'assets/images/img3.jpg',
  ),
  LanguageModel(
    name: 'Javascript',
    imageUrl: 'assets/images/img4.jpg',
  ),
  LanguageModel(
    name: 'Kotlin',
    imageUrl: 'assets/images/img5.jpg',
  ),
  LanguageModel(
    name: 'PHP',
    imageUrl: 'assets/images/img6.jpg',
  ),
  LanguageModel(
    name: 'SWIFT',
    imageUrl: 'assets/images/img7.jpg',
  ),
];
