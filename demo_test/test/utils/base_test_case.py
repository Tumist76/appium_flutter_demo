import os
import time
import unittest

from appium.webdriver import WebElement
from appium.webdriver.common.appiumby import AppiumBy
from appium.webdriver.webdriver import WebDriver
from appium_flutter_finder import FlutterFinder, FlutterElement
from selenium.common import TimeoutException, WebDriverException
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.wait import WebDriverWait

from test.utils.app_flutter_finder import AppFlutterFinder
from test.utils.driver_setup import create_driver
from test.utils.testing_platform import Platform


class BaseTestCase(unittest.TestCase):
    driver: WebDriver
    finder: AppFlutterFinder

    running_platform: Platform

    def setUp(self) -> None:
        self.driver = create_driver()
        self.finder = AppFlutterFinder()
        # Определяем текущую платформу
        self.running_platform = Platform(os.getenv('PLATFORM'))

    def tearDown(self) -> None:
        if self.driver:
            self.driver.quit()

    def is_flutter_element_exist(self, finder: str, wait_for_duration: int = 5000) -> bool:
        try:
            self.driver.execute_script('flutter:waitFor', finder, wait_for_duration)
            return True
        except WebDriverException:
            return False

    def is_element_exist(
            self,
            by: str = AppiumBy.ID,
            value: str | dict | None = None,
            wait_for_duration: int = 5
    ):
        try:
            WebDriverWait(self.driver, wait_for_duration).until(
                expected_conditions.presence_of_element_located((by, value))
            )
            return True
        except TimeoutException:
            return False

    def get_flutter_element(self, finder: str) -> FlutterElement:
        if not self.is_flutter_element_exist(finder):
            raise Exception('Element not found')
        return FlutterElement(self.driver, finder)

    def get_element(self, by: str = AppiumBy, value: str | dict | None = None) -> WebElement:
        if not self.is_element_exist(by, value):
            raise Exception('Element not found')
        return self.driver.find_element(by, value)

    def find_webview_context(self):
        self.driver.contexts
        # Ожидание для корректной загрузки доступных контекстов
        time.sleep(5)
        return next((x for x in self.driver.contexts if x.startswith('WEBVIEW')), None)

    def switch_to_webview(self, webview_id: str = None) -> None:
        """
        Меняет контекст драйвера на первый доступный WebView внутри Flutter-приложения
        """
        webview = webview_id if webview_id is not None else self.find_webview_context()
        self.driver.switch_to.context(webview)

    def switch_to_flutter(self) -> None:
        """
        Меняет контекст драйвера на Flutter-приложение
        """
        self.driver.switch_to.context('FLUTTER')

    def switch_to_native(self) -> None:
        """
        Меняет контекст драйвера на нативную часть приложения
        """
        self.driver.switch_to.context('NATIVE_APP')
