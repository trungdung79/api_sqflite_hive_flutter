import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  final String title;
  final String description;
  const FoodItem({Key? key,
    required this.title,
    required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),

        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(1, 3),),
        ],

      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
          ),
          const Divider(color: Colors.red, thickness: 0.7,),
          Text(description),
        ],
      ),
    );
  }
}
