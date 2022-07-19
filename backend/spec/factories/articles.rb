FactoryBot.define do
  factory :article do
    title { 'ポートフォリオの技術選定について' }
    content { '学習リソースの多い技術を中心に...' }
    association :user
  end

  factory :article2, class: Article do
    title { '学習継続のコツ' }
    content { '毎日●時間というルールより１週間で...' }
    association :user
  end

  factory :article3, class: Article do
    title { '参考になったUdemy教材' }
    content { '数ある動画教材の中でコレが分かりやすかった...' }
    association :user
  end

  factory :article4, class: Article do
    title { 'メンタルケア' }
    content { '画面に集中して学習を継続するのも大事だけど、休憩も必要で...' }
    association :user, factory: :other_user
  end

  factory :article5, class: Article do
    title { '学習ロードマップ' }
    content { '基礎学習からポートフォリオ作成までのロードマップ...' }
    association :user, factory: :other_user
  end
end
