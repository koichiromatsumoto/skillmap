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
    if answers.map{|h| h[:count]}.last != @answer.count #最後の回答のみ編集ができるようにcountカラムをチェック
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
    #回答者が編集した値を保存する処理
    params[:answers].each do |a| #すべての回答のレイヤーをeachで回す
      details.each do |detail| #対象の回答のレイヤーをeachで回す
        if detail.score != a[:score].to_i && detail.layer_id == a[:layer_id].to_i #layer_idが同じかつscoreが違う場合にscoreの値を更新
          detail.score = a[:score].to_i
          detail.save!
        end
      end
      #回答者が新しくレイヤーを追加（カテゴリを追加）した場合の処理
      if params[:answers].map{|h| h[:layer_id].to_i} != details.map{|h| h[:layer_id]} #元のレイヤー数と回答されたレイヤー数を比較して違う場合
        addlayer_ids = params[:answers].map{|h| h[:layer_id].to_i} - details.map{|h| h[:layer_id]} #追加されたlayer_idを抽出
        addlayer_ids.each do |addlayer_id| #追加が複数の場合もあるのでeachで回す
          if a[:layer_id].to_i == addlayer_id #回答された値のlayer_idがaddlayer_idと一致した場合
            detail = @answer.details.build #detailsに新規追加する
            detail.layer_id = a[:layer_id] #layer_idの値を代入
            detail.score = a[:score] #scoreの値を代入
            detail.save! #値を保存
          end
        end
      end
    end
    require 'date'
    @answer.updated_at = DateTime.now #updated_atに現在日時を代入
    @answer.save!
    redirect_to front_answer_url(@answer), notice: '回答を編集しました。' and return
  end

end
