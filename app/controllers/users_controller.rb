class UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page]).per(2).order(:created_at, :id)
  end

  def show
    @user = User.find(params[:id])
  end
end
