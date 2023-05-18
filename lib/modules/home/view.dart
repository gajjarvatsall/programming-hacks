import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/animations/list_animation.dart';
import 'package:programming_hacks/models/languages_model.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_bloc.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/modules/home/bloc/home_bloc.dart';
import 'package:programming_hacks/widgets/language_list_item.dart';

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
    // TODO: implement initState
    BlocProvider.of<HomeBloc>(context).add(GetLanguagesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is LanguagesLoadedState) {
              languagesList = state.languagesModel ?? [];
            }
          },
          builder: (context, state) {
            return state is LanguagesLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      /* SliverAppBar(
                        backgroundColor: Colors.amber,
                        actions: const [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.notifications,
                              color: Colors.black,
                            ),
                          )
                        ],

                        floating: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            "Elon Musk",
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),

                          // background: Image.asset(
                          //   'assets/images/appbar_img.jpg',
                          //   fit: BoxFit.cover,
                          // ),
                          // stretchModes: const [
                          //   StretchMode.blurBackground,
                          //   StretchMode.zoomBackground,
                          // ],
                        ),
                        // expandedHeight: 200,
                        // stretch: true,
                      ),*/
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Welcome to Programming Hacks,",
                                      style: TextStyle(color: Colors.black, fontSize: 14),
                                    ),
                                    Text("Elon Musk", style: TextStyle(color: Colors.black, fontSize: 26))
                                  ],
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.notifications,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.login_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<AuthUserBloc>(context).add(UserLogoutEvent());
          Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
        },
        child: const Icon(Icons.logout),
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
