install.packages("urltools")
install.packages("htmltools")
install.packages("rvest")
install.packages("stringi")

require(urltools)
require(htmltools)
require(rvest)
require(stringi)

#manually specify the url
#url <- 'http://data.people.com.cn/rmrb/s?type=1&qs=%7B%22cds%22%3A%5B%7B%22cdr%22%3A%22AND%22%2C%22cds%22%3A%5B%7B%22fld%22%3A%22title%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22subTitle%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22introTitle%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22contentText%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%5D%7D%5D%2C%22obs%22%3A%5B%7B%22fld%22%3A%22dataTime%22%2C%22drt%22%3A%22DESC%22%7D%5D%7D'
#webpage <- read_html(paste0(url, "&pageNo=3"))

#specifying the keyword and time span, use urltools to encod the url we need 
cat(url_decode("http://data.people.com.cn/rmrb/s?type=2&qs=%7B%22cds%22%3A%5B%7B%22fld%22%3A%22dataTime.start%22%2C%22cdr%22%3A%22AND%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%222016-07-13%22%7D%2C%7B%22fld%22%3A%22dataTime.end%22%2C%22cdr%22%3A%22AND%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%222018-07-11%22%7D%2C%7B%22fld%22%3A%22contentText%22%2C%22cdr%22%3A%22AND%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E6%97%A5%E6%9C%AC%22%7D%5D%2C%22obs%22%3A%5B%7B%22fld%22%3A%22dataTime%22%2C%22drt%22%3A%22DESC%22%7D%5D%7D"))


search <- function(page, from, to) {
    keyword <- '台湾'
    from <- paste0(from, "-01-01")
    to <- paste0(to, "-12-31")
    query <- paste0('{"cds":[{"fld":"dataTime.start","cdr":"AND", "hlt":"false","vlr":"AND","qtp":"DEF","val":"', from ,'"},',
                    '{"fld":"dataTime.end","cdr":"AND","hlt":"false","vlr":"AND","qtp":"DEF","val":"', to, '"},',
                    '{"fld":"contentText","cdr":"AND","hlt":"true","vlr":"AND","qtp":"DEF","val":"', keyword,'"}],"obs":[{"fld":"dataTime","drt":"DESC"}]}')
    
    url <- paste0('http://data.people.com.cn/rmrb/s?type=1&qs=', url_encode(query), "&pageNo=3", page)
    read_html(url)
    #html_nodes(index, xpath="//div[@class='sreach_div']//h3//a/@href")
}

fetch <- function(webpage) {
    #title
    title_data_html <- html_nodes(webpage,'.open_detail_link')
    title_data <- html_text(title_data_html)
    head(title_data)
    
    #date
    date_data_html <- html_nodes(webpage,'.listinfo')
    date_data <- html_text(date_data_html)
    head(date_data)
    date_data <- stri_replace_all_fixed(date_data, "\r","")
    date_data <- stri_replace_all_fixed(date_data, "\n","")
    date_data <- stri_replace_all_fixed(date_data, "\t","")
    date_data <- stri_replace_all_fixed(date_data, "【浏览本版】","")
    date_data<-date_data[3:length(date_data)]
    
    #keyword
    keyword_data_html <- html_nodes(webpage,'.keywords')
    keyword_data <- html_text(keyword_data_html)
    head(keyword_data)
    keyword_data<-date_data<-stri_replace_all_fixed(keyword_data, "\r","")
    keyword_data<-date_data<-stri_replace_all_fixed(keyword_data, "\n","")
    keyword_data<-date_data<-stri_replace_all_fixed(keyword_data, "\t","")
    
    #abstract
    abstract_data_html <- html_nodes(webpage,'p')
    abstract_data <- html_text(abstract_data_html)
    head(abstract_data)
    tail(abstract_data)
    abstract_data<-date_data<-stri_replace_all_fixed(abstract_data, "\r","")
    abstract_data<-date_data<-stri_replace_all_fixed(abstract_data, "\n","")
    abstract_data<-date_data<-stri_replace_all_fixed(abstract_data, "\t","")
    abstract_data<-abstract_data[3:length(abstract_data)]
    
    #body
    body_data_html <- html_nodes(webpage,'.detail_con')
    body_data <- html_text(body_data_html)
    head(body_data)
    tail(body_data)
    date_data <- stri_replace_all_fixed(body_data, "\r","")
    date_data <- stri_replace_all_fixed(body_data, "\n","")
    date_data <- stri_replace_all_fixed(body_data, "\t","")
    body_data<-body_data[3:length(body_data)]
    
    #building dataframe
    data <- data.frame(title = title_data, 
                           date = date_data, 
                           keyword = keyword_data, 
                           abstract = abstract_data,
                           url = paste0("http://data.people.com.cn", html_attr(title_data_html, "href")),
                           stringsAsFactors = FALSE)
    return(data)
}

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
