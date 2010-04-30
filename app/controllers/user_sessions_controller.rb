class UserSessionsController < ApplicationController
  def edit
    @user_session = UserSession.new
  end

  def update
    @user_session = UserSession.new params[:user_session]
    if @user_session.valid?
      old_user = current_user
      current_user_session.destroy
      @user_session.save
      @user_session.user.absorb old_user
      redirect_to :root
    else
      render :action => :edit
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to :root
  end
end
