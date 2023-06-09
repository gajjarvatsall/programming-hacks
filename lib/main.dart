import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:programming_hacks/app_theme/app_theme.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_bloc.dart';
import 'package:programming_hacks/modules/auth/login_screen.dart';
import 'package:programming_hacks/modules/auth/repository/auth_repository.dart';
import 'package:programming_hacks/modules/auth/signup_screen.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/modules/details/view.dart';
import 'package:programming_hacks/modules/home/bloc/home_bloc.dart';
import 'package:programming_hacks/modules/home/view.dart';
import 'package:programming_hacks/repository/hacks_repo.dart';
import 'package:programming_hacks/repository/languages_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // dark text for status bar
      statusBarColor: Colors.transparent));
  await Supabase.initialize(
    url: 'https://ymzdiwhuyzrkjmtuvymc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InltemRpd2h1eXpya2ptdHV2eW1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQzMDU3OTQsImV4cCI6MTk5OTg4MTc5NH0.crTCrnPlVM8YWA2o_LBvlEHil7xn9iXGiWK7pio6syI',
  );
  runApp(const MyApp());
}

final SupabaseClient client = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Session?> session;

  void initState() {
    super.initState();
    session = SupabaseAuth.instance.initialSession;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  HomeBloc(languagesRepository: LanguagesRepository())),
          BlocProvider(
              create: (context) =>
                  HacksBloc(hacksRepository: HacksRepository())),
          BlocProvider(
              create: (context) =>
                  AuthUserBloc(authRepo: AuthenticationRepository()))
        ],
        child: MaterialApp(
          theme: AppTheme.themeData,
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: session,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(" Snapshot have Data : ${snapshot.hasData}");
                return const HomeScreen();
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('${snapshot.error}'),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print(" Snapshot in waiting state : ${snapshot.hasData}");
                return Center(
                  child: Lottie.asset(
                    'assets/lottie/loading.json',
                    height: 100,
                    width: 100,
                  ),
                );
              }
              print(" Snapshot data is Null : ${snapshot.hasData}");
              // return const HomeScreen();
              return const LoginScreen();
            },
          ),
          routes: {
            '/loginScreen': (context) => const LoginScreen(),
            '/signupScreen': (context) => const SignupScreen(),
            '/homeScreen': (context) => const HomeScreen(),
            '/detailsScreen': (context) => const DetailsScreen(),
          },
        ),
      ),
    );
  }
}
