
import 'package:hive/hive.dart';

part 'food.g.dart';

@HiveType(typeId: 1)
class Food {
  Food({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String thumbnail;

  @HiveField(3)
  String description;

  @override
  String toString() {
    return '$id: $title';
  }
}
