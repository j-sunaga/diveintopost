class ApplicationController < ActionController::Base
  before_action :init_team, if: :user_signed_in?
  before_action :set_working_team, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def change_keep_team(user, current_team)
    user.keep_team_id = current_team.id
    user.save!
  end

  def is_owner?
    @working_team.owner_id == current_user.id
  end

  def is_myself?(user_id)
    user_id == current_user.id
  end

  private

  def set_working_team
    @working_team = current_user.keep_team_id ? Team.find(current_user.keep_team_id) : Team.first
  end

  def init_team
    current_user.assigns.create!(team_id: Team.first.id) if current_user.teams.blank?
  end

  protected

  def configure_permitted_parameters
    user_attributes = [:email, :icon, :content,:keep_team_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: user_attributes)
  end
end
