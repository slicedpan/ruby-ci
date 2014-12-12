class GithubAccount < ActiveRecord::Base
  def client
    Octokit::Client.new(:access_token => self.access_token || '')
  end

  def authorized?
    begin 
      client.user
    rescue Octokit::Unauthorized => e
      return false
    end
    true
  end

end
