import csv
import datetime
import random  # Tạo số ngẫu nhiên, chọn ngẫu nhiên từ danh sách.
import re  # Dùng cho biểu thức chính quy (regex): tìm kiếm, kiểm tra, thay thế chuỗi.
import string
from typing import List, Dict, Union, Optional  # Kiểu dữ liệu: List, Dict, Union, Optional.
import cv2  # Thư viện xử lý ảnh.
import numpy as np  # Thư viện xử lý mảng và ma trận.
import pytesseract  # Thư viện OCR.
import logging
from pathlib import Path  # Thay cho os.path, dùng để xử lý đường dẫn file/folder theo hướng object.
from Utils.FileHelper import FileHelper  # Import FileHelper class

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


def generate_random_username_with_timestamp() -> str:
    """Generate a random username with timestamp."""
    timestamp = int(datetime.datetime.now().timestamp())
    random_part = ''.join(random.choices(string.ascii_lowercase, k=5))
    return f"nga_{timestamp}_{random_part}"


def set_input_text_to_null() -> str:
    """Return empty string."""
    return ""


def extract_amount(money_string: str) -> Optional[float]:
    """Extract amount from money string using regex."""
    pattern = r'\d+\.\d+'  # Biểu thức chính quy: tìm kiếm số thập phân.
    if match := re.search(pattern, money_string):
        return float(match.group())
    return None


def sort_bid_price(data: Dict) -> List[Dict]:
    """Sort bid prices in descending order."""
    return sorted(data.values(), key=lambda x: x['price'], reverse=True)


def is_price_decreasing(data: Dict) -> str:
    """Check if prices are in decreasing order."""
    prices = [item["price"] for item in data.values()]
    return "True" if all(prices[i] < prices[i - 1] for i in range(1, len(prices))) else "False"


def is_price_increasing(data: Dict) -> str:
    """Check if prices are in increasing order."""
    prices = [item["price"] for item in data.values()]
    return "True" if all(prices[i] > prices[i - 1] for i in range(1, len(prices))) else "False"


# Configure Tesseract path
pytesseract.pytesseract.tesseract_cmd = "../OCR/tesseract.exe"


def extract_text_to_csv(image_path: Union[str, Path], output_csv: Union[str, Path], zoom_factor: float = 5.0) -> None:
    """
    Extract text from image and save to CSV with improved preprocessing.
    
    Args:
        image_path: Path to input image
        output_csv: Path to output CSV file
        zoom_factor: Factor to zoom the image for better OCR
    """
    try:
        # Read image
        image = cv2.imread(str(image_path))
        if image is None:
            logger.error("Failed to open image. Please check the path!")
            return

        # Resize image
        h, w = image.shape[:2]  # Lấy chiều cao và chiều rộng của ảnh,  bỏ qua kênh màu (nên dùng [:2]).
        image = cv2.resize(image, (int(w * zoom_factor), int(h * zoom_factor)),
                           interpolation=cv2.INTER_CUBIC)  # Using CUBIC for better quality

        # Convert to grayscale
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

        # Apply Contrast Limited Adaptive Histogram Equalization (CLAHE) for contrast enhancement
        clahe = cv2.createCLAHE(clipLimit=2.0,
                                tileGridSize=(8, 8))  # CLAHE giúp làm rõ chi tiết vùng sáng/tối — hữu ích cho ảnh mờ.
        enhanced = clahe.apply(gray)

        # Apply adaptive thresholding for better text extraction (Thiết lập ngưỡng tự động cho ảnh, giúp tách biệt vùng sáng/tối.)
        binary = cv2.adaptiveThreshold(
            enhanced,
            255,  # giá trị pixel tối đa sau ngưỡng hóa (trắng)
            cv2.ADAPTIVE_THRESH_GAUSSIAN_C,  # phương pháp tính ngưỡng cục bộ
            cv2.THRESH_BINARY,  # kiểu nhị phân: > ngưỡng => trắng, ngược lại => đen
            11,  # kích thước vùng lân cận (block size) để tính ngưỡng
            2  # giá trị sẽ bị trừ từ ngưỡng tính được (giúp điều chỉnh độ nhạy)
        )

        # Denoise using Non-local Means Denoising (Loại bỏ nhiễu nhẹ giúp OCR chính xác hơn.)
        denoised = cv2.fastNlMeansDenoising(binary, None, 10, 7, 21)

        # Apply morphological operations
        kernel = np.ones((2, 2), np.uint8)
        opened = cv2.morphologyEx(denoised, cv2.MORPH_OPEN, kernel)

        # OCR with improved configuration
        # Tạo config cho Tesseract OCR
        # --oem 3: Sử dụng OCR Engine 3 (LSTM) cho OCR chính xác hơn.
        # --psm 6: Sử dụng phương pháp phân tích khung hình (PSM) 6 (tức là tất cả hàng và cột được xử lý).
        # -c tessedit_char_whitelist=0123456789.,: Chỉ định danh sách các ký tự được phép trong kết quả OCR.(Chỉ nhận các ký tự 0-9, . và ,.)
        custom_config = r'--oem 3 --psm 6 -c tessedit_char_whitelist=0123456789., '
        text = pytesseract.image_to_string(opened, config=custom_config)

        # Process data
        lines = text.strip().split("\n")
        data = []

        for line in lines:
            if parts := re.split(r'\s+', line):
                if len(parts) >= 3:
                    cleaned_parts = [re.sub(r'[,"]', '', part) for part in parts]
                    data.append(cleaned_parts)

        if not data:
            logger.warning("No OCR data found!")
            return

        # Write to CSV using context manager
        with open(output_csv, mode="w", newline="", encoding="utf-8-sig") as file:
            writer = csv.writer(file)
            writer.writerows(data)

        logger.info(f"Data saved to: {output_csv}")

    except Exception as e:
        logger.error(f"Error during OCR processing: {e}", exc_info=True)


