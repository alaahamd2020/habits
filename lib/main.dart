import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habits/Auth/switcher.dart';
import 'package:habits/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habits/generated/l10n.dart';
import 'package:habits/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await StorageService.init();
  initializeDateFormatting('ar');
  // await setupFlutterNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static ColorScheme get theme =>
      ColorScheme.fromSeed(seedColor: Color(0xFF03DAC6));
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habits',
      theme: ThemeData(
        colorScheme: theme.copyWith(),
        textTheme: GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(StorageService.languageCode),
      home: const Switcher(),
    );
  }
}
