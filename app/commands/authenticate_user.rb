#define a command class
class AuthenticateUser
  # put SimpleCommand before the class ancestors chain
  prepend SimpleCommand

  #optional, initialize the command with some arguments
  def initialize(user, password)
    @user = user
    @password = password
  end
  
  #mandatory: define a #call method.
  #Its return value will be available through #result
  def call
    AuthToken.encode(user_id: user.id) if user
  end

  private

      attr_accessor :email, :password

      def user
        user = User.find_by(email: email)
        return user if user && user.authenticate(password)

        errors.add :user_authentication, 'invalid credentials'
        nil
      end

end
