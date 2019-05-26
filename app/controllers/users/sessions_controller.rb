class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(_)
    current_user.admin? ? admin_root_url : front_root_url
  end

  def after_sign_out_path_for(_)
    new_user_session_url
  end
end
