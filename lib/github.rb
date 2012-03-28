class Github
  include HTTParty
  base_uri 'https://api.github.com'

  def initialize(token)
    self.class.default_params :access_token => token, :per_page => 100
  end

  def organizations
    self.class.get('/user/orgs')
  end

  def user_repos
    self.class.get('/user/repos')
  end

  def org_repos
    organizations.collect {|org|
      self.class.get("/orgs/#{org['login']}/repos")
    }.flatten
  end

  def repos
    Hash[(user_repos + org_repos).collect{|r| [r['name'],r['html_url']] }]
  end

end