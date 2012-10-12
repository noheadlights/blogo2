class Post < ActiveRecord::Base
  attr_accessible :text, :title, :image, :user
  mount_uploader :image, ImageUploader
  has_many :comments , dependent: :destroy
  belongs_to :user
  validates :text, presence: true
  validates :title, presence: true
  validates :image, presence: true
  validates :user, presence: true

end
