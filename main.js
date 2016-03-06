var twit = require('twit')
 
var t = new twit({
  consumer_key:         process.env.twitter_search_consumer_key,
  consumer_secret:      process.env.twitter_search_consumer_secret,
  access_token:         process.env.twitter_search_access_token,
  access_token_secret:  process.env.twitter_search_access_token_secret,
  timeout_ms:           60*1000,  // optional HTTP request timeout to apply to all requests. 
})

var redis = require("redis"),
r = redis.createClient();

r.on("error", function (err) 
{
	console.log("Error " + err);
});

function iterateTimeline(maxId)
{
	console.log("looking for id " + maxId);

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

			//r.quit();
		}
		else
		{
			console.log("done.");
			r.quit();
		}
	});
}

// r.keys("*Kabam", function (err, replies) 
// {
//     replies.forEach(function (reply, i) 
//     {
//      	r.get(reply, function(err, item) 
//      	{
// 	    	var v = JSON.parse(item);
// 	    	console.log(v.text);
//     	});
// 	});

// 	r.quit();
// });

// iterate users timeline
//
iterateTimeline();


