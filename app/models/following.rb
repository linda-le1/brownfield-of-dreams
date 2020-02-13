class Following
  attr_reader :handle, :url, :uid

  def initialize(info)
    @handle = info[:login]
    @url = info[:html_url]
    @uid = info[:id]
  end

  def app_user?
    User.exists?(uid: @uid)
  end
end
