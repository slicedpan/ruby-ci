class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.integer :github_account_id
      t.string :github_name
      t.datetime :last_synced

      t.timestamps
    end
    add_index :repos, :github_account_id
  end
end
