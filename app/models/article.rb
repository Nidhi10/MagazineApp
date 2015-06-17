class Article < ActiveRecord::Base

  belongs_to :magazine
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :author, presence: true
end
