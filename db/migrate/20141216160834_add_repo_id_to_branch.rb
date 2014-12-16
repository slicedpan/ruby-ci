class AddRepoIdToBranch < ActiveRecord::Migration
  def change
    change_table :branches do |t|
      t.integer :repo_id
    end
    add_index :branches, :repo_id
  end
end
