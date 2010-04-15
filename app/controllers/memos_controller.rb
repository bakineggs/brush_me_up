class MemosController < ApplicationController
  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.create :text => params[:memo][:text]
    flash[:notice] = "We'll make sure you remember that"
    redirect_to :action => :index
  end

  def update
    @memo = Memo.find params[:id]

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
    @memo = Memo.next
  end
end
