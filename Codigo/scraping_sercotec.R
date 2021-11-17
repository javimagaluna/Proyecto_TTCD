# Librerías ---------------------------------------------------------------

library(tidyverse) 
library(rvest)    
library(RSelenium)

#--------------------------------------------------------------------------
# Iniciar Selenium -----------------------------
driver <- RSelenium::rsDriver(browser = "chrome", 
                              chromever = "94.0.4606.61")

remote_driver <- driver[["client"]]
remote_driver$navigate("https://capacitacion.sercotec.cl/portal/")

# Para iniciar sesión---------------------------
remote_driver$findElement("xpath", 
                          value= "//a[@class = 'login colorbox cboxElement init-colorbox-processed']")$clickElement()


### Para que entre en la ventana emergente:-----
XML::htmlParse(remote_driver$getPageSource()[[1]])
x <- remote_driver$findElements("xpath", value= "//iframe")

sapply(x, function(y){y$getElementAttribute("src")})

remote_driver$switchToFrame(x[[2]])
XML::htmlParse(remote_driver$getPageSource()[[1]])
#-----------------------------------------------

# Ingresando rut:
remote_driver$findElement("xpath", 
                          value= "//div[@class= 'loginContent']/form/div[1]")$clickElement()

#Por privacidad, poner cuenta propia correspondiente.

RUT <- "***"  # Poner rut sin los símbolos de puntos y guión.
for(i in RUT %>% str_split("") %>% unlist()){
  remote_driver$findElement("xpath",
                            value= "//div[@class= 'loginContent']/form/div[1]/input")$sendKeysToElement(list(i))
  Sys.sleep(runif(1, 0.5, 1))
}

# Ingresando contraseña:
remote_driver$findElement("xpath", 
                          value= "//div[@class= 'loginContent']/form/div[2]")$clickElement()

CONT <- "***"  # Poner contraseña de la cuenta
for(i in CONT %>% str_split("") %>% unlist()){
  remote_driver$findElement("xpath",
                            value= "//div[@class= 'loginContent']/form/div[2]/input")$sendKeysToElement(list(i))
  Sys.sleep(runif(1, 0.5, 1))
}

# Click ingreso:
remote_driver$findElement("xpath", 
                          value= "//div[@class= 'loginContent']/form/input[@class= 'button_login']")$clickElement()

Sys.sleep(3) # para que se cargue la nueva pag :D

#--------------------------------------------------------------------------
remote_driver$getCurrentUrl()[[1]]
pagina <- rvest::read_html(remote_driver$getCurrentUrl()[[1]], options= "HUGE")

# Nombre curso
nombre_curso <- pagina %>% 
  html_nodes(xpath= "//div[@class= 'info_container']/h2") %>% 
  html_text2()

# Info
info_sucia <- pagina %>% 
  html_nodes(xpath= "//div[@class= 'info_container']") %>% 
  html_text2()

info_sucia %>% head()

info_sucia_split <- strsplit(info_sucia, split = "\n\n")

## limpiar info sucia y crear el df c:

nombre_curso


#--------------------------------------------------------------------------
# Links (?)
## Mi idea aquí era sacar los links de la pag principal para que las personas entren desde ahí para iniciar sesión.
## Cuando inicien sesión les aparecerán todos los cursos asi que iwal no tiene taaanto sentido hacer esto, 
## pero pensaba que quizás lo haría "más personalizado"

pagina2 <- rvest::read_html("https://capacitacion.sercotec.cl/portal/")

link <- pagina2 %>%  
  html_nodes(xpath= "//div[@class= 'field-content']/a") %>% 
  html_attr("href")

link = paste0("https://capacitacion.sercotec.cl", link)

nombres2 <- pagina2 %>%  
  html_nodes(xpath= "//div[@class= 'views-field views-field-title']/span/a") %>% 
  html_text2()

length(nombres2)
length(link) # D:

# largos distintos pues toma otros cursos o:

# Después de encontrar los links, pensaba en hacer un merge() según curso, puesto que hay cursos 
# que no se pueden inscribir (no aparecen en nombre_curso) y que si aparecen en la pag principal (nombres2)







#=========================================================================
remote_driver$close()
driver[["server"]]$stop()

