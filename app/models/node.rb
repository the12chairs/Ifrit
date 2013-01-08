class Node < ActiveRecord::Base
  include ApplicationHelper
  validates :body, :picture, :presence => true
  
  has_many :comments, :order => "id ASC", :dependent => :destroy
  belongs_to :board
  mount_uploader :picture, PictureUploader
  before_create{
    |node|
    board = Board.find(node.board_id)
    node.ip = Thread.current[:request].remote_ip
    node.last_comment = Time.now # != creatd_at
    node.formated_date = Time.now.strftime("%d %b %Y, %H:%M")
    node.number = board.post_counter + 1
    board.post_counter += 1
    board.save
  }
end
