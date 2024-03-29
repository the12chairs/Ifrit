class Board < ActiveRecord::Base
  has_many :nodes, :order => "last_comment DESC", :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  before_create {
    |board|
    board.post_counter = 0 # Количество постов в свежесозданной доске - 0
  }

end
