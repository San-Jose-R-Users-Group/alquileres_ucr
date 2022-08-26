
# dependencias ------------------------------------------------------------

library(targets)
library(future)
library(future.callr)


# configuracio google drive -----------------------------------------------

options(
  gargle_oauth_cache = ".secrets",
  gargle_oauth_email = "dev.aguero@gmail.com"
)

# configuracion future (procesamiento en paralelo) ------------------------

plan(callr)


# configuracion targers ---------------------------------------------------

tar_option_set(
  packages = c("tibble","sf","httr","rmapshaper"),
  format = "qs" 
)


# cargar funciones en /R --------------------------------------------------

tar_source()


# definir proceso ---------------------------------------------------------

list(
  tar_target(
    name = "mapa_provincias",
    command = descargar_provincias(path = "data/provincias.qs"),
    format = "file"),
  tar_target(
    name = "mapa_cantones",
    command = descargar_cantones(path = "data/cantones.qs"),
    format = "file"),
  tar_target(
    name = "mapa_distritos",
    command = descargar_distritos(path = "data/distritos.qs"),
    format = "file"),
  tar_target(
    name = "descargar_formuario",
    command = descargar_formulario(
      name = "ejemplo_formulario_datos",
      path = "data-raw/formulario.qs"),
    format = "file"
  )
)
