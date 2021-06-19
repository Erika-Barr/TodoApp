require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  subject { FactoryBot.build(:todo_item) }

  it { should have_db_column(:text) }
  it { should belong_to(:todo_list) }
end
