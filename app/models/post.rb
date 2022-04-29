class Post < ApplicationRecord
  validates :title, :body, presence: true
  validates :views_count, numericality: true

  belongs_to :user
end
