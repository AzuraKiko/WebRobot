import numpy as np

hex_color = "#ececec"
rgb = tuple(int(hex_color[i:i+2], 16) for i in (1, 3, 5))
bgr = tuple(reversed(rgb))

print("BGR:", bgr)
