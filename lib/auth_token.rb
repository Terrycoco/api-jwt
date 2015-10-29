class AuthToken
  #simplifies JWT gem to issue and decode token

  #encode expiration claim into web token payload and return token
  def self.encode(payload, ttl_in_minutes = 60 * 24 * 30)
    payload[:exp] = ttl_in_minutes.minutes.from_now.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base) #returns token
  end

  #decode a token and return the payload inside
  #it will throw an error if expired or invalid
  def self.decode(token, leeway = nil )
    decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, leeway: leeway)
    HasWithIndifferentAccess.new(decoded[0])  #returns payload
  end


end
