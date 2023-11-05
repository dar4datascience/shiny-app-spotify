get_playlists_tracks <- function(playlist_list, token) {
  GET(
    'https://api.spotify.com/v1/users/claireunderwood2017/playlists/40HeD8KNiKZKiXzDARAzfN/tracks',
    query = list(access_token = token)
  ) %>%
    content
  
  # Clean response and combine all 1returned artists into a dataframe
  tracks <- map_df(seq_len(nrow(playlist_list)), function(i) {
    tracks = GET(
      paste0(
        'https://api.spotify.com/v1/users/',
        playlist_list[i, 2],
        '/playlists/',
        playlist_list[i, 1],
        '/tracks'
      ),
      query = list(access_token = token)
    ) %>%
      content %>% .$items
    print(i)
    tracks = map(seq_len(length(tracks)), function(x) {
      # print(x)
      list(
        track_name = tracks[[x]]$track$name,
        artist_name = tracks[[x]]$track$artists[[1]]$name,
        # playlist_id = playlist_list[i,1] %>% simplify(),
        track_id = tracks[[x]]$track$id
      )
    })
    
    # tracks = do.call(rbind.data.frame, tracks)
    
    tracks = plyr::rbind.fill(lapply(lapply(tracks, Filter, f = Negate(is.null)) , as.data.frame))
    
    get_tracks_features(tracks, token)
    
  })
  
  # tracks = tracks %>% drop_na() %>% group_by(track_id, artist_name, track_name) %>% summarise(appearances = n()) %>% arrange(desc(appearances))
  
  return(tracks)
}
