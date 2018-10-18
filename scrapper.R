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
try_max <- 2
i <- 7
try <- 1
while (TRUE) {
    txt <- character()
    elem <- read_html(temp$url[i]) %>% html_nodes("p")
    if (length(elem) == 0)
        elem <- read_html(temp$url[i]) %>% html_nodes("td")

    try <- try + 1
    txt <- paste0(html_text(elem), collapse = " ")
    cat(i, stri_sub(txt, 1, 100), "\n")
    
    if (txt != "" || try > try_max) {
        i <- i + 1
        try <- 1
    }
    Sys.sleep(10)
    if (length(temp$url) < i)
        break
}


