delete_artistUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("delete_UI"))
}




delete_artist <- function(input, output, session, spotify) {
  
  ns = session$ns 
  
  artists = reactive({
    if (is.null(unique(spotify$df$artist_name))) {
      return("")
    } else {
      return(unique(spotify$df$artist_name))
    }
  })
  
  
  
  output$delete_UI <- renderUI({
    list(
      selectizeInput(inputId = ns("artists_to_keep"), 
                     label = "Selected Artists", 
                     choices = artists(),
                     multiple = T,
                     selected = artists(),
                     options = list('plugins' = list('remove_button'))),
      actionButton(ns("filter_artists"), "Filter")
    )
  })
  
  
  return(input)
  
}

