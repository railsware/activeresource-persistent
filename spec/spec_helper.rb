Bundler.setup

require 'active_resource/persistent'

Dir["spec/support/**/*.rb"].each { |f| load f }

RSpec.configure do |config|
  config.before(:suite) do
    TestServer.start

    TestUser.site = TestServer.uri
    TestPost.site = TestServer.uri
  end 

  config.before(:each) do
    TestIPC.clear
  end 

  config.after(:suite) do
    TestServer.stop
  end
end
