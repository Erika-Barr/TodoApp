FactoryBot.define do
  factory :user do
    email { "fake@email.com" }
    first_name { "Erika" }
    last_name { "Barr" }
  end

  factory :todo_list do
    description { "Things to do this week" }
    freq { "weekly" }
    user_id { create(:user).id }
    #notification { true }
  end

  factory :todo_item do
    text { "Car inspection" }
    todo_list_id { create(:todo_list).id }
  end
end
