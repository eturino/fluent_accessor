# FluentAccessors

Adds class method `fluent_accessor` which will create several methods to enable fluent API access to the instance variables.

[![Gem Version](https://badge.fury.io/rb/fluent_accessors.svg)](http://badge.fury.io/rb/fluent_accessors)
[![Build Status](https://travis-ci.org/eturino/fluent_accessors.svg?branch=master)](https://travis-ci.org/eturino/fluent_accessors)
[![Code Climate](https://codeclimate.com/github/eturino/fluent_accessors.png)](https://codeclimate.com/github/eturino/fluent_accessors)
[![Code Climate Coverage](https://codeclimate.com/github/eturino/fluent_accessors/coverage.png)](https://codeclimate.com/github/eturino/fluent_accessors)

## Dependencies

it requires Ruby 2, since it uses keyword arguments

## Installation

Add this line to your application's Gemfile:

    gem 'fluent_accessors'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent_accessors

## Usage

### Basic usage

```ruby
class TestKlass
  extend FluentAccessors
  fluent_accessor :something
end

x = TestKlass.new

# normal setter
x.something = 1

# normal getter
x.something # => 1

# fluent setter method
x.set_something 2 # returns self
x.something # => 2

# using getter with argument => fluent method
x.something 3 # returns self
x.something # => 3
```

### fluent method

the Fluent method (getter with an argument) will:

1. always return `self`
2. it will *not* set the value directly:
  1. if the object responds to a `set_myproperty` method, it will call that and assume that it will
  2. if the object does not respond to a `set_myproperty` method, it will call the normal setter `myproperty=`
  3. if the object does not respond to a `set_myproperty` nor `myproperty=` methods, it will set the property directly.

### avoiding set_something method

if you don't want the `set_something` method, you can specify not to create it.

```ruby
class TestKlass
  extend FluentAccessors
  fluent_accessor :something, set_method: false
end

x = TestKlass.new
s.respond_to? :set_method # => false
```

### avoiding creating the writer method

if you don't want the `something=` method, you can specify not to create it.

```ruby
class TestKlass
  extend FluentAccessors
  fluent_accessor :something, writer_method: false
end

x = TestKlass.new
s.respond_to? :something= # => false
```


## Contributing

1. Fork it ( https://github.com/eturino/fluent_accessors/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
