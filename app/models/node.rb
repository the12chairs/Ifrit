class Node < ActiveRecord::Base
  
  validates :body, :picture, :presence => true
  
  has_many :comments, :dependent => :destroy
  belongs_to :board
  mount_uploader :picture, PictureUploader
  
  
  self.per_page = 10 
  
  #def to_param
  #  "#{number}"
  #end
end
