# Archivos de Código

## pagina_web.R

Contiene el código inicial de lo que será la interfaz de nuestra página web. Por ahora solo presenta lo que sería la selección de uno de los filtros.

## scraping_sence.R

Contiene un avance del código para el web scraping.

# Problemáticas

En la página de [SENCE](https://eligemejor.sence.cl/BuscarCursoNuevo/PorPrograma):

- Al cambiar de página no cambia la url, dándonos problemas. 

- La página abre ventanas emergentes interrumpiendo nuestro código.

- Hay cursos que no están categorizados, por lo cual tendremos problemas a futuro. Se nos ocurre hacer una base de datos de palabras clave por categorías, pero puede ser muy engorroso. ¿Existirá otra opción?

En la página de [SERCOTEC](https://www.sercotec.cl/):

- Una de las páginas a las que queremos hacerle web scraping requiere ingresar con cuenta. No sabemos si es posible realizar esto de alguna forma.
