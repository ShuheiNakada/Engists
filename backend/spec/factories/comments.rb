FactoryBot.define do
  factory :comment do
    category { '質問' }
    title { 'フレームワーク選定基準について' }
    content { '関西でwebエンジニアとして就職したいのですが、RailsよりPHPの方が求人数が...' }
    association :article
    association :user, factory: :other_user
  end
end
