class Addid < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses,:user_id,:inetger
  end
end
