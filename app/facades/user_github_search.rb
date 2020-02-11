class UserGithubSearch
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

  def followers
    return @followers if @followers

    service = GithubService.new(@token)
    @followers = service.get_followers.map do |follower|
      Follower.new(follower)
    end
  end

  def following
    return @following if @following
    
    service = GithubService.new(@token)
    @following = service.get_following.map do |following|
      Following.new(following)
    end
  end

  def find_handle(friend)
    following.find { |following| following.uid == friend.uid }.handle
  end
end
