

#' @export
get_tracks_features <- function(tracks, token) {
  features = GET(
    paste0('https://api.spotify.com/v1/audio-features/'),
    query = list(
      access_token = token,
      ids = paste(tracks$track_id, collapse = ",")
    )
  ) %>%
    content %>%
    .$audio_features
  
  
  
  
  features = plyr::rbind.fill(lapply(lapply(features, Filter, f = Negate(is.null)) , as.data.frame))
  
  
  features = features %>%
    mutate_at(
      c(
        'danceability',
        'energy',
        'key',
        'loudness',
        'mode',
        'speechiness',
        'acousticness',
        'instrumentalness',
        'liveness',
        'valence',
        'tempo',
        'duration_ms',
        'time_signature'
      ),
      funs(as.numeric(gsub(
        '[^e0-9.-]+', '', as.character(.)
      )))
    )
  
  
  
  features = merge(tracks,
                   features,
                   by.x = "track_id",
                   by.y = "id",
                   all = F)
  
  return(features)
}
