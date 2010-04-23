class MemosController < ApplicationController
  def new
    @memo = memos.new
  end

  def create
    @memo = memos.create :text => params[:memo][:text]
    flash[:notice] = "We'll make sure you remember that"
    redirect_to :action => :index
  end

  def update
    @memo = memos.find params[:id]

    if params[:memo][:remembering]
      @memo.remembering!
      flash[:notice] = "We'll remind you less often"
    elsif params[:memo][:forgetting]
      @memo.forgetting!
      flash[:notice] = "We'll remind you more often"
    end

    redirect_to :action => :index
  end

  def index
    @memo = memos.first
    @to_go = memos.to_go.count
  end

  private
    def memos
      current_user.memos
    end
end
