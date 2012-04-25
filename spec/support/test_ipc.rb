module TestIPC
  extend self

  def filename
    @filename = File.expand_path('../../../tmp/test_ipc.text', __FILE__)
  end

  def clear
    File.delete(filename) if File.exists?(filename)
  end

  def push(data)
    File.open(filename, "a+") { |f| f.puts(data) }
  end

  def pull
    File.exists?(filename) ? File.read(filename).split("\n") : []
  end
end
