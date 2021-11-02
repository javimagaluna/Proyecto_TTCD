
# Librerías ---------------------------------------------------------------

library(tidyverse) 
library(rvest)          
library(RSelenium)

#----------------------
pagina <- rvest::read_html("https://eligemejor.sence.cl/BuscarCursoNuevo/PorPrograma")

#----------------------
### PAG 1 ###

## Nombre curso:
nombre_curso <- pagina %>% 
  html_nodes(xpath= "//h4[@class = 'cursoTitulo movitit']") %>% 
  html_text2()


## URL curso:
url_curso <- pagina %>% 
  html_nodes(xpath= "//a[@class = 'btnmovilcursoinvi']") %>% 
  html_attr("href")

url_curso = paste0("https://eligemejor.sence.cl",url_curso)

#-----------------------

# Iniciar Selenium ----
driver <- RSelenium::rsDriver(browser = "chrome", 
                              chromever = "94.0.4606.61")

remote_driver <- driver[["client"]]
remote_driver$navigate("https://eligemejor.sence.cl/BuscarCursoNuevo/PorPrograma")

## Pasar a la otra pagina:
remote_driver$findElement("xpath", value= "//a[@class = 'despues']/span/img")$clickElement()

## Cursos por pagina:
remote_driver$findElement("xpath", value= "//select[@class = 'form-control']/option[@value= '50']")$clickElement()



#==========================================================================
# Buscando URL de los cursos ----------------------------------------------

#-----------------------

pagina <- rvest::read_html("https://eligemejor.sence.cl/BuscarCursoNuevo/PorPrograma")

## Total cursos encontrados:
total <- pagina %>% 
  html_nodes(xpath= "//div[@class = 'totalResultados col-xs-12 col-sm-12 col-md-12']") %>% 
  html_text2()

total = strsplit(total, split=" ")[[1]][2] %>% as.numeric()

#-----------------------
# Iniciar Selenium ----
driver <- RSelenium::rsDriver(browser = "chrome", 
                              chromever = "94.0.4606.61")

remote_driver <- driver[["client"]]
remote_driver$navigate("https://eligemejor.sence.cl/BuscarCursoNuevo/PorPrograma")


nombre_curso <- NULL
url_curso <- NULL

for(i in ceiling(total/10)){
  
  page <- rvest::read_html(remote_driver$getPageSource()[[1]])
  ## Nombre curso:
  nombre_curso = c(nombre_curso, page%>% 
    html_nodes(xpath= "//h4[@class = 'cursoTitulo movitit']") %>% 
    html_text2())
  
  ## URL curso:
  url_curso = c(url_curso, page%>% 
    html_nodes(xpath= "//a[@class = 'btnmovilcursoinvi']") %>% 
    html_attr("href"))
  
  ## Pasar a la otra pagina:
  remote_driver$findElement("xpath", value= "//a[@class = 'despues']/span/img")$clickElement()

  
  Sys.sleep(5)

}

beepr::beep(1)


#remote_driver$findElements("xpath", value="//h4[@class = 'cursoTitulo movitit']/b")
getElementText()


url_curso = paste0("https://eligemejor.sence.cl", url_curso)

