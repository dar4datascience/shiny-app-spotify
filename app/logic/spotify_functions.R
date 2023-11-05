box::use(
         stringr[str_replace, str_replace_all],
         tibble[tibble]
         )


#' @export
clean_artist_response <- function(search_artist_response_list) {
   # Clean response
   artists_found_df <- tibble(
      artist_name = search_artist_response_list$name,
      artist_id = search_artist_response_list$id,
      artist_uri = str_replace(search_artist_response_list$uri, 'spotify:artist:', ''),
      artist_followers = search_artist_response_list$followers$total,
      artist_popularity = search_artist_response_list$popularity,
      artist_genres = list( search_artist_response_list$genres),
      artist_img = ifelse(length(search_artist_response_list$images) > 0,
                          search_artist_response_list$images[[1]]$url,
                          NA) |> 
         as.character() |> 
         list()
   )
   

   return(artists_found_df)
}
