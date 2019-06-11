# 03_vis.r

#### basic vis data => 연도별 ####
occur_arrest_per_year <- data.frame(year = c(2015, 2016, 2017, 2018),
                                    dist = c('occur','occur','occur','occur',
                                             'arrest','arrest','arrest','arrest'),
                                    total = c(occur_2015$total, occur_2016$total,
                                              occur_2017$total, occur_2018$total,
                                              arrest_2015$total, arrest_2016$total,
                                              arrest_2017$total, arrest_2018$total))

# Rplot2
ggplot(data = occur_arrest_per_year, aes(x = year, y = total, col = dist)) + geom_line()


#### google map api ####
register_google(key="")

#### CCTV 위치정보를 통해 위도 경도 가져오기 ####
cctv_pos <- CCTV$소재지지번주소

gc <- geocode(enc2utf8(cctv_pos))
df <- data.frame(name=CCTV$설치목적구분,
                 lon=gc$lon,
                 lat=gc$lat)

# 데이터 클린징
df_nomiss <- df %>% filter(!is.na(df$lon) & !is.na(df$lat))

# 각 범위별로 나누어 따로 저장 및 위도 경도 지정
df_nomiss_child <- df_nomiss %>% filter(df_nomiss$name == "어린이보호")
df_nomiss_security <- df_nomiss %>% filter(df_nomiss$name == "생활방범")
df_nomiss_disaster <- df_nomiss %>% filter(df_nomiss$name == "재난재해")

gc_child <- df_nomiss_child %>% select(lon, lat)
gc_security <- df_nomiss_security %>% select(lon, lat)
gc_disaster <- df_nomiss_disaster %>% select(lon, lat)

# 지도에 표시 될 범위의 중앙 지정
cen <- c(mean(df_nomiss$lon),mean(df_nomiss$lat))

#### 범죄데이터 위도, 경도 (2018) ####
# police office location
region <- c("광주광산경찰서",
            "광주동부경찰서",
            "광주서부경찰서",
            "광주남부경찰서",
            "광주북부경찰서")
po <- data.frame(관서명 = region, geocode(enc2utf8(region)))
print(po)

region_crim_frame <- left_join(regional_crim_2018, po, by = "관서명")
region_crim_occur_nomiss <- region_crim_frame %>% filter(!is.na(region_crim_frame$lon) &
                                                           !is.na(region_crim_frame$lat) &
                                                           region_crim_frame$구분 == "발  생  건  수")%>%
  mutate(total = 살인 + 강도 + 강간.강제추행 + 절도 + 폭력)
region_crim_frame_nomiss <- region_crim_frame_nomiss %>% filter(!is.na(region_crim_frame_nomiss$lat))

# google map -> n0 Rpltot3
qmap(location = cen,
     zoom = 12,
     maptype = 'roadmap',
     source = 'google') +
  geom_point(data = gc_child,
             aes(x = lon, y = lat),
             shape = '▼',
             color = 'yellow',
             size = 3) +
  geom_point(data = gc_security,
             aes(x = lon, y = lat),
             shape = '▼',
             color = 'red',
             size = 2) +
  geom_point(data = gc_disaster,
             aes(x = lon, y = lat),
             shape = '▼',
             color = 'blue',
             size = 3) +
  geom_point(data = region_crim_occur_nomiss,
             aes(x = lon, y = lat, size = total, stroke = 5),
             color = 'darkblue',
             alpha = 0.5)

# ggplotly(q)
