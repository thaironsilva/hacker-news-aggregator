# hacker-news-aggregator
An Aggregator that fetches data from Hacker News API

# How I did it
First feature I have to do is the hacker news API caller. Everything will depend on it.
As the exercise stated that should be 2 types of connection, my first thought was to separate
into to different adapters for the same port.
I felt the need to create an Item module mainly for documentation purpose, but it also makes it
more scalable. To make the exercise as minimal as possible I only created it with the Stories fields.
I started with the HTTP adapter and used HTTPoison and Jason to implement the http calls.
Having created the hacker news handler I wanted to create as soon as possible the part I thought as
the second most important for starting the features and API, which is the stories updater.
My first thought was to do it using EctoJob, but I soon realized it would break the rule of no
external database and probably a unnecessary complexity addition. I ultimately dit it using genserver
and was satisfied with the result.
I didn't want to postpone even more testing, as I usually like to test as soon as a feature is finished,
so I created created the tests for the features I just described to make sure everything was working as I
intended. I tried using Mox to mock the HTTP calls, but I wasn't working because it mocks behaviours and
I just wanted to mock the HTTP call specifically, so Mock was good and simple enough as a solution.
