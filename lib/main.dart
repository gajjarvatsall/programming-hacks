import 'package:appwrite/appwrite.dart';
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
import 'package:programming_hacks/modules/home/view.dart';
import 'package:programming_hacks/modules/onboarding_screen.dart';
import 'package:programming_hacks/repository/hacks_repo.dart';
import 'package:programming_hacks/repository/languages_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? isFirstTime;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, // dark text for status bar
      statusBarColor: Colors.transparent));
  Client client = Client();
  client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
  await GetStorage.init();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('646b25f423d8d38d3471')
      .setSelfSigned(status: true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isFirstTime = await prefs.getBool("isFirstTime");
  await prefs.setBool("isFirstTime", true);
  print('initScreen ${isFirstTime}');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          initialRoute: '/loginScreen',
          routes: {
            '/loginScreen': (context) => const LoginScreen(),
            '/signupScreen': (context) => const SignupScreen(),
            '/homeScreen': (context) => const HomeScreen(),
            '/detailsScreen': (context) => const DetailsScreen(),
            '/onBoardingScreen': (context) => OnBoardingScreen(),
          },
        ),
      ),
    );
  }
}
