class Post < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
 
  validates :title,:body ,presence: true
 
  has_many :images,as: :imageable

  accepts_nested_attributes_for :images, allow_destroy: true
end
