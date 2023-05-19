import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/animations/list_animation.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/models/languages_model.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_bloc.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/modules/home/bloc/home_bloc.dart';
import 'package:programming_hacks/widgets/language_list_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LanguagesModel> languagesList = [];
  final ValueNotifier<ScrollDirection> scrollDirectionNotifier =
      ValueNotifier<ScrollDirection>(ScrollDirection.forward);

  @override
  void initState() {
    context.read<HomeBloc>().add(GetLanguagesEvent());
    super.initState();
  }

  String trimmedName() {
    String? name = Supabase.instance.client.auth.currentUser?.userMetadata?.values.elementAt(0);
    String? result = name!.substring(0, name.indexOf(' '));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xfc00766b), Color(0xff171717)],
              stops: [0, 1],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is LanguagesLoadedState) {
                languagesList = state.languagesModel ?? [];
              }
            },
            builder: (context, state) {
              return state is LanguagesLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SizedBox(
                              height: xLSizedBoxHeight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Welcome,",
                                        style: CustomTextTheme.headingText,
                                      ),
                                      Text(
                                        trimmedName(),
                                        style: CustomTextTheme.headingNameText,
                                      )
                                    ],
                                  ),
                                  // const Flexible(child: SizedBox(width: extraLargeSizedBoxWidth)),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(width: 1, color: Colors.white),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(padding),
                                            child: Icon(
                                              Icons.notifications,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: sSizedBoxWidth,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<AuthUserBloc>(context).add(UserLogoutEvent());
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/loginScreen',
                                            (route) => false,
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(width: 1, color: Colors.white)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(padding),
                                            child: Icon(Icons.login_outlined, color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        NotificationListener<UserScrollNotification>(
                          onNotification: (UserScrollNotification notification) {
                            if (notification.direction == ScrollDirection.forward ||
                                notification.direction == ScrollDirection.reverse) {
                              scrollDirectionNotifier.value = notification.direction;
                            }
                            return true;
                          },
                          child: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              childCount: languagesList.length,
                              addAutomaticKeepAlives: true,
                              (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<HacksBloc>(context)
                                        .add(GetHacksEvent(id: languagesList[index].id ?? 0));
                                    Navigator.pushNamed(context, '/detailsScreen');
                                  },
                                  child: ValueListenableBuilder(
                                    builder: (context, ScrollDirection scrollDirection, child) {
                                      return ListItemWrapper(
                                        scrollDirection: scrollDirection,
                                        keepAlive: false,
                                        child: child!,
                                      );
                                    },
                                    valueListenable: scrollDirectionNotifier,
                                    child: LanguageListItem(
                                      imageUrl: languages[index].imageUrl,
                                      name: languagesList[index].name ?? "",
                                    ),
                                  ),
                                );
                              },
                            ),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 9 / 14,
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
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
