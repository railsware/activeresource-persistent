module TestHelper
  extend self

  def log_request(env)
    data = [
      env['REMOTE_PORT'],
      env['REQUEST_METHOD'],
      env['REQUEST_URI']
    ].join('|') 

    TestIPC.push(data)
  end

  def logged_requests
    TestIPC.pull.map { |line| line.split('|') }
  end

  def persistent_requests_logged?
    logged_requests.map { |line| line[0] }.uniq.size == 1
  end

end
