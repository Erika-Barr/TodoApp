class User < ApplicationRecord
  enum role: { standard: "standard", admin: "admin" }
  has_many :todo_lists, dependent: :destroy
  has_many :todo_items, through: :todo_lists
end
