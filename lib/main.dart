import 'package:dich_x_noi_tu/bloc/events/app_event.dart';
import 'package:dich_x_noi_tu/bloc/translate_bloc.dart';
import 'package:dich_x_noi_tu/global.dart';
import 'package:dich_x_noi_tu/models/language.dart';
import 'package:dich_x_noi_tu/models/translator.dart';
import 'package:dich_x_noi_tu/repositories/database.dart';
import 'package:dich_x_noi_tu/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper db = DatabaseHelper();
  final database = await db.database;
  db.createTable(database, tableName: historyTable);
  db.createTable(database, tableName: bookMarkTable);
  // print(db.getData(database, tableName: bookMarkTable));
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Language initialLang =
      Language(originalLang: LanguageEnum.en, translatorLang: LanguageEnum.vi);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TranslateBloc>(
          create: (context) => TranslateBloc(),
        ),
        BlocProvider<AppBloc>(
          create: (context) =>
              AppBloc()..add(AppEventChange(lang: initialLang)),
        ),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: ScreenApp()),
    );
  }
}
