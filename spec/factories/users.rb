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

  trait :with_avatar do
    avatar { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test_image.jpg'))
    }
  end

  trait :invalid_image_avater do
    avatar { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', '10megabytes.jpg'))
    }
  end

  trait :invalid_file_avatar do
    avatar { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'invalid_file.pdf'))
    }
  end

  trait :with_profile_image do
    profile_image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test_image.jpg'))
    }
  end

  trait :invalid_image_profile_image do
    profile_image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', '10megabytes.jpg'))
    }
  end

  trait :invalid_file_profile_image do
    profile_image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'invalid_file.pdf'))
    }
  end
end
