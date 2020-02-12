class UserDashboardFacade
  attr_reader :token

  def initialize(user)
    @user = user
    @token = user.github_token
  end

  def first_name
    @user.first_name
  end

  def first_and_last_name
    "#{@user.first_name} #{@user.last_name}"
  end

  def email
    @user.email
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

  def has_bookmarks?
    !@user.user_videos.empty?
  end

  def bookmarks
    UserVideo.video_titles(@user.id)

  end 
end
