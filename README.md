# hacker-news-aggregator
An Aggregator that fetches data from Hacker News API

# How I did it
First feature I have to do is the hacker news API caller. Everything will depend on it. As the exercise stated that should be 2 types of connection, my first thought was to separate into to different adapters for the same port.
I felt the need to create an Item module mainly for documentation purpose, but it also makes it more scalable. To make the exercise as minimal as possible I only created it with the Stories fields. I started with the HTTP adapter and used HTTPoison and Jason to implement the http calls.
Having created the hacker news handler I wanted to create as soon as possible the part I thought as the second most important for starting the features and API, which is the stories updater.
My first thought was to do it using EctoJob, but I soon realized it would break the rule of no external database and probably a unnecessary complexity addition. I ultimately dit it using genserver and was satisfied with the result.
I didn't want to postpone even more testing, as I usually like to test as soon as a feature is finished, so I created created the tests for the features I just described to make sure everything was working as I intended. I tried using Mox to mock the HTTP calls, but I wasn't working because it mocks behaviours and I just wanted to mock the HTTP call specifically, so Mock was good and simple enough as a solution.
Now I was ready to make the APIs, but think I made a mistake trying to do it as minimalistic as possible, it took me much of my time to make everything work without relying on pre made phoenix project, it's not as good as would like it to be but I have to move on, there is still much to do.
Since every object the hacker news send is a Item, I thought it would make sense to create a ItemController instead of a StoryController, for instance.
I also took the liberty of assuming that when the exercise tells me to list the stories, it means the actual items, not the ids, but the API only fetches one at a time, so it would make the API really slow, and to make it more reliable it needs cache and even better would be to have a process that caches every top story once they're updated, but I'm not sure I'll have the time to do so.
On the list paginated stories endpoints I had to assume a few things. For pagination params, as page size was pre determined, I choose to pass "page" as a parameter and pagination data as a header content in the response.
I couldn't think of an easy way to test this feature using Mock, which made me regret a bit this decision, so I postponed it, being satisfied for now since the test passed successfully, but it depends on the hacker news API availability, which is really not optimal.
