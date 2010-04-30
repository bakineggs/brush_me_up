class MemosController < ApplicationController
  def new
    @memo = memos.new
  end

  def create
    @memo = memos.create :text => params[:memo][:text]
    flash[:notice] = "We'll make sure you remember that"
    redirect_to :root
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

    respond_to do |format|
      format.html { redirect_to :root }
      format.json do
        flash.discard :notice
        @next_memo = memos(true).first
      end
    end
  end

  def index
    @memo = memos.first
    @to_go = memos.to_go.count
  end

  private
    def memos reload = false
      current_user.memos reload
    end
end
