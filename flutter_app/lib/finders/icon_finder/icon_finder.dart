import 'package:flutter_driver/flutter_driver.dart';

class IconFinder extends SerializableFinder {
  final String? iconData;

  const IconFinder({required this.iconData});

  @override
  String get finderType => 'IconFinder';
}
