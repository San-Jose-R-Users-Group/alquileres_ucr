descargar_mapa <- function(typename) {
  function(path = NA_character_) {
    checkmate::assert_path_for_output(path, overwrite = T, extension = "qs")
    wfs_ign <- "https://geos.snitcr.go.cr/be/IGN_5/wfs?"
    
    url <- httr::parse_url(wfs_ign)
    
    url$query <- list(
      service = "wfs",
      request = "GetFeature",
      typename = typename,
      srsName = "EPSG:4326"
    )
    
    request <- httr::build_url(url)
    map <- sf::read_sf(request)
    
    # simplificar el mapa
    map <-
      rmapshaper::ms_simplify(map, keep = 0.01, keep_shapes = TRUE)
    
    # eliminar islas
    map <- rmapshaper::ms_filter_islands(map, min_area = 24000000)
    map <- sf::st_set_crs(x = map, value = sf::st_crs(4326))
    
    qs::qsave(x = map, file = path)
    return(path)
  }
  
}
get_provincias <- function(path = NA_character_) {
  checkmate::check_path_for_output(path, overwrite = T, extension = "qs")
  wfs_ign <- "https://geos.snitcr.go.cr/be/IGN_5/wfs?"
  
  url <- httr::parse_url(wfs_ign)
  
  url$query <- list(
    service = "wfs",
    request = "GetFeature",
    typename = "IGN_5:limiteprovincial_5k",
    srsName = "EPSG:4326"
  )
  
  request <- httr::build_url(url)
  map <- sf::read_sf(request)
  
  # simplificar el mapa
  map <-
    rmapshaper::ms_simplify(map, keep = 0.01, keep_shapes = TRUE)
  
  # eliminar islas
  map <- rmapshaper::ms_filter_islands(map, min_area = 24000000)
  map <- sf::st_set_crs(x = map, value = sf::st_crs(4326))
  
  qs::qsave(x = map, file = path)
  return(path)
}

descargar_provincias <- descargar_mapa("IGN_5:limiteprovincial_5k")
descargar_cantones <- descargar_mapa("IGN_5:limitecantonal_5k")
descargar_distritos <- descargar_mapa("IGN_5:limitedistrital_5k")
