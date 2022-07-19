require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:other_user)
  end

  it '有効なファクトリである' do
    expect(@user).to be_valid
    expect(@other_user).to be_valid
  end

  it 'フォローするユーザーIDがなければ、無効になる' do
    follow = Relationship.create(follower_id: '', followed_id: @other_user.id)
    expect(follow).to be_invalid
  end

  it 'フォローされるユーザーIDがなければ、無効になる' do
    follow = Relationship.create(follower_id: @user.id, followed_id: '')
    expect(follow).to be_invalid
  end

  it 'フォローする/フォローされるユーザーIDの両方があるなら、有効になる' do
    follow = Relationship.create(follower_id: @user.id, followed_id: @other_user.id)
    expect(follow).to be_valid
  end

  it '同じ相手を2回フォローする事はできない' do
    Relationship.create(follower_id: @user.id, followed_id: @other_user.id)
    follow2 = Relationship.new(follower_id: @user.id, followed_id: @other_user.id)
    expect(follow2.save).to be_falsey
    expect(follow2.errors.full_messages).to include('Followerはすでに存在します')
    expect(follow2.errors.full_messages).to include('Followedはすでに存在します')
  end
end
