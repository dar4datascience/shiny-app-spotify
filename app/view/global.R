library(purrr)
library(dplyr)
library(tidyr)
library(tibble)
library(httr)
library(stringr)
library(lubridate)
library(plotly)
library(shiny)
library(shinydashboard)
library(caret)
library(reshape2)
library(formattable)
library(data.table)
library(plotly)
library(highcharter)
library(RColorBrewer)
library(htmltools)
library(shinyjs)
source("spotify_functions.R")
source("loading_button.R")





module_server <- function(input, output, session) {
  spotify_df = reactiveValues()
  
  artist_list <- callModule(artist_input, "art")
  chosen_artist <-
    callModule(artist_choose, "choo", artist_list)
  ca_setup <- callModule(choose_artist_input, "choo")
  callModule(artist_img_print, "img", artist_list, ca_setup)
  selected_albums <-
    callModule(pick_albums, "alb", chosen_artist, ca_setup)
  spotify_df$df <-
    callModule(tracks_list, "fin", chosen_artist, selected_albums)
  
  return(spotify_df)
}


moduleUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    artist_inputUI(ns("art")),
    br(),
    artist_chooseUI(ns("choo")),
    br(),
    artist_img_printUI(ns("img")),
    br(),
    pick_albumsUI(ns("alb"))
  )
}
