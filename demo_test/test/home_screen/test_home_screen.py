import unittest

from appium.webdriver.common.appiumby import AppiumBy
from test.utils.base_test_case import BaseTestCase
from test.utils.testing_platform import Platform


class HomeScreenTest(BaseTestCase):
    test_title = 'Тестирование каких-то программ'

    def open_creation_dialog(self):
        self.get_flutter_element(self.finder.by_type('FloatingActionButton')).click()

    def pick_file_in_dialog(self):
        self.get_flutter_element(self.finder.by_text('Выбрать файл')).click()
        self.switch_to_native()

        if self.running_platform == Platform.ios:
            self.get_element(AppiumBy.ACCESSIBILITY_ID, 'Photo, August 09, 2012, 4:29 AM').click()
        if self.running_platform == Platform.android:
            self.get_element(AppiumBy.ID, 'com.google.android.apps.photos:id/image').click()
            self.get_element(AppiumBy.ACCESSIBILITY_ID, 'Photo taken on Jul 28, 2023 10:09:20 AM').click()

        self.switch_to_flutter()

    def enter_title(self):
        field = self.get_flutter_element(self.finder.by_type('TextField'))
        field.click()
        field.send_keys(self.test_title)

    def add_new_record(self):
        self.open_creation_dialog()
        self.pick_file_in_dialog()
        self.enter_title()
        self.get_flutter_element(self.finder.by_text('Сохранить')).click()

    def test_creation_dialog_opening(self):
        """
        Если нажата 'Добавить', открывать диалог добавления новой записи
        """
        self.open_creation_dialog()
        self.assertTrue(self.is_flutter_element_exist(self.finder.by_type('NewItemDialog')))

    def test_add_record_picked_file(self):
        """
        Если в диалоге добавления новой записи выбран файл, на кнопке выбора отображается "Файл выбран"
        """
        self.open_creation_dialog()
        self.pick_file_in_dialog()
        self.assertTrue(self.is_flutter_element_exist(self.finder.by_text('Файл выбран')))

    def test_add_record_title_edited(self):
        """
        Если в диалоге добавления новой записи введено название, оно отображается в поле
        """
        self.open_creation_dialog()
        self.enter_title()
        self.assertTrue(self.is_flutter_element_exist(self.finder.by_text(self.test_title)))

    def test_add_record_success(self):
        """
        Если в диалоге добавления новой записи введено название, выбрано изображение и нажата кнопка сохранить,
        запись отображается в списке
        """
        self.add_new_record()
        self.assertTrue(
            self.is_flutter_element_exist(
                self.finder.by_descendant(self.finder.by_type('RecordCard'), self.finder.by_text(self.test_title))
            )
        )

    def test_delete_record(self):
        """
        Если в карточке записи нажата кнопка "Удалить", убрать эту запись из списка
        """
        self.add_new_record()
        self.get_flutter_element(self.finder.by_icon('IconData(U+0F697)')).click()
        self.assertFalse(
            self.is_flutter_element_exist(
                self.finder.by_descendant(self.finder.by_type('RecordCard'), self.finder.by_text(self.test_title))
            )
        )
        self.assertTrue(self.is_flutter_element_exist(self.finder.by_type('EmptyWidget')))

    def test_record_search(self):
        """
        Если нажата кнопка поиска, открыть поиск в Википедии для названия текущей записи
        """
        self.add_new_record()
        self.get_flutter_element(self.finder.by_text('Найти в Wikipedia')).click()
        self.switch_to_webview()
        search_box = self.get_element(AppiumBy.XPATH, '//*[@id="ooui-php-1"]')
        self.assertEqual(search_box.get_attribute('value'), self.test_title)


if __name__ == '__main__':
    unittest.main()
