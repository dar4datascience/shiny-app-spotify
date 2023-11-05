box::use(httr[GET,
              POST,
              authenticate,
              config,
              content,
              accept_json],
         purrr[pluck])

#' @export
get_spotify_token <- function(client_id, client_secret) {
  token_response <- POST(
    'https://accounts.spotify.com/api/token',
    accept_json(),
    authenticate(
      Sys.getenv('SPOTIFY_CLIENT_ID'),
      Sys.getenv('SPOTIFY_CLIENT_SECRET')
    ),
    body = list(grant_type = 'client_credentials'),
    encode = 'form',
    config(http_version = 2)
  )
  
  token <- token_response |>
    content() |>
    pluck('access_token')
  
  
  return(token)
}
