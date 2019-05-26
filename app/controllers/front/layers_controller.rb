class Front::LayersController < Front::BaseController
  def new
    @layer = Layer.new(user_id: current_user.id)
  end

  def create
    layer = Layer.new(layer_params)
    layer.user_id = current_user.id
    layer.save

    @answer = AnswerDetail.new(layer_id: layer.id, score: 0)
  end

  private

  def layer_params
    params.require(:layer).permit(:category1_id, :category2_id, :category3_id, :category4_id, :category5_id, :category6_id)
  end
end
