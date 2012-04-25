require 'active_resource'

class TestUser < ActiveResource::Base
  self.element_name = 'user'
end

class TestPost < ActiveResource::Base
  self.element_name = 'post'
end
