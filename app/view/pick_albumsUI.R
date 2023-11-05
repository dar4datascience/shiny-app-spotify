

pick_albumsUI  <- function(id) {
  
  ns = NS(id)
  
  uiOutput(ns("albums_list"))
}


pick_albums <- function(input, output, session, selected_artist = NULL, choose_artist_input) {
  
  ns = session$ns
  
  albums_list = reactiveValues(df = NULL)
  
  observe({
    print(choose_artist_input$search_albums2)
  })
  
  observe({
    print(choose_artist_input$search_tracks_all_albums)
  })
  
  observeEvent({
    choose_artist_input$search_tracks_all_albums
  },{
    if(is.null(selected_artist())) return()
    albums_list$df = get_albums(selected_artist()$artist_uri, token)
  })
  
  
  #       
  observeEvent({
    choose_artist_input$search_albums2
  },{
    if(is.null(selected_artist())) return()
    albums_list$df = get_albums(selected_artist()$artist_uri, token)
  })
  
  
  output$albums_list <- renderUI({
    if(!is.null(albums_list$df)) {
      if(choose_artist_input$search_albums2 >0) {
        albums = albums_list$df %>% data.frame() %>% select(album_name) %>% as_vector() %>% as.character()
        list(
          selectizeInput(inputId = ns("chosen_albums"), 
                         label = "Choose an album:", 
                         choices = albums,
                         multiple = T,
                         selected = albums,
                         options = list('plugins' = list('remove_button'))),
          withBusyIndicatorUI(actionButton(ns("select_albums"), "Select"))
        )
      }
    }
  })
  
  return(reactive(albums_list$df))
}

pick_albums_input <- function(input, output, session) {
  return(input)
}