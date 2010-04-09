class MemosController < ApplicationController
  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.create :text => params[:memo][:text]
    redirect_to :action => :index
  end

  def update
    @memo = Memo.find params[:id]

    @memo.remembering! if params[:memo][:remembering]
    @memo.forgetting! if params[:memo][:forgetting]

    redirect_to :action => :index
  end

  def index
    @memo = Memo.next
  end
end
