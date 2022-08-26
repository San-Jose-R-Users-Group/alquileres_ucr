
consulta_osm <- function(bbox = NA, key = NA, value = NA, key_exact = TRUE) {
  
    # consultar https://wiki.openstreetmap.org/wiki/Map_features
    checkmate::assert_numeric(bbox)
    checkmate::assert_character(key)
    checkmate::assert_character(value)
    checkmate::assert_flag(key_exact)
    
    q <- osmdata::opq(bbox = bbox, timeout = 25 * 10) %>%
      osmdata::add_osm_feature(
        key = key,
        value = value,
        key_exact = key_exact)
    
    
    out <- osmdata::osmdata_sf(q)
    
    return(out)
}
