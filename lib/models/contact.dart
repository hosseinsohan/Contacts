import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String phone;
  @HiveField(2)
  final String email;

  Contact(
      {@required this.name,
        this.email,
        this.phone});
}
