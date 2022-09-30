import 'package:retrofitapi_flutter/base/base_viewmodel.dart';
import 'package:retrofitapi_flutter/remote/local/databases/food_database.dart';

import '../models/food_model.dart';

class FoodNewsSqfliteVM extends BaseViewModel {
  FoodDatabase db = FoodDatabase();
  Future<List<FoodModel>>? futureList;

  @override
  void onInit() {
    print("FoodNewsSqfliteVM");
    futureList = db.fetchAll();
    notifyListeners();
  }
}
