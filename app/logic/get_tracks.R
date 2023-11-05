
get_tracks <- function(artist_info, album_info, token) {
  track_info <- map_df(album_info$album_uri, function(x) {
    tracks <-
      GET(
        paste0('https://api.spotify.com/v1/albums/', x, '/tracks'),
        query = list(access_token = token)
      ) %>%
      content %>%
      .$items
    
    uris <- map(1:length(tracks), function(z) {
      gsub('spotify:track:', '', tracks[z][[1]]$uri)
    }) %>% unlist %>% paste0(collapse = ',')
    
    res <-
      GET(
        paste0(
          'https://api.spotify.com/v1/audio-features/?ids=',
          uris
        ),
        query = list(access_token = token)
      ) %>% content %>% .$audio_features
    
    df = plyr::rbind.fill(lapply(lapply(res, lapply, function(x)
      ifelse(is.null(x), NA, x)) , as.data.frame))#plyr::rbind.fill(lapply(lapply(res, Filter, f = Negate(is.null)) , as.data.frame))
    df = data.frame(do.call("cbind", lapply(df, function(x)
      if (is.numeric(x)) {
        round(x, 2)
      } else {
        x
      })), stringsAsFactors = F)
    #             df <- unlist(res) %>%
    #                   matrix(nrow = length(res), byrow = T) %>%
    #                   as.data.frame(stringsAsFactors = F
    # )
    names(df) <- names(res[[1]])
    
    df <- df %>%
      mutate(album_uri = x,
             track_number = row_number()) %>%
      rowwise %>%
      mutate(track_name = tracks[[track_number]]$name) %>%
      ungroup %>%
      left_join(album_info, by = 'album_uri') %>%
      rename(track_uri = id) %>%
      select(-c(type, track_href, analysis_url, uri))
    return(df)
  }) %>%
    drop_na() %>%
    mutate(artist_img = artist_info$artist_img,
           artist_name = artist_info$artist_name) %>%
    mutate_at(
      c(
        'album_uri',
        'track_uri',
        'album_release_date',
        'track_name',
        'album_name',
        'artist_img'
      ),
      funs(as.character)
    ) %>%
    mutate_at(
      c(
        'danceability',
        'energy',
        'key',
        'loudness',
        'mode',
        'speechiness',
        'acousticness',
        'album_release_year',
        'instrumentalness',
        'liveness',
        'valence',
        'tempo',
        'duration_ms',
        'time_signature',
        'track_number'
      ),
      funs(as.numeric(gsub(
        '[^e0-9.-]+', '', as.character(.)
      )))
    ) # for some reason parse_number() from readr doesn't work here
  return(track_info)
}
