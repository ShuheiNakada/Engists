require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it '有効なファクトリである' do
    profile = FactoryBot.create(:profile, user: @user)
    expect(profile).to be_valid
  end

  it 'ステータスが未入力であるなら、無効となる' do
    profile = FactoryBot.build(:profile, user: @user, status: nil)
    profile.valid?
    expect(profile.errors.full_messages).to include('Statusを入力してください')
  end

  it '学習開始の年齢が未入力であるなら、無効となる' do
    profile = FactoryBot.build(:profile, user: @user, starting_age: nil)
    profile.valid?
    expect(profile.errors.full_messages).to include('Starting ageを入力してください')
  end

  it '生年月日が未入力であるなら、無効となる' do
    profile = FactoryBot.build(:profile, user: @user, birth: nil)
    profile.valid?
    expect(profile.errors.full_messages).to include('Birthを入力してください')
  end

  it '性別が未入力であるなら、無効となる' do
    profile = FactoryBot.build(:profile, user: @user, gender: nil)
    profile.valid?
    expect(profile.errors.full_messages).to include('Genderを入力してください')
  end

  it '居住地が未入力であるなら、無効となる' do
    profile = FactoryBot.build(:profile, user: @user, residence: nil)
    profile.valid?
    expect(profile.errors.full_messages).to include('Residenceを入力してください')
  end

  it '全ての基本情報が入力できていれば、有効となる' do
    profile = FactoryBot.create(:profile, user: @user)
    expect(profile).to be_valid
  end

  it '1人のユーザーは1つのプロフィールしか作成できない' do
    FactoryBot.create(:profile, user: @user)
    profile2 = FactoryBot.build(:profile2, user: @user)
    expect(profile2.save).to be_falsey
    expect(profile2.errors.full_messages).to include('Userはすでに存在します')
  end
end
