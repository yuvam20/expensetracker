class Addfile < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses,:bill,:binary,:limit => 10.megabyte
  end
end
