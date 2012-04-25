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
end
