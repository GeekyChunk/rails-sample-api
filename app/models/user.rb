class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
    validates :name, presence: true
    has_secure_password
end
