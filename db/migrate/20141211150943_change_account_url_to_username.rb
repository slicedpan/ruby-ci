class ChangeAccountUrlToUsername < ActiveRecord::Migration
  def change
    change_table :github_accounts do |t|
      t.rename :url, :username
    end
  end
end
