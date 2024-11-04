class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!

  private

  def authenticate_user!
    @current_user = UserSession.find_by(id: cookies.encrypted[:user])
    if @current_user.blank?
      @current_user = UserSession.create
      cookies.encrypted.permanent[:user] = @current_user.id
    end

    @current_user.touch(:last_login_at)
  end
end
