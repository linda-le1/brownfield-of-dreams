class GithubService
  def get_repos
    get_json("/user/repos?page=1&per_page=5")
  end

  private
    def conn
      connection = Faraday.new(url: "https://api.github.com/")
      github_token = ENV["GITHUB_TOKEN"]
      connection.basic_auth(nil, github_token)
      connection
    end

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end
