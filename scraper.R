require(htmltools)
require(rvest)
keyword <- '日本'
query <- paste0('{"cds":[{"cdr":"AND","cds":[{"fld":"title","cdr":"OR","hlt":"true","vlr":"AND","qtp":"DEF","val":"', keyword , '"},', '
                                             {"fld":"subTitle","cdr":"OR","hlt":"false","vlr":"AND","qtp":"DEF","val":"', keyword,'"},', 
                                            '{"fld":"introTitle","cdr":"OR","hlt":"false","vlr":"AND","qtp":"DEF","val":"', keyword, '"},', 
                                            '{"fld":"contentText","cdr":"OR","hlt":"true","vlr":"AND","qtp":"DEF","val":"', keyword, '"}]}],', 
                '"obs":[{"fld":"dataTime","drt":"DESC"}]}')
url <- paste0('http://data.people.com.cn/rmrb/s?type=1&qs=', URLencode(query))
index <- read_html(url)
html_nodes(index, xpath="//div[@class='sreach_div']//h3//a/@href")
