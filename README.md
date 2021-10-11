# SimpleCov::Review

SimpleCov formatter to generate missing lines errors for reporting tools
like [reviewdog](https://github.com/reviewdog/reviewdog). It creates `coverage/review.txt` file containing uncovered
lines in a format that can be easily used with reviewdog. 

Example:

```
app/controllers/admin/companies_controller.rb:16:1: Missing coverage for line 16
app/controllers/admin/company_owners_controller.rb:17:1: Missing coverage for line 17
```

## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'simplecov-review', require: false
end
```

And then execute:

    $ bundle install

## Usage

Require the library in your `spec_helper.rb` and set it as your SimpleCov formatter:

```ruby
require 'simplecov'
require 'simplecov-review'

SimpleCov.start do
  formatter SimpleCov::Formatter::ReviewFormatter
end
```

### Reviewdog integration

Since in your workflow rspec will be executed before reviewdog, make sure to disable minimum coverage check in
SimpleCov.

To keep minimum coverage checks take a look at my other
library [simplecov-report-check-action](https://github.com/kukicola/simplecov-report-check-action), which makes it super
easy to report coverage percentage using GitHub Checks API.

To report uncovered lines with reviewdog, add following lines to `.reviewdog.yml`:

```yaml
runner:
  # other checks
  coverage:
    cmd: cat coverage/review.txt
    level: warning
    errorformat:
      - "%f:%l:%c: %m"
```

If you require 100% line coverage in your project change `level` value to `error`.

## Roadmap
* add branch coverage support

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kukicola/simplecov-review.
