class User < ApplicationRecord
  has_secure_token
  has_many :tweets

end
