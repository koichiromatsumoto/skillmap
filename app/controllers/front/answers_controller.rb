class Front::AnswersController < Front::BaseController
  def index
  end

  def show
    @answer = Answer.find(params[:id])
    answers = Answer.all
    @lastcount = answers.map{|h| h[:count]}.last

  end

  def new
    last_answer = current_user.answers.last

    @answers = [].tap do |list|
        Layer.includes(:user).references(:user)
          .where(User.arel_table[:id].eq(nil).or(User.arel_table[:id].eq(current_user.id))).each do |layer|
        detail = last_answer&.details&.find { |d| d.layer.id == layer.id }
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

  def edit  
    answers = Answer.all
    @answer = Answer.find(params[:id])
    if answers.map{|h| h[:count]}.last != @answer.count
      redirect_to front_root_url, alert: '無効な操作が行われました。'
    end
    @answers = [].tap do |list|
      Layer.includes(:user).references(:user).where(User.arel_table[:id].eq(nil).or(User.arel_table[:id].eq(current_user.id))).each do |layer|
        detail = @answer&.details&.find { |d| d.layer.id == layer.id }
        list << AnswerDetail.new(layer_id: layer.id, score: detail&.score || 0)
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    details = @answer.details
    params[:answers].each do |a|
      details.each do |detail|
        if detail.score != a[:score].to_i && detail.layer_id == a[:layer_id].to_i
          detail.score = a[:score].to_i
          detail.save!
        end
      end
      if params[:answers].map{|h| h[:layer_id].to_i} != details.map{|h| h[:layer_id]}
        addlayer_ids = params[:answers].map{|h| h[:layer_id].to_i} - details.map{|h| h[:layer_id]}
        addlayer_ids.each do |addlayer_id|
          if a[:layer_id].to_i == addlayer_id
            detail = @answer.details.build
            detail.layer_id = a[:layer_id]
            detail.score = a[:score]
            detail.save!
          end
        end
      end
    end
    require 'date'
    @answer.updated_at = DateTime.now
    @answer.save!
    redirect_to front_answer_url(@answer), notice: '回答を編集しました。' and return
  end

  # private
  # def answer_params
  #   params.require(:answers).map do |a|
  #     ActionController::Parameters.new(a).permit!
  #   end
  # end
  
end
