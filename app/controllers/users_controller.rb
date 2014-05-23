class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
    
    @user_games = GameDecorator.decorate_collection(
      GamePolicy::Scope.new(current_user, @user.games).resolve)
    @user_favorite_games = GameDecorator.decorate_collection(
      GamePolicy::Scope.new(current_user, @user.favorite_games.limit(4)).resolve)
  end
  
  def index
    authorize User, :index?
    @users = User.order(:id)
  end
end
