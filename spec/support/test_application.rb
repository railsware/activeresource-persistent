require 'yaml'
require 'sinatra'
require 'multi_json'

class TestApplication < Sinatra::Base
  before do
    TestHelper.log_request(env)
  end

  #
  # User resources
  #

  get '/users/:id.json' do
    id = params[:id]
    data_halt({
      'id'       => id,
      'username' => "jack_#{id}",
      'remote_port' => env['REMOTE_PORT']
    })
  end

  get '/users.json' do
    data_halt([
      {
        'id'       => 1,
        'username' => "alice",
        'remote_port' => env['REMOTE_PORT']
      },
      {
        'id'       => 2,
        'username' => "bob",
        'remote_port' => env['REMOTE_PORT']
      }
    ])
  end

  post '/users.json' do
    user = MultiJson.load(request.body)

    id = Time.now.to_i

    halt 202, { 'Location' => "/users/#{id}" }, ''
  end

  put '/users/:id.json' do
    id = params[:id]
    user = MultiJson.load(request.body)
    data_halt(user)
  end

  delete '/users/:id.json' do
    id = params[:id]
    halt 200
  end

  #
  # Post resources
  # 

  get '/posts/:id.json' do
    id = params[:id]

    data_halt({
      'id'    => id,
      'title' => "hello_world_#{id}",
      'remote_port' => env['REMOTE_PORT']
    })
  end

  put '/posts/:id.json' do
    id = params[:id]
    post = MultiJson.load(request.body)
    data_halt(post)
  end

  post '/posts.json' do
    post = MultiJson.load(request.body)

    id = Time.now.to_i

    halt 202, { 'Location' => "/posts/#{id}" }, ''
  end

  delete '/posts/:id.json' do
    id = params[:id]
    halt 200
  end

  #
  # Inspect other requests
  #
  head   '/*' do nil end
  get    '/*' do env_halt end
  delete '/*' do env_halt end
  post   '/*' do env_halt end
  put    '/*' do env_halt end

  protected

  def data_halt(data, status = 200)
    content_type :json
    body MultiJson.dump(data)
    halt status
  end

  def env_halt
    payload = {}

    env.sort.each do |key, value|
      case key
      when 'rack.input'
        while line = value.gets
          data ||= ""
          data << line
        end
        payload[key] = data
      when /^rack\./
      else
        payload[key] = value
      end
    end

    content_type :text
    body YAML.dump(payload)
    halt 200
  end
end
