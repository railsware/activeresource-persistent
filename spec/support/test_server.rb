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
    @pid = POSIX::Spawn.spawn("passenger start --port #{port}", out: output_file)
    sleep 5
  end

  def stop
    Process.kill("TERM", pid) if pid
  end

  def print_output
    puts "\n\n"
    File.readlines(output_file).each do |line|
      puts line
    end
  end

  def output_file
    'test_server.output'
  end

end
