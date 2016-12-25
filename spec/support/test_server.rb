require 'socket'
require 'posix/spawn'

module TestServer
  extend self

  def host
    'localhost'
  end

  def port
    9299
  end

  def uri
    URI.parse("http://#{host}:#{port}")
  end

  def pid
    @pid
  end

  def start
    @pid = POSIX::Spawn.spawn("passenger start --port #{port}", out: 'test_server.output')
    sleep 10
  end

  def stop
    Process.kill("TERM", pid) if pid
  end

end
