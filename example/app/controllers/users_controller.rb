class UsersController < ApplicationController
  before_action :initialize_repositories

  def edit
    @user = @user_repository.find(params[:id])
  end

  private

  def initialize_repositories
    # Requires and Includes
    require_relative '../repositories/user_repository'
    # Define repository instances
    @user_repository = UserRepository.new
  end

end

