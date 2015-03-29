# citibike-station-history

Grab a copy of the [NYC Citibike `stations.json`](https://member.citibikenyc.com/data/stations.json) file every 10 minutes and save it to S3.

The list of snapshots is here: [https://citibike-station-history.s3.amazonaws.com/snapshots.json](https://citibike-station-history.s3.amazonaws.com/snapshots.json)

This runs on Heroku under the scheduler addon. Needless to say.

To run this, you should (TK TK TK check this!) need Ruby 2.2.1 (I use rbenv), `bundle install`, make an S3 bucket and fill in `.env`, then `bundle exec rake download`. There is no web component (yet!)

The .env file looks like:

	S3_BUCKET=(your bucket)
	S3_ACCESS_KEY=(your key)
	S3_SECRET_KEY=(your secret)