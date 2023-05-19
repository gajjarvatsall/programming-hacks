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

  String trimmedName(String? name) {
    String? result = name?.split(' ')[0] ?? "Hello there";
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey[300],
        child: SafeArea(
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
                                        trimmedName(
                                            '${Supabase.instance.client.auth.currentUser?.userMetadata?.values.elementAt(0) ?? "Hello There"}'),
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
                                      imageUrl: languagesList[index].bgImage ?? "",
                                      name: languagesList[index].name ?? "",
                                    ),
                                  ),
                                );
                              },
                            ),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 18 / 9,
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
