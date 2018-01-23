# context ####
#   defines functions 




# function testing ####
  
#  par(mfrow=c(1,1)) 
#  setup1()
#  setup2()
#  tweets <- form_tweet_df('elonmusk', 1000)
#  View(tweets)
#  tweet_per_day(tweets)
#  tweets_per_hour(tweets)
#  plot_geolocation(tweets)
#  fav_retweet_ratio(tweets)
#  fav_rt_ratio_per_tweet(tweets)
#  rt_fav_frequency_table(tweets, size = 20)
#  word_cloud(tweets, 75)
#  display_data(tweets)
#  tweet_source(tweets)
  
# fucntion definitions #### 
  # funciton 1) authentication setup ####
  setup1 <- function(x){
    require(twitteR)
    consumer_key = ""
    consumer_secret = ""
    access_token = ""
    access_secret = ""
    setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
  }

  # fucntion 2) form_tweet_df ####
    form_tweet_df <- function(twitter_handle, n){
      #pull tweets
      tweets <- userTimeline(user = twitter_handle, 
                             n = n, 
                             excludeReplies = TRUE)
      
      #transform tweet df
      tweetdf <- twListToDF(tweets)
      
      #return 
      return(tweetdf)
    }  
  
  # function 3) ploting tweets per day ####
    tweet_per_day <- function(tweets){
      
      # subseting tweets to day created
      day_tweeted <- wday(tweets$created)
      
      # declaring vector to hold day of the week 
      week_day= vector()
      
      # giving numerical value a name
      for(i in 1:length(day_tweeted)){
        if(day_tweeted[i] == 1){
          week_day[i] <- "monday"
        } else if(day_tweeted[i] == 2){
          week_day[i] <- "tuesday"
        } else if (day_tweeted[i] == 3){
          week_day[i] <- "wednesday"
        } else if (day_tweeted[i] == 4){
          week_day[i] <- "thursday"
        } else if (day_tweeted[i] == 5){
          week_day[i] <- "friday"
        } else if(day_tweeted[i] == 6){
          week_day[i] <- "saturday"
        } else if (day_tweeted[i] == 7){
          week_day[i] <- "sunday"
        }
      }
      
      # declaring vector that holds the frequency of tweets per day
      freq = vector()
      for(i in 1:7){
        freq[i] = 0
      }
      
      # addinging the instance of a tweet per day
      for(i in 1:length(day_tweeted)){
        if(week_day[i] == "monday"){
          freq[1] = freq[1] + 1
        } else if(week_day[i] == "tuesday"){
          freq[2] = freq[2] + 1
        } else if(week_day[i] == "wednesday"){
          freq[3] = freq[3] + 1
        } else if(week_day[i] == "thursday"){
          freq[4] = freq[4] + 1
        } else if(week_day[i] == "friday"){
          freq[5] = freq[5] + 1
        } else if(week_day[i] == "saturday"){
          freq[6] = freq[6] +  1
        } else if(week_day[i] == "sunday"){
          freq[7] = freq[7] + 1
        }
      }
      
      # plotting a bargraph of tweets per day of the week
      list_of_days <- c("mon", "tues", "wed", "thur", "fri", "sat", "sun")
      freq_df <- data.frame(frequency = c(freq), 
                            days = factor(c(list_of_days), 
                                          levels = c(list_of_days)))
      plot <- ggplot(freq_df, aes(x = days, y = frequency)) + 
        geom_bar(stat="identity", fill = "steelblue4", color = "black") +
        ggtitle("Tweets per Day of the Week") + 
        theme(plot.title = element_text(lineheight=.8, face="bold"))
      
      return(plot)
    }
  # function 4) ploting tweets per hours ####
    tweets_per_hour <-  function(tweets){
      
      time <- tweets$created
      
      # transforming time stamps into hours 
      list_hours <- hour(time)
      
      # declaring a vecotr to store the labeled hours 
      hour_label = vector()
      
      # labeling the hours 
      for(i in 1:length(list_hours)){
        if(list_hours[i] == 0){
          hour_label[i] = "0:00"
        } else if(list_hours[i] == 1){
          hour_label[i] = "1:00"
        } else if(list_hours[i] == 2){
          hour_label[i] = "2:00"
        } else if(list_hours[i] == 3){
          hour_label[i] = "3:00"
        } else if(list_hours[i] == 4){
          hour_label[i] = "4:00"
        } else if(list_hours[i] == 5){
          hour_label[i] = "5:00"
        } else if(list_hours[i] == 6){
          hour_label[i] = "6:00"
        } else if(list_hours[i] == 7){
          hour_label[i] = "7:00"
        } else if(list_hours[i] == 8){
          hour_label[i] = "8:00"
        } else if(list_hours[i] == 9){
          hour_label[i] = "9:00"
        } else if(list_hours[i] == 10){
          hour_label[i] = "10:00"
        } else if(list_hours[i] == 11){
          hour_label[i] = "11:00"
        } else if(list_hours[i] == 12){
          hour_label[i] = "12:00"
        } else if(list_hours[i] == 13){
          hour_label[i] = "13:00"
        } else if(list_hours[i] == 14){
          hour_label[i] = "14:00"
        } else if(list_hours[i] == 15){
          hour_label[i] = "15:00"
        } else if(list_hours[i] == 16){
          hour_label[i] = "16:00"
        } else if(list_hours[i] == 17){
          hour_label[i] = "17:00"
        } else if(list_hours[i] == 18){
          hour_label[i] = "18:00"
        } else if(list_hours[i] == 19){
          hour_label[i] = "19:00"
        } else if(list_hours[i] == 20){
          hour_label[i] = "20:00"
        } else if(list_hours[i] == 21){
          hour_label[i] = "21:00"
        } else if(list_hours[i] == 22){
          hour_label[i] = "22:00"
        } else if(list_hours[i] == 23){
          hour_label[i] = "23:00"
        } else if(list_hours[i] == 24){
          hour_label[i] = "24:00"
        }
      }
      
      # declaring a vector to save the frequencies
      freq = vector()
      for(i in 1:25){
        freq[i] = 0
      }
      
      # counting frequencies
      for (i in 1:length(hour_label)){
        if(hour_label[i] == "0:00"){
          freq[1] = freq[1] + 1
        } else if (hour_label[i] == "1:00"){
          freq[2] = freq[2] + 1
        } else if (hour_label[i] == "2:00"){
          freq[3] = freq[3] + 1
        } else if (hour_label[i] == "3:00"){
          freq[4] = freq[4] + 1
        } else if (hour_label[i] == "4:00"){
          freq[5] = freq[5] + 1
        } else if (hour_label[i] == "5:00"){
          freq[6] = freq[6] + 1
        } else if (hour_label[i] == "6:00"){
          freq[7] = freq[7] + 1
        } else if (hour_label[i] == "7:00"){
          freq[8] = freq[8] + 1
        } else if (hour_label[i] == "8:00"){
          freq[9] = freq[9] + 1
        } else if (hour_label[i] == "9:00"){
          freq[10] = freq[10] + 1
        } else if (hour_label[i] == "10:00"){
          freq[11] = freq[11] + 1
        } else if (hour_label[i] == "11:00"){
          freq[12] = freq[12] + 1
        } else if (hour_label[i] == "12:00"){
          freq[13] = freq[13] + 1
        } else if (hour_label[i] == "13:00"){
          freq[14] = freq[14] + 1
        } else if (hour_label[i] == "14:00"){
          freq[15] = freq[15] + 1
        } else if (hour_label[i] == "15:00"){
          freq[16] = freq[16] + 1
        } else if (hour_label[i] == "16:00"){
          freq[17] = freq[17] + 1
        } else if (hour_label[i] == "17:00"){
          freq[18] = freq[18] + 1
        } else if (hour_label[i] == "18:00"){
          freq[19] = freq[19] + 1
        } else if (hour_label[i] == "19:00"){
          freq[20] = freq[20] + 1
        } else if (hour_label[i] == "20:00"){
          freq[21] = freq[21] + 1
        } else if (hour_label[i] == "21:00"){
          freq[22] = freq[22] + 1
        } else if (hour_label[i] == "22:00"){
          freq[23] = freq[23] + 1
        } else if (hour_label[i] == "23:00"){
          freq[24] = freq[24] + 1
        } else if (hour_label[i] == "24:00"){
          freq[25] = freq[25] + 1
        }
      }
      
      # ploting the freqency as line graph
      list_of_hours <- c("00:00", "01:00", "02:00", "03:00", "04:00", 
                         "05:00", "06:00", "07:00", "08:00", "09:00",
                         "10:00", "11:00", "12:00", "13:00", "14:00",
                         "15:00", "16:00", "17:00", "18:00", "19:00",
                         "20:00", "21:00", "22:00", "23:00", "24:00")
     
      freq_df <- data.frame(frequency = c(freq), hours = factor(list_of_hours))
      plot <- ggplot(freq_df, aes(hours, frequency)) + 
        geom_bar(stat="identity", fill = "steelblue4", color = "black")+
        ggtitle("Tweets per Hour of the Day (UTC)") + 
        theme(plot.title = element_text(lineheight=.8, face="bold"))
      plot <- plot + coord_flip()
      return(plot)
    }
  # function 5) favorite to retweet ratio ####
    fav_retweet_ratio <- function(tweets){
      
      freq_df <- data.frame(RT = c(log(tweets$retweetCount)), FAV = c(log(tweets$favoriteCount)))
      plot <- ggplot(freq_df, aes(FAV, RT)) + 
        geom_point(shape = 1) +
        geom_smooth(method = lm, se = TRUE) +
        ggtitle("Retweeted Count vs Favorite Count") + 
        theme(plot.title = element_text(lineheight=.8, face="bold"))
      
      
      return(plot)
    }
  # funciton 6) fav-rt-ratio per tweet ####
    fav_rt_ratio_per_tweet <- function(tweets){
    
      #subsetting dataframe
      RT <- tweets$retweetCount
      fav <- tweets$favoriteCount
    
      #calculating the ratio of average
      mean_ratio <- mean(RT)/mean(fav)
      
      # declare ratio that holds retweetCount/favoriteCount for every tweet
      ratio = vector()
      
      # filling ratio vector
      for(i in 1:nrow(tweets)){
        tryCatch(ratio[i] <- RT[i]/fav[i],
                 error = function(e) ratio[i] <- NULL)
      }
      
      # ploting the element in the ratio array per tweet 
      freq_df <- data.frame(INDEX = c(1:length(ratio)), RATIO = c(ratio))
      plot <- ggplot(freq_df, aes(INDEX, RATIO)) + 
        geom_point(shape = 1) +
        geom_hline(yintercept = mean_ratio, linetype="dashed", color = "red") +
        geom_hline(yintercept = 1.33*mean_ratio, color = "blue") +
        geom_hline(yintercept = .67*mean_ratio, color = "blue") +
        ggtitle("Retweeted Count vs Favorite Count per tweet") + 
        theme(plot.title = element_text(lineheight=.8, face="bold"))
      
      return(plot)
    }
  
  # function 7) forming a table of frequently used terms per strata ####
  rt_fav_frequency_table <-  function(tweets, size ){
    
    #calculating the ratio of average ####
    mean_ratio <- mean(tweets$retweetCount/tweets$favoriteCount)
    
    # filling ratio vector ####
    ratio = vector()
    for(i in 1:nrow(tweets)){
      ratio[i] <- tweets$retweetCount[i]/tweets$favoriteCount[i]
    }
    
    index <- c(1:nrow(tweets))
    data_set <- data.frame(index, ratio)
    
    # susbeting by strata ####
    
    XL <- subset(data_set,
                ratio >= 1.33*mean_ratio, 
                select = c(index, ratio))
    L <- subset(data_set,
                ratio < 1.33*mean_ratio & ratio >= mean_ratio,
                select = c(index, ratio))
    M <- subset(data_set,
                ratio < mean_ratio & ratio >= .67*mean_ratio,
                select = c(index, ratio))
    S <- subset(data_set,
                ratio <= .67*mean_ratio,
                select = c(index, ratio))
    
    # cleaning tweets and forming a tdm ####
    for(i in XL$index){
      text_XL <- tweets$text[XL$index]
      text_corpus_XL <- Corpus(VectorSource(text_XL)) 
      
      text_corpus_XL <- tm_map(text_corpus_XL, removeWords, c("amp", "the", "The")) #remove "amp"
      text_corpus_XL <- tm_map(text_corpus_XL, removePunctuation) #removes punctuation
      text_corpus_XL <- tm_map(text_corpus_XL, removeWords, stopwords("english")) #remove engMish words
      text_corpus_XL <- tm_map(text_corpus_XL, removeNumbers) #removes numbers
      text_corpus_XL <- tm_map(text_corpus_XL, stripWhitespace) #removes whitespace
      
      tdm_XL <- TermDocumentMatrix(text_corpus_XL)
      a_XL <- as.matrix(tdm_XL)
      b_XL <- sort(rowSums(a_XL), decreasing = TRUE)
      c_XL <- data.frame(word = names(b_XL), freq = b_XL)
    }
    #head(c_XL, 10)
    
    for(i in L$index){
      text_L <- tweets$text[L$index]
      text_corpus_L <- Corpus(VectorSource(text_L)) 
      
      text_corpus_L <- tm_map(text_corpus_L, removeWords, c("amp", "the", "The")) #remove "amp"
      text_corpus_L <- tm_map(text_corpus_L, removePunctuation) #removes punctuation
      text_corpus_L <- tm_map(text_corpus_L, removeWords, stopwords("english")) #remove engMish words
      text_corpus_L <- tm_map(text_corpus_L, removeNumbers) #removes numbers
      text_corpus_L <- tm_map(text_corpus_L, stripWhitespace) #removes whitespace
      
      tdm_L <- TermDocumentMatrix(text_corpus_L)
      a_L <- as.matrix(tdm_L)
      b_L <- sort(rowSums(a_L), decreasing = TRUE)
      c_L <- data.frame(word = names(b_L), freq = b_L)
    }
    #head(c_L, 10)
    
    for(i in M$index){
      text_M <- tweets$text[M$index]
      text_corpus_M <- Corpus(VectorSource(text_M)) 
      
      text_corpus_M <- tm_map(text_corpus_M, removeWords, c("amp", "the", "The")) #remove "amp"
      text_corpus_M <- tm_map(text_corpus_M, removePunctuation) #removes punctuation
      text_corpus_M <- tm_map(text_corpus_M, removeWords, stopwords("english")) #remove engMish words
      text_corpus_M <- tm_map(text_corpus_M, removeNumbers) #removes numbers
      text_corpus_M <- tm_map(text_corpus_M, stripWhitespace) #removes whitespace
      
      tdm_M <- TermDocumentMatrix(text_corpus_M)
      a_M <- as.matrix(tdm_M)
      b_M <- sort(rowSums(a_M), decreasing = TRUE)
      c_M <- data.frame(word = names(b_M), freq = b_M)
    }
    #head(c_M, 10)
    
    
    for(i in S$index){
      text_S <- tweets$text[S$index]
      text_corpus_S <- Corpus(VectorSource(text_S)) 
      
      text_corpus_S <- tm_map(text_corpus_S, removeWords, c("amp", "the", "The")) #remove "amp"
      text_corpus_S <- tm_map(text_corpus_S, removePunctuation) #removes punctuation
      text_corpus_S <- tm_map(text_corpus_S, removeWords, stopwords("english")) #remove engMish words
      text_corpus_S <- tm_map(text_corpus_S, removeNumbers) #removes numbers
      text_corpus_S <- tm_map(text_corpus_S, stripWhitespace) #removes whitespace
      
      tdm_S <- TermDocumentMatrix(text_corpus_S)
      a_S <- as.matrix(tdm_S)
      b_S <- sort(rowSums(a_S), decreasing = TRUE)
      c_S <- data.frame(word = names(b_S), freq = b_S)
    }
    #head(c_S, 10)
    
    # making a data frame from from processed tdm ####
    size_set_words <- data.frame(head(c_XL, size), 
                                 head(c_L, size), 
                                 head(c_M, size), 
                                 head(c_S, size))
    colnames(size_set_words) <- c("XL", "XL_freq",
                                  "L", "L_freq", 
                                  "M", "M_freq",
                                  "S", "S_freq")
    rownames(size_set_words) <- c(NULL)
    #as.matrix.data.frame(size_set_words)
    
    return(size_set_words)
    
  }

  # function 8) forming a word cloud of commonly used terms ####
  word_cloud <- function(tweets, max_words) {
    
    
    text_corpus <- Corpus(VectorSource(tweets$text))
    
    text_corpus <- tm_map(text_corpus, removeWords, c("amp"))
    text_corpus <- tm_map(text_corpus, removeWords, stopwords("english")) #remove english words
    text_corpus <- tm_map(text_corpus, removePunctuation) #removes punctuation
    text_corpus <- tm_map(text_corpus, removeNumbers) #removes numbers
    text_corpus <- tm_map(text_corpus, stripWhitespace) #removes whitespace
    
    tdm <- TermDocumentMatrix(text_corpus)
    a <- as.matrix(tdm)
    b <- sort(rowSums(a), decreasing = TRUE)
    c <- data.frame(word = names(b), freq = b)
    
    cloud <- wordcloud(text_corpus, 
                       max.words = max_words, 
                       random.order = FALSE, 
                       color = brewer.pal(8, "Dark2"))
    return(cloud)
  }
  
  
  
  # function 9) forming the table of raw data ####
  display_data <- function(tweets){
    temp_data = data.frame()
    temp_data <- subset(tweets, select = c(text, 
                                           created, 
                                           retweetCount, 
                                           favoriteCount, 
                                           id,
                                           longitude,
                                           latitude))
    temp_data$index = c(1:nrow(tweets))
    #View(temp_data)
    return(temp_data)
  }
  
  
  # function 10) ploting tweet sources ####
  tweet_source <- function(tweets){
    
    
    temp <- str_extract(tweets$statusSource, ">(.*)<")
    temp <- gsub('<', "", temp)
    temp <- gsub('>', "", temp)
    
    temp_df <- data.frame(table(temp))
    colnames(temp_df) <- c("source", "frequency")
    temp_plot <- ggplot(temp_df,
                        aes(x = "", y = frequency, fill = source)) +
      geom_bar(stat="identity", 
               color = "black") +
      ggtitle("Tweet Sources")
    temp_plot
    
    pie <- temp_plot +
      coord_polar("y", start = 0) +
      scale_fill_brewer(palette="Blues") +
      theme_minimal()
    
    return(pie)
    
  }
  