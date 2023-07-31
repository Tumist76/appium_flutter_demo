import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_driver/flutter_driver.dart' show SerializableFinder;
import 'package:flutter_test/flutter_test.dart';

import 'icon_finder.dart';

class IconFinderExtension extends FinderExtension {
  @override
  String get finderType => 'IconFinder';

  @override
  SerializableFinder deserialize(
    Map<String, String> params,
    DeserializeFinderFactory finderFactory,
  ) {
    return IconFinder(iconData: params['iconData']);
  }

  @override
  Finder createFinder(
    SerializableFinder finder,
    CreateFinderFactory finderFactory,
  ) {
    return find.byElementPredicate((element) {
      final iconFinder = finder as IconFinder;
      final Widget widget = element.widget;
      if (widget is Icon) {
        return (element.widget as Icon).icon.toString() == iconFinder.iconData;
      }
      return false;
    });
  }
}
