
#
# playlist_list = get_playlists("running", token)
# playlist_tracks = get_playlists_tracks(playlist_list = playlist_list, token)
# # features = get_tracks_features(playlist_tracks, token)
#
#
# relax_p = get_playlists("relax", token)
# relax_tracks = get_playlists_tracks(relax_p, token)
#
#
# run_tracks$label = "run"
# relax_tracks$label = "relax"
#
# tracks = rbind(run_tracks, relax_tracks)
# names(tracks)
#
# ggplot(tracks[order(rnorm(nrow(tracks))),], aes(x = instrumentalness, energy, color = label, text = track_name)) +
#       geom_point(alpha = 0.6)
# ggplotly(ggplot(tracks, aes(x = loudness, energy, color = label, text = track_name)) +
#       geom_point())
#
#
# require(caret)
#
# inTrain = createDataPartition(tracks$label, p = 0.7, list = F)
# train = tracks[inTrain,]
# test = tracks[-inTrain,]
#
# ctrl = trainControl(method = "repeatedcv", number = 5, repeats = 5, verboseIter = T)
#
# dput(names(train))
#
# features = c("danceability", "energy",
#   "key", "loudness", "mode", "speechiness", "acousticness", "instrumentalness",
#   "liveness", "valence", "tempo", "duration_ms", "time_signature", "label")
#
# model = train(label ~ ., train[,features], method = "glm", preProcess = c("center", "scale"), trControl = ctrl)
# modelrf = train(label ~ ., train[,features], method = "rf", preProcess = c("center", "scale"), tuneGrid = expand.grid(mtry = 2))
# modelsvm = train(label ~ ., train[,features], method = "svmLinear", preProcess = c("center", "scale"), trControl = ctrl, tuneGrid = expand.grid(C = c(1, 2,5)))
#
# confusionMatrix(model)
# model$finalModel
#
# saveRDS(model, "../Desktop/Projetos/Estudos/Shiny Apps/Machine Learning App/logistic_regression_chill_run")
#
#
# radiohead = get_artists(artist_name = "Radiohead", token)
# radiohead = radiohead[1,]
# r_albums = get_albums(radiohead$artist_uri, token)
# r_tracks = get_tracks(radiohead, r_albums, token)
#
#
# cbind(r_tracks, run = predict(model, r_tracks, type = "prob")[,2]) %>%  select(track_name, run) %>% arrange(run)
