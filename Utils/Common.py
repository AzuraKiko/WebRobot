import csv
import datetime
import random  # Tạo số ngẫu nhiên, chọn ngẫu nhiên từ danh sách.
# Dùng cho biểu thức chính quy (regex): tìm kiếm, kiểm tra, thay thế chuỗi.
import re
import string
# Kiểu dữ liệu: List, Dict, Union, Optional.
from typing import List, Dict, Union, Optional
import cv2  # Thư viện xử lý ảnh.
import numpy as np  # Thư viện xử lý mảng và ma trận.
import pytesseract  # Thư viện OCR.
import logging
# Thay cho os.path, dùng để xử lý đường dẫn file/folder theo hướng object.
from pathlib import Path

# Configure logging
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')
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


def replace_colors(image_path, save_path, colors, replacement_color, tolerance=60):
  # Read the image
    image = cv2.imread(image_path)
    if image is None:
        print(f"Error: Could not read image from {image_path}")
        return

    # Convert to RGB for easier color manipulation
    image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    # Create an empty mask
    combined_mask = np.zeros(image.shape[:2], dtype=np.uint8)

    # Process each color - ensure all values are integers
    for color in colors:
        # Convert color to numpy array of integers
        try:
            color_array = np.array([int(c) for c in color], dtype=np.uint8)
        except (ValueError, TypeError):
            print(
                f"Warning: Invalid color format {color}. Skipping this color.")
            continue

        # Define lower and upper bounds with tolerance
        lower_bound = np.maximum(color_array - tolerance, 0)
        upper_bound = np.minimum(color_array + tolerance, 255)

        # Create mask for this color
        color_mask = cv2.inRange(image_rgb, lower_bound, upper_bound)

        # Add to combined mask
        combined_mask = cv2.bitwise_or(combined_mask, color_mask)

    # Ensure replacement_color contains integers
    try:
        replacement_color = tuple(int(c) for c in replacement_color)
    except (ValueError, TypeError):
        print(
            f"Warning: Invalid replacement color format {replacement_color}. Using black (0,0,0) instead.")
        replacement_color = (0, 0, 0)

    # Replace colors in the image
    image_rgb[combined_mask > 0] = replacement_color

    # Convert back to BGR for saving
    output_image = cv2.cvtColor(image_rgb, cv2.COLOR_RGB2BGR)

    # Save the processed image
    cv2.imwrite(save_path, output_image)
    print(f"Processed image saved to: {save_path}")


def remove_red_green_and_replace_color(image_path, output_path, tolerance=60, replacement_color=(48, 32, 28)):
    # Đọc ảnh gốc
    image = cv2.imread(image_path)
    image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    # Định nghĩa khoảng màu xanh lá cây (green) với tolerance
    lower_green = np.array(
        [max(0 - tolerance, 0), max(100 - tolerance, 0), max(0 - tolerance, 0)])
    upper_green = np.array(
        [min(100 + tolerance, 255), 255, min(100 + tolerance, 255)])

    # Định nghĩa khoảng màu đỏ (red) với tolerance
    lower_red1 = np.array(
        [max(100 - tolerance, 0), max(0 - tolerance, 0), max(0 - tolerance, 0)])
    upper_red1 = np.array(
        [255, min(100 + tolerance, 255), min(100 + tolerance, 255)])

    # Tạo mask cho vùng xanh lá và đỏ
    green_mask = cv2.inRange(image_rgb, lower_green, upper_green)
    red_mask = cv2.inRange(image_rgb, lower_red1, upper_red1)

    # Kết hợp mask
    combined_mask = cv2.bitwise_or(green_mask, red_mask)

    # Thay các pixel trong mask thành màu thay thế
    image_rgb[combined_mask > 0] = replacement_color

    # Chuyển lại sang BGR để lưu
    output_image = cv2.cvtColor(image_rgb, cv2.COLOR_RGB2BGR)

    # Lưu ảnh đã xử lý
    cv2.imwrite(output_path, output_image)
    print(f"Đã lưu ảnh kết quả tại: {output_path}")


def fade_red_green_opacity(image_path, output_path, alpha_value=100, tolerance=50):
    """
    Giảm độ mờ (opacity) của vùng màu đỏ và xanh lá trong ảnh.

    :param image_path: Đường dẫn ảnh đầu vào
    :param output_path: Đường dẫn ảnh đầu ra (PNG để giữ alpha)
    :param alpha_value: Giá trị alpha mới cho vùng đỏ/xanh (0 = trong suốt, 255 = đục hoàn toàn, 100 = mờ vừa)
    :param tolerance: Độ rộng của dải màu được phát hiện (giá trị càng cao, dải màu càng rộng)
    """

    # Đọc ảnh BGR
    image = cv2.imread(image_path)

    # Thêm kênh alpha
    image_with_alpha = cv2.cvtColor(image, cv2.COLOR_BGR2BGRA)

    # Định nghĩa vùng màu xanh lá (green) với tolerance
    lower_green = np.array([0, max(100 - tolerance, 0), 0])
    upper_green = np.array(
        [min(100 + tolerance, 255), 255, min(100 + tolerance, 255)])

    # Định nghĩa vùng màu đỏ (red) với tolerance
    lower_red = np.array([0, 0, max(100 - tolerance, 0)])
    upper_red = np.array(
        [min(100 + tolerance, 255), min(100 + tolerance, 255), 255])

    # Tạo mask cho đỏ và xanh
    green_mask = cv2.inRange(image, lower_green, upper_green)
    red_mask = cv2.inRange(image, lower_red, upper_red)

    # Kết hợp mask
    combined_mask = cv2.bitwise_or(green_mask, red_mask)

    # Giảm alpha ở những vùng được mask
    image_with_alpha[combined_mask > 0, 3] = alpha_value  # alpha channel

    # Lưu ảnh với alpha channel (PNG)
    cv2.imwrite(output_path, image_with_alpha)

    print(f"Ảnh đã xử lý và lưu tại: {output_path}")


