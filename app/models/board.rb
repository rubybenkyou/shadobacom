class Board < ApplicationRecord
  belongs_to :user
  has_many :comments,dependent: :destroy
  has_many :likes,dependent: :destroy
  
  validates :title,presence: true,length:{maximum: 30}
  validates :content,presence: true,length:{maximum: 1000}
end
