# BeforeFilters

BeforeFilters is inspired both by ActiveRecord's use of callbacks as well as the following gist: [**https://gist.github.com/ryanlecompte/1283413**]() written by [**Ryan LeCompte**](https://github.com/ryanlecompte). His gist was used as the basis, but it was extended to allow an array of methods to be passed in as a list for the before_filter method to precursor.

The main use of this gem is for projects that do not include ActiveRecord, such as a Sinatra app, other gems, or internal ruby scripts.

## Installation

Add this line to your application's Gemfile:

    gem 'before_filters'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install before_filters

## Usage

After installing the gem, add it as a require to the ruby script you want to use it in.

`my_class.rb`

```ruby
require "before_filters"
class MyClass
  extend BeforeFilters
      
  attr_accessor :first_name
  attr_accessor :last_name
      
  # first arg is method to be called, second is array of methods that will have the before_filter ran
  # prior to calling the first arg
      
  before_filter :set_first_name, :only => [:set_last_name]
      
  def name
    "#{self.first_name} #{self.last_name}"
  end
      
  def set_last_name(last_name = nil)
    puts "original method"
    self.last_name = last_name
  end
      
  def set_first_name
    puts "called during before_filter"
    self.first_name = "First"
  end
end
```
	
Output shown from a pry session.

```ruby
$ pry
[1] pry(main)> require "before_filters"
=> true
[2] pry(main)> class TestClass
[2] pry(main)*
[2] pry(main)*   extend BeforeFilters
[2] pry(main)*
[2] pry(main)*   attr_accessor :first_name
[2] pry(main)*   attr_accessor :last_name
[2] pry(main)*
[2] pry(main)*   # first arg is method to be called, second is array of methods that will have the before_filter ran
[2] pry(main)*   # prior to calling the first arg
[2] pry(main)*   before_filter :set_first_name, :only => [:set_last_name]
[2] pry(main)*
[2] pry(main)*   def name
[2] pry(main)*     "#{self.first_name} #{self.last_name}"
[2] pry(main)*   end
[2] pry(main)*
[2] pry(main)*   def set_last_name(last_name = nil)
[2] pry(main)*     puts "original method"
[2] pry(main)*     self.last_name = last_name
[2] pry(main)*   end
[2] pry(main)*
[2] pry(main)*   def set_first_name
[2] pry(main)*     puts "called during before_filter"
[2] pry(main)*     self.first_name = "First"
[2] pry(main)*   end
[2] pry(main)*
[2] pry(main)* end
=> :set_first_name
[3] pry(main)> test = TestClass.new
=> #<TestClass:0x0000010189d968>
[4] pry(main)> test.set_last_name("Last")
called during before_filter
original method
=> "Last"
[5] pry(main)> test.name        
=> "First Last"
```    
## TODO:
- add support for :except => on before_filters

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
