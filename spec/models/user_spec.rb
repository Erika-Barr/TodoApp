require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }

  it { should have_many(:todo_lists).dependent(:destroy) }
  it { should have_many(:todo_items).through(:todo_lists) }
  it { should have_db_column(:email) }
  it do
    should define_enum_for(:role).
      with_values(standard: "standard", admin: "admin").
      backed_by_column_of_type(:enum)
  end
end
