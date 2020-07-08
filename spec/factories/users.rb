FactoryBot.define do
  factory :user do
    name { "yamamoto" }
    email { "yamamoto@email.com" }
    password {"yamamoto"}
    admin {true}
  end
  
  factory :other_user, class: User do
    name { "tanaka"}
    email { "tanaka@email.com"}
    password { "tanaka"}
  end
end
