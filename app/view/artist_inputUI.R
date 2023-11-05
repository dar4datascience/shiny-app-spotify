

artist_inputUI <- function(id) {
  
  ns = NS(id)
  
  uiOutput(ns("artist_input"))
  
  tagList(
    tags$div(style = "padding: 0cm", textInput(ns("artist"), "Artist")),
    tags$div(style = "padding: 0cm", withBusyIndicatorUI(actionButton(ns("search_artist"), "Search", icon = icon("spotify"))))
  )
  
}

artist_input <- function(input, output, session) {
  
  ns = session$ns
  
  
  artist_list <- eventReactive(input$search_artist, {
    withBusyIndicatorServer(ns("search_artist"), {
      if (nchar(input$artist) > 0) 
        return(get_artists(input$artist, token))
    })
  })
  return(artist_list)
}