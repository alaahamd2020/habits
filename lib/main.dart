import 'package:flutter/material.dart';
import 'package:habits/home_view.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('ar' );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static ColorScheme get theme => ColorScheme.fromSeed(seedColor: Color(0xFF03DAC6));
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Habits',
      theme: ThemeData(
        colorScheme: theme.copyWith(
        ),
      ),
      home: const HomeView(),
    );
  }
}
