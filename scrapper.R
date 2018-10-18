install.packages("urltools")
install.packages("htmltools")
install.packages("rvest")
install.packages("stringi")

source('functions.R')
require(urltools)
require(htmltools)
require(rvest)
require(stringi)

#manually specify the url
#url <- 'http://data.people.com.cn/rmrb/s?type=1&qs=%7B%22cds%22%3A%5B%7B%22cdr%22%3A%22AND%22%2C%22cds%22%3A%5B%7B%22fld%22%3A%22title%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22subTitle%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22introTitle%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22contentText%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%5D%7D%5D%2C%22obs%22%3A%5B%7B%22fld%22%3A%22dataTime%22%2C%22drt%22%3A%22DESC%22%7D%5D%7D'
#webpage <- read_html(paste0(url, "&pageNo=3"))

#specifying the keyword and time span, use urltools to encod the url we need 
cat(url_decode("http://data.people.com.cn/rmrb/s?type=2&qs=%7B%22cds%22%3A%5B%7B%22fld%22%3A%22dataTime.start%22%2C%22cdr%22%3A%22AND%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%222016-07-13%22%7D%2C%7B%22fld%22%3A%22dataTime.end%22%2C%22cdr%22%3A%22AND%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%222018-07-11%22%7D%2C%7B%22fld%22%3A%22contentText%22%2C%22cdr%22%3A%22AND%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E6%97%A5%E6%9C%AC%22%7D%5D%2C%22obs%22%3A%5B%7B%22fld%22%3A%22dataTime%22%2C%22drt%22%3A%22DESC%22%7D%5D%7D"))




taiwan_df

taiwan_df$body <- ""
for (i in seq(nrow(taiwan_df))) {
  cat(i, "\n")
  taiwan_df$body[i] <- read_html(taiwan_df$url[i]) %>% 
    html_nodes("p") %>% html_text()
  Sys.sleep(3)
}

while(i < 2670){
  url <- 'http://data.people.com.cn/rmrb/s?type=1&qs=%7B%22cds%22%3A%5B%7B%22cdr%22%3A%22AND%22%2C%22cds%22%3A%5B%7B%22fld%22%3A%22title%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22subTitle%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22introTitle%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22contentText%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%5D%7D%5D%2C%22obs%22%3A%5B%7B%22fld%22%3A%22dataTime%22%2C%22drt%22%3A%22DESC%22%7D%5D%7D'
  pageno <- i; i <- i+1;
  webpage <- read_html(paste0(url, "&pageNo=", pageno))
  webpage
}

help("stringi-encoding")

from <- 2012
to <- 2018

data <- data.frame()
for (year in seq(from, to)) {
  page <- count_page()
  #while (TRUE) {
  for (p in seq(page)) {
    index <- search(keyword, p, ...)
    data <- rbind(data, fetch(index))
    Sys.sleep(5)
  }
  saveRDS(data, paste0("data_", year, ".RDS"))
}


#see the stucture of dataframe



str(taiwan_df)


#file output 
write.csv(taiwan_df,"Taiwan_People's daily.csv", fileEncoding="utf-8")
help("write.table")