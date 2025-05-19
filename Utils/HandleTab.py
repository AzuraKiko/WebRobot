import logging
from robot.libraries.BuiltIn import BuiltIn

class HandleTab:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        self._selenium = None
    
    @property
    def selenium(self):
        """Get the SeleniumLibrary instance lazily when needed."""
        if self._selenium is None:
            try:
                self._selenium = BuiltIn().get_library_instance('SeleniumLibrary')
            except Exception as e:
                self.logger.error(f"Error getting SeleniumLibrary instance: {str(e)}")
                raise
        return self._selenium

    def is_tab_selected(self, tab_text):
        """Checks if a tab with the specified text is active (selected).
        Args:
            tab_text (str): The text content of the tab to check.
        Returns:
            bool: True if the tab is active, False otherwise.
        """
        try:
            tab = self.selenium.find_element(f"//li[contains(@class, 'lm_tab') and contains(., '{tab_text}')]")
            return 'lm_active' in tab.get_attribute('class')
        except Exception as e:
            self.logger.error(f'Error checking if tab "{tab_text}" is active: {str(e)}')
            return False

    def is_tab_not_selected(self, tab_text):
        """Checks if a tab with the specified text is not selected.
        Args:
            tab_text (str): The text content of the tab to check.
        Returns:
            bool: True if the tab is not selected, False otherwise.
        """
        return not self.is_tab_selected(tab_text)

    def click_tab(self, tab_text, timeout=5000):
        """Clicks on a tab with the specified text and waits for it to become active.
        Args:
            tab_text (str): The text content of the tab to click.
            timeout (int): Timeout in milliseconds (default: 5000).
        Returns:
            bool: True if the tab was clicked and became active, False otherwise.
        """
        try:
            tab = self.selenium.find_element(f"//li[contains(@class, 'lm_tab') and contains(., '{tab_text}')]")
            self.selenium.click_element(tab)
            return self.selenium.wait_until_element_contains(tab, 'lm_active', timeout=timeout/1000)
        except Exception as e:
            self.logger.error(f'Error clicking tab "{tab_text}": {str(e)}')
            return False

    def close_tab(self, tab_text):
        """Closes a tab with the specified text.

        Args:
            tab_text (str): The text content of the tab to close.
        """
        try:
            # Tìm tab với text được chỉ định
            tab_xpath = f"//li[contains(@class, 'lm_tab') and contains(., '{tab_text}')]"
            tab = self.selenium.find_element(tab_xpath)

            # Hover vào tab để hiển thị nút đóng
            self.selenium.mouse_over(tab)

            # Đợi cho nút đóng hiển thị sau khi hover
            close_button_xpath = f"{tab_xpath}//div[contains(@class, 'lm_close_tab')]"
            self.selenium.wait_until_element_is_visible(close_button_xpath, timeout=2)

            # Tìm và click vào nút đóng
            close_button = self.selenium.find_element(close_button_xpath)
            self.selenium.click_element(close_button)
        except Exception as e:
            self.logger.error(f'Error closing tab "{tab_text}": {str(e)}')

    def get_all_tabs(self):
        """Gets all available tabs.
        Returns:
            list: List of dictionaries containing tab text and active status.
        """
        try:
            tabs = self.selenium.find_elements("//li[contains(@class, 'lm_tab')]")
            return [{'text': tab.text.strip(), 'active': 'lm_active' in tab.get_attribute('class')} for tab in tabs]
        except Exception as e:
            self.logger.error(f'Error getting all tabs: {str(e)}')
            return []
