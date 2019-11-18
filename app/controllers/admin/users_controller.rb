class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_url, notice: 'ユーザーを登録しました。'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_url, notice: 'ユーザーを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_url, notice: 'ユーザーを削除しました。'
  end

  def edit_password
  end

  def update_password
    if current_user.update(user_params)
      sign_in(current_user, :bypass => true)
      redirect_to front_root_url(current_user), notice:"パスワードを変更しました。"
    else
      render :edit_password
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :login, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
