from typing import Any, Dict, Optional
from robot.api.deco import keyword
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class DynamicLocators:
    @keyword
    @staticmethod
    def create(base_locator: str, *params: Any) -> str:
        """
        Create dynamic locator with parameter substitution
        
        Args:
            base_locator: Base locator containing placeholders
            *params: Parameters to substitute into placeholders
            
        Returns:
            str: Locator with substituted parameters
            
        Examples:
            >>> DynamicLocators.create('//button[contains(text(), "{0}")]', 'Save')
            '//button[contains(text(), "Save")]'
            
            >>> DynamicLocators.create('//table[@id="{0}"]//tr[{1}]/td[{2}]', 'userTable', 3, 2)
            '//table[@id="userTable"]//tr[3]/td[2]'
        """
        if not base_locator:
            logger.error('Base locator cannot be empty')
            raise ValueError('Base locator cannot be empty')
            
        result = base_locator
        for i, param in enumerate(params):
            placeholder = f"{{{i}}}"
            value = str(param) if param is not None else ''
            result = result.replace(placeholder, value)
            
        logger.debug(f'Created dynamic locator: {result}')
        return result

    @keyword
    @staticmethod
    def xpath(base_xpath: str, *params: Any) -> str:
        """Create XPath locator with parameter substitution"""
        return DynamicLocators.create(base_xpath, *params)

    @keyword
    @staticmethod
    def css(base_css: str, *params: Any) -> str:
        """Create CSS selector with parameter substitution"""
        return DynamicLocators.create(base_css, *params)

    @keyword
    @staticmethod
    def exact_text(text: str) -> str:
        """Create locator for exact text match"""
        return f'//*/text()[normalize-space(.)="{text}"]/parent::*'

    @keyword
    @staticmethod
    def contains_text(text: str) -> str:
        """Create locator for containing text"""
        return f'//*[contains(text(), "{text}")]'

    @keyword
    @staticmethod
    def button(text: str) -> str:
        """Create locator for button with text"""
        return f'//button[contains(text(), "{text}") or contains(@value, "{text}")]'

    @keyword
    @staticmethod
    def input_by_label(label: str) -> str:
        """Create locator for input with label"""
        return f'//label[contains(text(), "{label}")]/following::input[1]'

    @keyword
    @staticmethod
    def input_by_placeholder(placeholder: str) -> str:
        """Create locator for input with placeholder"""
        return f'//input[@placeholder="{placeholder}"]'

    @keyword
    @staticmethod
    def link(text: str) -> str:
        """Create locator for link with text"""
        return f'//a[contains(text(), "{text}")]'

    @keyword
    @staticmethod
    def dropdown_by_label(label: str) -> str:
        """Create locator for dropdown with label"""
        return f'//label[contains(text(), "{label}")]/following::select[1]'

    @keyword
    @staticmethod
    def dropdown_option(text: str) -> str:
        """Create locator for dropdown option"""
        return f'//option[contains(text(), "{text}")]'

    @keyword
    @staticmethod
    def checkbox_by_label(label: str) -> str:
        """Create locator for checkbox with label"""
        return (f'//label[contains(text(), "{label}")]/preceding::input[@type="checkbox"][1] | '
                f'//label[contains(text(), "{label}")]/following::input[@type="checkbox"][1]')

    @keyword
    @staticmethod
    def radio_by_label(label: str) -> str:
        """Create locator for radio button with label"""
        return (f'//label[contains(text(), "{label}")]/preceding::input[@type="radio"][1] | '
                f'//label[contains(text(), "{label}")]/following::input[@type="radio"][1]')

    @keyword
    @staticmethod
    def table_cell(table_id: str, row: int, column: int) -> str:
        """Create locator for table cell"""
        return f'//table[@id="{table_id}"]//tr[{row}]/td[{column}]'

    @keyword
    @staticmethod
    def table_row_with_text(table_id: str, text: str) -> str:
        """Create locator for table row containing text"""
        return f'//table[@id="{table_id}"]//tr[contains(., "{text}")]'

    @keyword
    @staticmethod
    def element_by_attribute(tag: str, attribute: str, value: str) -> str:
        """Create locator for element with attribute"""
        return f'//{tag}[@{attribute}="{value}"]'

    @keyword
    @staticmethod
    def element_by_attributes(tag: str, attributes: Dict[str, str]) -> str:
        """Create locator for element with multiple attributes"""
        if not attributes:
            return f'//{tag}'
            
        conditions = ' and '.join(f'@{attr}="{value}"' for attr, value in attributes.items())
        return f'//{tag}[{conditions}]'

    @keyword
    @staticmethod
    def child_element(parent_locator: str, child_tag: str, child_attributes: Optional[Dict[str, str]] = None) -> str:
        """Create locator for child element"""
        if not child_attributes:
            return f'{parent_locator}//{child_tag}'
            
        conditions = ' and '.join(f'@{attr}="{value}"' for attr, value in child_attributes.items())
        return f'{parent_locator}//{child_tag}[{conditions}]'

    @keyword
    @staticmethod
    def next_sibling(locator: str, sibling_tag: str) -> str:
        """Create locator for next sibling element"""
        return f'{locator}/following-sibling::{sibling_tag}[1]'

    @keyword
    @staticmethod
    def previous_sibling(locator: str, sibling_tag: str) -> str:
        """Create locator for previous sibling element"""
        return f'{locator}/preceding-sibling::{sibling_tag}[1]'

    @keyword
    @staticmethod
    def parent(locator: str, parent_tag: str = '*') -> str:
        """Create locator for parent element"""
        return f'{locator}/parent::{parent_tag}'

    @keyword
    @staticmethod
    def element_by_position(tag: str, position: int) -> str:
        """Create locator for element by position"""
        return f'//{tag}[{position}]'

    @keyword
    @staticmethod
    def element_by_class(tag: str, class_name: str) -> str:
        """Create locator for element with class"""
        return f'//{tag}[contains(@class, "{class_name}")]'

    @keyword
    @staticmethod
    def element_by_id(tag: str, id: str) -> str:
        """Create locator for element with ID"""
        return f'//{tag}[@id="{id}"]'

    @keyword
    @staticmethod
    def element_by_name(tag: str, name: str) -> str:
        """Create locator for element with name"""
        return f'//{tag}[@name="{name}"]'

    @keyword
    @staticmethod
    def css_by_id(id: str) -> str:
        """Create CSS selector for element with ID"""
        return f'#{id}'

    @keyword
    @staticmethod
    def css_by_class(class_name: str) -> str:
        """Create CSS selector for element with class"""
        return f'.{class_name}'

    @keyword
    @staticmethod
    def css_by_attribute(attribute: str, value: str) -> str:
        """Create CSS selector for element with attribute"""
        return f'[{attribute}="{value}"]'

    @keyword
    @staticmethod
    def with_text(base_xpath: str) -> callable:
        """Create function that returns locator with text"""
        return lambda text: f'{base_xpath}[contains(text(), "{text}")]'

    @keyword
    @staticmethod
    def with_attribute(base_xpath: str, attribute: str) -> callable:
        """Create function that returns locator with attribute"""
        return lambda value: f'{base_xpath}[@{attribute}="{value}"]'

    @keyword
    @staticmethod
    def with_class(base_xpath: str) -> callable:
        """Create function that returns locator with class"""
        return lambda class_name: f'{base_xpath}[contains(@class, "{class_name}")]'

    @keyword
    @staticmethod
    def with_id(base_xpath: str) -> callable:
        """Create function that returns locator with ID"""
        return lambda id: f'{base_xpath}[@id="{id}"]'

    @keyword
    @staticmethod
    def nth_element(base_xpath: str) -> callable:
        """Create function that returns nth element locator"""
        return lambda position: f'({base_xpath})[{position}]'
