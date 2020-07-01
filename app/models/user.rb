class User < ApplicationRecord
  
    has_secure_password
    has_many :boards,dependent: :destroy
    has_many :comments,dependent: :destroy
    has_many :likes,dependent: :destroy
    
    validates :register_id,
    presence: true,
    uniqueness: true,
    length: {maximum: 20},
    format: {
      with: /\A[a-z0-9]+\z/,
      message: 'は小文字英数字で入力してください'
    }
  validates :password,
    length: {minimum: 6}
    validates :name,presence: true,length: {maximum: 20}
    
end
