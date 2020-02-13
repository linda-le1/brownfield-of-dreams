class GithubService
  def initialize(github_token)
    @github_token = github_token
  end

  def get_repos
    get_json('/user/repos?page=1&per_page=5&affiliation=owner')
  end

  def get_followers
    get_json('/user/followers')
  end

  def get_following
    get_json('/user/following')
  end

  def user_exists?(handle)
    status = response("/users/#{handle}").status

    if status == 200
      true
    elsif status == 404
      false
    end
  end

  def get_user(handle)
    get_json("/users/#{handle}")
  end

  private

  def conn
    connection = Faraday.new(url: 'https://api.github.com/') do |faraday|
      faraday.headers['Authorization'] = "token #{@github_token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def response(url)
    conn.get(url)
  end

  def get_json(url)
    JSON.parse(response(url).body, symbolize_names: true)
  end
end
