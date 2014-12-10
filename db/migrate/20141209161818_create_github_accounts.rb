class CreateGithubAccounts < ActiveRecord::Migration
  def change
    create_table :github_accounts do |t|
      t.string :name
      t.string :client_id
      t.string :client_secret
      t.string :url

      t.timestamps
    end
  end
end
