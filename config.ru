Dir["spec/support/**/*.rb"].each { |f| load f }
run TestApplication.new
