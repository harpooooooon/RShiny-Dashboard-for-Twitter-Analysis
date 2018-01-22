# twitter_RShiny_application
dashboard for twitter handle analysis


Hi,

This is my first RShiny Application. 
The dashboard uses the Twitter REST API to return a set number of tweets from a particular twitter handle, set by the user.
The application is meant to answer the following questions:
      When does a person tweet?
	  How often does a person twet?
      From what device/source does person tweet?
      What does a person tweet about?
      Is there a correlation between the RT and Favorited count?
      What subjects cause the highest user engagement, measured by RT and Favorited count?
         
Notes:
  . As stated before, the applcation uses the Twitter REST API and more specifically uses the 'userTimeline' function,
  dervied from twitteR package to pull Ttweets. The API, however, may not return the desired number of tweets due to restrictions 
  on time line history.
 
Lastly,
	The application runs, but it runs slowly. If you have suggestion on how to decrease the computational time of the strat analysis 
	tab along with any other suggestion, please leave them in the issues section.  
	
