
artist_img_printUI  <- function(id) {
  
  ns = NS(id)
  
  uiOutput(ns("print_artist_img"))
}


artist_img_print <- function(input, output, session, artist_list = NULL, choose_artist_input = NULL) {
  
  script = "$('.img_asd').each(function () {
        var imgwidth = $(this).width();
        var imgheight = $(this).height();

        if (imgwidth > imgheight) {
            $(this).css('width', 'auto');
            $(this).css('height', '230px');
        }
        else {
                $(this).css('width', '230px');
                $(this).css('height', 'auto');
            }
    });"
  
  
  output$print_artist_img <- renderUI({
    validate(need(choose_artist_input$chosen_artist, F))
    if(!is.null(choose_artist_input$chosen_artist) & !is.null(artist_list())) {
      img_link = artist_list() %>% filter(artist_uri == choose_artist_input$chosen_artist) %>% select(artist_img) %>% simplify()
      if(length(img_link)>0) {
        tags$div(style = "width: 230px; height: 230px; position: relative; overflow: hidden; margin: 0px; border-radius: 50%;",tags$img(class = "img_asd", style = "display: inline; margin: 0;", id = paste0("artist_image_sidebar_", choose_artist_input$chosen_artist), onload = script,  src = img_link, width = "50%", align = "middle"))
      }
    } else{
      print("No artists found.")
    }
  })
  
}