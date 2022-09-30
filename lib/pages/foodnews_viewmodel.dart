import 'package:dio/dio.dart';
import 'package:retrofitapi_flutter/base/base_viewmodel.dart';

import '../models/food_model.dart';
import '../remote/service/response/news_response.dart';

class FoodNewsVM extends BaseViewModel {
  NewAllResponse? data;
  List<FoodModel> listData = [];

  @override
  void onInit() {
    print("FoodNewsVM");
    fetchNewsAll();
  }

  Future fetchNewsAll() async {
    showLoading();
    try {
      final response = await api.newServices.getNewAll();
      data = response;
      listData.addAll(data?.dataList ?? []);
      notifyListeners();
      hideLoading();
    } on DioError catch (e) {
      print(e);
      hideLoading();
    }
  }
}
