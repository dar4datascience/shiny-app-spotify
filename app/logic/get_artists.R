box::use(
  httr[content,
       GET],
  stringr[str_replace],
  purrr[map,
        list_rbind,
        pluck],
  tidyr[nest],
  dplyr[group_by]
)

box::use(
  app/logic/auth_spotify[get_spotify_token],
  app/logic/spotify_functions[clean_artist_response],
  )


#' @export
get_artists <- function(artist_name) {
  token <- get_spotify_token()
  
  # Search Spotify API for artist name
  search_artist_response <-
    GET(
      'https://api.spotify.com/v1/search',
      query = list(
        q = artist_name,
        type = 'artist',
        access_token = token
      )
    ) |> 
    content() |> 
    pluck("artists", "items")
  
  # Clean search_artist_responseponse and combine all returned artists into a dataframe
  artists_found_df <- search_artist_response |> 
    map(
      function(artist_found) {
        clean_artist_response(artist_found)
      }
    ) |> 
    list_rbind() 
  
  if (nrow(artists_found_df) == 0)
    return(NULL)
  
  return(artists_found_df)
}