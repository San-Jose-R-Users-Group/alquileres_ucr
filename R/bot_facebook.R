# 
# start_server <- function(port, browserName = "phantom"){
#   
#   checkmate::assert_integer(port)
#   
#   out <- list()
#   out$server <- wdman::selenium(port = port)
#   out$browser <- RSelenium::remoteDriver(port = port, browserName = browserName)
#   return(out)
# }
# 
# login_facebook <- function(.browser = NULL, email = NA, password = NA){
#   
#   checkmate::assert_character(email)
#   checkmate::assert_character(password)
#   
#   .browser$navigate("https://touch.facebook.com")
#   
#   input_user <- .browser$findElement(using ="xpath",
#                                       value = "//input[@id = 'm_login_email']")
#   input_user$sendKeysToElement(list(email))
# 
#   input_pass <- .browser$findElement(using ="xpath",
#                                        value = "//input[@id = 'm_login_password']")
#   input_pass$sendKeysToElement(list(password))
#   
#   input_pass$sendKeysToElement(list(RSelenium::selKeys$enter)) 
#   
#   Sys.sleep(3)
#   btn <- .browser$findElement(
#     using ="xpath",
#     value = "//button[@value = 'Aceptar']"
#   )
#   btn$clickElement()
#   return(.browser)
#   
# }
# 
# scroll <- function(.browser, tiempo_espera = 1, tiempo_maximo = 60) {
#   hora_final <- Sys.time() + lubridate::seconds(tiempo_maximo)
#   while (TRUE) {
#     .browser$executeScript("window.scrollTo(0, document.body.scrollHeight);")
#     Sys.sleep(tiempo_espera)
#     if(Sys.time() > hora_final) break
#   }
#   return(invisible(.browser))
# }
# 
# 
# get_post_from_fbpage <- function(.browser){
# 
#   posts <- .browser$findElements(using = "xpath", value = "//article")
#   out <- lapply(posts, function(post) {
#     source <- unlist(post$getElementAttribute("outerHTML"))
#     
#     url <- read_html(source) %>%
#       html_node(xpath = "//a[@class = '_5msj']") %>%
#       html_attr("href") %>%
#       paste0("https://touch.facebook.com", .)
#     
#     page <- str_extract(url, "(?<=&id=)\\d+")
#     post <- str_extract(url, "(?<=fbid=)\\d+")
#     
#     text <- read_html(source) %>%
#       html_node(xpath = "//p") %>%
#       html_text(trim = T)
#     
#     data.frame(
#       page_id = page,
#       post_id = post,
#       text = text,
#       url = url
#     )
#   })
#   do.call("rbind", out)
#   
# }
# 
# r <- start_server(port = targets::tar_random_port())
# .browser <- r$browser
# .browser$open()
# .browser$setTimeout(type = "implicit", milliseconds = 5000)
# .browser$setTimeout(type = "page load", milliseconds = 5000)
# 
# login_facebook(.browser,
#                email = "dev.aguero@gmail.com",
#                password = "pysjuw-kapvy2-genCew")
# 
# .browser$navigate("https://facebook.com/groups/222561464778614")
# 
# i <- 5
# textos <- c()
# 
# while (i>0) {
#   scroll(.browser,tiempo_espera = 3, tiempo_maximo = 10)
#   
#   posts <- .browser$findElements(
#     using = "xpath",
#     value = "//div[@role = 'article']")
#   
#   x <- lapply(posts, function(post){
#     txt <- post$getElementText()[[1]]
#     txt <- txt[nchar(txt) > 0]
#     return(txt)
#   })
#   
#   x <- unlist(x)
#   
#   textos <- c(textos, x)
#   i  <- i - 1
#   cat(i,"\n")
# }
# 
# stringr::str_remove_all(string = textos, pattern = "\\n") %>% 
# stringr::str_remove_all(string = ., pattern = "Enviar.+") %>% 
# stringr::str_remove_all(string = ., pattern = ".+\\·\\S+") %>% 
# paste0(., collapse = "\n\n") %>% 
#   readr::write_lines("alquileres.txt")
# 
# .browser$close()
