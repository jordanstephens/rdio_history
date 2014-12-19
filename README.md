# RdioHistory

A ruby gem for fetching Rdio listening history.

## Origins

_All of the code in this project borrows **HEAVILY** from some scripts at [chanian/rdio-history](https://github.com/chanian/rdio-history) posted over two years ago_. The interface exposed by those scripts was too limiting in my opinion. In the process of trying to patch a fork of that repo, I decided that the changes I wanted to make were too major. I opted to create a new gem, which includes a lot of code from [chanian/rdio-history](https://github.com/chanian/rdio-history), but is heavily refactored and exposes a much more open and flexible interface. **Major thanks and credit to [@chanian](https://github.com/chanian) for paving the way!**

I'll also post the same disclaimer found at [@chanian](https://github.com/chanian) below.

## Disclaimer

> I used this script to collect my personal listening history for a dataviz project. While there is an existing REST API which auths over oauth, the history end point is not available at this time. This script fetches tokens from the web client, then re-uses the session tokens to authenticate and hit the existing history API endpoint.

> Please use at own risk.

> Rdio peeps, just let me know if this is a problem, I'll happily take this library down.

I will likewise adhere to the final line in the quote above at Rdio's request, so again: **Use at your own risk, this is an interface to an undocumented API, and it may be unstable or it may disappear at any time.**

## Installation

This gem is currently not distributed via rubygems, but you can include in your Gemfile by way of Github.

```ruby
gem "rdio_history", github: "jordanstephens/rdio_history"
```

## Usage

Fetching history is easy, all you need is your Rdio username, and the number of *sources* you want to fetch. Rdio differentiates between a *source* and a *track*, as far as I can tell, a source is a group of tracks that were listened to together, like an album. It is important to note that the number of items you are requesting is not the number of *tracks*, but the number of *sources*. In the example below, that number is `10`.

    history = RdioHistory.fetch("your_rdio_username", 10)
    
To get a list of sources in the response set:

    history.sources
    
A source looks like this:
    
    {
        "extraTrackTimes": [],
        "source": {
            "baseIcon": "album/d/a/8/00000000000958ad/square-200.jpg",
            "releaseDate": "2006-07-25",
            "displayDate": "Jul 25, 2006",
            "duration": 2992,
            "isClean": false,
            "shortUrl": "http://rd.io/x/Qj5LB-4/",
            "canStream": true,
            "embedUrl": "https://rd.io/e/Qj5LB-4/",
            "type": "a",
            "price": "None",
            "track_ids": [7348856, 7348859, 7348862, 7348864, 7348867, 7348869, 7348872, 7348875, 7348878, 7348879, 7348880],
            "key": "a612525",
            "icon": "http://img00.cdn2-rdio.com/album/d/a/8/00000000000958ad/square-200.jpg",
            "canSample": true,
            "name": "WWI",
            "isExplicit": false,
            "artist": "White Whale",
            "url": "/artist/White_Whale/album/WWI/",
            "artistKey": "r706568",
            "length": 11,
            "trackKeys": ["t7348856", "t7348859", "t7348862", "t7348864", "t7348867", "t7348869", "t7348872", "t7348875", "t7348878", "t7348879", "t7348880"],
            "canTether": true,
            "artistUrl": "/artist/White_Whale/"
        },
        "tracks": [{
            "track": {
                "key": "t7348856",
                "baseIcon": "album/d/a/8/00000000000958ad/square-200.jpg",
                "canDownloadAlbumOnly": false,
                "radio": {
                    "type": "sr",
                    "key": "sr7348856"
                },
                "artistUrl": "/artist/White_Whale/",
                "duration": 252,
                "album": "WWI",
                "isClean": false,
                "albumUrl": "/artist/White_Whale/album/WWI/",
                "shortUrl": "http://rd.io/x/QisyfTs/",
                "albumArtist": "White Whale",
                "canStream": true,
                "embedUrl": "https://rd.io/e/QisyfTs/",
                "type": "t",
                "gridIcon": "http://rdiodynimages2-a.akamaihd.net/?l=a612525-0%3Aboxblur%2810%25%2C10%25%29%3Ba612525-0%3Aprimary%280.65%29%3B%240%3Aoverlay%28%241%29%3Ba612525-0%3Apad%2850%25%29%3B%242%3Aoverlay%28%243%29",
                "price": "None",
                "trackNum": 1,
                "albumArtistKey": "r706568",
                "radioKey": "sr7348856",
                "icon": "http://img00.cdn2-rdio.com/album/d/a/8/00000000000958ad/square-200.jpg",
                "canSample": true,
                "name": "Nine Good Fingers",
                "isExplicit": false,
                "artist": "White Whale",
                "url": "/artist/White_Whale/album/WWI/track/Nine_Good_Fingers/",
                "icon400": "http://img02.cdn2-rdio.com/album/d/a/8/00000000000958ad/square-400.jpg",
                "artistKey": "r706568",
                "canDownload": false,
                "length": 1,
                "canTether": true,
                "albumKey": "a612525"
            },
            "time": "2014-12-18T23:06:24.277000"
        }],
        "extraTrackKeys": [],
        "time": "2014-12-18T23:06:24.277000
    }

    
To get a list of tracks in the response set:
    
    history.tracks
    
A track looks like this:

    {
        "track": {
            "key": "t7348856",
            "baseIcon": "album/d/a/8/00000000000958ad/square-200.jpg",
            "canDownloadAlbumOnly": false,
            "radio": {
                "type": "sr",
                "key": "sr7348856"
            },
            "artistUrl": "/artist/White_Whale/",
            "duration": 252,
            "album": "WWI",
            "isClean": false,
            "albumUrl": "/artist/White_Whale/album/WWI/",
            "shortUrl": "http://rd.io/x/QisyfTs/",
            "albumArtist": "White Whale",
            "canStream": true,
            "embedUrl": "https://rd.io/e/QisyfTs/",
            "type": "t",
            "gridIcon": "http://rdiodynimages2-a.akamaihd.net/?l=a612525-0%3Aboxblur%2810%25%2C10%25%29%3Ba612525-0%3Aprimary%280.65%29%3B%240%3Aoverlay%28%241%29%3Ba612525-0%3Apad%2850%25%29%3B%242%3Aoverlay%28%243%29",
            "price": "None",
            "trackNum": 1,
            "albumArtistKey": "r706568",
            "radioKey": "sr7348856",
            "icon": "http://img00.cdn2-rdio.com/album/d/a/8/00000000000958ad/square-200.jpg",
            "canSample": true,
            "name": "Nine Good Fingers",
            "isExplicit": false,
            "artist": "White Whale",
            "url": "/artist/White_Whale/album/WWI/track/Nine_Good_Fingers/",
            "icon400": "http://img02.cdn2-rdio.com/album/d/a/8/00000000000958ad/square-400.jpg",
            "artistKey": "r706568",
            "canDownload": false,
            "length": 1,
            "canTether": true,
            "albumKey": "a612525"
        },
        "time": "2014-12-18T23:06:24.277000"
    }

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rdio_history/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
