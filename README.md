# hacker-news-aggregator
An Aggregator that fetches data from Hacker News API

# How I did it
First feature I have to do is the hacker news API caller. Everything will depend on it.
As the exercise stated that should be 2 types of connection, my first thought was to separate
into to different adapters for the same port.
I felt the need to create an Item module mainly for documentation purpose, but it also makes it
more scalable. To make the exercise as concise as possible I only created it with the Stories fields.
