import json
import csv
import logging
from pathlib import Path
from typing import List, Dict, Any, Optional
import pandas as pd

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class FileHelper:
    """Utility class for file operations"""
    
    @staticmethod
    def read_json_file(file_path: str) -> Dict[str, Any]:
        """
        Read JSON file
        Args:
            file_path: Path to the file
        Returns:
            Dict containing JSON data
        """
        try:
            absolute_path = Path(file_path).resolve()
            logger.debug(f"Reading JSON file: {absolute_path}")
            
            with open(absolute_path, 'r', encoding='utf-8') as f:
                return json.load(f)
        except Exception as e:
            logger.error(f"Error reading JSON file: {file_path}", exc_info=True)
            raise

    @staticmethod
    def write_json_file(file_path: str, data: Dict[str, Any], pretty: bool = True) -> None:
        """
        Write data to JSON file
        Args:
            file_path: Path to the file
            data: Data to write
            pretty: Format JSON nicely (default: True)
        """
        try:
            absolute_path = Path(file_path).resolve()
            logger.debug(f"Writing JSON file: {absolute_path}")
            
            # Create directory if it doesn't exist
            absolute_path.parent.mkdir(parents=True, exist_ok=True)
            
            with open(absolute_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=2 if pretty else None, ensure_ascii=False)
            logger.debug(f"Successfully wrote JSON file: {absolute_path}")
        except Exception as e:
            logger.error(f"Error writing JSON file: {file_path}", exc_info=True)
            raise

    @staticmethod
    def read_csv_file(file_path: str, delimiter: str = ',') -> List[Dict[str, str]]:
        """
        Read CSV file and convert to list of dictionaries
        Args:
            file_path: Path to the file
            delimiter: Delimiter character (default: ,)
        Returns:
            List of dictionaries containing CSV data
        """
        try:
            absolute_path = Path(file_path).resolve()
            logger.debug(f"Reading CSV file: {absolute_path}")
            
            with open(absolute_path, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f, delimiter=delimiter)
                return [dict(row) for row in reader]
        except Exception as e:
            logger.error(f"Error reading CSV file: {file_path}", exc_info=True)
            raise

    @staticmethod
    def write_csv_file(file_path: str, data: List[Dict[str, Any]], delimiter: str = ',') -> None:
        """
        Write list of dictionaries to CSV file
        Args:
            file_path: Path to the file
            data: List of dictionaries to write
            delimiter: Delimiter character (default: ,)
        """
        try:
            absolute_path = Path(file_path).resolve()
            logger.debug(f"Writing CSV file: {absolute_path}")
            
            # Create directory if it doesn't exist
            absolute_path.parent.mkdir(parents=True, exist_ok=True)
            
            if not data:
                absolute_path.write_text('', encoding='utf-8')
                logger.debug(f"Wrote empty CSV file: {absolute_path}")
                return
            
            with open(absolute_path, 'w', encoding='utf-8', newline='') as f:
                writer = csv.DictWriter(f, fieldnames=data[0].keys(), delimiter=delimiter)
                writer.writeheader()
                writer.writerows(data)
            logger.debug(f"Successfully wrote CSV file: {absolute_path}")
        except Exception as e:
            logger.error(f"Error writing CSV file: {file_path}", exc_info=True)
            raise

    @staticmethod
    def read_text_file(file_path: str) -> str:
        """
        Read text file
        Args:
            file_path: Path to the file
        Returns:
            File content as string
        """
        try:
            absolute_path = Path(file_path).resolve()
            logger.debug(f"Reading text file: {absolute_path}")
            
            return absolute_path.read_text(encoding='utf-8')
        except Exception as e:
            logger.error(f"Error reading text file: {file_path}", exc_info=True)
            raise

    @staticmethod
    def write_text_file(file_path: str, content: str, append: bool = False) -> None:
        """
        Write content to text file
        Args:
            file_path: Path to the file
            content: Content to write
            append: Append to file instead of overwriting (default: False)
        """
        try:
            absolute_path = Path(file_path).resolve()
            logger.debug(f"{'Appending to' if append else 'Writing'} text file: {absolute_path}")
            
            # Create directory if it doesn't exist
            absolute_path.parent.mkdir(parents=True, exist_ok=True)
            
            mode = 'a' if append else 'w'
            with open(absolute_path, mode, encoding='utf-8') as f:
                f.write(content)
            logger.debug(f"Successfully {'appended to' if append else 'wrote'} text file: {absolute_path}")
        except Exception as e:
            logger.error(f"Error {'appending to' if append else 'writing'} text file: {file_path}", exc_info=True)
            raise

    @staticmethod
    def file_exists(file_path: str) -> bool:
        """
        Check if file exists
        Args:
            file_path: Path to the file
        Returns:
            True if file exists
        """
        try:
            return Path(file_path).resolve().exists()
        except Exception as e:
            logger.error(f"Error checking if file exists: {file_path}", exc_info=True)
            return False

    @staticmethod
    def delete_file(file_path: str) -> bool:
        """
        Delete file
        Args:
            file_path: Path to the file
        Returns:
            True if deletion was successful
        """
        try:
            absolute_path = Path(file_path).resolve()
            if absolute_path.exists():
                absolute_path.unlink()
                logger.debug(f"Deleted file: {absolute_path}")
                return True
            
            logger.debug(f"File does not exist to delete: {absolute_path}")
            return False
        except Exception as e:
            logger.error(f"Error deleting file: {file_path}", exc_info=True)
            return False

    @staticmethod
    def create_directory(dir_path: str) -> bool:
        """
        Create directory if it doesn't exist
        Args:
            dir_path: Path to the directory
        Returns:
            True if creation was successful or directory already exists
        """
        try:
            absolute_path = Path(dir_path).resolve()
            absolute_path.mkdir(parents=True, exist_ok=True)
            logger.debug(f"Directory created or already exists: {absolute_path}")
            return True
        except Exception as e:
            logger.error(f"Error creating directory: {dir_path}", exc_info=True)
            return False

    @staticmethod
    def list_files(dir_path: str, extension: str = '') -> List[str]:
        """
        List files in directory
        Args:
            dir_path: Path to the directory
            extension: File extension to filter (optional)
        Returns:
            List of file paths
        """
        try:
            absolute_path = Path(dir_path).resolve()
            if not absolute_path.exists():
                logger.warning(f"Directory does not exist: {absolute_path}")
                return []
            
            if extension:
                return [str(f) for f in absolute_path.glob(f"*{extension}")]
            return [str(f) for f in absolute_path.iterdir() if f.is_file()]
        except Exception as e:
            logger.error(f"Error listing files in directory: {dir_path}", exc_info=True)
            return []

    @staticmethod
    def save_screenshot(screenshot_data: bytes, file_name: str, dir_path: str = './screenshots') -> str:
        """
        Save screenshot
        Args:
            screenshot_data: Screenshot data as bytes
            file_name: File name (without path)
            dir_path: Directory to save screenshot (default: ./screenshots)
        Returns:
            Path to the saved screenshot
        """
        try:
            # Create directory if it doesn't exist
            FileHelper.create_directory(dir_path)
            
            # Ensure file name has .png extension
            file_name = f"{file_name}.png" if not file_name.endswith('.png') else file_name
            
            # Full path to file
            file_path = Path(dir_path) / file_name
            absolute_path = file_path.resolve()
            
            # Write file
            absolute_path.write_bytes(screenshot_data)
            logger.debug(f"Saved screenshot: {absolute_path}")
            
            return str(file_path)
        except Exception as e:
            logger.error(f"Error saving screenshot: {file_name}", exc_info=True)
            raise

    @staticmethod
    def read_excel_file(file_path: str, sheet_name: Optional[str] = None) -> List[Dict[str, Any]]:
        """
        Read Excel file and convert to list of dictionaries
        Args:
            file_path: Path to the file
            sheet_name: Sheet name (optional)
        Returns:
            List of dictionaries containing Excel data
        """
        try:
            absolute_path = Path(file_path).resolve()
            logger.debug(f"Reading Excel file: {absolute_path}")
            
            df = pd.read_excel(absolute_path, sheet_name=sheet_name)
            return df.to_dict('records')
        except Exception as e:
            logger.error(f"Error reading Excel file: {file_path}", exc_info=True)
            raise

    @staticmethod
    def write_excel_file(file_path: str, data: List[Dict[str, Any]], sheet_name: str = 'Sheet1') -> None:
        """
        Write list of dictionaries to Excel file
        Args:
            file_path: Path to the file
            data: List of dictionaries to write
            sheet_name: Sheet name (default: Sheet1)
        """
        try:
            absolute_path = Path(file_path).resolve()
            logger.debug(f"Writing Excel file: {absolute_path}")
            
            # Create directory if it doesn't exist
            absolute_path.parent.mkdir(parents=True, exist_ok=True)
            
            df = pd.DataFrame(data)
            df.to_excel(absolute_path, sheet_name=sheet_name, index=False)
            logger.debug(f"Successfully wrote Excel file: {absolute_path}")
        except Exception as e:
            logger.error(f"Error writing Excel file: {file_path}", exc_info=True)
            raise
