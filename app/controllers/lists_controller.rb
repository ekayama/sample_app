class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      flash[:notice] = "投稿に成功しました."
      redirect_to list_path(@list.id)
    else
      # フラッシュメッセージを実装してみようでのコード↓
      # redirect_toの時はflash、renderの時はflash.nowとセットで覚えておく
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
      # 前回までのコードい↓
      # flash[:notice] = "投稿に失敗しました。"
      # redirect_to new_list_path
      # ーーーーーーーーーーーー
    end
  end

  def index
      @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end
  
  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to '/lists'
  end

  private
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
