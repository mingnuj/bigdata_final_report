# 01_env.r

install.packages("ggplot2")
install.packages("dplyr")

library(ggplot2)
library(dplyr)

#### google map ####
install.packages('devtools')
library('devtools')

install_github('dkahle/ggmap', ref="tidyup")
library('ggmap')

install.packages("plotly")
library(plotly)

#### 공공데이터포털 ####
# 광주 광역시 CCTV -> https://www.data.go.kr/dataset/3073454/fileData.do
# 광주 광역시 각 지역별 범죄 현황 -> https://www.data.go.kr/dataset/15004571/fileData.do
