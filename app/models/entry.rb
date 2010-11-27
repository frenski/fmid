class Entry < ActiveRecord::Base
  validates :socid, :presence => true
end
