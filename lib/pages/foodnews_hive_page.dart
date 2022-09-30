import 'package:flutter/material.dart';
import 'package:retrofitapi_flutter/base/base_page.dart';

import '../components/food_item.dart';
import 'foodnews_hive_viewmodel.dart';

class FoodNewsHivePage extends StatefulWidget {
  const FoodNewsHivePage({Key? key}) : super(key: key);

  @override
  State<FoodNewsHivePage> createState() => _FoodNewsHivePageState();
}

class _FoodNewsHivePageState extends State<FoodNewsHivePage> with MixinBasePage<FoodNewsHiveVM> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return builder(() => Scaffold(
      appBar: AppBar(
        title: const Text('GET DATA FROM HIVE'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.8,
              child: ListView.builder(
                  itemCount: provider.foodList.length,
                  itemBuilder: (context, index) {
                    return FoodItem(
                      title: provider.foodList[index].title,
                      description: provider.foodList[index].description,
                    );
                  }),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  FoodNewsHiveVM create() {
    return FoodNewsHiveVM();
  }

  @override
  void initialise(BuildContext context) {}
}
