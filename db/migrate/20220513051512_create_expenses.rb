class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.integer :invoicenum
      t.text :description
      t.integer :amount
      t.date :date

      t.timestamps
    end
  end
end
