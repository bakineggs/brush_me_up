class UserSessionsController < ApplicationController
  def edit
    @user_session = UserSession.new
  end

  def update
    @user_session = UserSession.new params[:user_session]
    if @user_session.valid?
      current_user_session.destroy
      @user_session.save
      redirect_to :controller => :memos, :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to :controller => :memos, :action => :index
  end
end
