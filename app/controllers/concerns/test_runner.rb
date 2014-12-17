module TestRunner
  TEST_DIR = Rails.root.join('tmp', 'test_runs')

  def run_tests
    env_vars = 'BUNDLE_GEMFILE=./Gemfile RAILS_ENV=test'
    `cd #{working_dir}; bash -c '#{env_vars} bundle install; #{env_vars} rspec'`
  end

  def working_dir
    @dir ||= TEST_DIR.join("#{self.repo.name}-#{self.name}")
  end

  def git_object
    @git ||= begin
      client = self.repo.github_account.client
      branch_info = client.branch(self.repo.github_name, self.name)      
      FileUtils.mkdir_p(working_dir.to_s)
      begin
        git = Git.open(working_dir.to_s, :log => Logger.new(STDOUT))        
      rescue ArgumentError
        git = Git.init(working_dir.to_s)
        git.add_remote 'origin', "git@github.com:#{self.repo.github_name}.git"        
      end
    end
  end

  def initialize_dir
    git_object.fetch
    git_object.checkout "origin/#{self.name}"
  end

  def update_dir
    git_object.pull('origin', self.name)
  end

  def create_database_configuration
    content = <<-END
    test:
      adapter: sqlite3
      pool: 5
      timeout: 5000        
      database: db/test.sqlite3
    END
    File.open(working_dir.join('config', 'database.yml'), 'w') do |f|
      f.write(content)
    end
  end

end