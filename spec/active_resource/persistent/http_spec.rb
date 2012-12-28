require 'spec_helper'

describe ActiveResource::Persistent::HTTP do
  describe "class" do
    subject { described_class }
    its(:superclass) { should == Net::HTTP::Persistent }
  end

  describe "instance" do
    let(:site)  { URI.parse('http://site.example.com:3000') }
    let(:proxy)  { URI.parse('http://proxy.example.com:8080') }

    subject { described_class.new(site, proxy) }

    it "should have site" do
      subject.site.should == site
    end

    it "should have proxy_uri" do
      subject.proxy_uri.should == proxy
    end
  end

  context "request methods" do
    let(:site) { TestServer.uri }
    let(:instance) { described_class.new(site, nil) }

    let(:path) { '/inspect/all?key=value' }
    let(:body) { 'HELLO WORLD' }
    let(:headers) { { 'X-AUTHORIZATION' => 'qwerty' } }

    it "should HEAD data" do
      @response = instance.head(path, headers)

      @response.should be_instance_of(Net::HTTPOK)
      @response.body.should be_nil
    end

    it "should GET data" do
      @response = instance.get(path, headers)

      expect_response('GET', nil)
    end

    it "should DELETE data" do
      @response = instance.delete(path, headers)

      expect_response('DELETE', nil)
    end

    it "should POST data" do
      @response = instance.post(path, body, headers)

      expect_response('POST', body)
    end

    it "should PUT data" do
      @response = instance.put(path, body, headers)

      expect_response('PUT', body)
    end

    protected

    def expect_response(request_method, payload)
      @response.should be_instance_of(Net::HTTPOK)

      body = YAML.load(@response.body)

      body['REQUEST_METHOD'].should == request_method
      body['REQUEST_URI'].should == path
      body['HTTP_X_AUTHORIZATION'].should == 'qwerty'
      body['rack.input'].should == payload
    end

  end



  context "ActiveResource ssl options support" do
    let(:site) { URI.parse("https://127.0.0.1:2000") }
    let(:instance) { described_class.new(site, nil) }

    it "should support use_ssl for https scheme" do
      instance = described_class.new(URI.parse("https://127.0.0.1:2000"), nil)
      expect { instance.use_ssl = true }.to_not raise_error {ArgumentError}
    end

    it "should NOT support use_ssl for http scheme" do
      instance = described_class.new(URI.parse("http://127.0.0.1:2000"), nil)
      expect { instance.use_ssl = true }.to raise_error {ArgumentError}
    end

    it "should support verify_mode option" do
      instance.verify_mode.should_not == OpenSSL::SSL::VERIFY_NONE
      instance.verify_mode = OpenSSL::SSL::VERIFY_NONE
      instance.verify_mode.should == OpenSSL::SSL::VERIFY_NONE
    end

    it "should support verify_callback option" do
      instance.verify_callback = "call_me_back"
      instance.verify_callback.should == "call_me_back"
    end


    it "should support ca_file option" do
      instance.ca_file = "/tmp/ca.crt"
      instance.ca_file.should == "/tmp/ca.crt"
    end

    it "should support cert option" do
      instance.cert = "/tmp/some.crt"
      instance.cert.should == "/tmp/some.crt"
    end

    it "should support key option" do
      instance.key = "/tmp/some.key"
      instance.key.should == "/tmp/some.key"
    end

    it "should support cert_store option" do
      instance.cert_store = "/tmp/some_cert_store"
      instance.cert_store.should == "/tmp/some_cert_store"
    end

    it "should NOT support verify_depth option" do
      expect { instance.verify_depth = 5 }.to raise_error { NoMethodError}
    end

    it "should NOT support ca_path option" do
      expect { instance.ca_path = "/tmp/ca_path" }.to raise_error { NoMethodError }
    end

    it "should NOT support ssl_timeout option" do
      expect { instance.ssl_timeout = 10 }.to raise_error { NoMethodError }
    end
  end

end
