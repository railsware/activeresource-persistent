require 'socket'
require 'posix/spawn'

module TestServer
  extend self

  def host
    'localhost'
  end

  def port
    9292
  end

  def uri
    URI.parse("http://#{host}:#{port}")
  end

  def pid
    @pid
  end

  def start
    @pid = POSIX::Spawn.spawn("passenger start --port #{port}", :out => 'test_server.output')
    sleep(5)
  end

  def stop
    Process.kill("TERM", pid) if pid
  end

  protected

  def find_available_port
    server = TCPServer.new('127.0.0.1', '9292')
    server.addr[1]
  ensure
    server.close if server
  end
end
