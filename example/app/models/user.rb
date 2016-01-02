class User < ActiveRecord::Base
# Validate Username
  validates :username, presence: true, length: { maximum: 255 }, uniqueness: true

end
