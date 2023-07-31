from appium_flutter_finder import FlutterFinder


class AppFlutterFinder(FlutterFinder):
    def by_icon(self, icon_data: str):
        return self._serialize(dict(
            finderType='IconFinder',
            iconData=icon_data,
        ))