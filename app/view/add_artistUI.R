add_artistUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    box(title = "Pick Artists",
        artist_inputUI(ns("art")),
        artist_chooseUI(ns("choo")),
        br(),
        artist_img_printUI(ns("img")),
        br(),
        pick_albumsUI(ns("alb")),
        width = 12),
    box(
      delete_artistUI(ns("temp")),
      br(),
      all_imgs_printUI(ns("all_imgs")),
      width = 12
    )
  )
}

add_artist <- function(input, output, session, df_old) {
  
  spotify <- reactiveValues(df = structure(list(danceability = numeric(0), energy = numeric(0), 
                                                key = numeric(0), loudness = numeric(0), mode = numeric(0), 
                                                speechiness = numeric(0), acousticness = numeric(0), instrumentalness = numeric(0), 
                                                liveness = numeric(0), valence = numeric(0), tempo = numeric(0), 
                                                track_uri = character(0), duration_ms = numeric(0), time_signature = numeric(0), 
                                                album_uri = character(0), track_number = numeric(0), track_name = character(0), 
                                                album_name = character(0), album_img = character(0), album_release_date = character(0), 
                                                album_release_year = numeric(0), artist_img = character(0)), .Names = c("danceability", 
                                                                                                                        "energy", "key", "loudness", "mode", "speechiness", "acousticness", 
                                                                                                                        "instrumentalness", "liveness", "valence", "tempo", "track_uri", 
                                                                                                                        "duration_ms", "time_signature", "album_uri", "track_number", 
                                                                                                                        "track_name", "album_name", "album_img", "album_release_date", 
                                                                                                                        "album_release_year", "artist_img"), row.names = integer(0), class = "data.frame"))
  
  artist_list <- callModule(artist_input, "art")
  chosen_artist <- callModule(artist_choose, "choo", artist_list)
  ca_setup <- callModule(choose_artist_input, "choo")
  callModule(artist_img_print, "img", artist_list, ca_setup)
  selected_albums <- callModule(pick_albums, "alb", chosen_artist, ca_setup)
  
  
  pa_setup <- callModule(pick_albums_input, "alb")
  spotify <- callModule(tracks_list, "fin", chosen_artist, selected_albums, ca_setup, pa_setup, spotify)
  
  delete <- callModule(delete_artist, "temp", spotify)
  
  callModule(all_imgs_print, "all_imgs", spotify)
  
  observeEvent(delete$filter_artists, {
    if (is.null(delete$artists_to_keep)) {
      spotify$df = spotify$df[0,]
    } else {
      spotify$df = spotify$df %>% filter(artist_name %in% delete$artists_to_keep)
    }
  })
  
  return(spotify)
  
}