def replace_colors(image_path: Union[str, Path], save_path: Union[str, Path], colors: dict, replacement_color: tuple) -> None:
    """
    Replace specific colors in image with improved color matching.
    
    Args:
        image_path: Path to input image
        save_path: Path to save processed image
    """
    try:
        # Read image
        image = cv2.imread(str(image_path))
        if image is None:
            logger.error("Failed to open image")
            return

        # Convert image to HSV color space
        hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

        # Define colors with tolerance in HSV
        colors_hsv = {
            name: cv2.cvtColor(np.uint8([[bgr]]), cv2.COLOR_BGR2HSV)[0][0]
            for name, bgr in colors.items()
        }
        replacement_color_hsv = cv2.cvtColor(np.uint8([[replacement_color]]), cv2.COLOR_BGR2HSV)[0][0]  #(28, 32, 48)

        # Create combined mask for all colors in HSV
        combined_mask_hsv = np.zeros(hsv_image.shape[:2], dtype=np.uint8)
        tolerance_hsv = np.array([10, 50, 50])  # Adjust tolerance for HSV # Hue ±10, Saturation ±50, Value ±50

        for color_hsv in colors_hsv.values():
            lower_bound_hsv = np.array([max(0, c - t) for c, t in zip(color_hsv, tolerance_hsv)])
            upper_bound_hsv = np.array([min(255, c + t) for c, t in zip(color_hsv, tolerance_hsv)])
            mask_hsv = cv2.inRange(hsv_image, lower_bound_hsv, upper_bound_hsv)
            combined_mask_hsv = cv2.bitwise_or(combined_mask_hsv, mask_hsv)

        # Apply color replacement in HSV
        hsv_image[combined_mask_hsv > 0] = replacement_color_hsv

        # Convert back to BGR color space
        image = cv2.cvtColor(hsv_image, cv2.COLOR_HSV2BGR)

        # Save image
        cv2.imwrite(str(save_path), image)
        logger.info(f"Image saved to {save_path}")

    except Exception as e:
        logger.error(f"Error during color replacement: {e}", exc_info=True)

def count_lines_in_csv(file_path: Union[str, Path]) -> int:
    """Count lines in CSV file excluding header."""
    try:
        with open(file_path, mode='r', encoding='utf-8') as file:
            return sum(1 for _ in csv.reader(file)) - 1
    except Exception as e:
        logger.error(f"Error counting CSV lines: {e}", exc_info=True)
        return 0


def convert_to_hsv(image: np.ndarray) -> tuple:
    """Convert image to HSV and create mask for light text."""
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    lower = np.array([0, 0, 200])  # adjust for your text color
    upper = np.array([180, 25, 255])
    mask = cv2.inRange(hsv, lower, upper)
    result = cv2.bitwise_and(image, image, mask=mask)
    return result
