# 02_EDA.r

#### load files ####
folder <- "E:/R_Projects/Bigdata_report/dataset/"

CCTV_raw <- read.csv(paste(folder, "CCTV_20180910.csv", sep = ""), stringsAsFactors = F)
regional_crim_2015_raw <- read.csv(paste(folder, "2015_Gwangju_regional_crime.csv", sep = ""), stringsAsFactors = F)
regional_crim_2016_raw <- read.csv(paste(folder, "2016_Gwangju_regional_crime.csv", sep = ""), stringsAsFactors = F)
regional_crim_2017_raw <- read.csv(paste(folder, "2017_Gwangju_regional_crime.csv", sep = ""), stringsAsFactors = F)
regional_crim_2018_raw <- read.csv(paste(folder, "2018_Gwangju_regional_crime.csv", sep = ""), stringsAsFactors = F)


#### CCTV data ####
# 데이터 생김새 확인
str(CCTV_raw)
summary(CCTV_raw)

# CCTV 데이터 프레임 복사 및 기본 분석
CCTV <- CCTV_raw %>% select(소재지지번주소, 설치목적구분, 카메라대수)
CCTV$지역 <- as.factor(strtrim(CCTV$소재지지번주소, 16))
summary(CCTV)
CCTV_regional_purpose <- CCTV %>%
  group_by(설치목적구분, 지역) %>%
  summarise(total = sum(카메라대수))

# CCTV 기본 데이터 확인, 기초분석 => Rplot1
ggplot(data = CCTV_regional_purpose, aes(x = 지역, y = total, fill = 설치목적구분)) + geom_col()


##### 지역별 범죄 데이터 ####
# 데이터 프레임 복사
regional_crim_2015 <- regional_crim_2015_raw
regional_crim_2016 <- regional_crim_2016_raw
regional_crim_2017 <- regional_crim_2017_raw
regional_crim_2018 <- regional_crim_2018_raw

occur_2015 <- regional_crim_2015 %>%
  filter(구분 == "발  생  건  수" & 관서명 == "광주지방경찰청계") %>%
  mutate(total = 살인 + 강도 + 강간.강제추행 + 절도 + 폭력) %>%
  mutate(year = 2015)
arrest_2015 <- regional_crim_2015 %>%
  filter(구분 == "검  거  건  수" & 관서명 == "광주지방경찰청계") %>%
  mutate(total = 살인 + 강도 + 강간.강제추행 + 절도 + 폭력) %>%
  mutate(year = 2015)

occur_2016 <- regional_crim_2016 %>%
  filter(구분 == "발  생  건  수" & 관서명 == "광주지방경찰청계") %>%
  mutate(total = 살인 + 강도 + 강간.강제추행 + 절도 + 폭력) %>%
  mutate(year = 2016)
arrest_2016 <- regional_crim_2016 %>%
  filter(구분 == "검  거  건  수" & 관서명 == "광주지방경찰청계") %>%
  mutate(total = 살인 + 강도 + 강간.강제추행 + 절도 + 폭력) %>%
  mutate(year = 2016)

occur_2017 <- regional_crim_2017 %>%
  filter(구분 == "발  생  건  수" & 관서명 == "광주지방경찰청계") %>%
  mutate(total = 살인 + 강도 + 강간.강제추행 + 절도 + 폭력) %>%
  mutate(year = 2017)
arrest_2017 <- regional_crim_2017 %>%
  filter(구분 == "검  거  건  수" & 관서명 == "광주지방경찰청계") %>%
  mutate(total = 살인 + 강도 + 강간.강제추행 + 절도 + 폭력) %>%
  mutate(year = 2017)

regional_crim_2018$절도 <- as.numeric(sub(",", "", regional_crim_2018$절도))
regional_crim_2018$폭력 <- as.numeric(sub(",", "", regional_crim_2018$폭력)) 

occur_2018 <- regional_crim_2018 %>%
  filter(구분 == "발  생  건  수" & 관서명 == "광주지방경찰청계") %>%
  mutate(total = 살인 + 강도 + 강간.강제추행 + 절도 + 폭력) %>%
  mutate(year = 2018)
arrest_2018 <- regional_crim_2018 %>%
  filter(구분 == "발  생  건  수" & 관서명 == "광주지방경찰청계") %>%
  mutate(total = 살인 + 강도 + 강간.강제추행 + 절도 + 폭력) %>%
  mutate(year = 2018)

