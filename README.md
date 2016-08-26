# Link Shortener

![toon link](https://media.giphy.com/media/10tXRzZ3yObQ1G/giphy.gif)

[A url shortener to shrink your links!](https://toonlinks.herokuapp.com/)

### Dependencies

- Ruby 2.3.1 (security)
- bundler

## Setup

If you have to set Ruby versions refer to your installed version manager:

|rvm|rbenv|
|:---:|:---:|
|`rvm install 2.3.1`<br>`rvm use 2.3.1` |`rbenv install 2.3.1`<br>`rbenv local 2.3.1`|


- Clone this repository onto your computer
- Navigate into the folder in terminal and run:

```bash
gem install bundler (if you don't have bundler installed)
bundle exec bundle install
rake db:create
rake db:migrate
rake db:seed (optional)
```
- Run the server `bundle exec rails s`
- Go to `http://localhost:3000` and have fun!

## Features

This application allows you to submit a URL and get a shorter url. If you were to buy a short domain name it'd allow you to generate links using the smallest amount of characters available over the web.

Every link generated has some tracking built in, where one can track the number of its visitors.

There is a top 100 board that shows the most popular links.

## Design

Like TinyURL and Bit.ly, my approach was to store urls in my database and generate keys based on their unique primary keys. This is done by encoding the key number as a base62 string, which maps numbers to combinations of lower/uppercase letters and numbers.

The code to do this is hand rolled in the `Link` model. Every `Link` object knows how to encode itself and the class knows how to decode the id back into base10 for database lookup. When a link is created, we check for duplicates in the database and if one is found, the code for that url is given back the user for reuse.

Everytime a link is visited, a `View` object is created, which so far tracks the ip address and date of the visit for later use. This model was created so the feature set could grow with the application. If one needed more information on users and traffic we could implement it neatly. Tying them together is a `has_many`/`belongs_to` relationship.

In aggregation we dodge any n+1 queries through the use of cache counting. This is especially useful when it comes to the Top 100 page. It simplifies our query, and when the rendering engine iterates over all 100 links it doesn't then need to query, collect, and count, all of each links views.

It's only when you visit the show page for a short url that the query is explicitly made, and that data is fed into chart.js for a nice visualization.

## Challenges

The site and the charts in it are not the best looking at the moment. I can implement mockups but am by no means a designer, my apologies to your eyes.

This project was a challenge in that there were many different ways to approach URL generation. I burned a lot of time strategizing my approach out of anxiety over where I thought the code should shine. Many sites use base36 encoding to dodge the problem of having case sensitive urls, however to get the shortest lengths possible, base 62 was needed.

Given my timeframe I focused mainly on getting the data models and controllers functioning. The spec I followed didn't need full CRUD routes for the two resources but it feels a bit unfinished in that regard.

The show routes are nested behind a `site/links/:id` route, where 'links' takes the place of our generated shortcode. Whoever creates the 314,682,640th link is going to have a bad day, and I'd like to prevent that in time.

I am proud that I learned about cache counting during the project. It was fun to find a problem I hadn't encountered before and discover yet another useful feature built into Rails.

There is some amount of normalization in the urls submitted, like that adding of the `http://` protocol header and trailings slashes, but I dodged the issue of saving variants of the same URL(i.e: www.nytimes.com, nytimes.com) due to constraints in time. I check for duplicates at a minimum but if this were to be an analytics tool one would have to track these differences. If I were to address the problem I'd either expand the `Link` model's ability to detect domains, or create a `Domanin` model altogether. The use of both models could let us generate something like a salted string. The current method needs some salt anyway, at the moment the site is susceptible to "url guessing", where you could increment the shortcode and try to hit other links.

I couldn't tell if bit.ly actually obfuscated their shortcodes, but I do know that they keep two different sets of links, and check for duplicates. If you're not logged in you get one code whose pattern will repeat if you submit the same url again. If you have an account with them, the urls generated share a consistent prefix. My guess is they're taking some user attribute and mixing it into the shortcode. It was pretty interesting to pry into the site, it'd be fun to revisit this project again later and emulate it.

I had a ton of fun with this challenge, and look forward to improving further.







