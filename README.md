# SimpleCrawler

This is a simple crawler app

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'SimpleCrawler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install SimpleCrawler

## Usage

./bin/simple_crawler www.yourwebsite.com

mapper = SimpleCrawler::Mapper.new "www.yourwebsite.com", false

With subdomains:

mapper = SimpleCrawler::Mapper.new "www.yourwebsite.com", true

mapper.crawl

mapper.data_issuer(:asset_printer, './map.asset_printer')

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Design decisions
  This crawler makes use of the Mapper class that acts like an interface for the other crawler objects. Crawler is constituted 
  by 4 main classes, Page, contains  all the logic of what "can be searched", PageProcessor that has the logic of "how can it be searched", Map, where it saves 
  its data and Config that stores global configurations. 
  The presentation layer on this library is handled by the "issuers", they are responsible to 
  write the "Map" data on files.
  
  TODO:  
  Modify Mapper class to permit crawl method to launch multiples threads. 
  There are some validations out of normalizer
  

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

