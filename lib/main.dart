import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:retrofitapi_flutter/models/food.dart';
import 'package:retrofitapi_flutter/pages/foodnews_page.dart';
import 'package:retrofitapi_flutter/pages/foodnews_viewmodel.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'base/di/locator.dart';
import 'main_viewmodel.dart';
import 'pages/home_page.dart';

void main() {
  /*
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(FoodAdapter());
  */

  setUpInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<FoodNewsVM>(create: (_) => FoodNewsVM())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FULL API - RETROFIT',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const FoodNewsPage(title: 'FETCH API RETROFIT - DIO'),
      ),
    );
  }
}
