import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_bloc.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/modules/home/bloc/home_bloc.dart';
import 'package:programming_hacks/widgets/glassmorphic_container.dart';
import 'package:programming_hacks/widgets/rounded_blur_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<ScrollDirection> scrollDirectionNotifier =
      ValueNotifier<ScrollDirection>(ScrollDirection.forward);

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetLanguagesEvent());
    super.initState();
  }

  String getTrimmedName() {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            RoundedBlurContainer(
              right: 30,
              top: 50,
              color: Colors.greenAccent.withOpacity(0.4),
            ),
            RoundedBlurContainer(
              left: -100,
              bottom: 300,
              color: Colors.pinkAccent.withOpacity(0.4),
            ),
            RoundedBlurContainer(
              right: -100,
              bottom: -50,
              color: Colors.greenAccent.withOpacity(0.4),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
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
                                                  border:
                                                      Border.all(width: 1, color: Colors.white)),
                                              child: const Padding(
                                                padding: EdgeInsets.all(padding),
                                                child:
                                                    Icon(Icons.login_outlined, color: Colors.white),
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
                            SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                childCount: state.languagesModel?.length,
                                addAutomaticKeepAlives: true,
                                (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<HacksBloc>(context).add(
                                        GetHacksEvent(id: state.languagesModel?[index].id ?? ""),
                                      );
                                      Navigator.pushNamed(
                                        context,
                                        '/detailsScreen',
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GlassMorphismContainer(
                                        width: 0,
                                        height: 0,
                                        blur: 5,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: "${state.languagesModel?[index].bgImage}",
                                                width: 100,
                                                height: 100,
                                              ),
                                              SizedBox(
                                                height: sSizedBoxHeight,
                                              ),
                                              Text(
                                                "${state.languagesModel?[index].name}",
                                                style: CustomTextTheme.headingNameText,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: constraints.maxWidth > 550 ? 3 : 2,
                                childAspectRatio: 10 / 10,
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
            ),
          ],
        ),
      ),
    );
  }
}
