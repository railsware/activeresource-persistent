require 'active_resource'

class TestUser < ActiveResource::Base
  self.element_name = 'user'
  self.format = :json
end

class TestPost < ActiveResource::Base
  self.element_name = 'post'
  self.format = :json
end
