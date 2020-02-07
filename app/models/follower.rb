class Follower
    attr_reader :handle, :url

    def initialize(info)
        @handle = info[:login]
        @url = info[:html_url]
    end
  end
