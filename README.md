# README

PAYAM is an app wherein a user signs up and can create and participate in a Payam.

A PAYAM is a kind of poem. In a PAYAM, the first user picks a one-word title, selects a Style from a list (or creates a new style), then writes the first line that is between 10 and 20 words long.

A next "scribe" is selected at random from all users, who will then see only the title, the style, and last 5 words written by the previous scribe before adding their own line of 10-20 words.

After 8 scribes have written lines the completed PAYAM is viewable.


* Ruby version
2.3.0

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... TODO:
  decompose method automatically run (but be able to run it now using a button)
    It will:
      remove one random word from each line of the completed payam until only one word in each line remains.

  dada method
    select 8 random lines from any payams and stitch them together into a new payam

  admin role

  no long allow uncompleted payams to be displayed

  limit number of uncompleted payams?
