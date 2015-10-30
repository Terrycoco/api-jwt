class AuthController < ApplicationController
  skip_before_action :authenticate_request #don't run our subsequent command in this case - skip it

  def authenticate
    # initialize and call command
     #'.call' is a shortcut for .new(args).call
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end


#THIS CODE IS FROM SimpleCommand README AS AN EXAMPLE
 #  def create
 #    #initialize and execute the command
 #    # '.call' is a shortcut for .new(args).call
 #    command = AuthenticateUser.call(session_params[:user], session_params[:password])
 #
 #    #check command outcome
 #    if command.success?
 #      #command#result will contain the user instance, if found
 #      session[:user_token] = command.result.secret_token
 #      redirect_to_root_path
 #    else
 #      flash.now[:alert] = t(command.errors[:authentication])
 #      render :new
 #    end
 #
 #    private
 #
 #    def session_params
 #      params.require(:session).permit(:email, :password)
 #    end
 # end


  #THIS WAS FROM ANOTHER TUT NOT USING SIMPLE COMMAND
  #handles user authentication
  # skip_before_action :authenticate_request #implemented later
  #
  # def authenticate
  #   user = User.find_by(email: params[:email.downcase!])
  #
  #    #uses bcrypt to check password_digest
  #   if user && user.authenticate(params[:password])
  #     #passed check - call token generator below
  #     render json: { authentication_payload(user) }
  #   else
  #     render json: { error: 'Invalid username or password'}, status: :unauthorized
  #   end
  # end
  #
  # private
  #
  # def authentication_payload(user)
  #   return nil unless user && user.id
  #   {
  #     auth_token: AuthToken.encode({ user_id: id }), user: { id: user.id, email: user.email } #embed whatever user info you need
  #   }
  # end
