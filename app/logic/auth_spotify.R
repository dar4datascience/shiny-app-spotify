client_id <- '09419aa4748c4b5b94099c5bd1a3451e'
client_secret <- '2179e36d865f42488ff4bee8551d619c'
token <- POST(
  'https://accounts.spotify.com/api/token',
  accept_json(),
  authenticate(client_id, client_secret),
  body = list(grant_type = 'client_credentials'),
  encode = 'form',
  httr::config(http_version = 2)
) %>% content %>% .$access_token
