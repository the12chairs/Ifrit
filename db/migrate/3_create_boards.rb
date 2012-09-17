class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :code
      t.string :name
      t.integer :post_counter
      t.references :node
      t.references :comment
      t.timestamps
    end
  end
end
