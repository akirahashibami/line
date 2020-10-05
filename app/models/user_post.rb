class UserPost < ApplicationRecord

  has_many :post_comments,    dependent: :destroy

  belongs_to :user
  
end
