module TestRunner
  TEST_DIR = Rails.root.join('tmp', 'test_runs')

  def run_tests    

  end

  def git_object
    @git ||= begin
      client = self.repo.github_account.client
      branch_info = client.branch(self.repo.github_name, self.name)
      dir = TEST_DIR.join("#{self.repo.name}-#{self.name}")
      FileUtils.mkdir_p(dir.to_s)
      begin
        Git.open(dir.to_s, :log => Logger.new(STDOUT))
      rescue ArgumentError
        git = Git.init(dir.to_s)
        git.remote 
      end
    end
  end

end