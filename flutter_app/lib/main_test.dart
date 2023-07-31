import 'package:appium_demo/finders/icon_finder/icon_finder_extension.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:appium_demo/main.dart' as normal;

void main() {
  enableFlutterDriverExtension(finders: [IconFinderExtension()]);
  normal.main();
}
