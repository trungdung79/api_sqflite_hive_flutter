import 'package:flutter/material.dart';
import 'package:retrofitapi_flutter/base/base_page.dart';
import 'package:retrofitapi_flutter/models/food_model.dart';

import '../components/food_item.dart';
import 'foodnews_sqflite_viewmodel.dart';

class FoodNewsSqflitePage extends StatefulWidget {
  const FoodNewsSqflitePage({Key? key}) : super(key: key);

  @override
  State<FoodNewsSqflitePage> createState() => _FoodNewsSqflitePageState();
}

class _FoodNewsSqflitePageState extends State<FoodNewsSqflitePage> with MixinBasePage<FoodNewsSqfliteVM> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return builder(() => Scaffold(
      appBar: AppBar(
        title: const Text('GET DATA FROM SQFLITE'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.8,
              child: FutureBuilder<List<FoodModel>>(
                future: provider.futureList,
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return const Center(
                     child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.hasError) {
                    return const Center(
                      child: Text("Load Data Error!!"),
                    );
                  }
                  List<FoodModel> futureList = snapshot.data!;
                  return ListView.builder(
                    itemCount: futureList.length,
                    itemBuilder: (context, index) {
                      return FoodItem(
                        title: futureList[index].title!,
                        description: futureList[index].description!,
                      );
                    });
                },
              ),
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
  FoodNewsSqfliteVM create() {
    return FoodNewsSqfliteVM();
  }

  @override
  void initialise(BuildContext context) {}
}
