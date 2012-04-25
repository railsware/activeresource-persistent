require 'spec_helper'

describe ActiveResource::Connection do
  let(:site) { TestServer.uri }

  let(:instance) { described_class.new(site) }
  
  describe "#http" do
    subject { instance.send(:http) }
    it "should be persistent" do
      subject.should be_instance_of(ActiveResource::Persistent::HTTP)
      subject.site.should == site
    end
  end

  context "request methods" do
    let(:path) { '/inspect' }
    let(:body) { 'HELLO WORLD' }
    let(:headers) { { 'X_Header' => 'x_value' } }
    let(:http_mock) { mock('HTTP MOCK') }
    let(:response_mock) { mock('RESPONSE MOCK', :code => '200') }

    describe "#head" do
      it "should use ActiveResource::Persistent::HTTP#head" do
        expected_headers = headers.update('Accept' => 'application/json')
        instance.should_receive(:http).and_return(http_mock)
        http_mock.should_receive(:head).with(path, expected_headers).and_return(response_mock)

        instance.head(path, headers)
      end
    end

    describe "#get" do
      it "should use ActiveResource::Persistent::HTTP#get" do
        expected_headers = headers.update('Accept' => 'application/json')
        instance.should_receive(:http).and_return(http_mock)
        http_mock.should_receive(:get).with(path, expected_headers).and_return(response_mock)

        instance.get(path, headers)
      end
    end

    describe "#delete" do
      it "should use ActiveResource::Persistent::HTTP#delete" do
        expected_headers = headers.update('Accept' => 'application/json')
        instance.should_receive(:http).and_return(http_mock)
        http_mock.should_receive(:delete).with(path, expected_headers).and_return(response_mock)

        instance.delete(path, headers)
      end
    end

    describe "#post" do
      it "should use ActiveResource::Persistent::HTTP#post" do
        expected_headers = headers.update('Content-Type' => 'application/json')
        instance.should_receive(:http).and_return(http_mock)
        http_mock.should_receive(:post).with(path, body, expected_headers).and_return(response_mock)

        instance.post(path, body, headers)
      end
    end

    describe "#put" do
      it "should use ActiveResource::Persistent::HTTP#put" do
        expected_headers = headers.update('Content-Type' => 'application/json')
        instance.should_receive(:http).and_return(http_mock)
        http_mock.should_receive(:put).with(path, body, expected_headers).and_return(response_mock)

        instance.put(path, body, headers)
      end
    end
  end

end