def enhance_text(image_path, output_path):
    # Đọc ảnh
    image = cv2.imread(image_path)
    if image is None:
        raise ValueError("Không thể đọc ảnh từ đường dẫn được cung cấp")

    # Chuyển sang ảnh xám
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Tăng cường độ tương phản (CLAHE)
    clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
    enhanced = clahe.apply(gray)

    # Làm đậm chữ bằng thresholding
    _, thresh = cv2.threshold(
        enhanced, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)

    # Đảo ngược màu để có chữ đen trên nền trắng
    final = cv2.bitwise_not(thresh)

    # Nếu muốn giữ màu gốc nhưng làm đậm
    # enhanced_color = cv2.addWeighted(
    #     image, 1.5, cv2.GaussianBlur(image, (0, 0), 5), -0.5, 0)

    if output_path:
        cv2.imwrite(output_path, final)

    return final


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


# Configure Tesseract path
pytesseract.pytesseract.tesseract_cmd = "../OCR/tesseract.exe"


def preprocess_for_ocr(image_path, save_path):
    image = cv2.imread(image_path)

    # Resize to standard width for better OCR performance (optional)
    # image = cv2.resize(
    #     image, (1600, int(image.shape[0] * 1600 / image.shape[1])))

    # Convert to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Apply CLAHE (Contrast Limited Adaptive Histogram Equalization) for contrast enhancement
    # CLAHE giúp làm rõ chi tiết vùng sáng/tối — hữu ích cho ảnh mờ.
    clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
    gray = clahe.apply(gray)

    # Invert if background is dark (OCR prefers black text on white bg)
    if np.mean(gray) < 127:
        gray = cv2.bitwise_not(gray)

    # Apply adaptive thresholding for better text extraction (Thiết lập ngưỡng tự động cho ảnh, giúp tách biệt vùng sáng/tối.)
    binary = cv2.adaptiveThreshold(
        gray,
        255,  # giá trị pixel tối đa sau ngưỡng hóa (trắng)
        cv2.ADAPTIVE_THRESH_GAUSSIAN_C,  # phương pháp tính ngưỡng cục bộ
        cv2.THRESH_BINARY,  # kiểu nhị phân: > ngưỡng => trắng, ngược lại => đen
        15,  # kích thước vùng lân cận (block size) để tính ngưỡng
        # giá trị sẽ bị trừ từ ngưỡng tính được (giúp điều chỉnh độ nhạy)
        11
    )

    # Denoise using Non-local Means Denoising (Loại bỏ nhiễu nhẹ giúp OCR chính xác hơn.)
    denoised = cv2.fastNlMeansDenoising(binary, None, 10, 7, 21)

    # Morphological operations to remove noise and improve text shape
    kernel = np.ones((1, 1), np.uint8)
    opened = cv2.morphologyEx(denoised, cv2.MORPH_OPEN, kernel)

    cv2.imwrite(save_path, opened)


def preprocess_for_ocr_simple(image_path, save_path):
    image = cv2.imread(image_path)
    if image is None:
        print("❌ Lỗi: Không thể mở ảnh. Kiểm tra lại đường dẫn!")
        return

    # Resize to standard width for better OCR performance (optional)
    image = cv2.resize(
        image, (1600, int(image.shape[0] * 1600 / image.shape[1])))

    # Chuyển sang ảnh xám
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    # Invert if background is dark
    if np.mean(gray) < 127:
        gray = cv2.bitwise_not(gray)
    # **Xóa nền tối để làm nổi bật chữ**
    _, binary = cv2.threshold(
        gray, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
    # **Giảm nhiễu bằng Morphological Transform**
    kernel = np.ones((1, 1), np.uint8)
    processed = cv2.morphologyEx(binary, cv2.MORPH_CLOSE, kernel)
    cv2.imwrite(save_path, processed)


def extract_text_to_csv(image_path, output_csv, zoom_factor=5):
    """Extract text from image and save to CSV with improved preprocessing."""
    try:
        # Read image
        image = cv2.imread(str(image_path))
        if image is None:
            logger.error("Failed to open image. Please check the path!")
            return

        # Resize image
        # Lấy chiều cao và chiều rộng của ảnh,  bỏ qua kênh màu (nên dùng [:2]).
        h, w = image.shape[:2]
        image = cv2.resize(image, (int(w * zoom_factor), int(h * zoom_factor)),
                           interpolation=cv2.INTER_CUBIC)  # Using CUBIC for better quality

        # OCR with improved configuration
        # Tạo config cho Tesseract OCR
        # --oem 3: Sử dụng OCR Engine 3 (LSTM) cho OCR chính xác hơn.
        # --psm 6: Sử dụng phương pháp phân tích khung hình (PSM) 6 (tức là tất cả hàng và cột được xử lý).
        # -c tessedit_char_whitelist=0123456789.,: Chỉ định danh sách các ký tự được phép trong kết quả OCR.(Chỉ nhận các ký tự 0-9, . và ,.)
        # custom_config = r'--oem 3 --psm 6 -c tessedit_char_whitelist=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.,`'
        # !@#$%^&*()_+-={}[]|\:;"\'<>,.?/~
        text = pytesseract.image_to_string(image, config='--oem 3 --psm 6')

        # Process data
        lines = text.strip().split("\n")
        data = []

        for line in lines:
            parts = re.split(r'\s+', line)
            if len(parts) >= 3:
                cleaned_parts = [re.sub(r'[^\w\.\-]', '', part)
                                 for part in parts]
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
