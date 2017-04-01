# Cognitivebing

A gem for the new Bing Web Search API from Microsoft cognitive services.

https://www.microsoft.com/cognitive-services/en-us/apis


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cognitivebing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cognitivebing

## Usage
```ruby
require 'cognitivebing'

bing = CognitiveBing.new(account_key)
#call with params
bing = CognitiveBing.new(account_key, :mkt => "en-US", :count => 10, :offset => 0, :safesearch => "Moderate")
```

(to see params details : https://dev.cognitive.microsoft.com/docs/services/56b43eeccf5ff8098cef3807/operations/56b4447dcf5ff8098cef380d)
```ruby
#web search
result_set = bing.search(search_term)
#Image search
result_set = bing.search(search_term, 'image')
#Video search
result_set = bing.search(search_term, 'videos')
#Suggestion search
result_set = bing.suggestions(search_term)
#News search
bing = CognitiveBingNews.new(account_key)
result_set = bing.search(search_term)
#News trending 
result_set = bing.trending
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cognitivebing. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](./CODE_OF_CONDUCT.md) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

