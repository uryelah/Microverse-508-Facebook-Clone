# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'User successfully created'
      redirect_to posts_path
    else
      flash.now[:error] = 'Error saving new user :-('
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @friend_requests = @user.received_requests
  end

  def index
    @users = User.all.where('id != ?', current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update; end

  def destroy
    @user = User.find(params[:id])
    if @user&.destroy
      flash[:success] = 'User successfully deleted'
    else
      flash[:error] = 'Error deleting user :-('
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
