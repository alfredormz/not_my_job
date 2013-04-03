# (That's) Not My Job

Also known as EmpleadoPublico ;) provides a delegate class method to easily expose contained object's methods as your own.

## Installation

Add this line to your application's Gemfile:
```
gem 'not_my_job'
```
And then execute:
```
$ bundle install
```
Or install it yourself as:
```
$ gem install not_my_job
```

## Usage
```
  delegate(*methods, to: target [, with_prefix: true|false ]) { block } → obj
```
In order to access the delegate object's methods, NotMyJob creates instance methods for each one specified method.

If the delegate object is nil, there are several options: If no block is provided, it will raise an NoMethodError exception; if the optional code block is specified, then that will be run and its result returned.

## Examples

Simple delegation:
```ruby
class Cuisine
  attr_accessor :name, :chef
  
  def initialize(name, chef)
    @name = name
    @chef = chef
  end
end

class Restaurant
  extend NotMyJob
  
  delegate :name, to: :cuisine
  delegate :chef, to: :cuisine, with_prefix: false
  
  def initialize(cuisine)
    @cuisine = cuisine
  end
end

cuisine    = Cuisine.new("Italian", "Mario") 
restaurant = Restauran.new(cuisine)

restaurant.cuisine_name #=> "Italian"
restaurant.chef         #=> "Mario"
```

Multiple methods delegation:
```ruby
class Restaurant
  extend NotMyJob
  delegate :name, :chef to: :cuisine
end

restaurant.cuisine_name #=> "Italian"
restaurant.cuisine_chef #=> "Mario"
```

ActiveRecord Associations:
```ruby
class Restaurant < ActiveRecord::Base
  extend NotMyJob
  
  belongs_to :place
  delegate :name, to: :place
end
restaurant.place_name #=> "Argentina"
```

If the delegate object is nil and a block is specified:
```ruby
class Restaurant
  extend NotMyJob
  
  delegate :name, to: :category do
    logger.debug "Category is nil"
    send_notification_email
    "No category has been assigned to this restaurant"
  end
end
restaurant.category_name #=> "No category has been assigned to this restaurant"
```
