all_imgs_print <- function(input, output, session, spotify) {
  
  output$print_artist_img <- renderUI({
    if(!is.null(spotify)) {
      lapply(unique(spotify$df$album_img), function(x) {
        tags$img(src = x, style = "float: left; margin-right = 1%; margin-bottom = 0.5em", width = "24%", align = "middle")
      }
      )
    }
  })
  
  reactive({
    spotify
  })
  
}

all_imgs_printUI  <- function(id) {
  
  ns = NS(id)
  
  uiOutput(ns("print_artist_img"))
}
