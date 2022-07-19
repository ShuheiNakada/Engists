FactoryBot.define do
  factory :user do
    name { 'Shuhei Nakada' }
    email { 't_develop@app.com' }
    password { 'pass1234' }
    password_confirmation { 'pass1234' }
  end

  factory :other_user, class: User do
    name { 'Hidehira Nakata' }
    email { 't_developer@app.com' }
    password { 'pass1234' }
    password_confirmation { 'pass1234' }
  end
end
