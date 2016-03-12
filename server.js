var express = require('express')
var app = express()

var redis = require("redis"),
r = redis.createClient();

var twit = require('twit')
 
var t = new twit({
  consumer_key:         process.env.twitter_search_consumer_key,
  consumer_secret:      process.env.twitter_search_consumer_secret,
  access_token:         process.env.twitter_search_access_token,
  access_token_secret:  process.env.twitter_search_access_token_secret,
  timeout_ms:           60*1000,  // optional HTTP request timeout to apply to all requests. 
})


app.get('/', function (req, res) {
	res.send('Hello World')
})

app.get('/tweets', function (req, res) {
	var q = req.query['s'];
	var searchTerm = "*" + q + "*";

 	r.keys(searchTerm, function (err, keys)
	{
		var s = "";

 		r.mget(keys, function(err, v)
 		{
 			if (v)
 			{
				v.forEach(function(item, i) 
				{
					var json = JSON.parse(item);

					if (json.entities.urls.length > 0)
					{
						s += json.text + "| <a href='" + json.entities.urls[0].url + "'>" + "tweet</a>" + "<br><br>";
					}
					else
					{
						s += json.text + "<br>";
					}
				});

	 			res.send(s);
	 		}
	 		else
	 		{
	 			res.send("")
	 		}
 		});
    })
})

function iterateTimeline(maxId)
{
	var q;

	if (maxId == undefined)
	{
		q = { user_id:57425501, count:100 };
	}
	else
	{
		q = { user_id:57425501, max_id:maxId, count:100 };
	}

	t.get('statuses/user_timeline', q, function(err, data, response)
	{
		if (data == undefined) { return; }

		for (i in data)
		{
			var item = data[i];

			r.set(item.text, JSON.stringify(item));
		}

		if (data.length > 0)
		{
			var nextMaxId = data[data.length - 1].id - 1;

			iterateTimeline(nextMaxId);
		}
		else
		{
			console.log("done.");
		}
	});
}

iterateTimeline();


app.listen(3000)