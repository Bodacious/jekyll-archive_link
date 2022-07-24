# Jekyll::ArchiveLink

Adds [InternetArchive Wayback Machine](https://archive.org) links for a given URL. Useful for preserving access to content on other sites that you do not control.

## Installation

Add this line to your application's Gemfile:

```ruby
group :jekyll_plugins do
  gem 'jekyll-archive_link'
end
```

Install via `$ bundle install`.

And then add this line to your Jekyll config file:

``` yaml
plugins:
  - jekyll-archive_link
```


## Usage

To add an archive link to your Jekyll pages, embed the following view tag:

``` liquid
{% archive_url_link %}
  {{ page.content_url }} <!-- Whatever attribute you use to define URLs -->
{% endarchive_url_link %}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bodacious/jekyll-archive_link.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
