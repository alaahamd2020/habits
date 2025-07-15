import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habits/binding.dart';
import 'package:habits/firebase_options.dart';
import 'package:habits/home.dart';
import 'package:habits/home_view.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting('ar' );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static ColorScheme get theme => ColorScheme.fromSeed(seedColor: Color(0xFF03DAC6));
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Habits',
      theme: ThemeData(
        colorScheme: theme.copyWith(
        ),
      ),
      home: const Home(),
    );
  }
}
