module TestRunner
  TEST_DIR = Rails.root.join('tmp', 'test_runs')

  def run_tests
    return if self.status != 'ready'
    Thread.new do
      begin
        ActiveRecord::Base.connection_pool.with_connection do
          update({:status => 'getting changes from Repo'})
          update_dir
          update({:status => 'running tests'})
          env_vars = 'BUNDLE_GEMFILE=./Gemfile RAILS_ENV=test'
          `cd #{working_dir}; bash -c '#{env_vars} bundle install; #{env_vars} rspec -fj -o tmp/rspec_output.json'`
          dat = nil
          File.open(working_dir.join('tmp', 'rspec_output.json')) do |f|
            dat = JSON.load(f.read)
          end
          update({:status => 'saving test data'})
          test_run = self.test_runs.create          
          passing = true
          dat["examples"].each do |example|
            passing = false if example["status"] == 'failed'
            test_run.examples.create(
              :description => example["full_description"],
              :status => example["status"],
              :filename => example["file_path"],
              :line_number => example["line_number"]
            )
          end
          test_run.update({:status => passing ? 'passing' : 'failing'})
          update({:status => 'ready'})
        end
      rescue StandardError => e
        Rails.logger.error "TestRunner thread threw: #{e}"
        Rails.logger.error e.backtrace.join("\n")
      end
    end
    true
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