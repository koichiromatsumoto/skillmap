class Admin::LayersController < ApplicationController
  before_action :set_layer, only: %i[edit update sort accept]

  def index
    @layers = Layer.rank(:row_order)
  end

  def new
    @layer = Layer.new
  end

  def edit
  end

  def create
    @layer = Layer.new(layer_params)

    if @layer.save
      redirect_to admin_layers_url, notice: 'レイヤーを登録しました。'
    else
      render :new
    end
  end

  def update
    @layer.update(layer_params)

    if @layer.save
      redirect_to admin_layers_url, notice: 'レイヤーを更新しました。'
    else
      render :edit
    end
  end

  def sort
    @layer.update(layer_params)

    head :no_content
  end

  def accept
    @layer.user_id = nil
    @layer.save

    redirect_to admin_layers_url, notice: 'レイヤーを承認しました。'
  end

  private

  def layer_params
    params.require(:layer).permit(:category1_id, :category2_id, :category3_id, :category4_id, :category5_id, :category6_id, :row_order_position)
  end

  def set_layer
    @layer = Layer.find(params[:id])
  end
end
