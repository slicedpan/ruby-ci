class Branch < ActiveRecord::Base
  include TestRunner

  belongs_to :repo
  has_many :test_runs

end
