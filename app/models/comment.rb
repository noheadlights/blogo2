class Comment < ActiveRecord::Base
  attr_accessible :post, :text, :user
  belongs_to :post
  belongs_to :user
  validates :post, presence: true
  validates :text, presence: true
  validates :user, presence: true

end
