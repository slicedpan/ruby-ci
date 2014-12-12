class AddAccessTokenToAccount < ActiveRecord::Migration
  def change
    change_table :github_accounts do |t|
      t.string :access_token
    end
  end
end
