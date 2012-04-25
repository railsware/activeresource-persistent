require 'active_resource/connection'

module ActiveResource
  class Connection

    protected

    def new_http_with_persistent
      ActiveResource::Persistent::HTTP.new(site, proxy)
    end

    alias_method :new_http_without_persistent, :new_http
    alias_method :new_http, :new_http_with_persistent
  end
end
