class AuthController < ApplicationController
  #handles user authentication
  skip_before_action :authenticate_request #implemented later

  def authenticate
    user = User.find_by(email: params[:email.downcase!])

     #uses bcrypt to check password_digest
    if user && user.authenticate(params[:password])
      #passed check - call token generator below
      render json: { authentication_payload(user) }
    else
      render json: { error: 'Invalid username or password'}, status: :unauthorized
    end
  end

  private

  def authentication_payload(user)
    return nil unless user && user.id
    {
      auth_token: AuthToken.encode({ user_id: id }), user: { id: user.id, email: user.email } #embed whatever user info you need
    }
  end

end
