class Admin::Users::AnswersController < Admin::BaseController
  before_action :set_user

  def index
    @answers = @user.answers
  end

  def show
    @answer = Answer.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
