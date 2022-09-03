
# dependencias ------------------------------------------------------------

library(targets)
library(future)
library(future.callr)


# configuracio google drive -----------------------------------------------

options(
  gargle_oauth_cache = ".secrets",
  gargle_oauth_email = "dev.aguero@gmail.com" # cambiar por tu email
)

# configuracion future (procesamiento en paralelo) ------------------------

plan(callr)


# configuracion targers ---------------------------------------------------

tar_option_set(
  packages = c("tibble","sf","httr","readr","rmapshaper","qs","googledrive"),
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
    name = "descargar_formulario",
    command = descargar_form(
      name = as_id("1w3_wxfWFc1ZFyLHAx5KQ4ukQy2EVorXjQ8J0uWvTmVQ"),
      path = "data-raw/formulario.csv"),
    format = "file",
    cue = tarchetypes::tar_cue_force({
      modified_time <- suppressMessages(
        googledrive::drive_get(as_id("1w3_wxfWFc1ZFyLHAx5KQ4ukQy2EVorXjQ8J0uWvTmVQ"))[["drive_resource"]][[1]]$modifiedTime
      )
      modified_time <- lubridate::ymd_hms(modified_time)
      last_run <- try(tar_meta("descargar_formulario")[["time"]], silent = T)
      if(inherits(last_run,"try-error")){
        FALSE
      }else{
        modified_time > last_run
      }
      
    })
  )
)
