search <- function(page, from, to) {
  keyword <- '台湾'
  from <- paste0(from, "-01-01")
  to <- paste0(to, "-12-31")
  query <- paste0('{"cds":[{"fld":"dataTime.start","cdr":"AND", "hlt":"false","vlr":"AND","qtp":"DEF","val":"', from ,'"},',
                  '{"fld":"dataTime.end","cdr":"AND","hlt":"false","vlr":"AND","qtp":"DEF","val":"', to, '"},',
                  '{"fld":"contentText","cdr":"AND","hlt":"true","vlr":"AND","qtp":"DEF","val":"', keyword,'"}],"obs":[{"fld":"dataTime","drt":"DESC"}]}')
  
  url <- paste0('http://data.people.com.cn/rmrb/s?type=1&qs=', url_encode(query), "&pageNo=", page)
  index <- read_html(url)
  paste0("http://data.people.com.cn", 
         html_text(html_nodes(index, xpath="//div[@class='sreach_div']//h3//a/@href")))
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
