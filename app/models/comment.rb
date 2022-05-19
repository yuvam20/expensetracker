class Comment < ApplicationRecord
    belongs_to :expense,foreign_key:true,optional:true
end
