class TodoList < ApplicationRecord
  enum freq: { daily: "daily", weekly: "weekly", monthly: "monthly", not_set: "not set" }
  belongs_to :user
  has_many :todo_items, inverse_of: :todo_list ,dependent: :destroy
  accepts_nested_attributes_for :todo_items, reject_if: :all_blank, allow_destroy: true

  include PgSearch::Model
  multisearchable(
    against: [:description, :todo_items_text],
    additional_attributes: -> (todo_list) { { user_id: todo_list.user_id } }
  )
  def todo_items_text
    todo_items.map(&:text).join(" ")
  end
end
