# Gates

[![Build
Status](https://travis-ci.org/phillbaker/gates.png?branch=master)](https://travis-ci.org/phillbaker/gates)

This is an implementation of the ideas expressed in this post about Stripe's public API versioning, [Move fast, don't break your API](http://amberonrails.com/move-fast-dont-break-your-api/). The goal is to separate layers of request and response compatibility from the API logic, with two important drivers:
 * let your customers migrate API versions at their convenience, minimize the pain of upgrades when they do upgrade.
 * make it feasible to fix backward incompatible API schema mistakes (they will happen).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gates'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gates

## Usage

Check for whether a gate is enabled:

```ruby
version = request.api_version || user.api_version
version = Gates.for(version)
version.enabled?(:foo) # => true / false

Gates.available_versions # => [<Gates::ApiVersion ...>]
```

In CI make sure to lint the version manifest:

```ruby
rake gates:lint
```

This can be combined with A/B testing or feature flipping like:

```ruby
def foo
  return unless feature_enabled?(user, :foo) || ab_test?(:foo) || version.enabled?(:foo)

  "foo"
end
```

```yaml
----
versions:
  -
    id: 2016-01-30-1
    gates:
      -
        name: reallows_amount
        description: |
          Just kidding. Sending amount is supported for some folks.
  -
    id: 2016-01-30
    gates:
      -
        name: disallows_amount
        description: |
          Sending amount is now deprecated.
  -
    id: 2016-01-20
    gates:
      -
        name: allows_amount
        description: |
          Sending amount is supported.
```

### Testing

Make sure to test both paths in order to not break compatibility!

## Similar projects

* [multiverse in Elixir](https://github.com/Nebo15/multiverse)

## Contributing

1. Fork it ( https://github.com/phillbaker/gates/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
