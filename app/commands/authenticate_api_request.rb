class AuthenticateApiRequest
#this command will check subsequent API requests for JWT token in header
#which will be checked for validation

  #add SimpleCommand
  prepend SimpleCommand

  #initialize - call private attributes to find the headers
  def initialize(headers = {})
    @headers = headers
  end

  #mandatory call - call private method user
  def call
    user
  end

private
    attr_readers :headers

    def user
      #if there is a decoded user id, find and return user
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
      #return either the user or an error
      @user || errors.add(:token, 'Invalid token') && nil
    end

    #use AuthToken class to decode the header
    def decoded_auth_token
      @decoded_auth_token ||= AuthToken.decode(http_auth_header)
    end

    #splits up header for use in our class
    def http_auth_header
      if headers['Authorization'].present?
        return headers['Authorization'].split(' ').last
      else
        errors.add :token, "Missing token"
      end
      nil
    end
end
