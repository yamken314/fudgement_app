FactoryBot.define do
  factory :choice do
    name { "test" }
    association :micropost
    user { micropost.user }
  end
end
