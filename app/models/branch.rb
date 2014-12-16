class Branch < ActiveRecord::Base
  include TestRunner

  belongs_to :repo

end
