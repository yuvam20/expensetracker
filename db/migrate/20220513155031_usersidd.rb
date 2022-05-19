class Usersidd < ActiveRecord::Migration[7.0]
  def change
    remove_column :expenses,:user_id
    add_column :expenses,:user_id,:integer
  end
end
