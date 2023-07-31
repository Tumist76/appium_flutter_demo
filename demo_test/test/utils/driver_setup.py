import os

from appium.webdriver import webdriver, Remote
from dotenv import load_dotenv

from test.utils.testing_platform import Platform

load_dotenv()


def create_driver() -> webdriver.WebDriver:
    host = os.getenv('APPIUM_HOST')
    platform = Platform(os.getenv('PLATFORM'))
    capabilities = dict(
        platformName=platform.value,
        automationName='flutter',
    )
    if platform == Platform.android:
        capabilities['app'] = os.getenv('ANDROID_APP_PATH')
        capabilities['autoGrantPermissions'] = True
        capabilities['chromedriverExecutableDir'] = os.getenv('CHROMEDRIVER_EXECUTABLE_DIR')
    if platform == Platform.ios:
        capabilities['app'] = os.getenv('IOS_APP_PATH')
        capabilities['deviceName'] = os.getenv('IOS_DEVICE_NAME')
        capabilities['platformVersion'] = os.getenv('IOS_PLATFORM_VERSION')
        capabilities['autoAcceptAlerts'] = True

    return Remote(host, capabilities)
