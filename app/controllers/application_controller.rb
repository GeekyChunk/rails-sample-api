class ApplicationController < ActionController::API
  include JsonWebToken

  def authorize
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = jwt_decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
