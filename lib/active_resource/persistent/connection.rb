require 'active_resource/connection'

module ActiveResource
  class Connection

    protected

    def new_http
      ActiveResource::Persistent::HTTP.new(site, proxy)
    end
  end
end
