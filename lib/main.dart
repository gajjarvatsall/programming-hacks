import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/app_theme/app_theme.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_bloc.dart';
import 'package:programming_hacks/modules/auth/login_screen.dart';
import 'package:programming_hacks/modules/auth/repository/auth_repository.dart';
import 'package:programming_hacks/modules/auth/signup_screen.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/modules/details/view.dart';
import 'package:programming_hacks/modules/home/bloc/home_bloc.dart';
import 'package:programming_hacks/modules/home/save_screen.dart';
import 'package:programming_hacks/modules/home/view.dart';
import 'package:programming_hacks/repository/appwrite_client.dart';
import 'package:programming_hacks/repository/hacks_repo.dart';
import 'package:programming_hacks/repository/languages_repo.dart';
import 'package:programming_hacks/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/onboarding_screen.dart';

bool? isFirstTime;
bool? status;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, // dark text for status bar
      statusBarColor: Colors.transparent));
  AppWriteConfig.getClient();
  AppWriteConfig.getDatabases();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  status = await prefs.getBool('isLoggedIn') ?? false;
  isFirstTime = await prefs.getBool("isFirstTime");
  await prefs.setBool("isFirstTime", true);
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic notifications',
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        playSound: true,
        criticalAlerts: true,
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled notifications',
        channelDescription: 'Notification channel for Scheduled notifications',
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        playSound: true,
        // locked: true,
        criticalAlerts: true,
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Client client;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (context) => HomeBloc(languagesRepository: LanguagesRepository())),
          BlocProvider<HacksBloc>(create: (context) => HacksBloc(hacksRepository: HacksRepository())),
          BlocProvider<AuthUserBloc>(create: (context) => AuthUserBloc(authRepo: AuthenticationRepository()))
        ],
        child: MaterialApp(
          theme: AppTheme.themeData,
          debugShowCheckedModeBanner: false,
          initialRoute: isFirstTime == true
              ? status == true
                  ? '/homeScreen'
                  : '/loginScreen'
              : '/onBoardingScreen',
          routes: {
            '/loginScreen': (context) => const LoginScreen(),
            '/signupScreen': (context) => const SignupScreen(),
            '/homeScreen': (context) => const HomeScreen(),
            '/detailsScreen': (context) => DetailsScreen(),
            '/saveScreen': (context) => SaveHacksScreen(),
            '/onBoardingScreen': (context) => OnBoardingScreen(),
          },
        ),
      ),
    );
  }
}
