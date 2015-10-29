
class AccessDeniedError < StandardError
end

class NotAuthenticatedError < StandardError
end

class AuthenticationTimeoutError < StandardError
end


class ApplicationController < ActionController::API
  attr_reader :current_useer
#when an error occurs, respond with the private method below

  rescue_from AuthenticationTimeoutError, with: :authentication_timeout

  rescue_from NotAuthenticatedError, with: :user_not_authenticated

protected

#this method gets the current user based on the user_id included in the Authorization header (JWT)
#call this from child controllers in a before_action or from within the action method itself
  def authenticate_request!
    fail NotAuthenticatedError unless user_id_included_in_auth_token?
    @current_user = User.find(decoded_auth_token[:user_id])
    rescue JWT::ExpiredSignature
      raise AuthenticationTimeoutError
    rescue JWT::VerificationError, JWT::DecodeError
      raise NotAuthenticatedError
  end


private

# Authenticatation Related Helper Methods
  def user_id_included_in_auth_token?
    http_auth_token && decoded_auth_token && decoded_auth_token[:user_id]
  end

  #decode the authorization header token and return the payload
  def decoded_auth_token
    @decoded_auth_token ||= AuthToken.decode(http_auth_token)
  end

  #raw authorization header token (JWT format)
  #JWTs are stored in the Authorization header using this format:
  # bearer SomeRandomString.EncodedPayload.AnotherRandomString
  def http_auth_token
   @http_auth_token ||= if request.headers['Authorization'].present?
     request.headers['Authorization'].split(' ').last
   end
  end

  #helper methods for responding to errors
  def authentication_timeout
    render json: { errors: ['Authentication Timeout']}, status: 419
  end

  def forbidden_resource
    render json: { errors: ['Not Authorized to Access Resource']}, status: :forbidden
  end

  def user_not_authenticated
    render Json: { errors: ['Not Authenticated']} status: :unauthorized
  end
end
