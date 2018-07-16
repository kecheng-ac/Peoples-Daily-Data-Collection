require(htmltools)
require(urltools)
require(rvest)

cat(url_decode("http://data.people.com.cn/rmrb/s?type=2&qs=%7B%22cds%22%3A%5B%7B%22fld%22%3A%22dataTime.start%22%2C%22cdr%22%3A%22AND%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%222016-07-13%22%7D%2C%7B%22fld%22%3A%22dataTime.end%22%2C%22cdr%22%3A%22AND%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%222018-07-11%22%7D%2C%7B%22fld%22%3A%22contentText%22%2C%22cdr%22%3A%22AND%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E6%97%A5%E6%9C%AC%22%7D%5D%2C%22obs%22%3A%5B%7B%22fld%22%3A%22dataTime%22%2C%22drt%22%3A%22DESC%22%7D%5D%7D"))



keyword <- '日本'
from <- "2018-01-01"
to <- '2018-12-31'
query <- paste0('{"cds":[{"fld":"dataTime.start","cdr":"AND", "hlt":"false","vlr":"AND","qtp":"DEF","val":"', from ,'"},',
                '{"fld":"dataTime.end","cdr":"AND","hlt":"false","vlr":"AND","qtp":"DEF","val":"', to, '"},',
                '{"fld":"contentText","cdr":"AND","hlt":"true","vlr":"AND","qtp":"DEF","val":"', keyword,'"}],"obs":[{"fld":"dataTime","drt":"DESC"}]}')


# query <- paste0('{"cds":[{"cdr":"AND","cds":[{"fld":"title","cdr":"OR","hlt":"true","vlr":"AND","qtp":"DEF","val":"', keyword , '"},', '
#                                              {"fld":"subTitle","cdr":"OR","hlt":"false","vlr":"AND","qtp":"DEF","val":"', keyword,'"},', 
#                                             '{"fld":"introTitle","cdr":"OR","hlt":"false","vlr":"AND","qtp":"DEF","val":"', keyword, '"},', 
#                                             '{"fld":"contentText","cdr":"OR","hlt":"true","vlr":"AND","qtp":"DEF","val":"', keyword, '"}]}],', 
#                 '"obs":[{"fld":"dataTime","drt":"DESC"}]}')
url <- paste0('http://data.people.com.cn/rmrb/s?type=1&qs=', url_encode(query))
index <- read_html(url)
html_nodes(index, xpath="//div[@class='sreach_div']//h3//a/@href")

#渡辺先生が使ったようなパッケージの説明を一通り読んだうえで自分で試したコードは以下です。基本的な情報：各ニュースのタイトル、時間、キーワード、
#アブストラクトをスクレーピングすることに成功したが、各ニュースの本文を抽出させること、ページの転換、あと正確に時間の制限を加えること（例えば５年）はまだ
# どうやるか見当つきません。
install.packages("htmltools")
install.packages("rvest")
install.packages("stringi")

require(htmltools)
require(rvest)
require(stringi)

url <- 'http://data.people.com.cn/rmrb/s?type=1&qs=%7B%22cds%22%3A%5B%7B%22cdr%22%3A%22AND%22%2C%22cds%22%3A%5B%7B%22fld%22%3A%22title%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22subTitle%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22introTitle%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22false%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%2C%7B%22fld%22%3A%22contentText%22%2C%22cdr%22%3A%22OR%22%2C%22hlt%22%3A%22true%22%2C%22vlr%22%3A%22AND%22%2C%22qtp%22%3A%22DEF%22%2C%22val%22%3A%22%E5%8F%B0%E6%B9%BE%22%7D%5D%7D%5D%2C%22obs%22%3A%5B%7B%22fld%22%3A%22dataTime%22%2C%22drt%22%3A%22DESC%22%7D%5D%7D'
webpage <- read_html(paste0(url, "&pageNo=3"))

#title
title_data_html <- html_nodes(webpage,'.open_detail_link')
title_data <- html_text(title_data_html)
head(title_data)



#date
date_data_html <- html_nodes(webpage,'.listinfo')
date_data <- html_text(date_data_html)
head(date_data)
date_data<-gsub("\r","",date_data)
date_data<-gsub("\n","",date_data)
date_data<-gsub("\t","",date_data)
date_data<-gsub("【浏览本版】","",date_data)

require(stringi)
stri_replace_all_fixed(date_data, "\r", "")

#keyword
keyword_data_html <- html_nodes(webpage,'.keywords')
keyword_data <- html_text(keyword_data_html)
head(keyword_data)
keyword_data<-gsub("\r","",keyword_data)
keyword_data<-gsub("\n","",keyword_data)
keyword_data<-gsub("\t","",keyword_data)

#abstract
abstract_data_html <- html_nodes(webpage,'p')
abstract_data <- html_text(abstract_data_html)
head(abstract_data)
tail(abstract_data)
abstract_data<-gsub("\r","",abstract_data)
abstract_data<-gsub("\n","",abstract_data)
abstract_data<-gsub("\t","",abstract_data)
abstract_data<-abstract_data[3:length(abstract_data)]

#building dataframe
taiwan_df <-data.frame(title = title_data, 
                      date = date_data, 
                      keyword = keyword_data, 
                      abstract = abstract_data,
                      url = paste0("http://data.people.com.cn", html_attr(title_data_html, "href")),
                      stringsAsFactors = FALSE)

taiwan_df$body <- ""
for (i in seq(nrow(taiwan_df))) {
    cat(i, "\n")
    taiwan_df$body[i] <- read_html(taiwan_df$url[i]) %>% 
                         html_nodes(".detail_con") %>% html_text()
    Sys.sleep(3)
}




#see the stucture of dataframe



str(taiwan_df)

#loop to capture information on other pages

#get information of every single text

#needs to figure out the way to set time scale for the whole scrapping

#file output 
write.csv(taiwan_df,"Taiwan_People's daily.csv", fileEncoding="UTF-16LE")
help("write.table")

