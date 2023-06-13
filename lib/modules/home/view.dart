import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:programming_hacks/app_theme/app_theme.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_bloc.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/modules/home/bloc/home_bloc.dart';
import 'package:programming_hacks/services/notification_service.dart';
import 'package:programming_hacks/widgets/custom_button.dart';
import 'package:programming_hacks/widgets/glassmorphic_container.dart';
import 'package:programming_hacks/widgets/rounded_blur_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ValueNotifier<ScrollDirection> scrollDirectionNotifier =
      ValueNotifier<ScrollDirection>(ScrollDirection.forward);
  TextEditingController hacksController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? currentUser;
  String? _selectedTechnology;
  bool? isNotification;
  late SharedPreferences preferences;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await notificationPermission(context);
  }

  @override
  void initState() {
    getTechnologyData();
    getCurrentUserName();
    _loadNotificationState();
    super.initState();
  }

  Future<void> _loadNotificationState() async {
    preferences = await SharedPreferences.getInstance();
    isNotification = preferences.getBool('notification_enabled') ?? true;
    if (isNotification ?? true) {
      await scheduleNotification();
    } else {
      print("Notification Cancle");
    }
  }

  notificationPermission(BuildContext context) async {
    await NotificationService.notificationPermission(context);
  }

  welcomeNotification() async {
    await NotificationService.welcomeNotification();
  }

  scheduleNotification() async {
    await NotificationService.scheduledNotification();
  }

  getTechnologyData() {
    BlocProvider.of<HomeBloc>(context).add(GetTechnologyEvent());
  }

  Future<String?> getCurrentUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser = await prefs.getString("currentUser");
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          RoundedBlurContainer(
            right: 30,
            top: 50,
            color: Colors.greenAccent.withOpacity(0.4),
          ),
          RoundedBlurContainer(
            left: -100,
            bottom: 400,
            color: Colors.pinkAccent.withOpacity(0.4),
          ),
          RoundedBlurContainer(
            right: -50,
            bottom: 200,
            color: Colors.greenAccent.withOpacity(0.4),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
            child: BlocConsumer<HomeBloc, HomeState>(
              buildWhen: (previousState, currentState) {
                return currentState is TechnologyLoadedState || currentState is TechnologyLoadingState;
              },
              listener: (context, state) {},
              builder: (context, state) {
                if (state is TechnologyLoadingState) {
                  return Center(
                    child: Lottie.asset(
                      'assets/lottie/loading.json',
                      height: 100,
                      width: 100,
                    ),
                  );
                }
                if (state is TechnologyLoadedState) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: SafeArea(
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
                                            "${currentUser}",
                                            style: CustomTextTheme.headingNameText,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: sSizedBoxWidth,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              BlocProvider.of<HacksBloc>(context).add(GetSavedHacksEvent());
                                              Navigator.pushNamed(
                                                context,
                                                '/saveScreen',
                                              );
                                            },
                                            icon: Icon(
                                              Icons.bookmark_border,
                                              size: 30,
                                            ),
                                            color: Colors.white,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              BlocProvider.of<AuthUserBloc>(context).add(UserLogoutEvent());
                                              Navigator.pushNamed(
                                                context,
                                                '/settingScreen',
                                              );
                                            },
                                            icon: Icon(
                                              Icons.settings,
                                              size: 30,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AnimationLimiter(
                            child: SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                childCount: state.technologyData?.length,
                                addAutomaticKeepAlives: true,
                                (context, index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    columnCount: 2,
                                    duration: const Duration(milliseconds: 1100),
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        duration: Duration(microseconds: 900),
                                        curve: Curves.bounceInOut,
                                        child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<HacksBloc>(context).add(
                                              GetHacksEvent(id: state.technologyData?[index].id ?? ""),
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
                                                      imageUrl: "${state.technologyData?[index].bgImage}",
                                                      width: 100,
                                                      height: 100,
                                                    ),
                                                    SizedBox(
                                                      height: sSizedBoxHeight,
                                                    ),
                                                    Text(
                                                      "${state.technologyData?[index].name}",
                                                      style: CustomTextTheme.headingNameText,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
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
      floatingActionButton: Visibility(
        visible: currentUser == "admin@gmail.com",
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (_) {
                return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {
                      if (state is CreateHacksLoadedState) {
                        getTechnologyData();
                      }
                    },
                    builder: (context, state) {
                      if (state is CreateHacksLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is TechnologyLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TechnologyLoadedState) {
                        final languageList = state.technologyData;
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                          child: StatefulBuilder(builder: (BuildContext context, setState) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "ADD HACKS",
                                      style: CustomTextTheme.titleText,
                                    ),
                                    SizedBox(
                                      height: mSizedBoxHeight,
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField<String>(
                                        decoration: AppTheme.inputDecoration,
                                        borderRadius: BorderRadius.circular(12),
                                        hint: Text('Select a technology'),
                                        value: _selectedTechnology,
                                        items: languageList?.map((tech) {
                                          return DropdownMenuItem<String>(
                                            value: tech.id,
                                            child: Text(tech.name ?? ""),
                                          );
                                        }).toList(),
                                        onChanged: (String? selectedTech) {
                                          setState(() {
                                            _selectedTechnology = selectedTech;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select an option';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: mSizedBoxHeight,
                                    ),
                                    TextFormField(
                                      controller: hacksController,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: Colors.grey.shade400),
                                        ),
                                        hintText: 'Enter Tips here',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a value';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: mSizedBoxHeight,
                                    ),
                                    CustomButton(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<HomeBloc>(context).add(
                                            CreateHacksEvent(
                                                techId: _selectedTechnology ?? "", hackDetails: hacksController.text),
                                          );
                                        }
                                        hacksController.clear();
                                      },
                                      text: 'Submit',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
