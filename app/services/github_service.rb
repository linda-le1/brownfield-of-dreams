class GithubService
  def get_repos
    conn = Faraday.new(url: "https://api.github.com/")
    github_token = ENV["GITHUB_TOKEN"] # variable above would replace this
    conn.basic_auth(nil, github_token)
    response = conn.get("/user/repos?page=1&per_page=5")
    repos = JSON.parse(response.body, symbolize_names: true)
  end
end
