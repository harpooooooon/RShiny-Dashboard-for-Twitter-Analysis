# twitter_RShiny_application
<h3>dashboard for twitter handle analysis</h3>


Hi,

The code in this repository is for a RShiny dashboard that uses the Twitter REST API to return a set number of tweets from a particular twitter handle, set by the user. Powered by R, this application is designed to answer the following questions:

  <li>What subjects cause the highest user engagement, measured by RT/ Favorited count?</li>

  <li>When does a person tweet?</li>
  
  <li>How often does a person tweet?</li>
  
  <li>From what device/source does person tweet?</li>
  
  <li>What does a person tweet about?</li>
  
  <li>Is there a correlation between the RT and Favorited count?</li>
  
  
         
<h3>Notes: </h3>
  
  <li>For security reasons I excluded the API consumer and access keys. Insert your own under the authentication function named 'setup1'
  and the application will chug along dandily.</li>
  
  
  <li>As stated before, the applcation uses the Twitter REST API and more specifically uses the 'userTimeline' function, derived from twitteR package to pull Tweets. The API, however, may not return the desired number of tweets due to restrictions on time line history</li>
  
<li>The app is constructed using two scripts. One entitled 'functions' containing a set of functions, each of which except a data frame of tweets and associated metadata, and filter through according to what specifically it operates upon. The other, entitled 'app', is the the real meat of the dashboard. Functions from from the 'functions' script are called in and executed. The aforementioned architecture is used to declutter the already messy script 'app' and provides no circumstance in which erroneous syntax errors can occur.  </li>
  
 
<h3>Lastly,</h3>

The application runs, but it runs slowly. If you have suggestion on how to decrease the computational time, specifically for the strata analysis tab along with any other suggestion, please leave them in the issues section.
