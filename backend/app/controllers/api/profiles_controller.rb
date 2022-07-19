module Api
  class ProfilesController < ApplicationController
    before_action :authenticate_user!, only: %w[create update]

    def create
      profile = current_user.build_profile(profile_params)
      if profile.save
        render json: profile, status: :ok
      else
        render json: profile, status: :bad_request
      end
    end

    def update
      profile = Profile.find(params[:id])
      if profile.user.id == current_user.id
        profile.update(profile_params)

        render json: profile, status: :ok
      else
        render status: :bad_request
      end
    end

    private

    def profile_params
      params.require(:profile).permit(
        :status, :starting_age, :birth, :gender, :residence, :introduction, :hobby, :github, :twitter, :qiita, :wontedly,
        :technology_used, :study_period, :study_method, :teaching_materials, :corporate_form, :company_size,
        :annual_income, :entry, :meet, :accepted
      )
    end
  end
end
