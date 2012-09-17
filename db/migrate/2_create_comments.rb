class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :head
      t.text :body
      t.string :picture
      t.integer :number
      t.string :formated_date
      t.string :ip
      t.references :node
      t.references :board
      t.timestamps
    end
    #add_index :comments, :number, :unique => true
  end
end
