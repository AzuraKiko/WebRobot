from typing import List, Tuple, Union
import numpy as np
from PIL import Image
import csv
import os
import cv2


class HandleImg:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self, engine: str = "easyocr", languages: List[str] = None):
        self.engine = engine.lower()
        self.languages = languages or ['en']
        self._ocr = None
        self._initialize_ocr()

    def _initialize_ocr(self):
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

    def preprocess_image(self, image: Union[np.ndarray, Image.Image]) -> np.ndarray:
        if isinstance(image, Image.Image):
            image = np.array(image)
        # Convert to grayscale
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        # Enhance contrast
        clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
        contrast = clahe.apply(gray)
        # Reduce noise without thresholding
        denoised = cv2.fastNlMeansDenoising(contrast, h=10)
        # Convert back to 3 channels
        denoised_3channel = cv2.cvtColor(denoised, cv2.COLOR_GRAY2BGR)
        return denoised_3channel

    def read_text(self, image_path: Union[str, np.ndarray, Image.Image]) -> List[Tuple[str, float]]:
        if self._ocr is None:
            self._initialize_ocr()
        if isinstance(image_path, Image.Image):
            image_path = np.array(image_path)
        try:
            if self.engine == "easyocr":
                results = self._ocr.readtext(image_path)
                return [(text, conf) for _, text, conf in results]
            else:  # paddleocr
                # Use .predict() instead of .ocr()
                results = self._ocr.predict(image_path)
                print("Raw PaddleOCR results (read_text):", results)
                if not results or len(results) == 0:
                    print("No results from PaddleOCR (read_text)")
                    return []
                formatted_results = []
                for line in results:
                    if not line:
                        continue
                    text = line['text']  # Extract text
                    conf = line['confidence']  # Extract confidence
                    formatted_results.append((text, conf))
                return formatted_results
        except Exception as e:
            raise Exception(f"Error during OCR processing: {str(e)}")

    def read_text_with_boxes(self, image_path: Union[str, np.ndarray, Image.Image]) -> List[Tuple[List[Tuple[float, float]], str, float]]:
        if self._ocr is None:
            self._initialize_ocr()
        if isinstance(image_path, str):
            image = cv2.imread(image_path)
            if image is None:
                raise ValueError(
                    f"Could not load image from path: {image_path}")
        else:
            image = image_path
        preprocessed_image = self.preprocess_image(image)
        try:
            if self.engine == "easyocr":
                results = self._ocr.readtext(preprocessed_image)
                return [(box, text, conf) for box, text, conf in results]
            else:  # paddleocr
                # Use .predict() instead of .ocr()
                results = self._ocr.predict(preprocessed_image)
                print("Raw PaddleOCR results:", results)
                if not results or len(results) == 0:
                    print("No results from PaddleOCR")
                    return []
                formatted_results = []
                for line in results:
                    if not line:
                        continue
                    box = line['points']  # Extract bounding box
                    text = line['text']  # Extract text
                    conf = line['confidence']  # Extract confidence
                    formatted_results.append((box, text, conf))
                print("Formatted PaddleOCR results:", formatted_results)
                return formatted_results
        except Exception as e:
            raise Exception(f"Error during OCR processing: {str(e)}")

    def save_table_to_csv(self, results: List[Tuple[List[Tuple[float, float]], str, float]], output_path: str, num_columns: int = 8) -> None:
        def y_center(box):
            pts = np.array(box)
            return np.mean(pts[:, 1])

        def x_center(box):
            pts = np.array(box)
            return np.mean(pts[:, 0])

        # Filter out empty or malformed boxes
        filtered_results = [item for item in results if isinstance(
            item[0], (list, np.ndarray)) and np.array(item[0]).ndim == 2 and len(item[0]) > 0]
        print("Filtered results:", filtered_results)
        results_sorted = sorted(filtered_results, key=lambda x: y_center(x[0]))

        # Group into rows based on y-coordinate
        rows = []
        current_row = []
        last_y = None
        y_threshold = 30
        for item in results_sorted:
            box, text, conf = item
            yc = y_center(box)
            if last_y is None or abs(yc - last_y) < y_threshold:
                current_row.append(item)
                last_y = yc if last_y is None else (last_y + yc) / 2
            else:
                current_row_sorted = sorted(
                    current_row, key=lambda x: x_center(x[0]))
                rows.append(current_row_sorted)
                current_row = [item]
                last_y = yc
        if current_row:
            current_row_sorted = sorted(
                current_row, key=lambda x: x_center(x[0]))
            rows.append(current_row_sorted)

        print("Grouped rows:", rows)

        # Skip the first row (headers) and process data rows
        data_rows = rows[1:]  # Exclude the header row

        # Pad rows to num_columns and extract text
        formatted_rows = []
        for row in data_rows:
            # Extract text from each cell
            row_text = [cell[1] for cell in row]
            # Pad or trim to num_columns
            while len(row_text) < num_columns:
                row_text.append('')
            if len(row_text) > num_columns:
                row_text = row_text[:num_columns]
            formatted_rows.append(row_text)

        print("Formatted rows for CSV:", formatted_rows)

        # Define headers based on image structure
        headers = ['DS', 'COUNT', 'QUANTITY',
                   'BID', 'ASK', 'QUANTITY', 'COUNT', 'CS']

        # Write to CSV
        try:
            os.makedirs(os.path.dirname(output_path), exist_ok=True)
            with open(output_path, 'w', newline='', encoding='utf-8') as csvfile:
                writer = csv.writer(csvfile)
                writer.writerow(headers)
                for row in formatted_rows:
                    writer.writerow(row)
        except Exception as e:
            raise Exception(f"Error saving table to CSV: {str(e)}")


ocr = HandleImg(engine="easyocr", languages=["en"])
text_conf = ocr.read_text("Data/MarketDepth.png")
boxes_text_conf = ocr.read_text_with_boxes("Data/MarketDepth.png")
ocr.save_table_to_csv(boxes_text_conf, "Data/MarketDepth.csv")
