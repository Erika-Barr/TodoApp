class TodoList < ApplicationRecord
  enum freq: { daily: "daily", weekly: "weekly", monthly: "monthly", not_set: "not set" }
  has_many :todo_items, dependent: :destroy
end
