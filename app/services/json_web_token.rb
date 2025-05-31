module JsonWebToken
  SECRET_KEY = Rails.application.credentials.dig(:secret_key_base)

  def self.encode(payload, exp = 2.minutes.from_now.to_i)
    payload[:exp] = exp
    token = JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    token = JWT.decode(token, SECRET_KEY)
  end
end