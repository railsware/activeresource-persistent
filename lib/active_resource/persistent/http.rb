require 'net/http/persistent'

module ActiveResource
  module Persistent
    class HTTP < Net::HTTP::Persistent
      def initialize(site, proxy)
        super('active_resource', proxy)
        @site = site
      end

      attr_reader :site

      def get(path, headers)
        req = Net::HTTP::Get.new(path, headers)
        request(@site, req)
      end

      def post(path, data, headers)
        req = Net::HTTP::Post.new(path, headers)
        req.body = data
        request(@site, req)
      end

      def put(path, data, headers)
        req = Net::HTTP::Put.new(path, headers)
        req.body = data
        request(@site, req)
      end

      def delete(path, headers)
        req = Net::HTTP::Delete.new(path, headers)
        request(@site, req)
      end

      def head(path, headers)
        req = Net::HTTP::Head.new(path, headers)
        request(@site, req)
      end

      ##
      # SSL support
      #

      def use_ssl=(value)
        expected_scheme = value ? 'https' : 'http'
        site.scheme == expected_scheme or
          raise ArgumentError, "Site scheme should be #{expected_scheme.inspect}"
      end

    end
  end
end
