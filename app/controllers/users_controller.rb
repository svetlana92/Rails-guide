class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit, :update]
  before_action :authenticate_owner!, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show

  end

  def edit

  end

  def update

  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def authenticate_owner!
    if @user != current_user
      flash[:alert] = 'You cannot do that!'
      redirect_to request.referer
    end
  end
end
