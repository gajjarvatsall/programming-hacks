import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:programming_hacks/animations/list_animation.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_bloc.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/modules/home/bloc/home_bloc.dart';
import 'package:programming_hacks/widgets/language_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<ScrollDirection> scrollDirectionNotifier =
      ValueNotifier<ScrollDirection>(ScrollDirection.forward);

  // @override
  // void initState() {
  //   context.read<HomeBloc>().add(GetLanguagesEvent());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[300],
        body: Center(
          child: Text("HELLO"),
        )
        /*SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LanguagesLoadingState) {
              return Center(
                child: Lottie.asset(
                  'assets/lottie/loading.json',
                  height: 100,
                  width: 100,
                ),
              );
            }
            if (state is LanguagesLoadedState) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return CustomScrollView(
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
                                      getTrimmedName(),
                                      style: CustomTextTheme.headingNameText,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: sSizedBoxWidth,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<AuthUserBloc>(context)
                                            .add(UserLogoutEvent());
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/loginScreen',
                                          (route) => false,
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1, color: Colors.white)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(padding),
                                          child: Icon(Icons.login_outlined,
                                              color: Colors.white),
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
                          if (notification.direction ==
                                  ScrollDirection.forward ||
                              notification.direction ==
                                  ScrollDirection.reverse) {
                            scrollDirectionNotifier.value =
                                notification.direction;
                          }
                          return true;
                        },
                        child: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            childCount: state.languagesModel?.length,
                            addAutomaticKeepAlives: true,
                            (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<HacksBloc>(context).add(
                                    GetHacksEvent(
                                        id: state.languagesModel?[index].id),
                                  );
                                  Navigator.pushNamed(
                                      context, '/detailsScreen');
                                },
                                child: ValueListenableBuilder(
                                  builder: (context,
                                      ScrollDirection scrollDirection, child) {
                                    return ListItemWrapper(
                                      scrollDirection: scrollDirection,
                                      keepAlive: false,
                                      child: child!,
                                    );
                                  },
                                  valueListenable: scrollDirectionNotifier,
                                  child: LanguageListItem(
                                    imageUrl:
                                        state.languagesModel?[index].bgImage ??
                                            "",
                                    name:
                                        state.languagesModel?[index].name ?? "",
                                  ),
                                ),
                              );
                            },
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: constraints.maxWidth > 550 ? 2 : 1,
                            childAspectRatio: 18 / 9,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          },
        ),
      ),*/
        );
  }
}
