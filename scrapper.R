#install.packages("urltools")
#install.packages("htmltools")
#install.packages("rvest")
#install.packages("stringi")

source('functions.R')
require(urltools)
require(htmltools)
require(rvest)
require(stringi)

url <- search(1, 2018, 2018)
temp <- data.frame(url = url, text = "", stringsAsFactors = FALSE)

# for (i in seq_along(temp$url)) {
#     
#     para <- read_html(temp$url[i]) %>% 
#             html_nodes("p") %>% 
#             html_text() 
#     temp$text[i] <- paste0(para, collapse = " ")
#     cat(i, stri_sub(temp$text[i], 1, 100), "\n")
#     Sys.sleep(5)
# }

i <- 1
while(TRUE) {
    txt <- character()
    para <- read_html(temp$url[i]) %>% 
        html_nodes("p") %>% 
        html_text() 
    txt <- paste0(para, collapse = " ")
    cat(i, stri_sub(txt, 1, 100), "\n")
    if (txt != "")
        i <- i + 1
    Sys.sleep(5)
    if (length(temp$url) < i)
        break
}


