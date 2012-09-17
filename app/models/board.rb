class Board < ActiveRecord::Base
  has_many :nodes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  #def to_param
  #  "#{code}"
  #end
end
