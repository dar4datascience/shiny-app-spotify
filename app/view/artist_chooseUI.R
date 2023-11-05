

artist_chooseUI  <- function(id) {
  
  ns = NS(id)
  
  uiOutput(ns("pick_artist"))
}


artist_choose <- function(input, output, session, artist_list = NULL) {
  
  ns = session$ns
  
  output$pick_artist <- renderUI({
    
    if(!is.null(artist_list())) {
      
      
      artists = artist_list()$artist_uri %>% simplify %>% as.list
      names(artists) = artist_list()$artist_name
      list(br(),
           selectInput(inputId = ns("chosen_artist"), 
                       label = "Results", 
                       choices = artists),
           div(style="display:inline-block",withBusyIndicatorUI(actionButton(ns("search_albums2"), "Choose Albums"))),
           div(style="display:inline-block",withBusyIndicatorUI(actionButton(ns("search_tracks_all_albums"), "Get All Tracks")))
           
      )
      
    }
  })
  selected_artist <- reactive(artist_list() %>% filter(artist_uri == input$chosen_artist))
  
  observe(print(input$asdasd))
  
  return(selected_artist)
  
}


choose_artist_input <- function(input, output, session) {
  return(input)
}


