require 'rails_helper'

RSpec.describe 'Api::Profiles', type: :request do
  before do
    @user = FactoryBot.create(:user)
  end
  let(:profile) { FactoryBot.create(:profile, user_id: @user.id) }

  describe 'POST /api/profiles' do
    it '有効なファクトリである' do
      expect(@user).to be_valid
    end

    it 'ユーザーに紐づくプロフィールを新規作成する' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_tokens = sign_in(user)
      params = {
        profile: {
          status: '学習中',
          starting_age: '30-34歳',
          birth: '1989-01-01',
          gender: '男性',
          residence: '大阪府'
        }
      }

      post api_profiles_path, params: params, headers: auth_tokens
    end
  end

  describe 'PUT /api/profiles/:id' do
    it '有効なファクトリである' do
      expect(@user).to be_valid
      expect(profile).to be_valid
    end

    it 'プロフィールを更新する(ステータスを「学習中」から「就職済み」に変更)' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_tokens = sign_in(user)
      params = {
        profile: {
          status: '就職済み'
        }
      }

      put api_profile_path(profile.id), params: params, headers: auth_tokens
    end
  end
end
