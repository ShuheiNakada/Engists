FactoryBot.define do
  factory :profile do
    status { '学習中' }
    starting_age { '30-34歳' }
    birth { '1989-01-01' }
    gender { '男性' }
    residence { '大阪府' }
  end

  factory :profile2, class: Profile do
    status { '就職済み' }
    starting_age { '30-34歳' }
    birth { '1989-01-01' }
    gender { '男性' }
    residence { '大阪府' }
  end
end
