FactoryBot.define do
  # is_deactivated: false, role: "standard"
  factory :user do
    email { "fake@email.com" }
    password { ';Testtesttest1' }
  end

  factory :todo_list do
    description { "Things to do this week" }
    freq { "weekly" }
    user { create(:user) }
    #notification { true }
  end

  factory :todo_item do
    text { "Car inspection" }
    todo_list { create(:todo_list) }
  end
end
