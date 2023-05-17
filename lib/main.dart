import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/modules/details/view.dart';
import 'package:programming_hacks/modules/home/view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ymzdiwhuyzrkjmtuvymc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InltemRpd2h1eXpya2ptdHV2eW1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQzMDU3OTQsImV4cCI6MTk5OTg4MTc5NH0.crTCrnPlVM8YWA2o_LBvlEHil7xn9iXGiWK7pio6syI',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HacksBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/detailsScreen',
        routes: {
          '/homeScreen': (context) => const HomeScreen(),
          '/detailsScreen': (context) => const DetailsScreen(),
        },
      ),
    );
  }
}
