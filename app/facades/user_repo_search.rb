class UserRepoSearch
  def repos
    return @repos if @repos
    service = GithubService.new
    @repos = service.get_repos.map do |repo|
      Repository.new(repo)
    end
  end
end
