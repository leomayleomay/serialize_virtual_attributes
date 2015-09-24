# SerializeVirtualAttributes

Dump/Reload the specified virtual attributes into/from serialized
column, which is basically doing the same thing with
http://api.rubyonrails.org/classes/ActiveRecord/Store.html

## Installation

Add this line to your application's Gemfile:

    gem 'serialize_virtual_attributes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serialize_virtual_attributes

## Usage

```ruby
class Person < ActiveRecord::Base
  serialize :fullname, Hash

  serialize_virtual_attrs :first_name, :last_name, to: fullname
end

person = Person.create(first_name: "Hao", last_name: "Liu")

person.reload

person.first_name # "Hao"
person.last_name # "Liu"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
