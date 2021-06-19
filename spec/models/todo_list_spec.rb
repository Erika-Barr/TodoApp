require 'rails_helper'

RSpec.describe TodoList, type: :model do
  subject { FactoryBot.build(:todo_list) }

  it { should have_many(:todo_items).dependent(:destroy) }
  it { should have_db_column(:description) }
  it { should have_db_column(:completed) }
  it { should have_db_column(:archive) } # TODO rename column to archived
  it { should have_db_column(:notification) }
  it do
    should define_enum_for(:freq).
      with_values(daily: "daily", weekly: "weekly", monthly: "monthly", not_set: "not set").
      backed_by_column_of_type(:enum)
  end
end
