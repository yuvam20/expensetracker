class ExpenseId < ActiveRecord::Migration[7.0]
  def change
    add_column :comments,:expense_id,:integer
  end
end
