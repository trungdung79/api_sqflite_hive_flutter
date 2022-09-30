import 'package:hive/hive.dart';
import 'package:retrofitapi_flutter/base/base_viewmodel.dart';

import '../models/food.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

class FoodNewsHiveVM extends BaseViewModel {
  List<Food> foodList = [];

  @override
  void onInit() async {
    print("FoodNewsHiveVM");

    var appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    //Hive.registerAdapter(FoodAdapter());

    var box = await Hive.openBox('foods');
    var list = box.values.toList();
    for (var i = 0; i < list.length; i++) {
      foodList.add(list[i]);
    }

    foodList.sort((a, b) {
      if (a.id > b.id) return 1;
      else if (a.id < b.id) return -1;
      else return 0;
    });

    notifyListeners();
  }
}
