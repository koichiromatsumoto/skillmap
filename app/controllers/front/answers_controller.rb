class Front::AnswersController < Front::BaseController
  def index
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def new
    last_answer = current_user.answers.last

    @answers = [].tap do |list|
      Layer.includes(:user).references(:user).where(User.c[:id].eq(nil).or(User.arel_table[:id].eq(current_user.id))).each do |layer|
        detail = last_answer.details.find { |d| d.layer.id == layer.id }
        list << AnswerDetail.new(layer_id: layer.id, score: detail&.score || 0)
      end
    end
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        answer = Answer.new
        answer.user_id = current_user.id
        answer.count = current_user.answers.order(count: :desc).first&.count || 0
        answer.count += 1
        answer.save!

        params[:answers].each do |a|
          detail = answer.details.build
          detail.layer_id = a[:layer_id]
          detail.score = a[:score]
          detail.save!
        end
      end
    end

    redirect_to front_root_url, notice: '回答しました。'
  end
end
