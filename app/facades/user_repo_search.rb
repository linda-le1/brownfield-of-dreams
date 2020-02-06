class UserRepoSearch
  def initialize(token)
    @token = token
  end
  
  def repos
    return @repos if @repos
    service = GithubService.new(@token)
    @repos = service.get_repos.map do |repo|
      Repository.new(repo)
    end
  end
end
