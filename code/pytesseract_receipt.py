# 환경설정 ------------------
import cv2
import pytesseract

pytesseract.pytesseract.tesseract_cmd = r"/usr/local/bin/tesseract"

# OCR 작업 ------------------
receipt_img = cv2.imread('fig/ocr-receipt.png')
receipt_text = pytesseract.image_to_string(receipt_img, config = r'--psm 3', lang = 'eng')

# OCR 작업결과 저장 ------------------
with open('fig/receipt_pytesseract_eng.txt', mode = 'w') as f:
    f.write(receipt_text)

# 데이터 정형화 작업 ------------------
structured_data = {}

with open('fig/receipt_pytesseract_eng.txt', 'r') as ocr_file:
    line_lst = ocr_file.readlines()

for line in line_lst:
    line_strip = line.strip()
    if 'Store' in line_strip:
        structured_data['Store'] = " ".join(line_strip.split()[1:])
    if '(' in line_strip:
        structured_data['Phone'] = " ".join(line_strip.split())
    if 'Total' in line_strip:
        structured_data['Price'] = " ".join(line_strip.split()[1:])
    if 'MASTER' in line_strip:
        structured_data['Master Card'] = line_strip.split()[-1]

print(structured_data)

# 원본 이미지 텍스트 위치 파악 ------------------------------------- 

h, w, _ = receipt_img.shape # assumes color image

# run tesseract, returning the bounding boxes
boxes = pytesseract.image_to_boxes(receipt_img)

# draw the bounding boxes on the image
for b in boxes.splitlines():
    b = b.split(' ')
    receipt_img = cv2.rectangle(receipt_img, (int(b[1]), h - int(b[2])), (int(b[3]), h - int(b[4])), (0, 255, 0), 2)

# show annotated image and wait for keypress
# cv2.imshow("Receipt OC", receipt_img)
# cv2.waitKey(0)

# Save OCR image
cv2.imwrite("fig/ocr-receipt-pytesseract.jpg", receipt_img)
