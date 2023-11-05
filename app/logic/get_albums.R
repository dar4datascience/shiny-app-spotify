
#' @export
get_albums <- function(artist_uri, token) {
  albums <-
    GET(
      paste0(
        'https://api.spotify.com/v1/artists/',
        artist_uri,
        '/albums'
      ),
      query = list(
        access_token = token,
        market = "US",
        limit = 50,
        album_type = "album"
      )
    ) %>% content
  
  if (length(albums$items) == 0)
    stop("Sorry. No albums were found for this artist.")
  
  map_df(1:length(albums$items), function(x) {
    tmp <- albums$items[[x]]
    
    # Make sure the album_type is not "single"
    if (tmp$album_type == 'album') {
      data.frame(
        album_uri = str_replace(tmp$uri, 'spotify:album:', ''),
        album_name = str_replace_all(tmp$name, '\'', ''),
        album_img = albums$items[[x]]$images[[1]]$url,
        stringsAsFactors = F
      ) %>%
        mutate(
          album_release_date = GET(
            paste0(
              'https://api.spotify.com/v1/albums/',
              str_replace(tmp$uri, 'spotify:album:', '')
            ),
            query = list(access_token = token)
          ) %>% content %>% .$release_date,
          # you need a separate call to on "albums" to get release date.
          album_release_year = ifelse(
            nchar(album_release_date) == 4,
            year(as.Date(album_release_date, '%Y')),
            year(as.Date(album_release_date, '%Y-%m-%d'))
          ) # not all album_release_dates have months, so I created album_release year for sorting
        )
    } else {
      NULL
    }
    
  }) %>% filter(!duplicated(tolower(album_name))) %>%  # Sometimes there are multiple versions (just with different capitalizations) of the same album
    arrange(album_release_year)
}
