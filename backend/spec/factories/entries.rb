FactoryBot.define do
  factory :entry do
    association :user
    association :room
  end

  factory :entry2, class: Entry do
    association :user, factory: :other_user
    association :room
  end
end
