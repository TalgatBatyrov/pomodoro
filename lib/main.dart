import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ky', 'KG'),
        Locale('ru', 'RU'),
      ],
      path: 'translations',
      fallbackLocale: const Locale('ru', 'RU'),
      child: const App(),
    ),
  );
}
