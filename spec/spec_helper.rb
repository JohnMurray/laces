
##
## Setup some basic stuff:
##  - require files
##  - setup some helper methods
##  - load modules
##  - etc.
##

require 'rspec'

$: << ::File.expand_path('../../src', __FILE__)
require 'laces'


class Class
  def publicize_methods
    saved_private_instance_methods = self.private_instance_methods
    self.class_eval { public *saved_private_instance_methods }
    yield
    self.class_eval { private *saved_private_instance_methods }
  end
end


RSpec.configure do |c|
    include Laces
end
