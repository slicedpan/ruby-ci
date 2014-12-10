class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.text :description
      t.text :filename
      t.integer :line_number
      t.string :status
      t.integer :test_run_id

      t.timestamps
    end
    add_index :examples, :test_run_id
  end
end
