class AuthController < ApplicationController
  before_action :authorize, only: [:me]
  def create
    validator = UserValidator.new

    result = validator.call(user_params.to_h)

    if result.success?
      @user = User.create(user_params)
      if @user.save
        render json: @user.slice(:name, :username, :created_at, :updated_at)
      else
        render json: @user.errors
      end
    else
      render json: { errors: result.errors.to_h }, status: :unprocessable_entity
    end
  end

  def login
    validator = LoginValidator.new

    result = validator.call(login_params.to_h)
    if result.success?
      @user = User.where(username: login_params[:username]).first

      if @user&.authenticate(params[:password])
        token = jwt_encode(user_id: @user.id)
        render json: { token: token, username: @user.username }, status: :ok
      end
    else
      render json: { errors: result.errors.to_h }, status: :unprocessable_entity
    end
  end

  def me
    render json: @current_user.slice(:username, :name, :created_at, :updated_at)
  end

  private
    def user_params
      params.permit(:name, :username, :password)
    end

    def login_params
      params.permit(:username, :password)
    end
end
