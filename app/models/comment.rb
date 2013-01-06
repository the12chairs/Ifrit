class Comment < ActiveRecord::Base
  validates :body, :presence => true
  mount_uploader :picture, PictureUploader
  belongs_to :node
  belongs_to :board
  before_create {
    |comment|
    comment.ip = Thread.current[:request].remote_ip
    board = Board.find(Node.find(comment.node_id).board_id)
    node = Node.find comment.node_id
    comment.number = board.post_counter + 1
    comment.formated_date = Time.now.strftime("%d %b %Y, %H:%M") # Не равно created_at!
    # Вероятно, стоит переделать
    if comment.head != "sage"
      node.last_comment = Time.now #comment.created_at
      node.save
    end
    board.post_counter +=1
    board.save
  }
end
