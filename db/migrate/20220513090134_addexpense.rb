class Addexpense < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses,:is_accpted,:string
  end
end
