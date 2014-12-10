class CreateTestRuns < ActiveRecord::Migration
  def change
    create_table :test_runs do |t|
      t.integer :branch_id
      t.string :status

      t.timestamps
    end
    add_index :test_runs, :branch_id
  end
end
