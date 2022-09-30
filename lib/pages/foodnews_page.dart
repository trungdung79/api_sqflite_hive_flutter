import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:retrofitapi_flutter/base/base_page.dart';
import 'package:retrofitapi_flutter/models/food.dart';
import 'package:retrofitapi_flutter/models/food_model.dart';
import 'package:retrofitapi_flutter/pages/foodnews_sqflite_page.dart';
import 'package:retrofitapi_flutter/pages/foodnews_viewmodel.dart';
import 'package:retrofitapi_flutter/remote/local/databases/food_database.dart';
import 'package:sqflite/sqflite.dart';

import '../components/food_item.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'foodnews_hive_page.dart';

class FoodNewsPage extends StatefulWidget {
  const FoodNewsPage({super.key, required this.title});

  final String title;

  @override
  State<FoodNewsPage> createState() => _FoodNewsPageState();
}

class _FoodNewsPageState extends State<FoodNewsPage> with MixinBasePage<FoodNewsVM> {
  @override
  void initState() {
    super.initState();
    Hive.registerAdapter(FoodAdapter());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return builder(() => Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.6,
              child: ListView.builder(
                  itemCount: provider.listData.length,
                  itemBuilder: (context, index) {
                    return FoodItem(
                      title: provider.listData[index].title??'',
                      description: provider.listData[index].description??'',
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    FoodDatabase db = FoodDatabase();
                    for (FoodModel foodModel in provider.listData) {
                      FoodModel foodModel1 = FoodModel.name1(
                        id: null,
                        title: foodModel.title,
                        thumbnail: foodModel.thumbnail,
                        description: foodModel.description,
                      );
                      await db.addFoodModel(foodModel1);
                    }
                    //db.closeDb();
                    print('FoodData have been saved to Sqflite');
                  },
                  child: const Text('Save data to Sqflite'),
                ),
                TextButton(
                  onPressed: () async {
                    await deleteDatabase('food.db');
                    //db.closeDb();
                    print('FoodData have been deleted from Sqflite');
                  },
                  child: const Text('Delete data from Sqflite'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                var route = MaterialPageRoute(builder: (context) => const FoodNewsSqflitePage());
                Navigator.push(context, route);
              },
              child: const Text('Move to new page and get data from Sqflite'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {

                    var appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
                    Hive.init(appDocumentDirectory.path);

                    var box = await Hive.openBox('foods');

                    for (FoodModel foodModel in provider.listData) {
                      Food food = Food(
                          id: foodModel.id!,
                          title: foodModel.title!,
                          thumbnail: foodModel.thumbnail!,
                          description: foodModel.description!
                      );
                      await box.put(food.id.toString(), food);
                      print(box.get(food.id.toString()));
                    }
                    print('FoodData have been saved to Hive');
                    //box.close();
                  },
                  child: const Text('Save data to Hive'),
                ),
                TextButton(
                  onPressed: () async {

                    var appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
                    Hive.init(appDocumentDirectory.path);

                    var box = await Hive.openBox('foods');
                    await box.clear();

                    print('FoodData have been deleted from Hive');
                    //box.close();
                  },
                  child: const Text('Delete data from Hive'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                var route = MaterialPageRoute(builder: (context) => const FoodNewsHivePage());
                Navigator.push(context, route);
              },
              child: const Text('Move to new page and get data from Hive'),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  FoodNewsVM create() {
    return FoodNewsVM();
  }

  @override
  void initialise(BuildContext context) {}
}
