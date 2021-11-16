library(tidyverse)
library(pdftools)
library(magick)
library(stringr)

pdf_files <- fs::dir_ls("data/rconf_final")
enc2utf8(pdf_files)
# Encoding(pdf_files) <- "UTF-8"
pdf_files


get_filename <- function(keyword = "마무리") {
  pdf_files[str_detect(pdf_files, keyword)]
}


# PDF 파일 분리 --------------------------
## 1. 오프닝

filename <- get_filename("마무리") %>% 
  stringi::stri_escape_unicode()

pdftools::pdf_subset(iconv(get_filename("마무리"), to= "EUC-KR"), pages = 1:4)

fs::dir_ls("data/rconf_final") %>% 
  guess_encoding()

iconv(get_filename("마무리"), from = "EUC-KR", to= "UTF-8")

filename <- iconv(get_filename("마무리"), from = "UTF-8", to= "EUC-KR")
filename

pdftools::pdf_subset(get_filename("마무리"), pages = 1:4)
pdftools::pdf_subset(enc2native(get_filename("마무리")), pages = 1:4)
pdftools::pdf_subset(enc2utf8(get_filename("마무리")), pages = 1:4)
pdftools::pdf_subset(enc2native(pdf_files[1]), pages = 1:4)


