class TodoList < ApplicationRecord
  enum freq: { daily: "daily", weekly: "weekly", monthly: "monthly", not_set: "not set" }
  has_many :todo_items, inverse_of: :todo_list ,dependent: :destroy
  accepts_nested_attributes_for :todo_items, reject_if: :all_blank, allow_destroy: true
end
