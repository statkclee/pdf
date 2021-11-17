library(tidyverse)
library(pdftools)
library(magick)
library(stringr)

## 맥에서 작업을 진행해야 함 =====================
# convmv -f utf8 -t utf8 --nfc --notest *.pdf

pdf_files <- fs::dir_ls("data/rconf_final")
# enc2utf8(pdf_files)
# Encoding(pdf_files) <- "UTF-8"

get_filename <- function(keyword = "마무리") {
  pdf_files[str_detect(pdf_files, keyword)]
}

# PDF 파일 분리 --------------------------
library(pdftools)

fs::dir_create("data/rconf_slipsheet")

## 1. 오프닝과 마무리, 키노트 --------
pdftools::pdf_subset(get_filename("마무리"), pages = 1:4, output = "data/rconf_slipsheet/opening.pdf")

pdftools::pdf_subset(get_filename("마무리"), pages = 5, output = "data/rconf_slipsheet/ending.pdf")

pdftools::pdf_subset(get_filename("마무리"), pages = 2, output = "data/rconf_slipsheet/keynote_program.pdf")


## 2. 실시간 ----------
### 2.0. 시작간지 ------
pdftools::pdf_subset(get_filename("실시간"), pages = 1, output = "data/rconf_slipsheet/실시간_시작간지.pdf")

### 2.1. 이광춘 ------
pdftools::pdf_subset(get_filename("실시간"), pages = 2, output = "data/rconf_slipsheet/간지_이광춘.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_이광춘.pdf", get_filename("이광춘")), 
                        output = "data/rconf_slipsheet/실시간_이광춘.pdf")

### 2.2. 최재성 ------
pdftools::pdf_subset(get_filename("실시간"), pages = 3, output = "data/rconf_slipsheet/간지_최재성.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_최재성.pdf", get_filename("최재성")), 
                      output = "data/rconf_slipsheet/실시간_최재성.pdf")

### 2.3. 이준혁 ------
pdftools::pdf_subset(get_filename("실시간"), pages = 4, output = "data/rconf_slipsheet/간지_이준혁.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_이준혁.pdf", get_filename("이준혁")), 
                      output = "data/rconf_slipsheet/실시간_이준혁.pdf")

### 2.4. 윤화영 ------
pdftools::pdf_subset(get_filename("실시간"), pages = 5, output = "data/rconf_slipsheet/간지_윤화영.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_윤화영.pdf", get_filename("윤화영")), 
                      output = "data/rconf_slipsheet/실시간_윤화영.pdf")

### 2.5. 휴식 ------
pdftools::pdf_subset(get_filename("실시간"), pages = 6, output = "data/rconf_slipsheet/간지_휴식.pdf")

### 2.6. 이은조 ------
pdftools::pdf_subset(get_filename("실시간"), pages = 7, output = "data/rconf_slipsheet/간지_이은조.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_이은조.pdf", get_filename("이은조")), 
                      output = "data/rconf_slipsheet/실시간_이은조.pdf")

### 2.7. 이남신 ------
pdftools::pdf_subset(get_filename("실시간"), pages = 8, output = "data/rconf_slipsheet/간지_이남신.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_이남신.pdf", get_filename("이남신")), 
                      output = "data/rconf_slipsheet/실시간_이남신.pdf")

### 2.8. 박성우 ------
pdftools::pdf_subset(get_filename("실시간"), pages = 9, output = "data/rconf_slipsheet/간지_박성우.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_박성우.pdf", get_filename("박성우")), 
                      output = "data/rconf_slipsheet/실시간_박성우.pdf")

### 2.99. 취합 ------
pdftools::pdf_combine(c("data/rconf_slipsheet/opening.pdf",
                        "data/rconf_slipsheet/실시간_이광춘.pdf",
                        "data/rconf_slipsheet/실시간_최재성.pdf",
                        "data/rconf_slipsheet/실시간_이준혁.pdf",
                        "data/rconf_slipsheet/실시간_윤화영.pdf",
                        "data/rconf_slipsheet/간지_휴식.pdf",
                        "data/rconf_slipsheet/실시간_이은조.pdf",
                        "data/rconf_slipsheet/실시간_이남신.pdf",
                        "data/rconf_slipsheet/실시간_박성우.pdf",
                        "data/rconf_slipsheet/ending.pdf"
                        ), output = "data/rconf_slipsheet/realtime.pdf")

# 3. 녹화 동영상 ---------------------

