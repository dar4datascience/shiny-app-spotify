
get_artists <- function(artist_name, token) {
  # Search Spotify API for artist name
  res <-
    GET(
      'https://api.spotify.com/v1/search',
      query = list(
        q = artist_name,
        type = 'artist',
        access_token = token
      )
    ) %>%
    content %>% .$artists %>% .$items
  
  # Clean response and combine all returned artists into a dataframe
  artists <- map_df(seq_len(length(res)), function(x) {
    list(
      artist_name = res[[x]]$name,
      artist_uri = str_replace(res[[x]]$uri, 'spotify:artist:', ''),
      # remove meta info from the uri string
      artist_img = ifelse(length(res[[x]]$images) > 0, res[[x]]$images[[1]]$url, NA)
    )
  })
  
  if (nrow(artists) > 0)
    return(artists)
  
  return(NULL)
}