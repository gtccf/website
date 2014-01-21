class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2, :gplus]

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    from_google(access_token.info)
  end

  def self.from_google(data)
    user = User.where(:email => data["email"]).first

    unless user
      user = User.new(
        email: data["email"],
        password: Devise.friendly_token[0,20]
      )
    end

    user.first_name = data["first_name"]
    user.last_name = data["last_name"]
    user.save!
    user
  end

  def self.find_for_gplus(access_token, signed_in_resource=nil)
    from_google(access_token.info)
  end
end
