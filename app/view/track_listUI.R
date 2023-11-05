


tracks_list <-
  function(input,
           output,
           session,
           chosen_artist = NULL,
           albums_list = NULL,
           choose_artist_input,
           pick_albums_input,
           spotify) {
    ns = session$ns
    
    tracks = reactiveValues()
    
    observeEvent(pick_albums_input$select_albums, {
      withBusyIndicatorServer("add-alb-select_albums", {
        tracks$df = rbind(
          spotify$df,
          get_tracks(
            chosen_artist(),
            albums_list() %>% filter(album_name  %in% pick_albums_input$chosen_albums),
            token
          ) %>% data.frame
        )
      })
    })
    
    observeEvent(choose_artist_input$search_tracks_all_albums, {
      withBusyIndicatorServer("add-choo-search_tracks_all_albums", {
        tracks$df = rbind(spotify$df,
                          get_tracks(chosen_artist(),
                                     albums_list(),
                                     token) %>% data.frame)
      })
    })
    
    return(tracks)
  }