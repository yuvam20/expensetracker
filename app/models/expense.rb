class Expense < ApplicationRecord
    belongs_to :user,foreign_key:true,optional:true
    has_many :comments
    has_one_attached :bill
end
