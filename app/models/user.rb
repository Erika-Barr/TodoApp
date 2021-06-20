class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { standard: "standard", admin: "admin" }
  has_many :todo_lists, dependent: :destroy
  has_many :todo_items, through: :todo_lists
end