### 3.0. 시작간지 ------
pdftools::pdf_subset(get_filename("녹화강연"), pages = 1, output = "data/rconf_slipsheet/녹화강연_시작간지.pdf")

### 3.1. 문건웅 ------
pdftools::pdf_subset(get_filename("녹화강연"), pages = 2, output = "data/rconf_slipsheet/간지_문건웅.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_문건웅.pdf", get_filename("문건웅")), 
                      output = "data/rconf_slipsheet/녹화강연_문건웅.pdf")

### 3.2. 이민호 ------
pdftools::pdf_subset(get_filename("녹화강연"), pages = 3, output = "data/rconf_slipsheet/간지_이민호.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_이민호.pdf", get_filename("이민호")), 
                      output = "data/rconf_slipsheet/녹화강연_이민호.pdf")

### 3.3. 이혜선 ------
pdftools::pdf_subset(get_filename("녹화강연"), pages = 4, output = "data/rconf_slipsheet/간지_이혜선.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_이혜선.pdf", get_filename("이혜선")), 
                      output = "data/rconf_slipsheet/녹화강연_이혜선.pdf")

### 3.4. 황의찬 ------
pdftools::pdf_subset(get_filename("녹화강연"), pages = 5, output = "data/rconf_slipsheet/간지_황의찬.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_황의찬.pdf", get_filename("황의찬")), 
                      output = "data/rconf_slipsheet/녹화강연_황의찬.pdf")

### 3.5. 휴식 ------
pdftools::pdf_subset(get_filename("녹화강연"), pages = 6, output = "data/rconf_slipsheet/간지_녹화강연_휴식.pdf")

### 3.6. 이영록 ------
pdftools::pdf_subset(get_filename("녹화강연"), pages = 7, output = "data/rconf_slipsheet/간지_이영록.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_이영록.pdf", get_filename("이영록")), 
                      output = "data/rconf_slipsheet/녹화강연_이영록.pdf")

### 3.7. 김진환 ------
pdftools::pdf_subset(get_filename("녹화강연"), pages = 8, output = "data/rconf_slipsheet/간지_김진환.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_김진환.pdf", get_filename("김진환")), 
                      output = "data/rconf_slipsheet/녹화강연_김진환.pdf")

### 3.8. 박상훈 ------
pdftools::pdf_subset(get_filename("녹화강연"), pages = 9, output = "data/rconf_slipsheet/간지_박상훈.pdf")
pdftools::pdf_combine(c("data/rconf_slipsheet/간지_박상훈.pdf", get_filename("박상훈")), 
                      output = "data/rconf_slipsheet/녹화강연_박상훈.pdf")

### 3.99. 취합 ------
pdftools::pdf_combine(c("data/rconf_slipsheet/opening.pdf",
                        "data/rconf_slipsheet/녹화강연_문건웅.pdf",
                        "data/rconf_slipsheet/녹화강연_이민호.pdf",
                        "data/rconf_slipsheet/녹화강연_이혜선.pdf",
                        "data/rconf_slipsheet/녹화강연_황의찬.pdf",
                        "data/rconf_slipsheet/간지_녹화강연_휴식.pdf",
                        "data/rconf_slipsheet/녹화강연_이영록.pdf",
                        "data/rconf_slipsheet/녹화강연_김진환.pdf",
                        "data/rconf_slipsheet/녹화강연_박상훈.pdf",
                        "data/rconf_slipsheet/ending.pdf"
), output = "data/rconf_slipsheet/record.pdf")

## 4. 키노트 ----------
### 4.0. 시작간지 ------
# `opening.pdf` 로 갈음함

### 4.1. 이광춘 ------
pdftools::pdf_combine(c("data/rconf_slipsheet/opening.pdf", get_filename("오프닝")), 
                      output = "data/rconf_slipsheet/keynote_opening.pdf")

### 4.2. Julia Silge ------
pdftools::pdf_combine(c("data/rconf_slipsheet/keynote_program.pdf", get_filename("Julia")), 
                      output = "data/rconf_slipsheet/keynote_juila.pdf")

### 4.3. 유충현 ------
pdftools::pdf_combine(c("data/rconf_slipsheet/keynote_program.pdf", get_filename("유충현")), 
                      output = "data/rconf_slipsheet/keynote_유충현.pdf")

### 4.99. 취합 ------
pdftools::pdf_combine(c("data/rconf_slipsheet/keynote_opening.pdf",
                        "data/rconf_slipsheet/keynote_juila.pdf",
                        "data/rconf_slipsheet/keynote_유충현.pdf"
), output = "data/rconf_slipsheet/keynote.pdf")

