
#' @export
get_playlists <- function(playlist_name, token) {
  # Search Spotify API for a1rtist name
  res <-
    GET(
      'https://api.spotify.com/v1/search',
      query = list(
        q = playlist_name,
        type = 'playlist',
        access_token = token
      )
    ) %>%
    content %>% .$playlists %>% .$items
  
  
  
  
  # Clean response and combine all returned artists into a dataframe
  playlists <- map_df(seq_len(length(res)), function(x) {
    list(
      playlist_id = res[[x]]$id,
      user_id = str_replace(res[[x]]$owner$uri, 'spotify:user:', '') # remove meta info from the uri string
    )
  })
  
  return(playlists)
}