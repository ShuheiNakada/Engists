module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :following, :followers, :profile]

    def index
      users = User.profile

      render json: users, status: :ok
    end

    def show
      user = User.find(params[:id])
      current_user_entry = Entry.where(user_id: current_user.id)
      user_entry = Entry.where(user_id: user.id)
      is_room = false
      created_room_id = false
      unless user.id == current_user.id
        current_user_entry.each do |cu|
          user_entry.each do |u|
            if cu.room_id == u.room_id
              is_room = true
              created_room_id = cu.room_id
            end
          end
        end
      end

      user_base = {
        id: user.id,
        name: user.name,
        email: user.email,
        icon_path: user.image.url,
        icon_name: user.image_identifier
      }

      user_profile = if user.profile.present?
                       {
                         profile_id: user.profile.id,
                         status: user.profile.status,
                         starting_age: user.profile.starting_age,
                         birth: user.profile.birth,
                         gender: user.profile.gender,
                         residence: user.profile.residence,
                         introduction: user.profile.introduction,
                         hobby: user.profile.hobby,
                         github: user.profile.github,
                         twitter: user.profile.twitter,
                         qiita: user.profile.qiita,
                         wontedly: user.profile.wontedly,
                         technology_used: user.profile.technology_used,
                         study_period: user.profile.study_period,
                         study_method: user.profile.study_method,
                         teaching_materials: user.profile.teaching_materials,
                         corporate_form: user.profile.corporate_form,
                         company_size: user.profile.company_size,
                         annual_income: user.profile.annual_income,
                         entry: user.profile.entry,
                         meet: user.profile.meet,
                         accepted: user.profile.accepted
                       }
                     else
                       {
                         profile_id: '',
                         status: '',
                         starting_age: '',
                         birth: '',
                         gender: '',
                         residence: '',
                         introduction: '',
                         hobby: '',
                         github: '',
                         twitter: '',
                         qiita: '',
                         wontedly: '',
                         technology_used: '',
                         study_period: '',
                         study_method: '',
                         teaching_materials: '',
                         corporate_form: '',
                         company_size: '',
                         annual_income: '',
                         entry: '',
                         meet: '',
                         accepted: ''
                       }
                     end

      render json: {
        user_base: user_base,
        user_profile: user_profile,
        dm_room_check: is_room,
        room_id: created_room_id
      }, status: :ok
    end

    def following
      user = User.find(params[:id])
      users = user.following
      follow_user_array = users.map do |u|
        {
          id: u.id,
          name: u.name,
          email: u.email,
          status: u.profile.status,
          starting_age: u.profile.starting_age,
          gender: u.profile.gender,
          residence: u.profile.residence,
          created_at: u.created_at,
          updated_at: u.updated_at,
          icon_path: u.image.url,
          follow_date: u.passive_relationships.where(follower_id: current_user.id).pluck(:updated_at)
        }
      end

      render json: follow_user_array, status: :ok
    end

    def followers
      user = User.find(params[:id])
      users = user.followers
      followed_user_array = users.map do |u|
        {
          id: u.id,
          name: u.name,
          email: u.email,
          status: u.profile.status,
          starting_age: u.profile.starting_age,
          gender: u.profile.gender,
          residence: u.profile.residence,
          created_at: u.created_at,
          updated_at: u.updated_at
        }
      end

      render json: followed_user_array, status: :ok
    end

    def profile
      user = User.find(current_user.id)
      user_object = {
        id: user.id,
        login: true,
        icon_path: user.image.url
      }

      if user.profile.present?
        profile_exist = true
      elsif user.profile.blank?
        profile_exist = false
      end

      render json: { user: user_object, profile_exist: profile_exist }, status: :ok
    end
  end
end
