## Proyecto Alquileres

### Instalar dependencias

Para instalar las dependencias (paquetes) necesarios para ejecutar el proyeto ejecuta la siguiente instruccion:

```
renv::restore()
```

### Configuracion google drive

El formulario estaría guardado en google drive, seguramente como un archivo compartido, para descargarlo debes autenticarte y guardar el acceso a tu archivos de google drive, para esto ejecuta el siguiente código:

```
library(googledrive)
library(gargle)
options(gargle_oauth_cache = ".secrets")
gargle_oauth_cache() 
drive_auth()
```

ahora en el archivo `_targets.R` edita el email en la configuración de google drive.

### Ejecutar el proceso


```
targets::tar_make()
```




