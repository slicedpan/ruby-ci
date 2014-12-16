class Repo < ActiveRecord::Base
  has_many :branches
  belongs_to :github_account
end
