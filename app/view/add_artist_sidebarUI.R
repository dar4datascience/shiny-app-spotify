box::use(shiny[NS],
         htmltools[tagList,
                   tags,
                   br],
         shinydashboard[box])

box::use(
  app / view / artist_inputUI[artist_inputUI],
  app / view / artist_chooseUI[artist_chooseUI],
  app / view / artist_img_printUI[artist_img_printUI],
  app / view / pick_albumsUI[pick_albumsUI],
  app / view / delete_artistUI[delete_artistUI],
  app / view / all_imgs_printUI[all_imgs_printUI],
)

add_artist_sidebarUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    box(
      title = "Pick Artists",
      artist_inputUI(ns("art")),
      artist_chooseUI(ns("choo")),
      br(),
      artist_img_printUI(ns("img")),
      br(),
      pick_albumsUI(ns("alb")),
      width = 12
    ),
    box(
      style = "padding-bottom: 50px",
      delete_artistUI(ns("temp")),
      br(),
      all_imgs_printUI(ns("all_imgs")),
      width = 12
    ),
    tags$div(
      class = "footnote",
      tags$div("Created by Joel Ponte"),
      tags$div("joelcponte@gmail.com"),
      align = "center"
    )
  )
}
