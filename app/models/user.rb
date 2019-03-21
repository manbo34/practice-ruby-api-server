class User < ApplicationRecord
  has_secure_token
  has_many :follows
  has_many :follows
end
