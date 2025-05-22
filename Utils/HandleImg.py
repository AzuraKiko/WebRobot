from typing import List, Tuple, Union
import numpy as np
from PIL import Image
import csv
import os


class HandleImg:

    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self, engine: str = "easyocr", languages: List[str] = None):
        """
        Initialize OCR handler with specified engine and languages.

        Args:
            engine (str): OCR engine to use ('easyocr' or 'paddleocr')
            languages (List[str]): List of languages to recognize (e.g., ['en', 'ch_sim'])
        """
        self.engine = engine.lower()
        self.languages = languages or ['en']
        self._ocr = None
        self._initialize_ocr()

    def _initialize_ocr(self):
        """Initialize the selected OCR engine."""
        try:
            if self.engine == "easyocr":
                import easyocr
                self._ocr = easyocr.Reader(self.languages)
            elif self.engine == "paddleocr":
                from paddleocr import PaddleOCR
                self._ocr = PaddleOCR(use_textline_orientation=True, lang='en')
            else:
                raise ValueError(f"Unsupported OCR engine: {self.engine}")
        except ImportError as e:
            raise ImportError(f"Failed to import {self.engine}. Please install it using:\n"
                              f"pip install {self.engine}") from e

    def read_text(self, image_path: Union[str, np.ndarray, Image.Image]) -> List[Tuple[str, float]]:
        """
        Extract text from an image.
        Args:
            image_path: Path to image file, numpy array, or PIL Image
        Returns:
            List of tuples containing (text, confidence)
        """
        if self._ocr is None:
            self._initialize_ocr()

        # Convert PIL Image to numpy array if needed
        if isinstance(image_path, Image.Image):
            image_path = np.array(image_path)

        try:
            if self.engine == "easyocr":
                results = self._ocr.readtext(image_path)
                return [(text, conf) for _, text, conf in results]
            else:  # paddleocr
                # Thay thế ocr() bằng predict() và loại bỏ tham số cls
                results = self._ocr.predict(image_path)

                # Xử lý kết quả từ API mới
                if not results or len(results) == 0:
                    return []

                text_confidence = []
                for result in results:
                    if isinstance(result, list):
                        for line in result:
                            if len(line) >= 2 and isinstance(line[1], tuple) and len(line[1]) >= 2:
                                text = line[1][0]  # Văn bản
                                confidence = line[1][1]  # Độ tin cậy
                                text_confidence.append((text, confidence))
                            elif len(line) >= 2 and isinstance(line[1], list) and len(line[1]) >= 2:
                                text = line[1][0]  # Văn bản
                                confidence = line[1][1]  # Độ tin cậy
                                text_confidence.append((text, confidence))

                return text_confidence
        except Exception as e:
            raise Exception(f"Error during OCR processing: {str(e)}")

    def read_text_with_boxes(self, image_path: Union[str, np.ndarray, Image.Image]) -> List[Tuple[List[Tuple[float, float]], str, float]]:
        """
        Extract text and bounding boxes from an image.
        Args:
            image_path: Path to image file, numpy array, or PIL Image
        Returns:
            List of tuples containing (bounding_box, text, confidence)
            where bounding_box is a list of (x,y) coordinates
        """
        if self._ocr is None:
            self._initialize_ocr()

        # Convert PIL Image to numpy array if needed
        if isinstance(image_path, Image.Image):
            image_path = np.array(image_path)

        try:
            if self.engine == "easyocr":
                results = self._ocr.readtext(image_path)
                return [(box, text, conf) for box, text, conf in results]
            else:  # paddleocr
                # Thay thế ocr() bằng predict() và loại bỏ tham số cls
                results = self._ocr.predict(image_path)

                # Xử lý kết quả từ API mới
                if not results or len(results) == 0:
                    return []

                boxes_text_confidence = []
                for result in results:
                    if isinstance(result, list):
                        for line in result:
                            if len(line) >= 2:
                                box = line[0]  # Bounding box
                                if isinstance(line[1], (tuple, list)) and len(line[1]) >= 2:
                                    text = line[1][0]  # Văn bản
                                    confidence = line[1][1]  # Độ tin cậy
                                    boxes_text_confidence.append(
                                        (box, text, confidence))

                return boxes_text_confidence
        except Exception as e:
            raise Exception(f"Error during OCR processing: {str(e)}")

    def save_to_csv(self, results: List[Tuple[str, float]], output_path: str) -> None:
        """
        Save OCR results to a CSV file.

        Args:
            results: List of tuples containing (text, confidence)
            output_path: Path where the CSV file should be saved
        """
        try:
            # Create directory if it doesn't exist
            os.makedirs(os.path.dirname(output_path), exist_ok=True)

            with open(output_path, 'w', newline='', encoding='utf-8') as csvfile:
                writer = csv.writer(csvfile)
                # Write data
                for text, confidence in results:
                    writer.writerow([text, confidence])
        except Exception as e:
            raise Exception(f"Error saving results to CSV: {str(e)}")


ocr = HandleImg(engine="paddleocr", languages=["en"])
text_conf = ocr.read_text("Data/MarketDepth.png")
boxes_text_conf = ocr.read_text_with_boxes("Data/MarketDepth.png")
ocr.save_to_csv(text_conf, "Data/MarketDepth.csv")
