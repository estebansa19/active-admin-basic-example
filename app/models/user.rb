class User < ApplicationRecord
  enum rol: { admin: 0, author: 1 }

  has_many :posts

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
