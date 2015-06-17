class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true
  has_many :comments, -> { includes(:user, :comments).order(created_at: :desc) }, as: :commentable, dependent: :destroy

  delegate :name, to: :user, prefix: true, allow_nil: true

  validates :content, presence: true

end
