class User < ApplicationRecord
    has_secure_password

    validates :email,presence:true,uniqueness:true,format:{with: /\A[^@\s]+@[^@\s]+\z/,message:'Must be a valid email address'}
    PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x

validates :password, 
  presence: true,   
  format: { with: PASSWORD_FORMAT ,message:'Enter a strong password'}

    has_many :expenses
end
