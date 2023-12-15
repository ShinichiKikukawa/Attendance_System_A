class BasesController < ApplicationController
  before_action :set_base, only: [:edit, :update, :destroy]
  before_action :admin_user, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @bases = Base.all.order(base_number: "ASC")
  end

  def new
    @base = Base.new
  end

  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "拠点情報を追加しました。"
      redirect_to bases_url
    else
      flash[:danger] = "拠点情報の登録に失敗しました。入力漏れ、重複がないか確認してください。"
      @bases = Base.all
      render :index
    end
  end

  def edit
  end

  def update
    if @base.update(base_params)
      flash[:success] = "拠点情報の修正をしました。"
      redirect_to bases_url
    else
      flash.now[:danger] = "拠点情報の更新に失敗しました。入力漏れ、重複がないか確認してください。"
      render :_edit
    end
  end

  def destroy
    if @base.destroy
      flash[:success] = "#{@base.base_name}の拠点情報を削除しました。"
    else
      flash.now[:danger] = "#{@base.base_name}の削除に失敗しました。やり直してください。"
    end
      redirect_to bases_url
  end


    private
      def base_params
        params.require(:base).permit(:base_number, :base_name, :work_type)
      end

      def set_base
        @base = Base.find(params[:id])
      end
end