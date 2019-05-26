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
      render :new
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_url, notice: 'ユーザーを削除しました。'
  end

  private

  def user_params
    params.require(:user).permit(:username, :login, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
