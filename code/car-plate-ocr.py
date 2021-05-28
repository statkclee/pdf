# 관련 작업 모듈 불러오기 ---------------
import numpy as np
import matplotlib.pyplot as plt

import cv2
import pytesseract

# Tesseract 설정 ------------------------
pytesseract.pytesseract.tesseract_cmd = r"/usr/local/bin/tesseract"

# 번호판 인식 모듈 -----------------------
carplate_haar_cascade = cv2.CascadeClassifier('data/haarcascade_russian_plate_number.xml')

# 차량 번호판 인식 ------------------
carplate_img = cv2.imread('fig/ocr-bmw-car-plate.jpg')
carplate_img_rgb = cv2.cvtColor(carplate_img, cv2.COLOR_BGR2RGB)
plt.imshow(carplate_img_rgb)

# 차량 번호판 인식 함수 -----------------

def carplate_detect(image):
  carplate_overlay = image.copy() 
  carplate_rects = carplate_haar_cascade.detectMultiScale(carplate_overlay, scaleFactor=1.1, minNeighbors=3)
  
  for x,y,w,h in carplate_rects: 
      cv2.rectangle(carplate_overlay, (x,y), (x+w,y+h), (255,0,0), 5) 
      
  return carplate_overlay
  
detected_carplate_img = carplate_detect(carplate_img_rgb)
plt.imshow(detected_carplate_img)  

# 차량 이미지 회전 후 번호판 인식 ---------------------

height, width, channel = carplate_img_rgb.shape
matrix = cv2.getRotationMatrix2D((width/2, height/2), 15, 1)
carplate_rotated_rgb = cv2.warpAffine(carplate_img_rgb, matrix, (width, height))


carplate_rotated_rgb = carplate_detect(carplate_rotated_rgb)

plt.imshow(carplate_rotated_rgb)  
plt.show()

# 번호판 추출 -----------------------------------------

def carplate_extract(image):
    
  carplate_rects = carplate_haar_cascade.detectMultiScale(image,scaleFactor=1.1, minNeighbors=5)

  for x,y,w,h in carplate_rects: 
      carplate_img = image[y+15:y+h-10 ,x+55:x+w-7]
      
  return carplate_img

carplate_extract_img = carplate_extract(carplate_rotated_rgb)
plt.imshow(carplate_extract_img)
plt.show()


# OCR 이미지 전처리 작업 -----------------------------

carplate_extract_img_gray = cv2.cvtColor(carplate_extract_img, cv2.COLOR_RGB2GRAY)
# carplate_extract_img_gray_blur = cv2.medianBlur(carplate_extract_img_gray, 3) 
plt.axis('off') 
plt.imshow(carplate_extract_img_gray, cmap = 'gray');
plt.show()

# OCR 작업 -------------------------------------------

car_plate_text = pytesseract.image_to_string(carplate_extract_img_gray, lang='kor',
                            config = f'--psm 8 --oem 3 -c tessedit_char_whitelist=오ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')

car_plate_text = pytesseract.image_to_string(carplate_extract_img_gray, lang='kor')

car_plate_text

